use clap::{Parser, Subcommand};
use std::fs;
use std::path::Path;
use std::process::Command;
use std::rc::Rc;
use std::cell::RefCell;

// Gunakan modul dari library crate
use telacore_compiler::lexer::Lexer;
use telacore_compiler::parser::Parser as TelaParser;
use telacore_compiler::semantik::{AnalyzerSemantik, LingkunganTipe};
use telacore_compiler::llvm_codegen::LLVMGenerator;


#[derive(Parser)]
#[command(name = "tela")]
#[command(about = "Compiler Tela Core Nusantara (Get-Touch-Tela)", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Membuat kerangka proyek Tela baru
    Buat {
        /// Nama proyek yang akan dibuat
        nama: String,
    },
    /// Mengkompilasi proyek di direktori saat ini
    Bangun {
        /// Target kompilasi LLVM triple (misal: x86_64-unknown-linux-gnu)
        #[arg(long)]
        target: Option<String>,
        
        /// Hanya menghasilkan LLVM IR tanpa melakukan penautan executable
        #[arg(long)]
        hanya_ir: bool,
    },
    /// Mengkompilasi dan langsung menjalankan program
    Jalankan {
        /// Target kompilasi LLVM triple
        #[arg(long)]
        target: Option<String>,
    },
    /// Menjalankan pengujian proyek
    Uji {
        /// Target kompilasi LLVM triple
        #[arg(long)]
        target: Option<String>,
    },
}

fn main() {
    let cli = Cli::parse();

    match &cli.command {
        Commands::Buat { nama } => {
            let path = Path::new(nama);
            if path.exists() {
                println!("❌ Direktori '{}' sudah ada!", nama);
                return;
            }
            fs::create_dir_all(path.join("src")).unwrap();
            fs::create_dir_all(path.join("bangun")).unwrap();
            
            let toml_isi = format!("[proyek]\nnama = \"{}\"\nversi = \"0.1.0\"\n", nama);
            fs::write(path.join("tela.toml"), toml_isi).unwrap();
            
            let utama_isi = "fungsi utama() {\n    Sistem::cetak_teks(\"Halo Dunia, Ini dari Tela Core Nusantara!\");\n}\n";
            fs::write(path.join("src").join("utama.tela"), utama_isi).unwrap();
            
            println!("✅ Proyek '{}' berhasil dibuat!", nama);
            println!("Silakan masuk ke direktori: cd {}", nama);
            println!("");
        }
        Commands::Bangun { target, hanya_ir } => {
            let target_clone = target.clone();
            let hanya_ir_val = *hanya_ir;
            let handle = std::thread::Builder::new()
                .stack_size(8 * 1024 * 1024)
                .spawn(move || {
                    bangun_proyek(false, false, target_clone, hanya_ir_val);
                })
                .unwrap();
            handle.join().unwrap();
        }
        Commands::Jalankan { target } => {
            let target_clone = target.clone();
            let handle = std::thread::Builder::new()
                .stack_size(8 * 1024 * 1024)
                .spawn(move || {
                    bangun_proyek(true, false, target_clone, false);
                })
                .unwrap();
            handle.join().unwrap();
        }
        Commands::Uji { target } => {
            let target_clone = target.clone();
            let handle = std::thread::Builder::new()
                .stack_size(8 * 1024 * 1024)
                .spawn(move || {
                    bangun_proyek(true, true, target_clone, false);
                })
                .unwrap();
            handle.join().unwrap();
        }
    }
}

