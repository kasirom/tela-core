use clap::{Parser, Subcommand, CommandFactory};
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
use serde::Deserialize;

#[derive(Deserialize)]
struct TelaToml {
    proyek: ProyekConfig,
}

#[derive(Deserialize)]
struct ProyekConfig {
    #[allow(dead_code)]
    nama: String,
    #[allow(dead_code)]
    versi: String,
    entry: Option<String>,
}

#[derive(Parser)]
#[command(name = "tela")]
#[command(about = "Compiler Tela Core Nusantara (Get-Touch-Tela)", long_about = None)]
struct Cli {
    /// Menampilkan versi compiler Tela Core Nusantara
    #[arg(short = 'v', long = "version")]
    versi: bool,

    #[command(subcommand)]
    command: Option<Commands>,
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
    /// Membuka file sumber utama (utama.tela) dengan Notepad
    Lihat,
}

fn main() {
    let cli = Cli::parse();

    // Jika flag -v / --version diberikan, tampilkan versi dan keluar
    if cli.versi {
        println!("tela 0.1.0");
        return;
    }

    match &cli.command {
        Some(Commands::Buat { nama }) => {
            let path = Path::new(nama);
            if path.exists() {
                println!("❌ Direktori '{}' sudah ada!", nama);
                println!("ℹ️  Saran: Gunakan nama proyek lain, atau hapus direktori '{}' terlebih dahulu.", nama);
                return;
            }
            fs::create_dir_all(path.join("src")).unwrap();
            fs::create_dir_all(path.join("bangun")).unwrap();
            
            let toml_isi = format!("[proyek]\nnama = \"{}\"\nversi = \"0.1.0\"\nentry = \"src/utama.tela\"\n", nama);
            fs::write(path.join("tela.toml"), toml_isi).unwrap();
            
            let utama_isi = "fungsi utama() {\n    Sistem::cetak_teks(\"Halo Dunia, Ini dari Tela Core Nusantara!\");\n}\n";
            fs::write(path.join("src").join("utama.tela"), utama_isi).unwrap();
            
            println!("✅ Proyek '{}' berhasil dibuat!", nama);
            println!("Silakan masuk ke direktori: cd {}", nama);
            println!("");
        }
        Some(Commands::Bangun { target, hanya_ir }) => {
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
        Some(Commands::Jalankan { target }) => {
            let target_clone = target.clone();
            let handle = std::thread::Builder::new()
                .stack_size(8 * 1024 * 1024)
                .spawn(move || {
                    bangun_proyek(true, false, target_clone, false);
                })
                .unwrap();
            handle.join().unwrap();
        }
        Some(Commands::Uji { target }) => {
            let target_clone = target.clone();
            let handle = std::thread::Builder::new()
                .stack_size(8 * 1024 * 1024)
                .spawn(move || {
                    bangun_proyek(true, true, target_clone, false);
                })
                .unwrap();
            handle.join().unwrap();
        }
        Some(Commands::Lihat) => {
            lihat_file_sumber();
        }
        None => {
            // Tidak ada subcommand - tampilkan bantuan
            let mut cmd = Cli::command();
            let _ = cmd.print_help();
            println!();
        }
    }
}

/// Membuka file sumber utama (utama.tela) dengan Notepad
fn lihat_file_sumber() {
    // 1. Cek apakah tela.toml ada
    let toml_path = Path::new("tela.toml");
    if !toml_path.exists() {
        println!("❌ 'tela.toml' tidak ditemukan!");
        println!("ℹ️  Saran: Pastikan Anda berada di direktori root proyek Tela.");
        println!("ℹ️  Saran: Jalankan 'tela buat <nama_proyek>' untuk membuat proyek baru dari awal.");
        return;
    }
    
    // 2. Baca tela.toml untuk menentukan file entry
    let toml_content = fs::read_to_string(&toml_path).unwrap_or_default();
    let mut entry_file = "src/utama.tela".to_string();
    
    if let Ok(config) = toml::from_str::<TelaToml>(&toml_content) {
        if let Some(entry) = config.proyek.entry {
            entry_file = entry;
        }
    } else {
        println!("⚠️  Gagal membaca 'tela.toml'. Menggunakan default 'src/utama.tela'.");
    }
    
    // 3. Cek apakah file sumber ada
    let utama_path = Path::new(&entry_file);
    if !utama_path.exists() {
        println!("❌ File sumber '{}' tidak ditemukan!", entry_file);
        println!("ℹ️  Saran: Periksa kembali isi 'tela.toml' pada bagian 'entry'.");
        println!("ℹ️  Saran: Pastikan file tersebut benar-benar ada di direktori proyek Anda.");
        return;
    }
    
    // 4. Buka file dengan Notepad
    println!("==>  Membuka '{}' dengan Notepad...", entry_file);
    match Command::new("notepad").arg(utama_path).spawn() {
        Ok(_) => {
            println!("✅ Berhasil membuka '{}' dengan Notepad.", entry_file);
        }
        Err(e) => {
            println!("❌ Gagal membuka Notepad: {}", e);
            println!("ℹ️  Saran: Pastikan aplikasi Notepad tersedia di sistem Windows Anda.");
            println!("ℹ️  Saran: Anda juga dapat membuka berkas '{}' secara manual dengan editor teks apa pun.", entry_file);
        }
    }
}

/// Menampilkan snippet kode sumber yang bermasalah dengan highlight baris/kolom
fn tampilkan_snippet_kode(kode_sumber: &str, pesan_error: &[String]) {
    let baris_list: Vec<&str> = kode_sumber.lines().collect();
    
    for pesan in pesan_error {
        // Ekstrak nomor baris dari pesan error (format: "... di baris N, kolom M")
        let mut nomor_baris: Option<usize> = None;
        let parts: Vec<&str> = pesan.split("baris").collect();
        if parts.len() > 1 {
            let after_baris = parts[1].trim();
            let angka_str: String = after_baris.chars().take_while(|c| c.is_digit(10)).collect();
            if !angka_str.is_empty() {
                nomor_baris = angka_str.parse::<usize>().ok();
            }
        }
        
        if let Some(baris) = nomor_baris {
            if baris > 0 && baris <= baris_list.len() {
                let start = baris.saturating_sub(2);
                let end = (baris + 1).min(baris_list.len());
                
                println!("\x1b[1;36m  --> {}\x1b[0m", baris);
                for i in start..end {
                    let nomor = i + 1;
                    let marker = if nomor == baris { "\x1b[1;31m>\x1b[0m" } else { " " };
                    let highlight = if nomor == baris {
                        format!("\x1b[1;31m{}\x1b[0m", baris_list[i])
                    } else {
                        baris_list[i].to_string()
                    };
                    println!("{} {:>4} | {}", marker, nomor, highlight);
                }
                println!("");
            }
        }
    }
}

fn bangun_proyek(jalankan: bool, mode_uji: bool, target: Option<String>, hanya_ir: bool) {
    let toml_path = Path::new("tela.toml");
    if !toml_path.exists() {
        println!("❌ 'tela.toml' tidak ditemukan!");
        println!("ℹ️  Saran: Pastikan Anda berada di direktori root proyek Tela.");
        println!("ℹ️  Saran: Jalankan 'tela buat <nama_proyek>' untuk membuat proyek baru dari awal.");
        return;
    }
    
    let toml_content = fs::read_to_string(&toml_path).unwrap_or_default();
    let mut entry_file = "src/utama.tela".to_string();
    
    if let Ok(config) = toml::from_str::<TelaToml>(&toml_content) {
        if let Some(entry) = config.proyek.entry {
            entry_file = entry;
        }
    }
    
    let utama_path = Path::new(&entry_file);
    if !utama_path.exists() {
        println!("❌ File sumber '{}' tidak ditemukan!", entry_file);
        println!("ℹ️  Saran: Periksa kembali isi 'tela.toml' pada bagian 'entry'.");
        println!("ℹ️  Saran: Pastikan file tersebut benar-benar ada di direktori proyek Anda.");
        return;
    }
    
    println!("==>  Membaca {}...", entry_file);
    let kode_sumber = fs::read_to_string(&utama_path).unwrap();
    
    let mut lexer = Lexer::new(&kode_sumber);
    let entry_dir = Path::new(&entry_file).parent().map(|p| p.to_path_buf());
    let mut parser = TelaParser::new_with_base_dir(&mut lexer, entry_dir);
    let program = parser.parse_program();

    if parser.pesan_error.len() > 0 {
        println!("\x1b[1;31m❌ Terdapat Error Parsing:\x1b[0m");
        for pesan in &parser.pesan_error {
            println!("   \x1b[31m- {}\x1b[0m", pesan);
        }
        println!("\x1b[1;33mℹ️  Saran: Periksa kembali sintaks pada baris yang disebutkan di atas.\x1b[0m");
        tampilkan_snippet_kode(&kode_sumber, &parser.pesan_error);
        return;
    }
    
    println!("==>  Menjalankan Analisis Semantik...");
    let mut analyzer = AnalyzerSemantik::new();
    let lingkungan_tipe = Rc::new(RefCell::new(LingkunganTipe::baru()));
    
    analyzer.cek_node(&program, &lingkungan_tipe, Some("bilangan"));
    
    if analyzer.pesan_error.len() > 0 {
        println!("\x1b[1;31m❌ ERROR SEMANTIK DITEMUKAN:\x1b[0m");
        for msg in analyzer.pesan_error {
            println!("   \x1b[31m- {}\x1b[0m", msg);
        }
        println!("\x1b[1;33mℹ️  Saran: Periksa kembali tipe data, deklarasi variabel, dan pemanggilan fungsi pada kode Anda.\x1b[0m");
        println!("\x1b[1;33mℹ️  Saran: Gunakan 'tela lihat' untuk membuka file sumber dan periksa baris yang bermasalah.\x1b[0m");
        println!("\x1b[1;31mKompilasi dibatalkan sebelum dieksekusi.\x1b[0m");
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
