**Bahasa Pemrograman Tingkat Sistem Berbahasa Indonesia-Hybrid Modern**

---

## 🧭 PENDAHULUAN

### Filosofi & Visi TELACORE Nusantara
Pemrograman tingkat sistem (*systems programming*) secara historis selalu menjadi bidang yang sulit dimasuki. Bahasa seperti C++ dan Rust menawarkan performa maksimal tanpa *Garbage Collector*, tetapi menuntut kurva pembelajaran yang curam serta sintaksis matematika abstrak yang dingin.

**TELACORE NUSANTARA** lahir untuk mendekatkan pemrograman tingkat rendah kepada pengembang Indonesia dengan mengombinasikan **Ergonomi Bahasa Indonesia**, **Standar Teknis Global (LLVM & C-FFI)**, serta **Performa Maksimal Tanpa GC**.

### Perbandingan Singkat dengan Bahasa Lain
| Karakteristik | Python | C | C++ | Rust | Go | **TELACORE** |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Garbage Collector** | Ya | Tidak | Tidak | Tidak | Ya | **Tidak** |
| **Akses Pointer** | Tidak | Bebas (Bahaya) | Bebas | Ketat | Terbatas | **Ketat & Visual** |
| **Pencegahan Crash** | Runtime | Tidak | Tidak | Compile-time | Runtime | **Blok `aman` (Otomatis)** |
| **Gaya Sintaksis** | Bahasa Inggris | Simbolik | Sangat Kompleks | Sangat Abstrak | Bahasa Inggris | **Indonesia-Hybrid** |

### Telacore Ini Untuk Siapa?
Catatan ini ditujukan bagi:
1. **Pemula** yang ingin mempelajari manajemen memori komputer tanpa frustrasi oleh *borrow checker* yang kaku.
2. **Developer Aplikasi** (Web/Mobile) yang ingin mempelajari cara kerja sistem operasi secara mendalam.
3. **Pendidik & Mahasiswa** di Indonesia untuk mempercepat pemahaman ilmu komputer dasar lewat bahasa ibu.

---

## 📦 BAGIAN I: MEMULAI DENGAN PROYEK NYATA

### BAB 1: MENGENAL TELACORE & ALAT BARIS PERINTAH `tela`

#### 1.1 Apa itu Kompilator TELACORE?
Kompilator TELACORE menerjemahkan berkas sumber `.tela` menjadi representasi perantara **LLVM IR** (`.ll`), yang kemudian dioptimalkan secara otomatis ke dalam arsitektur mesin asli (seperti `.exe` di Windows atau biner ELF di Linux) melalui perangkat *Clang*.

#### 1.2 Cara Menginstal TELACORE
1. **Windows**: Unduh Clang/LLVM dan tambahkan biner `tela.exe` ke variabel lingkungan `PATH` sistem Anda.
2. **Linux & macOS**: Instal dependensi llvm-compiler:
   ```bash
   sudo apt install clang lld  # Debian/Ubuntu
   ```

#### 1.3 Mengenal Alat Bantu `tela`
Kompilasi dan manajemen proyek dikelola melalui perintah berikut:
* `tela buat <nama_proyek>`: Inisialisasi struktur folder.
* `tela bangun`: Kompilasi berkas LLVM IR ke folder `bangun/`.
* `tela jalankan`: Kompilasi sekaligus mengeksekusi biner.
* `tela uji`: Menjalankan fungsi pengujian dengan penanda `@uji`.

#### 1.4 Proyek Pertama: "Halo Nusantara!"
Buat berkas `src/utama.tela`:
```tela
fungsi utama() {
    Sistem::cetak_teks("Halo Nusantara! Selamat datang di Tela Core.");
}
```
Jalankan perintah `tela jalankan`. Hasil cetak akan muncul di layar konsol Anda secara instan.

---

### BAB 2: PROYEK 1 – KALKULATOR ILMIAH ANTARMUKA TERMINAL (TUI)

Kalkulator ini menggunakan kontrol ANSI terminal untuk mempercantik tata letak konsol tanpa dependensi berat.

#### 2.1 Membangun Modul Kontrol Terminal (`src/tui.tela`)
```tela
gunakan Sistem::*;

fungsi tui_bersihkan_layar() {
    cetak_teks("\e[2J\e[H");
}

fungsi tui_sembunyikan_kursor() {
    cetak_teks("\e[?25l");
}

fungsi tui_posisi(baris: bilangan, kolom: bilangan) {
    // Simulasi pengaturan kursor manual via ANSI Escape Codes
    cetak_teks("\e[");
    cetak_bilangan(baris);
    cetak_teks(";");
    cetak_bilangan(kolom);
    cetak_teks("H");
}
```

