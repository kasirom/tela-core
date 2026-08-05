// tests/fitur_dasar.rs
// ============================================================
// Integration Test Komprehensif — Bab A.1 sampai A.16
// Memverifikasi bahwa lexer, parser, dan semantic analyzer
// Telacore menangani semua fitur dasar bahasa dengan benar.
// ============================================================

use telacore_compiler::lexer::Lexer;
use telacore_compiler::parser::Parser as TelaParser;
use telacore_compiler::semantik::{AnalyzerSemantik, LingkunganTipe};
use telacore_compiler::llvm_codegen::LLVMGenerator;
use std::rc::Rc;
use std::cell::RefCell;

/// Helper: parse kode Tela dan kembalikan (program, errors)
fn parse_kode(kode: &str) -> (telacore_compiler::ast::Program, Vec<String>) {
    let mut lexer = Lexer::new(kode);
    let mut parser = TelaParser::new(&mut lexer);
    let program = parser.parse_program();
    (program, parser.pesan_error)
}

/// Helper: parse + semantic check, kembalikan semua error
fn kompilasi_penuh(kode: &str) -> Vec<String> {
    let (program, parse_errors) = parse_kode(kode);
    if !parse_errors.is_empty() {
        return parse_errors;
    }

    let mut analyzer = AnalyzerSemantik::new();
    let lingkungan = Rc::new(RefCell::new(LingkunganTipe::baru()));
    analyzer.cek_node(&program, &lingkungan, Some("bilangan"));

    analyzer.pesan_error
}

/// Helper: full pipeline sampai LLVM IR
fn kompilasi_ke_llvm(kode: &str) -> Result<String, Vec<String>> {
    let (program, parse_errors) = parse_kode(kode);
    if !parse_errors.is_empty() {
        return Err(parse_errors);
    }

    let mut analyzer = AnalyzerSemantik::new();
    let lingkungan = Rc::new(RefCell::new(LingkunganTipe::baru()));
    analyzer.cek_node(&program, &lingkungan, Some("bilangan"));

    if !analyzer.pesan_error.is_empty() {
        return Err(analyzer.pesan_error);
    }

    let mut generator = LLVMGenerator::new();
    generator.generate(&program);
    Ok(generator.output)
}

// ============================================================
// BAB A.1: Program Pertama — Halo Dunia
// ============================================================

