# TODO - Pengembangan Telacore Bertahap

## Fase 1: Teks Concatenation + Standard Library + Error Messages
- [ ] **1.1 Teks Concatenation**
  - [ ] Tambah deklarasi fungsi C string (strlen, strcpy, strcat) di `llvm_codegen.rs`
  - [ ] Implementasi operator `+` untuk tipe `teks` (string concatenation) di `llvm_codegen.rs`
  - [ ] Tambah test untuk string concatenation

- [ ] **1.2 Standard Library - Modul Koleksi (HashMap/HashSet)**
  - [ ] Tambah modul `Koleksi::` di `semantik.rs` (kamus_baru, set_baru, simpan, ambil, hapus, panjang, ada)
  - [ ] Implementasi LLVM codegen untuk modul `Koleksi::` di `llvm_codegen.rs`
  - [ ] Tambah test untuk modul Koleksi

- [ ] **1.3 Standard Library - Modul Teks**
  - [ ] Tambah modul `Teks::` di `semantik.rs` (panjang, gabung, potong, ubah_besar, ubah_kecil, ganti, pisah)
  - [ ] Implementasi LLVM codegen untuk modul `Teks::` di `llvm_codegen.rs`
  - [ ] Tambah test untuk modul Teks

- [ ] **1.4 Standard Library - Modul Konversi**
  - [ ] Tambah modul `Konversi::` di `semantik.rs` (teks_ke_bilangan, bilangan_ke_teks, teks_ke_desimal, desimal_ke_teks, karakter_ke_teks)
  - [ ] Implementasi LLVM codegen untuk modul `Konversi::` di `llvm_codegen.rs`
  - [ ] Tambah test untuk modul Konversi

- [ ] **1.5 Error Messages Lebih Informatif**
  - [ ] Perbaiki format error di `main.rs` dengan highlight baris/kolom
  - [ ] Tambah warna ANSI untuk error
  - [ ] Tampilkan snippet kode sumber yang error

## Fase 2: Package Manager
- [ ] **2.1 Perintah `tela tambah <paket>`**
- [ ] **2.2 Perintah `tela hapus <paket>`**
- [ ] **2.3 File dependencies di `tela.toml`**
- [ ] **2.4 Registry paket sederhana**

## Fase 3: IDE Support
- [ ] **3.1 Syntax highlighting untuk VS Code (.tela)**
- [ ] **3.2 Konfigurasi VS Code (snippets, keybindings)**

## Fase 4: Dokumentasi
- [ ] **4.1 Perluas buku panduan dengan bab-bab baru**