#### 2.2 Logika Perhitungan & Program Utama (`src/utama.tela`)
```tela
impor "src/tui.tela";
gunakan Sistem::*;

fungsi hitung(a: desimal, b: desimal, op: teks) -> desimal {
    // Penanganan pembagian dengan nol menggunakan pengaman bersyarat
    jika (op == "/") maka {
        jika (b == 0.0) maka {
            cetak_teks("⚠️ Peringatan: Pembagian dengan nol terdeteksi.");
            kembalikan 0.0;
        }
        kembalikan a / b;
    }
    jika (op == "+") maka { kembalikan a + b; }
    jika (op == "-") maka { kembalikan a - b; }
    jika (op == "*") maka { kembalikan a * b; }
    kembalikan 0.0;
}

fungsi utama() {
    tui_bersihkan_layar();
    tui_sembunyikan_kursor();
    tui_posisi(2, 5);
    
    cetak_teks("=== KALKULATOR TELACORE TUI ===");
    ubah x: desimal = 75.5;
    ubah y: desimal = 0.0;
    
    tui_posisi(4, 5);
    cetak_teks("Hasil Pembagian: ");
    ubah hasil = hitung(x, y, "/");
    cetak_desimal(hasil);
}
```

---

### BAB 3: PROYEK 2 – ALARM WAKTU & UTAS ASINKRON

Tela Core menyederhanakan pemrograman paralel dengan memperkenalkan fungsi asinkron via `tugas` (task) dan `tunggu` (await).

#### 3.1 Prosedur Utas Latar Belakang (`src/utama.tela`)
```tela
gunakan Sistem::*;
gunakan Waktu::*;

tugas fungsi bunyi_alarm(detik: bilangan) -> logika {
    cetak_teks("🕒 Utas Alarm: Menghitung mundur waktu...");
    ubah i = 0;
    selama (i < detik) {
        Sistem::bunyi_bip();
        i = i + 1;
    }
    cetak_teks("⏰ KRINGGG! Waktu habis!");
    kembalikan benar;
}

fungsi utama() {
    cetak_teks("Fungsi Utama: Memulai Alarm di latar belakang...");
    ubah alarm_tugas = bunyi_alarm(5);
    
    cetak_teks("Fungsi Utama: Tetap berjalan melakukan proses lain...");
    
    // Menunggu utas alarm latar belakang selesai
    ubah sukses = tunggu alarm_tugas;
    jika (sukses) maka {
        cetak_teks("Fungsi Utama: Alarm berhasil didengar.");
    }
}
```

---

### BAB 4: PROYEK 3 – PENGELOLA BERKAS SEDERHANA

Membaca dan menulis berkas sistem menggunakan modul pustaka bawaan `Berkas`.

#### 4.1 Logika Aktivitas Berkas Log (`src/utama.tela`)
```tela
gunakan Sistem::*;
gunakan Berkas::*;

fungsi utama() {
    ubah path_berkas: teks = "aktivitas.log";
    
    // Membuka berkas dengan mode 'tulis' (write)
    ubah f = buka_file(path_berkas, "w");
    tulis_teks(f, "Log Aktivitas: Tela Core berhasil merekam operasi sistem berkas.\n");
    tutup_file(f);
    cetak_teks("✅ Berkas log berhasil ditulis!");
    
    // Membaca berkas
    // Catatan: modul sistem dapat melacak isi melalui buffer stream
}
```

---

## 🧠 BAGIAN II: DASAR BAHASA & ARSITEKTUR INTI

### BAB 5: SISTEM TIPE, VARIABEL & KONSTANTA

#### 5.1 Tipe Data Dasar
* **`bilangan`**: Representasi integer signed 64-bit (`i64`).
* **`desimal`**: Representasi float presisi ganda 64-bit (`double`).
* **`logika`**: Boolean (`benar` atau `salah`).
* **`teks`**: String literal bertipe pointer null-terminated C-string.

#### 5.2 Deklarasi Variabel & Konstanta
* Variabel yang nilainya dapat diubah menggunakan kata kunci **`ubah`**:
  ```tela
  ubah skor: bilangan = 100;
  ```
* Konstanta menggunakan kata kunci **`tetap`**:
  ```tela
  tetap PI: desimal = 3.14159;
  ```

---

### BAB 6: ALUR KENDALI PROGRAM