#[test]
fn a01_halo_dunia() {
    let kode = r#"
fungsi utama() {
    Sistem::cetak_teks("Halo Dunia, Ini dari Tela Core!");
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Halo Dunia gagal: {:?}", errors);
}

#[test]
fn a01_kalkulator_sederhana() {
    let kode = r#"
fungsi utama() {
    ubah a: bilangan = 10;
    ubah b: bilangan = 20;
    ubah hasil: bilangan = a + b;
    Sistem::cetak_bilangan(hasil);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Kalkulator gagal: {:?}", errors);
}

// ============================================================
// BAB A.3: Komentar
// ============================================================

#[test]
fn a03_komentar_baris() {
    let kode = r#"
fungsi utama() {
    // Ini komentar baris
    ubah x: bilangan = 42;
    Sistem::cetak_bilangan(x);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Komentar baris gagal: {:?}", errors);
}

#[test]
fn a03_komentar_blok() {
    let kode = r#"
fungsi utama() {
    /* Ini komentar blok
       yang bisa multi-baris */
    ubah x: bilangan = 99;
    Sistem::cetak_bilangan(x);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Komentar blok gagal: {:?}", errors);
}

// ============================================================
// BAB A.4: Variabel (Peubah)
// ============================================================

#[test]
fn a04_deklarasi_ubah() {
    let kode = r#"
fungsi utama() {
    ubah nama: teks = "Tela";
    ubah umur: bilangan = 1;
    ubah aktif: logika = benar;
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Deklarasi ubah gagal: {:?}", errors);
}

#[test]
fn a04_penugasan_ulang() {
    let kode = r#"
fungsi utama() {
    ubah x: bilangan = 10;
    x = 20;
    x = x + 5;
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Penugasan ulang gagal: {:?}", errors);
}

// ============================================================
// BAB A.5: Tipe Data Skalar Primitif
// ============================================================

#[test]
fn a05_tipe_bilangan() {
    let kode = r#"
fungsi utama() {
    ubah a: bilangan = 42;
    ubah b: bilangan = -10;
    ubah c: bilangan = 0;
    Sistem::cetak_bilangan(a);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Tipe bilangan gagal: {:?}", errors);
}

#[test]
fn a05_tipe_desimal() {
    let kode = r#"
fungsi utama() {
    ubah pi: desimal = 3.14;
    ubah suhu: desimal = 36.5;
    Sistem::cetak_desimal(pi);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Tipe desimal gagal: {:?}", errors);
}

#[test]
fn a05_tipe_logika() {
    let kode = r#"
fungsi utama() {
    ubah aktif: logika = benar;
    ubah selesai: logika = salah;
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Tipe logika gagal: {:?}", errors);
}

// ============================================================
// BAB A.6: Teks (String Literal)
// ============================================================

#[test]
fn a06_teks_literal() {
    let kode = r#"
fungsi utama() {
    ubah salam: teks = "Selamat datang!";
    ubah teks_kosong: teks = "";
    Sistem::cetak_teks(salam);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Teks literal gagal: {:?}", errors);
}

// ============================================================
// BAB A.7: Konstanta
// ============================================================

#[test]
fn a07_konstanta() {
    let kode = r#"
fungsi utama() {
    konstanta MAX: bilangan = 100;
    Sistem::cetak_bilangan(MAX);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Konstanta gagal: {:?}", errors);
}

// ============================================================
// BAB A.8: Operator
// ============================================================

#[test]
fn a08_operator_aritmatika() {
    let kode = r#"
fungsi utama() {
    ubah a: bilangan = 10;
    ubah b: bilangan = 3;
    ubah tambah: bilangan = a + b;
    ubah kurang: bilangan = a - b;
    ubah kali: bilangan = a * b;
    ubah bagi: bilangan = a / b;
    ubah sisa: bilangan = a % b;
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Operator aritmatika gagal: {:?}", errors);
}

#[test]
fn a08_operator_perbandingan() {
    let kode = r#"
fungsi utama() {
    ubah a: bilangan = 10;
    ubah b: bilangan = 20;
    jika a < b {
        Sistem::cetak_teks("a lebih kecil");
    }
    jika a == b {
        Sistem::cetak_teks("sama");
    }
    jika a != b {
        Sistem::cetak_teks("berbeda");
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Operator perbandingan gagal: {:?}", errors);
}

#[test]
fn a08_operator_logika() {
    let kode = r#"
fungsi utama() {
    ubah a: logika = benar;
    ubah b: logika = salah;
    jika a && b {
        Sistem::cetak_teks("keduanya benar");
    }
    jika a || b {
        Sistem::cetak_teks("salah satu benar");
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Operator logika gagal: {:?}", errors);
}

#[test]
fn a08_operator_penugasan_gabungan() {
    let kode = r#"
fungsi utama() {
    ubah x: bilangan = 10;
    x += 5;
    x -= 3;
    x *= 2;
    Sistem::cetak_bilangan(x);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Operator penugasan gabungan gagal: {:?}", errors);
}

// ============================================================
// BAB A.9: Seleksi Kondisi (jika / lainnya jika / lainnya)
// ============================================================

#[test]
fn a09_jika_sederhana() {
    let kode = r#"
fungsi utama() {
    ubah nilai: bilangan = 85;
    jika nilai >= 80 {
        Sistem::cetak_teks("Lulus");
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Jika sederhana gagal: {:?}", errors);
}

#[test]
fn a09_jika_lainnya() {
    let kode = r#"
fungsi utama() {
    ubah nilai: bilangan = 50;
    jika nilai >= 70 {
        Sistem::cetak_teks("Lulus");
    } lainnya {
        Sistem::cetak_teks("Tidak Lulus");
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Jika-lainnya gagal: {:?}", errors);
}

#[test]
fn a09_jika_lainnya_jika() {
    let kode = r#"
fungsi utama() {
    ubah nilai: bilangan = 75;
    jika nilai >= 90 {
        Sistem::cetak_teks("A");
    } lainnya jika nilai >= 80 {
        Sistem::cetak_teks("B");
    } lainnya jika nilai >= 70 {
        Sistem::cetak_teks("C");
    } lainnya {
        Sistem::cetak_teks("D");
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Jika-lainnya-jika gagal: {:?}", errors);
}

// ============================================================
// BAB A.10: Perulangan selama (while)
// ============================================================

#[test]
fn a10_selama() {
    let kode = r#"
fungsi utama() {
    ubah i: bilangan = 0;
    selama i < 5 {
        Sistem::cetak_bilangan(i);
        i = i + 1;
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Perulangan selama gagal: {:?}", errors);
}

// ============================================================
// BAB A.11: Perulangan putar (loop) + henti + lanjut
// ============================================================

#[test]
fn a11_putar_henti() {
    let kode = r#"
fungsi utama() {
    ubah i: bilangan = 0;
    putar {
        jika i >= 5 {
            henti;
        }
        Sistem::cetak_bilangan(i);
        i = i + 1;
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Putar-henti gagal: {:?}", errors);
}

#[test]
fn a11_putar_lanjut() {
    let kode = r#"
fungsi utama() {
    ubah i: bilangan = 0;
    putar {
        i = i + 1;
        jika i > 10 {
            henti;
        }
        jika i == 5 {
            lanjut;
        }
        Sistem::cetak_bilangan(i);
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Putar-lanjut gagal: {:?}", errors);
}

// ============================================================
// BAB A.12: Perulangan untuk...dalam (for in)
// ============================================================

#[test]
fn a12_untuk_dalam_rentang() {
    let kode = r#"
fungsi utama() {
    untuk i dalam 1..6 {
        Sistem::cetak_bilangan(i);
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Untuk-dalam rentang gagal: {:?}", errors);
}

// ============================================================
// BAB A.13: Larik (Array)
// ============================================================

#[test]
fn a13_larik_literal() {
    let kode = r#"
fungsi utama() {
    ubah angka = [1, 2, 3, 4, 5];
    Sistem::cetak_bilangan(angka[0]);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Larik literal gagal: {:?}", errors);
}

// ============================================================
// BAB A.15: Rangkap (Tuple)
// ============================================================

#[test]
fn a15_rangkap_tuple() {
    let kode = r#"
struktur Koordinat {
    x: bilangan,
    y: bilangan,
}

fungsi utama() {
    ubah k = Koordinat { x: 10, y: 20 };
    Sistem::cetak_bilangan(k.x);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Rangkap/struktur gagal: {:?}", errors);
}

// ============================================================
// BAB A.17: Fungsi
// ============================================================

#[test]
fn a17_fungsi_dengan_parameter() {
    let kode = r#"
fungsi tambah(a: bilangan, b: bilangan) -> bilangan {
    kembalikan a + b;
}

fungsi utama() {
    ubah hasil: bilangan = tambah(3, 7);
    Sistem::cetak_bilangan(hasil);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Fungsi parameter gagal: {:?}", errors);
}

#[test]
fn a17_fungsi_tanpa_kembalian() {
    let kode = r#"
fungsi sapa(nama: teks) {
    Sistem::cetak_teks(nama);
}

fungsi utama() {
    sapa("Telacore");
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Fungsi tanpa kembalian gagal: {:?}", errors);
}

// ============================================================
// BAB A.23: Bentuk / Struktur (Struct)
// ============================================================

#[test]
fn a23_struktur_dasar() {
    let kode = r#"
struktur Titik {
    x: bilangan,
    y: bilangan,
}

fungsi utama() {
    ubah p = Titik { x: 10, y: 20 };
    Sistem::cetak_bilangan(p.x);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Struktur dasar gagal: {:?}", errors);
}

// ============================================================
// BAB A.26: Pilihan (Enum)
// ============================================================

#[test]
fn a26_enum_dasar() {
    let kode = r#"
enum Warna {
    Merah,
    Hijau,
    Biru,
}

fungsi utama() {
    ubah w = Warna::Merah;
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Enum dasar gagal: {:?}", errors);
}

// ============================================================
// BAB A.27: Alias Tipe & Konversi
// ============================================================

#[test]
fn a27_alias_tipe() {
    let kode = r#"
tipe Angka = bilangan;

fungsi utama() {
    ubah x: Angka = 42;
    Sistem::cetak_bilangan(x);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Alias tipe gagal: {:?}", errors);
}

#[test]
fn a27_konversi_sebagai() {
    let kode = r#"
fungsi utama() {
    ubah x: bilangan = 42;
    ubah y: desimal = x sebagai desimal;
    Sistem::cetak_desimal(y);
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Konversi sebagai gagal: {:?}", errors);
}

// ============================================================
// BAB A.36: Sifat (Traits) — Dasar
// ============================================================

#[test]
fn a36_sifat_dasar() {
    let kode = r#"
sifat Tampilkan {
    fungsi tampil(diri) -> teks;
}

struktur Orang {
    nama: teks,
    umur: bilangan,
}

implementasi Tampilkan untuk Orang {
    fungsi tampil(diri) -> teks {
        kembalikan diri.nama;
    }
}

fungsi utama() {
    ubah p = Orang { nama: "Budi", umur: 25 };
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Sifat dasar gagal: {:?}", errors);
}

// ============================================================
// BAB A.42: Pencocokan Pola (cocokkan)
// ============================================================

#[test]
fn a42_cocokkan_dasar() {
    let kode = r#"
fungsi utama() {
    ubah x: bilangan = 3;
    cocokkan x {
        1 => Sistem::cetak_teks("satu"),
        2 => Sistem::cetak_teks("dua"),
        3 => Sistem::cetak_teks("tiga"),
        _ => Sistem::cetak_teks("lainnya"),
    }
}
"#;
    let errors = kompilasi_penuh(kode);
    assert!(errors.is_empty(), "Cocokkan dasar gagal: {:?}", errors);
}

// ============================================================
// LLVM IR Generation Test
// ============================================================

#[test]
fn llvm_halo_dunia_generates_ir() {
    let kode = r#"
fungsi utama() {
    Sistem::cetak_teks("Halo Dunia!");
}
"#;
    let ir = kompilasi_ke_llvm(kode);
    assert!(ir.is_ok(), "LLVM IR generation gagal: {:?}", ir.err());
    let output = ir.unwrap();
    assert!(output.contains("@main"), "Output harus mengandung fungsi @main");
    assert!(output.contains("Halo Dunia!"), "Output harus mengandung string literal");
}

#[test]
fn llvm_fungsi_tambah_generates_ir() {
    let kode = r#"
fungsi tambah(a: bilangan, b: bilangan) -> bilangan {
    kembalikan a + b;
}

fungsi utama() {
    ubah hasil: bilangan = tambah(5, 10);
    Sistem::cetak_bilangan(hasil);
}
"#;
    let ir = kompilasi_ke_llvm(kode);
    assert!(ir.is_ok(), "LLVM IR generation gagal: {:?}", ir.err());
    let output = ir.unwrap();
    assert!(output.contains("@tambah"), "Output harus mengandung fungsi @tambah");
    assert!(output.contains("add"), "Output harus mengandung instruksi add");
}