fn bangun_proyek(jalankan: bool, mode_uji: bool, target: Option<String>, hanya_ir: bool) {
    let toml_path = Path::new("tela.toml");
    if !toml_path.exists() {
        println!("❌ 'tela.toml' tidak ditemukan! Pastikan Anda berada di root proyek Tela.");
        return;
    }
    
    let utama_path = Path::new("src").join("utama.tela");
    if !utama_path.exists() {
        println!("❌ File sumber 'src/utama.tela' tidak ditemukan!");
        return;
    }
    
    println!("==>  Membaca src/utama.tela...");
    let kode_sumber = fs::read_to_string(&utama_path).unwrap();
    
    let mut lexer = Lexer::new(&kode_sumber);
    let mut parser = TelaParser::new(&mut lexer);
    let program = parser.parse_program();

    if parser.pesan_error.len() > 0 {
        println!("❌ Terdapat Error Parsing:");
        for pesan in parser.pesan_error {
            println!(" - {}", pesan);
        }
        return;
    }
    
    println!("==>  Menjalankan Analisis Semantik...");
    let mut analyzer = AnalyzerSemantik::new();
    let lingkungan_tipe = Rc::new(RefCell::new(LingkunganTipe::baru()));
    
    analyzer.cek_node(&program, &lingkungan_tipe, Some("bilangan"));
    
    if analyzer.pesan_error.len() > 0 {
        println!("❌ ERROR SEMANTIK DITEMUKAN:");
        for msg in analyzer.pesan_error {
            println!("   - {}", msg);
        }
        println!("Kompilasi dibatalkan sebelum dieksekusi.");
        return;
    }
    
    println!("==>  Menghasilkan Kode LLVM IR...");
    let mut generator = LLVMGenerator::new();
    generator.is_test_mode = mode_uji;
    generator.generate(&program);
    
    let build_dir = Path::new("bangun");
    if !build_dir.exists() {
        fs::create_dir_all(build_dir).unwrap();
    }
    
    let ll_path = build_dir.join("program.ll");
    let exe_path = build_dir.join("program.exe");
    
    fs::write(&ll_path, &generator.output).unwrap();
    println!("==>  LLVM IR tertulis di: {}", ll_path.display());
    
    if hanya_ir {
        return;
    }
    
    println!("==>  Memanggil Clang untuk kompilasi executable...");

    if cfg!(target_os = "windows") && exe_path.exists() {
        let _ = Command::new("taskkill").args(&["/F", "/IM", "program.exe", "/T"]).output();
    }
    
    let mut clang_bin = "clang".to_string();
    if Command::new("clang").arg("--version").output().is_err() {
        if std::path::Path::new(r"C:\Program Files\LLVM\bin\clang.exe").exists() {
            clang_bin = r"C:\Program Files\LLVM\bin\clang.exe".to_string();
        } else if std::path::Path::new(r"C:\LLVM\bin\clang.exe").exists() {
            clang_bin = r"C:\LLVM\bin\clang.exe".to_string();
        }
    }

    let mut cmd = Command::new(clang_bin);
    cmd.arg(ll_path.to_str().unwrap())
        .arg("-o")
        .arg(exe_path.to_str().unwrap());
        
    if let Some(ref t) = target {
        cmd.arg("-target").arg(t);
    }
    
    cmd.arg("-llegacy_stdio_definitions")
        .arg("-lUser32")
        .arg("-lwinmm")
        .arg("-lmsimg32")
        .arg("-lgdiplus")
        .arg("-lOle32")
        .arg("-lGdi32");
        
    let status = cmd.output();
        
    match status {
        Ok(s) => {
            if s.status.success() {
                println!("==>  Kompilasi Selesai! Executable: {}", exe_path.display());
                println!("");
                if jalankan {
                    println!("🚀 Mengeksekusi program...\n");
                    let mut eksekusi = Command::new(exe_path.to_str().unwrap());
                    let hasil = eksekusi.status();
                    if let Ok(hs) = hasil {
                        println!("");
                        println!("\n(Program selesai dengan kode: {})", hs.code().unwrap_or(0));
                        println!("");
                    } else {
                        println!("❌ Gagal menjalankan eksekusi.");
                        println!("");
                    }
                }
            } else {
                let stderr = String::from_utf8_lossy(&s.stderr);
                println!("❌ Kompilasi Clang Gagal:\n{}", stderr);
                println!("");
            }
        },
        Err(e) => {
            println!("❌ Gagal memanggil clang: {}", e);
            println!("Silakan install LLVM/Clang terlebih dahulu di sistem OS Windows Anda dan pastikan masuk PATH.");
        }
    }
}