#### 6.1 Percabangan Keputusan
```tela
jika (skor > 80) maka {
    Sistem::cetak_teks("Nilai A");
} lain jika (skor > 60) maka {
    Sistem::cetak_teks("Nilai B");
} lain {
    Sistem::cetak_teks("Remidi");
}
```

#### 6.2 Perulangan
```tela
ubah i = 1;
selama (i <= 5) {
    jika (i == 3) maka {
        i = i + 1;
        lanjut; // Lewati angka 3
    }
    Sistem::cetak_bilangan(i);
    i = i + 1;
}
```

---

### BAB 7: FUNGSI & MODUL

#### 7.1 Definisi Fungsi
```tela
fungsi tambah(a: bilangan, b: bilangan) -> bilangan {
    kembalikan a + b;
}
```

#### 7.2 Impor & Modul Namespace
Kode Tela Core dipisahkan menggunakan kata kunci `impor` dan nama ruang lingkup diakses menggunakan operator titik dua ganda `::`.
```tela
impor "src/matematika.tela";
gunakan Matematika::*;
```

---

### BAB 8: KEPEMILIKAN & PEMINJAMAN MEMORI

Manajemen memori Tela Core didasarkan pada tiga aturan penjamin keamanan (*ownership*):
1. **Aturan Kepemilikan Tunggal**: Setiap data di dalam memori heap memiliki satu variabel penanggung jawab (pemilik).
2. **Peminjaman Nilai**: Referensi aman dibedakan menjadi:
   - Peminjaman baca menggunakan operator ampersand `&`.
   - Peminjaman tulis menggunakan modifier `&ubah`.
3. **Pelepasan Otomatis**: Saat variabel keluar dari ruang lingkup (*scope*), kompiler secara otomatis menyisipkan kode pelepasan memori.

---

### BAB 9: VISUALISASI MEMORI DENGAN `pantau_memori`

Kata kunci **`pantau_memori`** adalah fitur visualizer runtime bawaan Tela Core untuk memeriksa isi alokasi memori fisik variabel:
```tela
fungsi utama() {
    ubah skor: bilangan = 250;
    pantau_memori skor;
}
```
Menghasilkan output runtime komprehensif pada layar konsol:
```
========================================
[PANTAU MEMORI: skor]
  Alamat Pointer : 00000019AF5DFB90
  Tipe Data      : bilangan (i64)
  Ukuran Memori  : 8 byte
========================================
```

---

### BAB 10: STRUKTUR DATA, SIFAT & POLIMORFISME

#### 10.1 Membuat Struktur Data dengan `bentuk`
```tela
bentuk Manusia {
    nama: teks,
    umur: bilangan
}
```

#### 10.2 Antarmuka dengan `sifat` (Interface)
```tela
sifat Pekerja {
    fungsi bekerja() -> kosong;
}

implementasi Pekerja untuk Manusia {
    fungsi bekerja() {
        Sistem::cetak_teks("Sedang mengetik kode...");
    }
}
```

---

### BAB 11: PENANGANAN KESALAHAN & PENCOCOKAN POLA

Monad `Hasil<Sukses, Gagal>` dan struktur pencocokan pola `cocokkan` (pattern matching):
```tela
fungsi periksa_angka(n: bilangan) -> Hasil<teks, teks> {
    jika (n > 0) maka {
        kembalikan Sukses("Angka Positif");
    }
    kembalikan Gagal("Angka Negatif");
}

fungsi utama() {
    ubah res = periksa_angka(-5);
    cocokkan res {
        Sukses(msg) => Sistem::cetak_teks(msg),
        Gagal(err) => Sistem::cetak_teks(err),
    }
}
```

---

## 🛠 BAGIAN III: PENGEMBANGAN SISTEM TINGKAT LANJUT

### BAB 12: KODE TIDAK AMAN & PEMANGGILAN FUNGSI LUAR (FFI)

Sistem operasi dan API hardware memerlukan pemanggilan fungsi bahasa C (FFI). Gunakan kata kunci `asing` dan jalankan di dalam blok `bahaya` (unsafe block):
```tela
// FFI memanggil fungsi libc standard C
asing fungsi putchar(c: bilangan) -> bilangan;

fungsi utama() {
    ubah karakter: bilangan = 65; // Kode ASCII untuk 'A'
    bahaya {
        putchar(karakter);
    }
}
```

---

### BAB 13: ALAT BANTU PENGEMBANGAN & ARGUMEN BARIS PERINTAH

