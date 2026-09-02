# 📖 Buku Panduan Resmi Pemrograman TelaCore

**TelaCore** adalah bahasa pemrograman modern berkinerja tinggi (*high performance*) dengan sintaks berbahasa Indonesia asli yang dikompilasi secara *native* ke *machine code* melalui infrastruktur compiler **LLVM**.

---

## 📑 Daftar Isi
1. [Pengantar & Filosofi](#1-pengantar--filosofi)
2. [Instalasi & Persyaratan Sistem](#2-instalasi--persyaratan-sistem)
3. [Alat Baris Perintah (CLI tela)](#3-alat-baris-perintah-cli-tela)
4. [Struktur Proyek & tela.toml](#4-struktur-proyek--telatoml)
5. [Tipe Data Dasar & Variabel](#5-tipe-data-dasar--variabel)
6. [Operator & Operasi String](#6-operator--operasi-string)
7. [Alur Kontrol (Percabangan & Perulangan)](#7-alur-kontrol)
8. [Fungsi & Modularitas](#8-fungsi--modularitas)
9. [Struktur Data & Sifat (OOP/Traits)](#9-struktur-data--sifat)
10. [Keamanan Memori & Pantau Memori](#10-keamanan-memori--pantau-memori)
11. [Konkurensi & Multi-Threading](#11-konkurensi--multi-threading)
12. [Interoperabilitas C (FFI)](#12-interoperabilitas-c-ffi)
13. [Pustaka Standar (Standard Library)](#13-pustaka-standar)
14. [Dukungan Editor VS Code](#14-dukungan-editor-vs-code)
15. [Contoh Program Nyata](#15-contoh-program-nyata)
16. [Proyek Demo Resmi](#16-proyek-demo-resmi)
17. [Panduan Pengembang & Tips](#17-panduan-pengembang--tips)
18. [Peta Jalan World-Class](#18-peta-jalan-world-class)

---

## 1. Pengantar & Filosofi
TelaCore diciptakan dengan visi memberdayakan generasi pengembang teknologi di Indonesia agar mampu memahami komputasi tingkat tinggi (*systems programming*) dalam bahasa ibu tanpa mengorbankan kecepatan eksekusi.
- **Native Speed**: Menggunakan LLVM IR untuk optimasi kode setara C/C++ dan Rust.
- **Sintaks Intuitif**: Kata kunci yang jelas dan konsisten dalam Bahasa Indonesia.
- **Aman & Modern**: Dilengkapi *type-checking*, *borrow-checker* analitik, dan alat inspeksi memori bawaan.

---

## 2. Instalasi & Persyaratan Sistem
### Persyaratan:
1. **LLVM & Clang** (Versi 15+ terpasang di PATH atau `C:\Program Files\LLVM\bin\clang.exe`).
2. **Rust Toolchain** (untuk mengkompilasi compiler `tela`).

### Membangun Compiler:
```bash
cd telacore_compiler
cargo build --release
```
Binary compiler `tela.exe` akan berada di `target/release/tela.exe`.

---

## 3. Alat Baris Perintah (CLI `tela`)

| Perintah | Deskripsi |
| :--- | :--- |
| `tela buat <nama_proyek>` | Membuat kerangka proyek TelaCore baru |
| `tela buat <nama> --template <dasar|tui|game|gui|musik|cli|rest|berkas>` | Membuat proyek dengan template khusus (dasar / TUI / game / GUI / musik / CLI / REST API / sistem berkas) |
| `tela periksa` (atau `tela cek`) | Memeriksa sintaks dan semantik kode sumber proyek secara instan (*Linter Cepat*) |
| `tela bangun` | Mengompilasi kode sumber ke file executable di `bangun/protela.exe` |
| `tela bangun --optimasi` (atau `-O`) | Mengompilasi dengan optimasi performa tinggi LLVM (`-O3`) |
| `tela bangun --hanya-ir` | Hanya menghasilkan file LLVM IR (`bangun/protela.ll`) |
| `tela jalankan` | Mengompilasi dan langsung mengeksekusi program |
| `tela jalankan --optimasi` | Mengompilasi dengan optimasi `-O3` dan langsung mengeksekusi |
| `tela uji` | Menjalankan kode dalam mode pengujian |
| `tela rapikan [file]` | Merapikan format kode sumber berkas .tela (*Code Formatter*) |
| `tela rapikan --semua` | Merapikan seluruh berkas .tela di dalam proyek |
| `tela repl` | Membuka konsol interaktif REPL untuk evaluasi kode langsung |
| `tela doc` | Menghasilkan dokumentasi HTML (`bangun/dokumentasi.html`) & Markdown dari komentar `///` |
| `tela ukur [--iterasi N]` | Melakukan benchmark performa eksekusi program berpresisi tinggi |
| `tela rilis` | Mengompilasi dan mengemas biner rilis produksi mandiri di folder `rilis/` |
| `tela bersih` | Membersihkan folder `bangun/` dan berkas artefak kompilasi |
| `tela lsp` | Menjalankan server Language Server Protocol untuk editor VS Code / IDE |
| `tela tambah <paket>` | Menambahkan dependensi paket ke `tela.toml` dan membuat template modul |
| `tela hapus <paket>` | Menghapus dependensi paket dari `tela.toml` |
| `tela pasang` | Memasang / memverifikasi seluruh dependensi paket lokal |
| `tela lihat` | Membuka file `src/main.tela` langsung dengan editor |

---

## 4. Struktur Proyek & `tela.toml`

Setiap proyek TelaCore memiliki struktur standar:
```text
nama_proyek/
├── tela.toml          # File konfigurasi proyek & dependensi
├── src/
│   └── main.tela      # Titik masuk utama (entry point)
├── modul/             # Paket & modul tambahan
└── bangun/            # Hasil kompilasi (protela.ll & protela.exe)
```

Contoh file konfigurasi `tela.toml`:
```toml
[proyek]
nama = "aplikasi_saya"
versi = "0.1.0"
entry = "src/main.tela"

[ketergantungan]
matematika_lanjutan = "0.1.0"
```

---

## 5. Tipe Data Dasar & Variabel

### Tipe Data Primitif:
- `bilangan`: Integer bertanda 64-bit (`i64`).
- `desimal`: Floating point 64-bit presisi ganda (`f64`).
- `teks`: Rangkaian karakter teks / string UTF-8 null-terminated (`ptr`).
- `karakter`: Karakter tunggal 1-byte (`i8`).
- `logika`: Nilai boolean (`benar` atau `salah`).
- `kosong`: Tipe unit / tanpa kembalian (`void`).
- `bita`: Tipe byte tidak bertanda (`u8`).

### Deklarasi Variabel:
```tela
// Variabel yang nilainya dapat diubah
ubah skor = 100;
ubah nama = "Budi";
ubah aktif = benar;

// Deklarasi dengan tipe eksplisit
ubah pi: desimal = 3.14159;
ubah huruf: karakter = 'A';

// Tetapan (konstanta tidak dapat diubah)
tetapan MAKSIMAL = 1000;
```

---

## 6. Operator & Operasi String

- **Aritmatika**: `+`, `-`, `*`, `/`, `%`
- **Perbandingan**: `==`, `!=`, `<`, `>`, `<=`, `>=`
- **Logika**: `&&` (dan), `||` (atau), `!` (bukan)
- **Bitwise**: `&`, `|`, `^`, `~`, `<<`, `>>`
- **Penggabungan Teks (*String Concatenation*)**:
  ```tela
  ubah depan = "Halo ";
  ubah belakang = "Dunia!";
  ubah gabung = depan + belakang; // Menghasilkan "Halo Dunia!"
  ```

---

## 7. Alur Kontrol

### Percabangan `jika` - `kalau` - `lain`:
```tela
ubah nilai = 85;

jika nilai >= 90 {
    Sistem::cetak_teks("Nilai: A");
} kalau nilai >= 80 {
    Sistem::cetak_teks("Nilai: B");
} kalau nilai >= 70 {
    Sistem::cetak_teks("Nilai: C");
} lain {
    Sistem::cetak_teks("Perlu Remedi");
}
```

### Pemilihan `pilih` - `kasus` - `bawaan`:
```tela
ubah opsi = 2;
pilih opsi {
    kasus 1 {
        Sistem::cetak_teks("Menu 1");
    }
    kasus 2 {
        Sistem::cetak_teks("Menu 2");
    }
    bawaan {
        Sistem::cetak_teks("Menu tidak dikenal");
    }
}
```

### Perulangan `untuk`:
```tela
untuk ubah i = 0; i < 5; i = i + 1 {
    Sistem::cetak_bilangan(i);
}
```

### Perulangan `selama`:
```tela
ubah hitung = 3;
selama hitung > 0 {
    Sistem::cetak_bilangan(hitung);
    hitung = hitung - 1;
}
```

---

## 8. Fungsi & Modularitas

### Deklarasi Fungsi:
```tela
fungsi tambah(a: bilangan, b: bilangan) -> bilangan {
    kembalikan a + b;
}

fungsi sapa(nama: teks) {
    Sistem::cetak_teks("Halo " + nama);
}

fungsi utama() {
    ubah hasil = tambah(10, 20);
    Sistem::cetak_bilangan(hasil);
    sapa("Nusantara");
}
```

### Menggunakan Modul:
```tela
gunakan Sistem::*;
gunakan Matematika::*;
gunakan Teks as Str;
```

---

## 9. Struktur Data & Sifat

### Struktur Data (`struktur`):
```tela
struktur Titik {
    x: bilangan,
    y: bilangan,
}

fungsi cetak_titik(t: Titik) {
    Sistem::cetak_bilangan(t.x);
    Sistem::cetak_bilangan(t.y);
}
```

### Sifat (*Traits / Interfaces*):
```tela
sifat DapatDihitung {
    fungsi hitung_luas() -> desimal;
}

struktur Persegi {
    sisi: desimal,
}

untuk_sifat DapatDihitung untuk Persegi {
    fungsi hitung_luas(&ini) -> desimal {
        kembalikan ini.sisi * ini.sisi;
    }
}
```

---

## 10. Keamanan Memori & Pantau Memori

TelaCore menyediakan fitur diagnostik memori langsung pada saat *runtime*:
```tela
fungsi utama() {
    ubah data = "Data Memori Penting";
    
    // Inspeksi pointer dan byte yang dialokasikan di heap
    pantau_memori data {
        Sistem::cetak_teks("Sedang memeriksa alokasi...");
    }
}
```

---

## 11. Konkurensi & Multi-Threading

TelaCore mendukung *multithreading* tingkat sistem operasi melalui kata kunci `tugas` dan `tunggu`:
```tela
fungsi tugas_latar() {
    Sistem::tidur(500);
    Sistem::cetak_teks("Tugas latar selesai.");
}

fungsi utama() {
    ubah t = tugas tugas_latar();
    Sistem::cetak_teks("Menjalankan tugas utama...");
    tunggu t;
    Sistem::cetak_teks("Semua tugas selesai.");
}
```

---

## 12. Interoperabilitas C (FFI)

Memanggil fungsi pustaka C eksternal secara langsung tanpa overhead:
```tela
luar fungsi puts(str: teks) -> bilangan;

fungsi utama() {
    puts("Dipanggil via C standard library!");
}
```

---

## 13. Pustaka Standar (Standard Library)

### Modul `Sistem::`
| Fungsi | Deskripsi |
| :--- | :--- |
| `Sistem::cetak_teks(t: teks)` | Mencetak teks diikuti baris baru |
| `Sistem::cetak_bilangan(b: bilangan)` | Mencetak bilangan bulat |
| `Sistem::cetak_desimal(d: desimal)` | Mencetak angka desimal |
| `Sistem::cetak_baris()` | Mencetak baris baru (`\n`) |
| `Sistem::cetak_karakter(k: karakter)` | Mencetak karakter tunggal |
| `Sistem::baca_bilangan() -> bilangan` | Membaca input bilangan dari pengguna |
| `Sistem::baca_desimal() -> desimal` | Membaca input desimal dari pengguna |
| `Sistem::baca_tombol() -> karakter` | Membaca input tombol keyboard |
| `Sistem::tidur(ms: bilangan)` | Menghentikan program sementara (milidetik) |
| `Sistem::bunyi_bip()` | Membunyikan nada speaker internal |
| `Sistem::keluar(kode: bilangan)` | Menghentikan eksekusi program dengan status code |
| `Sistem::jumlah_argumen() -> bilangan` | Mengembalikan jumlah argumen baris perintah CLI (`argc`) |
| `Sistem::argumen(indeks: bilangan) -> teks` | Mengembalikan argumen baris perintah ke-i (`argv[i]`) |
| `Sistem::eksekusi(perintah: teks) -> bilangan` | Menjalankan perintah shell OS eksternal (`system(cmd)`) |
| `Sistem::jalankan_perintah(perintah: teks) -> bilangan` | Menjalankan perintah shell / terminal sistem operasi dan mengembalikan exit code |
| `Sistem::bersihkan_layar()` | Membersihkan layar konsol terminal (*clear screen*) |
| `Sistem::nama_os() -> teks` | Mengembalikan nama sistem operasi host (`"Windows"`) |
| `Sistem::arsitektur() -> teks` | Mengembalikan arsitektur CPU host (`"x86_64"`) |
| `Sistem::waktu_milidetik() -> bilangan` | Mengembalikan uptime / timestamp berpresisi tinggi dalam milidetik |


### Modul `Teks::`
| Fungsi | Deskripsi |
| :--- | :--- |
| `Teks::panjang(t: teks) -> bilangan` | Menghitung panjang teks |
| `Teks::gabung(a: teks, b: teks) -> teks` | Menggabungkan dua string |
| `Teks::potong(t, awal, panjang) -> teks` | Mengambil cuplikan substring |
| `Teks::ubah_besar(t: teks) -> teks` | Mengubah string ke HURUF BESAR |
| `Teks::ubah_kecil(t: teks) -> teks` | Mengubah string ke huruf kecil |
| `Teks::ganti(teks, cari, ganti) -> teks` | Mengganti kata dalam string |
| `Teks::berisi(sumber, cari) -> logika` | Memeriksa apakah teks memuat kata |
| `Teks::kosong(t: teks) -> logika` | Memeriksa apakah string kosong |
| `Teks::trim(t: teks) -> teks` | Menghapus spasi di awal dan akhir teks |
| `Teks::awalan_sama(t, awalan) -> logika` | Cek awalan kata (startsWith) |
| `Teks::akhiran_sama(t, akhiran) -> logika` | Cek akhiran kata (endsWith) |
| `Teks::karakter_ke(t, indeks) -> karakter` | Mengambil karakter pada indeks |
| `Teks::ulangi(t: teks, n: bilangan) -> teks` | Mengulang string teks sebanyak N kali |
| `Teks::pad_kiri(t: teks, n: bilangan, pengisi: teks) -> teks` | Menyelaraskan teks ke kanan dengan padding di sebelah kiri |
| `Teks::pad_kanan(t: teks, n: bilangan, pengisi: teks) -> teks` | Menyelaraskan teks ke kiri dengan padding di sebelah kanan |
| `Teks::pisah(sumber: teks, pemisah: teks) -> vektor<teks>` | Memecah teks menjadi larik vektor potongan string dinamis |
| `Teks::gabung_vektor(daftar: vektor<teks>, pemisah: teks) -> teks` | Menggabungkan elemen-elemen vektor string menjadi satu teks |

### Modul `Konversi::`
| Fungsi | Deskripsi |
| :--- | :--- |
| `Konversi::teks_ke_bilangan(t) -> bilangan` | Konversi string ke angka bulat |
| `Konversi::bilangan_ke_teks(b) -> teks` | Konversi angka bulat ke string |
| `Konversi::teks_ke_desimal(t) -> desimal` | Konversi string ke angka pecahan |
| `Konversi::desimal_ke_teks(d) -> teks` | Konversi pecahan ke string |
| `Konversi::logika_ke_teks(l) -> teks` | Konversi boolean ke `"benar"`/`"salah"` |
| `Konversi::teks_ke_logika(t) -> logika` | Konversi string ke boolean |
| `Konversi::karakter_ke_teks(k) -> teks` | Konversi karakter ke teks |
| `Konversi::karakter_ke_bilangan(k) -> bilangan` | Nilai ASCII / byte karakter |

### Modul `Matematika::`
| Fungsi | Deskripsi |
| :--- | :--- |
| `Matematika::pi() -> desimal` | Nilai konstanta PI (3.14159...) |
| `Matematika::e() -> desimal` | Nilai konstanta Euler (2.71828...) |
| `Matematika::akar(d: desimal) -> desimal` | Menghitung akar kuadrat |
| `Matematika::pangkat(b, p) -> desimal` | Menghitung pangkat bilangan |
| `Matematika::sin`, `cos`, `tan` | Fungsi trigonometri standar (sudut dalam radian) |
| `Matematika::asin`, `acos`, `atan`, `atan2` | Fungsi invers trigonometri (arcsin, arccos, arctan) |
| `Matematika::hipotenusa(x, y) -> desimal` | Menghitung panjang hipotenusa segitiga $\sqrt{x^2 + y^2}$ |
| `Matematika::pembatas(nilai, min, max) -> desimal` | Membatasi angka desimal pada rentang minimum dan maksimum (*clamp*) |
| `Matematika::pembatas_bilangan(nilai, min, max) -> bilangan` | Membatasi angka bulat pada rentang minimum dan maksimum |
| `Matematika::derajat_ke_radian(derajat) -> desimal` | Mengonversi nilai sudut derajat ke radian |
| `Matematika::radian_ke_derajat(radian) -> desimal` | Mengonversi nilai sudut radian ke derajat |
| `Matematika::logaritma`, `logaritma_alami` | Perhitungan logaritma basis 10 & e |
| `Matematika::pembulatan(d) -> bilangan` | Pembulatan nilai terdekat |
| `Matematika::lantai(d) -> bilangan` | Pembulatan ke bawah (floor) |
| `Matematika::langit(d) -> bilangan` | Pembulatan ke atas (ceil) |
| `Matematika::maksimum(a, b) -> bilangan` | Mencari nilai terbesar |
| `Matematika::minimum(a, b) -> bilangan` | Mencari nilai terkecil |
| `Matematika::acak() -> desimal` | Angka acak 0.0 s.d 1.0 |
| `Matematika::acak_rentang(min, max) -> bilangan` | Angka bulat acak dalam rentang |

### Modul `Berkas::` (File I/O & Direktori)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Berkas::buka_file(path, mode) -> ptr` | Membuka file stream (`"r"`, `"w"`, `"a"`) |
| `Berkas::tulis_teks(file, teks)` | Menulis string ke file stream |
| `Berkas::tulis_desimal(file, desimal)` | Menulis angka desimal ke file stream |
| `Berkas::tulis_semua(path: teks, teks: teks) -> logika` | Menulis seluruh teks langsung ke berkas (tanpa buka/tutup manual) |
| `Berkas::tutup_file(file)` | Menutup file stream |
| `Berkas::baca_semua(path: teks) -> teks` | Membaca seluruh isi file teks ke string |
| `Berkas::ada_file(path: teks) -> logika` | Memeriksa apakah file ada di sistem |
| `Berkas::buat_direktori(path: teks) -> logika` | Membuat direktori/folder baru di sistem |
| `Berkas::apakah_direktori(path: teks) -> logika` | Memeriksa apakah suatu jalur path adalah sebuah direktori/folder |
| `Berkas::hapus_file(path: teks) -> logika` | Menghapus file secara permanen |
| `Berkas::salin_file(sumber: teks, tujuan: teks) -> logika` | Menyalin berkas dari sumber ke lokasi tujuan |
| `Berkas::pindah_file(sumber: teks, tujuan: teks) -> logika` | Memindahkan atau mengganti nama berkas |
| `Berkas::ukuran_file(path: teks) -> bilangan` | Mendapatkan ukuran berkas dalam byte |

### Modul `Waktu::`
| Fungsi | Deskripsi |
| :--- | :--- |
| `Waktu::waktu_sekarang() -> teks` | Format tanggal & jam (`YYYY-MM-DD HH:MM:SS`) |
| `Waktu::waktu_unix() -> bilangan` | Unix timestamp detik |

### Modul `Koleksi::` (Kamus / Map & Set)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Koleksi::kamus_baru() -> ptr` | Membuat instans kamus (key-value) |
| `Koleksi::simpan(k, kunci, nilai)` | Menyimpan nilai berdasarkan kunci teks |
| `Koleksi::ambil(k, kunci) -> bilangan` | Mengambil nilai dari kamus |
| `Koleksi::ada(k, kunci) -> logika` | Cek keberadaan kunci |
| `Koleksi::panjang_kamus(k) -> bilangan` | Jumlah pasangan kunci-nilai |

### Modul `Warna::` (Terminal Styling & Warna ANSI)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Warna::merah(t: teks) -> teks` | Mewarnai teks menjadi merah cerah |
| `Warna::hijau(t: teks) -> teks` | Mewarnai teks menjadi hijau |
| `Warna::kuning(t: teks) -> teks` | Mewarnai teks menjadi kuning |
| `Warna::biru(t: teks) -> teks` | Mewarnai teks menjadi biru |
| `Warna::magenta(t: teks) -> teks` | Mewarnai teks menjadi magenta |
| `Warna::sian(t: teks) -> teks` | Mewarnai teks menjadi sian (cyan) |
| `Warna::putih(t: teks) -> teks` | Mewarnai teks menjadi putih |
| `Warna::tebal(t: teks) -> teks` | Membuat teks bercetak tebal (*bold*) |
| `Warna::miring(t: teks) -> teks` | Membuat teks bercetak miring (*italic*) |
| `Warna::garis_bawah(t: teks) -> teks` | Memberi garis bawah pada teks (*underline*) |
| `Warna::reset() -> teks` | Mengembalikan warna terminal ke default |

### Modul `Kripto::` (Enkripsi, Hash & Windows CryptoAPI)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Kripto::base64_encode(sumber: teks) -> teks` | Mengubah string teks menjadi representasi Base64 |
| `Kripto::base64_decode(sumber_b64: teks) -> teks` | Mendekode string Base64 kembali ke teks asli |
| `Kripto::hex_encode(sumber: teks) -> teks` | Mengubah string teks menjadi representasi Heksadesimal (*Hex*) |
| `Kripto::hex_decode(sumber_hex: teks) -> teks` | Mendekode representasi Heksadesimal kembali ke teks asli |
| `Kripto::hash_djb2(sumber: teks) -> bilangan` | Menghitung nilai hash 64-bit DJB2 cepat dari teks |
| `Kripto::rot13(sumber: teks) -> teks` | Melakukan substitusi rotasi huruf simetris ROT13 (A-Z, a-z) |
| `Kripto::sha256(sumber: teks) -> teks` | Menghasilkan 64-karakter heksadesimal hash SHA-256 via Win32 CryptoAPI |
| `Kripto::md5(sumber: teks) -> teks` | Menghasilkan 32-karakter heksadesimal hash MD5 via Win32 CryptoAPI |
| `Kripto::crc32(sumber: teks) -> bilangan` | Menghitung checksum CRC-32 (IEEE 802.3) |
| `Kripto::acak_kripto(panjang_byte: bilangan) -> teks` | Menghasilkan string hex acak berkualitas kriptografis via CryptGenRandom |

### Modul `JSON::` (Pemformatan & Serializer JSON)
| Fungsi | Deskripsi |
| :--- | :--- |
| `JSON::buat_objek() -> ptr` | Membuat objek kontainer data JSON baru |
| `JSON::tambah_string(obj: ptr, kunci: teks, nilai: teks)` | Menambahkan field string `{"kunci": "nilai"}` |
| `JSON::tambah_angka(obj: ptr, kunci: teks, nilai: bilangan)` | Menambahkan field integer `{"kunci": 123}` |
| `JSON::tambah_desimal(obj: ptr, kunci: teks, nilai: desimal)` | Menambahkan field desimal `{"kunci": 3.14}` |
| `JSON::tambah_logika(obj: ptr, kunci: teks, nilai: logika)` | Menambahkan field boolean `{"kunci": true/false}` |
| `JSON::ke_string(obj: ptr) -> teks` | Menghasilkan string JSON yang valid |

### Modul `Jaringan::` (HTTP Client & Web API)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Jaringan::ambil_http(url: teks) -> teks` | Melakukan HTTP GET request dan mengembalikan isi respon web/API |
| `Jaringan::kirim_http(url: teks, data: teks) -> teks` | Mengirim data HTTP POST dan mengembalikan isi respon server |
| `Jaringan::kirim_post(url: teks, data: teks) -> teks` | Mengirim data HTTP POST ke endpoint API |
| `Jaringan::kode_status_terakhir() -> bilangan` | Mengembalikan kode status HTTP respon terakhir (200, 404, dll.) |

### Modul `Antarmuka::` (Native Windows GUI Desktop)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Antarmuka::kotak_pesan(judul: teks, pesan: teks)` | Menampilkan kotak dialog popup informasi (*MessageBox*) |
| `Antarmuka::kotak_peringatan(judul: teks, pesan: teks)` | Menampilkan kotak dialog peringatan dengan ikon segitiga kuning |
| `Antarmuka::kotak_kesalahan(judul: teks, pesan: teks)` | Menampilkan kotak dialog kesalahan dengan ikon silang merah |
| `Antarmuka::kotak_konfirmasi(judul: teks, pesan: teks) -> logika` | Menampilkan dialog konfirmasi (Tombol Ya/Tidak) dan mengembalikan `benar` atau `salah` |

### Modul `Benang::` (Thread OS & Hardware CPU)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Benang::tunda(milidetik: bilangan)` | Menunda eksekusi / sleep thread berpresisi tinggi dalam milidetik |
| `Benang::id_saat_ini() -> bilangan` | Mengembalikan ID Thread OS yang sedang aktif |
| `Benang::jumlah_cpu() -> bilangan` | Mendeteksi jumlah core CPU / Processor perangkat keras |

### Modul `Uji::` (Unit Test & Assertion)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Uji::tegaskan(kondisi: logika, pesan: teks)` | Penegasan kondisi; mencetak `[LULUS]` atau `[GAGAL]` |
| `Uji::tegaskan_sama(a: bilangan, b: bilangan, pesan: teks)` | Penegasan kesamaan nilai dua bilangan |
| `Uji::tegaskan_teks_sama(a: teks, b: teks, pesan: teks)` | Penegasan kesamaan nilai dua teks |

### Modul `Suara::` (Audio Multimedia & Efek Suara Game)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Suara::putar_nada(frekuensi_hz: bilangan, durasi_ms: bilangan)` | Memainkan nada audio frekuensi Hertz selama durasi milidetik |
| `Suara::putar_berkas(jalur_file_wav: teks)` | Memutar file suara WAV secara asinkron di latar belakang |
| `Suara::hentikan()` | Menghentikan pemutaran audio aktif |

### Modul `Lingkungan::` (OS Environment & System)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Lingkungan::ambil(kunci: teks) -> teks` | Membaca nilai environment variable sistem |
| `Lingkungan::simpan(kunci: teks, nilai: teks)` | Menetapkan nilai environment variable pada proses aktif |
| `Lingkungan::direktori_kerja() -> teks` | Mengembalikan jalur direktori kerja aktif (*Current Working Directory*) |
| `Lingkungan::nama_pengguna() -> teks` | Mengembalikan nama pengguna OS aktif |

### Modul `Bit::` (Operasi Bitwise Tingkat Rendah & Biner)
| Fungsi | Deskripsi |
| :--- | :--- |
| `Bit::geser_kiri(a: bilangan, n: bilangan) -> bilangan` | Menggeser bit bilangan bulat ke kiri (`a << n`) |
| `Bit::geser_kanan(a: bilangan, n: bilangan) -> bilangan` | Menggeser bit bilangan bulat ke kanan (`a >> n`) |
| `Bit::dan(a: bilangan, b: bilangan) -> bilangan` | Operasi logika bitwise AND (`a & b`) |
| `Bit::atau(a: bilangan, b: bilangan) -> bilangan` | Operasi logika bitwise OR (`a \| b`) |
| `Bit::xor(a: bilangan, b: bilangan) -> bilangan` | Operasi logika bitwise XOR (`a ^ b`) |
| `Bit::bukan(a: bilangan) -> bilangan` | Operasi logika pembalikan bit NOT (`~a`) |
| `Bit::hitung_satu(a: bilangan) -> bilangan` | Menghitung jumlah bit bernilai 1 (*population count / popcount*) |









---

## 14. Dukungan Editor VS Code & Language Server (LSP)

TelaCore dilengkapi dengan **Language Server Protocol (`tela lsp`)** bawaan untuk memberikan pengalaman coding modern kelas dunia.

### Cara Memasang Ekstensi di VS Code:
1. Salin folder `ekstensi-vscode/` ke folder `%USERPROFILE%\.vscode\extensions\telacore-nusantara`.
2. Pastikan file executable `tela.exe` sudah berada di dalam direktori `PATH` sistem Anda.
3. Buka berkas `.tela` di VS Code untuk menikmati:
   - 🔴 **Real-time Diagnostics**: Garis merah bawah (*error squiggles*) otomatis muncul saat ada kesalahan sintaks atau tipe data.
   - 💡 **Intelligent Auto-completion**: Saran kata kunci, tipe data, dan pemanggilan modul standar (`Sistem::*`, `Matematika::*`, `JSON::*`, `Kripto::*`, dll.).
   - ℹ️ **Hover Tooltips**: Arahkan mouse ke kode untuk membaca dokumentasi dan definisi tipe data dalam Bahasa Indonesia.
   - 🎨 **Syntax Highlighting**: Pewarnaan sintaks kaya warna.
   - ⚡ **Snippets**: Snippet instan (`utama`, `fungsi`, `jika`, `selama`, `untuk`, `struktur`, `pantau`).
   - 🔒 **Auto-closing Pairs**: Penutupan otomatis tanda kurung `{ }`, `[ ]`, `( )`, dan tanda kutip `" "`.


---

## 15. Contoh Program Nyata

```tela
gunakan Sistem::*;
gunakan Teks::*;
gunakan Matematika::*;
gunakan Konversi::*;

fungsi hitung_lingkaran(radius: desimal) {
    ubah luas = Matematika::pi() * (radius * radius);
    Sistem::cetak_teks("Radius: " + Konversi::desimal_ke_teks(radius));
    Sistem::cetak_teks("Luas Lingkaran: " + Konversi::desimal_ke_teks(luas));
}

fungsi utama() {
    Sistem::cetak_teks("=== PROGRAM TELACORE NUSANTARA ===");
    hitung_lingkaran(7.0);
}
```

---

## 16. Proyek Demo Resmi

Semua proyek demo tersedia di folder `Project/` dan dapat langsung dikompilasi:

| Proyek | Template | Deskripsi |
| :--- | :--- | :--- |
| `Project/demo_nusantara` | - | **Showcase utama** — 6 bagian (Sistem, Matematika, Kripto, JSON, Koleksi, Uji) |
| `Project/demo_blockchain` | - | Blockchain 4 blok dengan SHA-256 real via Win32 CryptoAPI |
| `Project/demo_ai` | - | Perceptron AI — Gerbang OR & AND, fungsi Sigmoid |
| `Project/demo_api` | rest | REST API Engine — JSON routing, token SHA-256 |
| `Project/demo_database` | berkas | File Database CRUD — 4 record, backup, checksum |
| `Project/demo_stdlib` | - | Showcase 9 modul pustaka standar + 4 unit test |
| `Project/playground_telacore` | - | Playground HTML interaktif |
| `Project/demo_kripto` | - | Suite kriptografi lengkap |
| `Project/demo_rest` | rest | Demo HTTP GET/POST via WinINet |
| `Project/demo_gui` | gui | Native Windows GUI (MessageBox, Dialog) |
| `Project/kalkulatortui` | tui | Kalkulator Terminal UI interaktif |
| `Project/uji_stdlib` | - | Suite pengujian 12 modul — 100% `[LULUS]` |
| `Project/umroh_modern` | - | Aplikasi manajemen keuangan Umroh (Node.js backend) |

### Cara Menjalankan Proyek Demo:
```bash
# Masuk ke folder proyek
cd Project\demo_nusantara

# Kompilasi saja
tela bangun

# Kompilasi + jalankan langsung
tela jalankan

# Kompilasi dengan optimasi (-O3 LLVM)
tela bangun --optimasi

# Hanya hasilkan LLVM IR
tela bangun --hanya-ir

# Benchmark performa
tela ukur --iterasi 10
```

---

## 17. Panduan Pengembang & Tips

### ⚠️ Encoding File: Wajib UTF-8 tanpa BOM

Parser TelaCore menolak file yang mengandung **BOM** (`\u{feff}`).

**❌ SALAH** — PowerShell `Out-File` default menambahkan BOM:
```powershell
"kode" | Out-File file.tela -Encoding UTF8  # SALAH! Ada BOM
```

**✅ BENAR** — Gunakan `[System.IO.File]::WriteAllText` dengan encoding tanpa BOM:
```powershell
$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText("src\main.tela", $kode, $utf8)
```

Atau di VS Code: pastikan status bar bawah menampilkan **`UTF-8`** bukan `UTF-8 with BOM`.

---

### 🚫 Kata Riservasi — Jangan Dipakai sebagai Nama Parameter/Variabel

Kata berikut adalah tipe data bawaan TelaCore — **tidak boleh** digunakan sebagai nama parameter fungsi:

| Kata | Fungsi |
| :--- | :--- |
| `bilangan` | Tipe integer 64-bit |
| `desimal` | Tipe float 64-bit |
| `teks` | Tipe string |
| `logika` | Tipe boolean |
| `karakter` | Tipe char 1-byte |
| `bita` | Tipe byte unsigned |
| `kosong` | Tipe void |

**❌ Salah:**
```tela
fungsi tampil(karakter: teks) { }  // 'karakter' adalah nama tipe!
```

**✅ Benar:**
```tela
fungsi tampil(simbol: teks) { }   // Ganti dengan nama lain
```

---

### 📐 Sintaks Loop `untuk` yang Benar

TelaCore menggunakan sintaks **C-style** untuk loop `untuk`, bukan range iterator:

**❌ Salah (bukan sintaks TelaCore):**
```tela
untuk i dalam 0..10 { }  // TIDAK VALID
```

**✅ Benar:**
```tela
untuk ubah i = 0; i < 10; i = i + 1 {
    Sistem::cetak_bilangan(i);
}
```

---

### 🔧 Nama Fungsi Modul yang Tepat

Beberapa nama fungsi yang sering salah:

| ❌ Salah | ✅ Benar | Modul |
| :--- | :--- | :--- |
| `Teks::huruf_besar()` | `Teks::ubah_besar()` | `Teks::` |
| `Teks::huruf_kecil()` | `Teks::ubah_kecil()` | `Teks::` |
| `Teks::mengandung()` | `Teks::berisi()` | `Teks::` |
| `Teks::pangkas()` | `Teks::trim()` | `Teks::` |
| `JSON::tambah_bilangan()` | `JSON::tambah_angka()` | `JSON::` |
| `Matematika::pi` | `Matematika::pi()` | `Matematika::` |
| `Matematika::e` | `Matematika::e()` | `Matematika::` |
| `Matematika::log10()` | `Matematika::logaritma()` | `Matematika::` |

---

### 🏗️ Arsitektur Proyek Wajib

Setiap proyek TelaCore **harus** memiliki struktur ini:

```
nama_proyek/
├── tela.toml       # Wajib: konfigurasi & dependensi
├── src/
│   └── main.tela   # Wajib: entry point (fungsi utama)
├── bangun/         # Wajib: hasil kompilasi (protela.ll + protela.exe)
└── modul/          # Wajib: modul & paket tambahan
```

Semua proyek harus diletakkan di:
```
telacore_compiler/Project/<nama_proyek>/
```

---

### 💡 Tips Produktivitas

1. **`tela periksa`** — Linter cepat tanpa kompilasi penuh, ideal untuk cek sintaks.
2. **`tela jelaskan E001`** — Penjelasan kode error dalam Bahasa Indonesia.
3. **`tela doc`** — Generate dokumentasi HTML dari komentar `///`.
4. **`tela ukur --iterasi 10`** — Benchmark presisi tinggi.
5. **`tela repl`** — REPL interaktif untuk coba kode langsung.
6. **`tela rilis`** — Buat binary produksi mandiri di folder `rilis/`.

---

## 18. Peta Jalan World-Class

TelaCore telah menyelesaikan **8 Fase pengembangan** menuju kelas dunia:

| Fase | Status | Capaian |
| :--- | :--- | :--- |
| Fase 1 | ✅ | Teks concatenation, Standard Library dasar, Error messages informatif |
| Fase 2 | ✅ | Package manager (`tela tambah/hapus/pasang`), `tela.toml` |
| Fase 3 | ✅ | VS Code extension: syntax highlighting, LSP, snippets, auto-close |
| Fase 4 | ✅ | Buku Panduan Resmi lengkap (PANDUAN_TELACORE.md) |
| Fase 5 | ✅ | Konkurensi native: `Benang::`, kata kunci `tugas` & `tunggu` |
| Fase 6 | ✅ | `Jaringan::` (HTTP WinINet), `Antarmuka::` (Native GUI Windows) |
| Fase 7 | ✅ | LSP, Benchmark, Doc Generator, Rilis produksi, Format & Linter |
| Fase 8 | ✅ | 15 Modul standar lengkap, Kripto lanjutan, Suara, Uji suite |

### 🌏 Posisi Unik TelaCore di Dunia

> **TelaCore adalah satu-satunya bahasa pemrograman di dunia yang menggunakan Bahasa Indonesia secara native di level LLVM IR.**

| Aspek | TelaCore | Rust | C/C++ | Python |
| :--- | :---: | :---: | :---: | :---: |
| Bahasa sintaks Indonesia | ✅ | ❌ | ❌ | ❌ |
| Native LLVM IR | ✅ | ✅ | ✅ | ❌ |
| Performa native (C-level) | ✅ | ✅ | ✅ | ❌ |
| Cross-platform | ✅ | ✅ | ✅ | ✅ |
| Pustaka standar bawaan | 15 modul | ✅ | ✅ | ✅ |
| VS Code LSP bawaan | ✅ | via plugin | via plugin | via plugin |
| Diagnostic Bahasa Indonesia | ✅ | ❌ | ❌ | ❌ |

### 🚀 Langkah Selanjutnya (Fase 9+)

- **Vektor & Array dinamis** — tipe `vektor<T>` built-in dengan operasi push/pop
- **Generik (Generics)** — fungsi dan struktur dengan tipe parameter `<T>`
- **Penanganan Kesalahan** — `hasil<T, E>` + kata kunci `coba` / `selesaikan`
- **Modul eksternal** — registry paket online `telahub.id`
- **Kompilasi ke WebAssembly** — target `wasm32-unknown-unknown`
- **Borrow Checker Analitik** — keamanan memori tanpa GC
- **Makro Prosedural** — metaprogramming Bahasa Indonesia