Membaca input baris perintah menggunakan metode `Sistem::argumen()` yang mengembalikan vektor string:
```tela
fungsi utama() {
    ubah args = Sistem::argumen();
    jika (args.len() > 1) maka {
        Sistem::cetak_teks("Argumen Pertama:");
        // Cetak parameter CLI
    }
}
```

---

### BAB 14: PENCATATAN PERISTIWA, PEMERIKSAAN & PELACAKAN

Tingkat logging terstruktur digunakan untuk pelacakan alur debug sistem:
```tela
fungsi utama() {
    Sistem::log_info("Aplikasi backend dimulai.");
    Sistem::log_debug("Alamat memori dialokasikan.");
    Sistem::log_warning("Koneksi lambat terdeteksi.");
    Sistem::log_error("Gagal terhubung database.");
}
```

---

### BAB 15: KOMUNIKASI JARINGAN

Menggunakan komunikasi socket TCP bawaan Tela Core:
```tela
gunakan Jaringan::*;

fungsi hubungkan_server() {
    ubah soket = Socket::hubungkan("127.0.0.1", 9000);
    Socket::kirim(soket, "Halo dari Client Tela!\n");
    Socket::tutup(soket);
}
```

---

### BAB 16: INTEGRASI PANGKALAN DATA

Menghubungkan aplikasi ke SQLite pangkalan data melalui C-FFI:
```tela
asing fungsi sqlite3_open(nama_db: teks, db: ptr) -> bilangan;
asing fungsi sqlite3_close(db: ptr) -> bilangan;

fungsi utama() {
    ubah db_ptr: ptr = null;
    ubah rc = sqlite3_open("aplikasi.db", &db_ptr);
    jika (rc == 0) maka {
        Sistem::cetak_teks("Database SQLite berhasil terhubung!");
        sqlite3_close(db_ptr);
    }
}
```

---

### BAB 17: KOMPILASI SILANG & PENYEBARAN

Kompilator Tela mendukung kompilasi silang ke target mesin lain melalui target triple LLVM:
```cmd
# Kompilasi dari Windows ke biner Linux 64-bit
tela bangun --target x86_64-unknown-linux-gnu

# Kompilasi ke perangkat mikro ARM
tela bangun --target aarch64-unknown-linux-gnu
```

---

### BAB 18: LATIHAN MEMBUAT APLIKASI DENGAN TELACORE

#### 18.1 Membuat Game Snake
Game Snake berbasis TUI ini mendeteksi penekanan tombol keyboard non-blocking untuk memperbarui pergerakan arah ular di dalam matriks terminal.
```tela
// Implementasi ringkas Snake arena
fungsi render_arena(lebar: bilangan, tinggi: bilangan, x_ular: bilangan, y_ular: bilangan) {
    ubah y = 0;
    selama (y < tinggi) {
        ubah x = 0;
        selama (x < lebar) {
            jika (x == x_ular && y == y_ular) maka {
                Sistem::cetak_teks("O"); // Kepala Ular
            } lain {
                Sistem::cetak_teks("."); // Arena
            }
            x = x + 1;
        }
        Sistem::cetak_teks("\n");
        y = y + 1;
    }
}
```

#### 18.2 Membuat Aplikasi Kasir TUI
Menerima item belanja, menjumlahkan harga subtotal, membebankan pajak, dan mencetak nota transaksi.
```tela
bentuk Item {
    nama: teks,
    harga: bilangan
}

fungsi utama() {
    ubah item1 = Item { nama: "Buku Panduan", harga: 45000 };
    ubah item2 = Item { nama: "Kopi Hitam", harga: 15000 };
    
    ubah subtotal = item1.harga + item2.harga;
    ubah pajak = subtotal / 10; // Pajak 10%
    ubah total = subtotal + pajak;
    
    Sistem::cetak_teks("=== NOTA TRANSAKSI KASIR ===");
    Sistem::cetak_teks(item1.nama);
    Sistem::cetak_bilangan(item1.harga);
    Sistem::cetak_teks(item2.nama);
    Sistem::cetak_bilangan(item2.harga);
    Sistem::cetak_teks("----------------------------");
    Sistem::cetak_teks("Total Tagihan (+ PPN 10%):");
    Sistem::cetak_bilangan(total);
}
```

#### 18.3 Membuat Game Petualangan
Aplikasi berbasis state engine di mana pemain menjelajahi ruangan melalui CLI input.
```tela
fungsi utama() {
    ubah status_ruangan = 1; // 1: Gerbang, 2: Kastil
    ubah input_pilihan = 2; // Simulasi input dari pemain
    
    Sistem::cetak_teks("Kamu berada di gerbang kastil tua. Ketik 2 untuk masuk...");
    jika (input_pilihan == 2) maka {
        status_ruangan = 2;
        Sistem::cetak_teks("Selamat! Kamu berhasil masuk ke dalam Kastil.");
    } lain {
        Sistem::cetak_teks("Kamu diam di tempat dan diserang naga!");
    }
}
```

#### 18.4 Membuat TELACORE OS (Konseptual & Struktur Kernel)
Merancang sistem operasi konseptual menggunakan pustaka aslinya di mana kernel, bootloader, shared memory, dan manajemen memori terintegrasi langsung:

```
+-------------------------------------------------------------+
|                     TELACORE DESKTOP MANAGER                |
+-------------------------------------------------------------+
|                 APLIKASI BERKAS / FILE MANAGER              |
+-------------------------------------------------------------+
|        SHARED MEMORY INTERFACE (Alokasi IPC antar-aplikasi) |
+-------------------------------------------------------------+
|      KERNEL TELACORE (Manajer Penjadwal Utas & Utas Utas)   |
+-------------------------------------------------------------+
|       BOOTLOADER (Memuat kernel ke memori fisik komputer)   |
+-------------------------------------------------------------+
```

Contoh stub kode alokasi shared memory IPC di tingkat Kernel OS:
```tela
// Alokasi memori bersama antar proses di OS
fungsi alokasi_shared_memory(kunci: bilangan, ukuran: bilangan) -> ptr {
    ubah alamat_fisik: ptr = null;
    bahaya {
        // Pemanggilan syscall kernel alokasi memori halaman
        Sistem::log_info("Alokasi shared memory berhasil dipetakan.");
    }
    kembalikan alamat_fisik;
}
```

---

## 🚀 BAGIAN IV: MATERI TAMBAHAN & LAMPIRAN

### LAMPIRAN A: GLOSARIUM ISTILAH
* **`bilangan`**: Representasi integer signed 64-bit (`i64`).
* **`desimal`**: Representasi float presisi ganda (`double`).
* **`bentuk`**: Alias representasi struktur data kelas / tipe kustom (*struct*).
* **`sifat`**: Antarmuka kontrak fungsi bersama (*trait* / *interface*).
* **`tugas`**: Definisi unit kerja asinkron (*async function*).
* **`tunggu`**: Menghentikan utas hingga tugas asinkron selesai (*await*).
* **`bahaya`**: Blok tidak aman penanda bypass aturan kompiler (*unsafe*).
* **`pribadi`**: Batasan akses item dalam modul (*private*).

### LAMPIRAN B: DAFTAR KATA KUNCI & OPERATOR
* Kata kunci resmi: `ubah`, `tetap`, `fungsi`, `kembalikan`, `jika`, `maka`, `lain`, `selama`, `untuk`, `henti`, `lanjut`, `impor`, `gunakan`, `sifat`, `implementasi`, `tugas`, `tunggu`, `bahaya`, `asing`, `bentuk`, `aman`, `pantau_memori`.
* Operator:
  - Aritmatika: `+`, `-`, `*`, `/`.
  - Logika: `dan`, `atau`, `!`.
  - Hubungan: `==`, `!=`, `<`, `>`, `<=`, `>=`.

### LAMPIRAN C: RINGKASAN PERINTAH `tela`
* `tela buat <proyek>`: Inisialisasi folder proyek.
* `tela bangun --target <triple>`: Kompilasi kode ke target mesin spesifik.
* `tela jalankan`: Kompilasi dan eksekusi.
* `tela uji`: Menjalankan suite pengujian unit.

### LAMPIRAN D: PROYEK LANJUTAN
1. **Editor Teks Sederhana CLI**: Menggunakan pembacaan ANSI raw-input untuk membuat klon editor Nano/Vim.
2. **Server Berkas Web (HTTP Server)**: Membaca berkas statis HTML dari disk dan menyajikannya melalui soket TCP port 80.
3. **Dan masih banyak lagi aplikasi-aplikasi yang akan kita bangun melalui telacore, lebih unggul dari pada Bahasa ZORA Kami.

### LAMPIRAN E: SUMBER DAYA & KOMUNITAS
* Repositori Utama: `https://github.com/tela-core/tela`
* Komunitas Telegram: `@telacore_nusantara`
* Kontribusi: Laporkan isu kompiler atau ajukan perubahan kode melalui *pull request* repositori.
