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

#### 1.4 Proyek Pertama: "Halo Dunia!"
Buat berkas `src/utama.tela`:
```tela
fungsi utama() {
    Sistem::cetak_teks("Halo Dunia, Ini dari Tela Core Nusantara!");
}
```
Jalankan perintah `tela jalankan`. Hasil cetak akan muncul di layar konsol Anda secara instan.

---

### BAB 2: PROYEK 1 – KALKULATOR ILMIAH ANTARMUKA TERMINAL (TUI)

Kalkulator ini menggunakan kontrol ANSI terminal untuk mempercantik tata letak konsol tanpa dependensi berat.
Full Kode Diperlihatkan Untuk Memperjelas Pengguna Tela Core di Seluruh Dunia Beserta Gambar Hasil Pemrogaman di Folder Screenshoot. 

#### 2.1 Membangun Modul Kontrol Terminal (`src/tui.tela`)
```tela
// ======================================
// PUSTAKA STANDAR TUI TELA CORE
// Dibuat oleh Mbah Suro
// ======================================
gunakan Sistem::*;

// Mengembalikan kursor ke baris 1, kolom 1 tanpa membersihkan layar
fungsi tui_ke_atas() -> kosong {
    cetak_teks("\e[H");
}

// Membersihkan seluruh layar dan memindahkan kursor ke atas
fungsi tui_bersihkan_layar() -> kosong {
    cetak_teks("\e[2J\e[H");
}

// Menyembunyikan kursor (bagus untuk UI Kalkulator)
fungsi tui_sembunyikan_kursor() -> kosong {
    cetak_teks("\e[?25l");
}

// Memunculkan kursor kembali
fungsi tui_tampilkan_kursor() -> kosong {
    cetak_teks("\e[?25h");
}

// Menonaktifkan mode pelacakan mouse (mouse tracking)
fungsi tui_matikan_mouse() -> kosong {
    cetak_teks("\e[?1000l\e[?1015l\e[?1006l");
}

// Mengaktifkan mode pelacakan mouse
fungsi tui_hidupkan_mouse() -> kosong {
    cetak_teks("\e[?1000h\e[?1015h\e[?1006h");
}

// Reset semua gaya warna dan format
fungsi tui_reset_gaya() -> kosong {
    cetak_teks("\e[0m");
}

// =======================
// FUNGSI WARNA DASAR
// =======================

fungsi tui_warna_merah() -> kosong {
    cetak_teks("\e[31m");
}

fungsi tui_warna_hijau() -> kosong {
    cetak_teks("\e[32m");
}

fungsi tui_warna_kuning() -> kosong {
    cetak_teks("\e[33m");
}

fungsi tui_warna_biru() -> kosong {
    cetak_teks("\e[34m");
}

fungsi tui_warna_magenta() -> kosong {
    cetak_teks("\e[35m");
}

fungsi tui_warna_cyan() -> kosong {
    cetak_teks("\e[36m");
}

fungsi tui_warna_putih() -> kosong {
    cetak_teks("\e[37m");
}
fungsi tui_warna_hitam() -> kosong {
    cetak_teks("\e[30m");
}

// =======================
// FUNGSI WARNA TEBAL (BOLD)
// =======================

fungsi tui_warna_merah_tebal() -> kosong {
    cetak_teks("\e[31;1m");
}

fungsi tui_warna_kuning_tebal() -> kosong {
    cetak_teks("\e[33;1m");
}

fungsi tui_warna_magenta_tebal() -> kosong {
    cetak_teks("\e[35;1m");
}

fungsi tui_warna_putih_tebal() -> kosong {
    cetak_teks("\e[37;1m");
}

// =======================
// FUNGSI LATAR BELAKANG (BACKGROUND)
// =======================

fungsi tui_latar_hitam() -> kosong {
    cetak_teks("\e[40m");
}

fungsi tui_latar_merah() -> kosong {
    cetak_teks("\e[41m");
}

fungsi tui_latar_biru() -> kosong {
    cetak_teks("\e[44m");
}

fungsi tui_latar_cyan() -> kosong {
    cetak_teks("\e[46m");
}

fungsi tui_latar_putih() -> kosong {
    cetak_teks("\e[47m");
}

fungsi tui_kursor_kolom_9() -> kosong {
    cetak_teks("\e[9G");
}

fungsi tui_kursor_kolom_46() -> kosong {
    cetak_teks("\e[46G");
}


```

#### 2.2 Logika Perhitungan & Program Utama (`src/utama.tela`)
```tela
impor "src/tui.tela";
gunakan Sistem::*;
gunakan Matematika::*;
gunakan Berkas::*;
gunakan Waktu::*;

// ======================================
// KALKULATOR TUI TELA CORE - VISUAL GUI ANSI
// ======================================

fungsi gambar_kalkulator(kiri: desimal, kanan: desimal, op: bilangan, fokus: bilangan, ngetik_kanan: bilangan) -> kosong {
    // Gunakan \e[H untuk kembali ke atas (TANPA clear screen) agar tidak ada kedipan/delay!
    // Gabung string bagian atas UI untuk kecepatan tinggi
    // =========================================================================
    // PERINGATAN: JANGAN ASAL MENAMBAHKAN BARIS BARU (\n) PADA STRING DI BAWAH INI!
    // =========================================================================
    // Jika Anda menambahkan baris baru (seperti enter / \n), maka kordinat Y dari 
    // tombol-tombol di bawahnya akan ikut turun/bergeser. Jika bergeser, Anda WAJIB
    // menyesuaikan angka `y` di dalam fungsi `tangkap_mouse()` yang ada di bawah.
    // =========================================================================
    cetak_teks("\e[H\e[?25l\e[44m\e[37;1m ╔════════════════════════════════════════════════════════════╗ \n ║                   Calculator Telacore                      ║ \n ╠════════════════════════════════════════════════════════════╣ \n ║                                                            ║ \n ║    [ \e[47m\e[30m                                                 \e[9G");
    
    jika (fokus == 0) maka {
        cetak_desimal(kiri);
    } lainnya {
        jika (fokus == 1) maka {
            cetak_desimal(kiri);
            jika (op == 1) maka { cetak_teks(" + "); }
            jika (op == 2) maka { cetak_teks(" - "); }
            jika (op == 3) maka { cetak_teks(" * "); }
            jika (op == 4) maka { cetak_teks(" / "); }
            jika (op == 5) maka { cetak_teks(" ^ "); }
            
            jika (ngetik_kanan == 1) maka {
                cetak_desimal(kanan);
            }
        } lainnya {
            // fokus == 2 (hasil)
            cetak_desimal(kiri);
        }
    }
    
    // Gabung string bagian bawah UI untuk rendering secepat kilat (0 delay)
    cetak_teks("\e[58G\e[44m\e[37;1m ]   ║ \n ║                                                            ║ \n ║    \e[45m\e[37;1m sin  \e[44m\e[37;1m     \e[46m\e[31;1m  M+  \e[44m\e[37;1m     \e[46m\e[31;1m  M-  \e[44m\e[37;1m     \e[46m\e[31;1m  MR  \e[44m\e[37;1m     \e[46m\e[31;1m  MC  \e[44m\e[37;1m      ║ \n ║                                                            ║ \n ║    \e[45m\e[37;1m cos  \e[44m\e[37;1m     \e[46m\e[30m  +   \e[44m\e[37;1m     \e[46m\e[30m  -   \e[44m\e[37;1m     \e[46m\e[30m  *   \e[44m\e[37;1m     \e[46m\e[30m  /   \e[44m\e[37;1m      ║ \n ║                                                            ║ \n ║    \e[45m\e[37;1m tan  \e[44m\e[37;1m     \e[46m\e[30m  7   \e[44m\e[37;1m     \e[46m\e[30m  8   \e[44m\e[37;1m     \e[46m\e[30m  9   \e[44m\e[37;1m     \e[46m\e[31;1m Off  \e[44m\e[37;1m      ║ \n ║                                                            ║ \n ║    \e[45m\e[37;1m log  \e[44m\e[37;1m     \e[46m\e[30m  4   \e[44m\e[37;1m     \e[46m\e[30m  5   \e[44m\e[37;1m     \e[46m\e[30m  6   \e[44m\e[37;1m     \e[46m\e[31;1m  C   \e[44m\e[37;1m      ║ \n ║                                                            ║ \n ║    \e[45m\e[37;1m sqrt \e[44m\e[37;1m     \e[46m\e[30m  1   \e[44m\e[37;1m     \e[46m\e[30m  2   \e[44m\e[37;1m     \e[46m\e[30m  3   \e[44m\e[37;1m     \e[46m\e[31;1m  CE  \e[44m\e[37;1m      ║ \n ║                                                            ║ \n ║    \e[45m\e[37;1m ^    \e[44m\e[37;1m     \e[46m\e[30m  0   \e[44m\e[37;1m     \e[46m\e[30m  .   \e[44m\e[37;1m     \e[46m\e[30m Del  \e[44m\e[37;1m     \e[46m\e[30m  =   \e[44m\e[37;1m      ║ \n ╚════════════════════════════════════════════════════════════╝ \n\e[0m\n \e[33mInfo:\e[0m Klik langsung di GUI kalkulator! \n Tekan \e[31m[?]\e[0m di keyboard untuk Menu Bantuan.\n Ini Adalah Aplikasi Yg Dibuat Dari Telacore Ashura\n");
    kembalikan;
}

fungsi layar_bantuan() -> kosong {
    cetak_teks("\e[2J\e[H"); 
    cetak_teks("\e[44m\e[37;1m");
    cetak_teks(" ╔════════════════════════════════════════════════════════════════════╗ \n");
    cetak_teks(" ║                         MENU BANTUAN TELA                          ║ \n");
    cetak_teks(" ╠════════════════════════════════════════════════════════════════════╣ \n");
    cetak_teks(" ║ Made In Mbah Suro | Kontak: 085325399007                           ║ \n");
    cetak_teks(" ║ Email   : kasirom97@gmail.com                                      ║ \n");
    cetak_teks(" ║                                                                    ║ \n");
    cetak_teks(" ║ PETUNJUK TOMBOL SPESIAL & SCIENTIFIC:                              ║ \n");
    cetak_teks(" ║ 1. M+   : Menambahkan nilai layar ke memori                        ║ \n");
    cetak_teks(" ║    Cth  : Ketik 10, klik M+, memori jadi 10                        ║ \n");
    cetak_teks(" ║ 2. M-   : Mengurangi nilai layar dari memori                       ║ \n");
    cetak_teks(" ║    Cth  : Ketik 2, klik M-, memori jadi 8                          ║ \n");
    cetak_teks(" ║ 3. MR   : Menampilkan (Recall) nilai memori                        ║ \n");
    cetak_teks(" ║ 4. MC   : Menghapus (Clear) isi memori jadi 0                      ║ \n");
    cetak_teks(" ║ 5. sin  : Menghitung nilai Sinus (dalam radian). Cth: 0 sin = 0    ║ \n");
    cetak_teks(" ║ 6. cos  : Menghitung nilai Cosinus. Cth: 0 cos = 1                 ║ \n");
    cetak_teks(" ║ 7. tan  : Menghitung nilai Tangen.                                 ║ \n");
    cetak_teks(" ║ 8. log  : Menghitung Logaritma (basis 10). Cth: 100 log = 2        ║ \n");
    cetak_teks(" ║ 9. sqrt : Menghitung Akar Kuadrat. Cth: 144 sqrt = 12              ║ \n");
    cetak_teks(" ║ 10. ^   : Menghitung Pangkat. Cth: 2 ^ 3 = 8                       ║ \n");
    cetak_teks(" ║ 11. CE  : Clear Error (Hapus angka ketikan saat ini saja)          ║ \n");
    cetak_teks(" ║ 12. C   : Clear All (Reset semua perhitungan awal)                 ║ \n");
    cetak_teks(" ║ 13. Off : Keluar dari Aplikasi Kalkulator                          ║ \n");
    cetak_teks(" ║                                                                    ║ \n");
    cetak_teks(" ║ Tekan sembarang tombol untuk kembali...                            ║ \n");
    cetak_teks(" ╚════════════════════════════════════════════════════════════════════╝ \n");
    cetak_teks("\e[0m\n"); 
    
    // Tunggu input sekali
    baca_tombol();
    kembalikan;
}

fungsi hitung(a: desimal, b: desimal, op: bilangan) -> desimal {
    jika (op == 1) maka { kembalikan a + b; }
    jika (op == 2) maka { kembalikan a - b; }
    jika (op == 3) maka { kembalikan a * b; }
    jika (op == 4) maka {
        jika (b == 0) maka {
            kembalikan a;
        }
        kembalikan a / b;
    }
    jika (op == 5) maka { kembalikan pangkat(a, b); }
    kembalikan a;
}

fungsi tangkap_mouse(koordinat: bilangan) -> bilangan {
    ubah y: bilangan = koordinat - ((koordinat / 1000) * 1000); // 3 digit terakhir adalah Y
    ubah x: bilangan = koordinat / 1000;
    
    // Mapping Koordinat X Baru
    // Kolom: 7-12(btn1), 18-23(btn2), 29-34(btn3), 40-45(btn4), 51-56(btn5)
    ubah kol: bilangan = 0;
    jika (x >= 7 && x <= 12) maka { kol = 1; }
    jika (x >= 18 && x <= 23) maka { kol = 2; }
    jika (x >= 29 && x <= 34) maka { kol = 3; }
    jika (x >= 40 && x <= 45) maka { kol = 4; }
    jika (x >= 51 && x <= 56) maka { kol = 5; }
    
    jika (kol == 0) maka { kembalikan 0; }
    
    // =========================================================================
    // MAPPING KOORDINAT Y (BARIS LAYAR)
    // =========================================================================
    // Y adalah nomor baris di terminal. Baris ke-1 dimulai dari "╔════...".
    // Saat ini baris tombol adalah:
    // Baris 7: Tombol-tombol M (sin, M+, dll)
    // Baris 9: Tombol Operator (cos, +, dll)
    // Baris 11: Tombol Angka Atas (tan, 7, 8, 9, Off)
    // Baris 13: Tombol Angka Tengah (log, 4, 5, 6, C)
    // Baris 15: Tombol Angka Bawah (sqrt, 1, 2, 3, CE)
    // Baris 17: Tombol Bawah Sendiri (^, 0, ., Del, =)
    //
    // PENTING: Jika Anda mengedit desain UI di fungsi `gambar_kalkulator()` dan
    // menambahkan baris teks baru di atas kalkulator, nilai-nilai `y` di bawah
    // ini WAJIB Anda tambah/kurangi sesuai jumlah baris yang bergeser!
    // =========================================================================
    jika (y == 7) maka {
        jika (kol == 1) maka { kembalikan 301; } // sin
        jika (kol == 2) maka { kembalikan 201; } // M+
        jika (kol == 3) maka { kembalikan 202; } // M-
        jika (kol == 4) maka { kembalikan 203; } // MR
        jika (kol == 5) maka { kembalikan 204; } // MC
    }
    jika (y == 9) maka {
        jika (kol == 1) maka { kembalikan 302; } // cos
        jika (kol == 2) maka { kembalikan 43; } // +
        jika (kol == 3) maka { kembalikan 45; } // -
        jika (kol == 4) maka { kembalikan 42; } // *
        jika (kol == 5) maka { kembalikan 47; } // /
    }
    jika (y == 11) maka {
        jika (kol == 1) maka { kembalikan 303; } // tan
        jika (kol == 2) maka { kembalikan 55; } // 7
        jika (kol == 3) maka { kembalikan 56; } // 8
        jika (kol == 4) maka { kembalikan 57; } // 9
        jika (kol == 5) maka { kembalikan 113; } // q (Off)
    }
    jika (y == 13) maka {
        jika (kol == 1) maka { kembalikan 304; } // log
        jika (kol == 2) maka { kembalikan 52; } // 4
        jika (kol == 3) maka { kembalikan 53; } // 5
        jika (kol == 4) maka { kembalikan 54; } // 6
        jika (kol == 5) maka { kembalikan 99; } // C
    }
    jika (y == 15) maka {
        jika (kol == 1) maka { kembalikan 305; } // sqrt
        jika (kol == 2) maka { kembalikan 49; } // 1
        jika (kol == 3) maka { kembalikan 50; } // 2
        jika (kol == 4) maka { kembalikan 51; } // 3
        jika (kol == 5) maka { kembalikan 101; } // CE (e)
    }
    jika (y == 17) maka {
        jika (kol == 1) maka { kembalikan 306; } // pow (^)
        jika (kol == 2) maka { kembalikan 48; } // 0
        jika (kol == 3) maka { kembalikan 46; } // .
        jika (kol == 4) maka { kembalikan 8; } // Backspace
        jika (kol == 5) maka { kembalikan 61; } // =
    }
    kembalikan 0;
}

fungsi utama() -> bilangan {
    // Clear screen sekali saja di awal
    cetak_teks("\e[2J");
    // Enable Mouse Tracking di Terminal (SGR Mode)
    cetak_teks("\e[?1000h\e[?1015h\e[?1006h");

    ubah jalan: bilangan = 1;
    ubah layar_kiri: desimal = 0.0;
    ubah layar_kanan: desimal = 0.0;
    ubah memori: desimal = 0.0;
    
    // op: 0=none, 1=+, 2=-, 3=*, 4=/
    ubah op: bilangan = 0; 
    
    // fokus: 0=kiri, 1=kanan, 2=hasil
    ubah fokus: bilangan = 0; 
    ubah ngetik_kanan: bilangan = 0;
    
    gambar_kalkulator(layar_kiri, layar_kanan, op, fokus, ngetik_kanan);

    selama (jalan == 1) {
        ubah tombol: bilangan = baca_tombol();
        
        jika (tombol == 63) maka { // 63 adalah '?'
            layar_bantuan();
            cetak_teks("\e[2J"); // Clear screen sebelum gambar ulang
            gambar_kalkulator(layar_kiri, layar_kanan, op, fokus, ngetik_kanan);
            tombol = 0;
        }
        
        // Cek Escape Sequence untuk Mouse
        jika (tombol == 27) maka {
            ubah c1: bilangan = baca_tombol();
            jika (c1 == 91) maka { // '['
                ubah c2: bilangan = baca_tombol();
                jika (c2 == 60) maka { // '<'
                    // Ini adalah mouse!
                    ubah l_loop: bilangan = 1;
                    selama (l_loop == 1) {
                        ubah cb: bilangan = baca_tombol();
                        jika (cb == 59) maka { l_loop = 0; }
                    }
                    
                    ubah x: bilangan = 0;
                    ubah l_loop2: bilangan = 1;
                    selama (l_loop2 == 1) {
                        ubah cx: bilangan = baca_tombol();
                        jika (cx == 59) maka { l_loop2 = 0; }
                        lainnya { x = x * 10 + (cx - 48); }
                    }
                    
                    ubah y: bilangan = 0;
                    ubah is_press: bilangan = 0;
                    ubah l_loop3: bilangan = 1;
                    selama (l_loop3 == 1) {
                        ubah cy: bilangan = baca_tombol();
                        jika (cy == 77 || cy == 109) maka {
                            jika (cy == 77) maka { is_press = 1; }
                            l_loop3 = 0;
                        } lainnya {
                            y = y * 10 + (cy - 48);
                        }
                    }
                    
                    jika (is_press == 1) maka {
                        tombol = tangkap_mouse(x * 1000 + y);
                        jika (tombol != 0) maka {
                            // Suara beep akan dipanggil di bawah
                        }
                    } lainnya {
                        tombol = 0; // Release diabaikan
                    }
                } lainnya {
                    jika (c2 == 27 || c2 == 81 || c2 == 113) maka { jalan = 0; }
                }
            } lainnya {
                // Tombol esc saja untuk off
                jalan = 0;
            }
        }
        
        // Proses logic kalkulator
        jika (tombol != 0) maka {
            bunyi_bip(); // Bunyi untuk semua input (mouse & keyboard)
            // Cek Memory
            jika (tombol >= 201 && tombol <= 204) maka {
                jika (tombol == 201) maka { memori = memori + layar_kiri; }
                jika (tombol == 202) maka { memori = memori - layar_kiri; }
                jika (tombol == 203) maka { 
                    jika (fokus == 0 || fokus == 2) maka {
                        layar_kiri = memori;
                    } lainnya {
                        layar_kanan = memori;
                        ngetik_kanan = 1;
                    }
                }
                jika (tombol == 204) maka { memori = 0.0; }
            } lainnya {
                // Cek Scientific (Unary: 301-305)
                jika (tombol >= 301 && tombol <= 305) maka {
                    ubah target: desimal = layar_kiri;
                    jika (fokus == 1 && ngetik_kanan == 1) maka {
                        target = layar_kanan;
                    }
                    
                    jika (tombol == 301) maka { target = sin(target); }
                    jika (tombol == 302) maka { target = cos(target); }
                    jika (tombol == 303) maka { target = tan(target); }
                    jika (tombol == 304) maka { target = logaritma(target); }
                    jika (tombol == 305) maka { target = akar(target); }
                    
                    jika (fokus == 1 && ngetik_kanan == 1) maka {
                        layar_kanan = target;
                    } lainnya {
                        layar_kiri = target;
                        fokus = 2; // Paksa jadi hasil jika diterapkan ke layar kiri
                    }
                } lainnya {
                // Cek jika tombol adalah digit 0-9 (ASCII 48 - 57)
                jika (tombol >= 48 && tombol <= 57) maka {
                ubah digit: bilangan = tombol - 48;
                
                jika (fokus == 2) maka {
                    layar_kiri = 0.0 + digit;
                    fokus = 0;
                    op = 0;
                } lainnya {
                    jika (fokus == 0) maka {
                        layar_kiri = layar_kiri * 10.0 + digit;
                    } lainnya {
                        layar_kanan = layar_kanan * 10.0 + digit;
                        ngetik_kanan = 1;
                    }
                }
            } lainnya {
                // Cek operator: + (43), - (45), * (42), / (47), ^ (306)
                jika (tombol == 43 || tombol == 45 || tombol == 42 || tombol == 47 || tombol == 306) maka {
                    ubah new_op: bilangan = 0;
                    jika (tombol == 43) maka { new_op = 1; }
                    jika (tombol == 45) maka { new_op = 2; }
                    jika (tombol == 42) maka { new_op = 3; }
                    jika (tombol == 47) maka { new_op = 4; }
                    jika (tombol == 306) maka { new_op = 5; }
                    
                    jika (fokus == 1 && ngetik_kanan == 1) maka {
                        layar_kiri = hitung(layar_kiri, layar_kanan, op);
                    } 
                    
                    layar_kanan = 0.0;
                    op = new_op;
                    fokus = 1; 
                    ngetik_kanan = 0;
                } lainnya {
                    // Cek samadengan: = (61) atau Enter (13 atau 10)
                    jika (tombol == 61 || tombol == 13 || tombol == 10) maka {
                        jika (fokus == 1 && op != 0) maka {
                            ubah hasil_sementara: desimal = hitung(layar_kiri, layar_kanan, op);
                            
                            // Tulis ke riwayat
                            ubah f: teks = buka_file("riwayat.txt", "a");
                            tulis_teks(f, "[");
                            tulis_teks(f, waktu_sekarang());
                            tulis_teks(f, "] ");
                            tulis_desimal(f, layar_kiri);
                            jika (op == 1) maka { tulis_teks(f, " + "); }
                            jika (op == 2) maka { tulis_teks(f, " - "); }
                            jika (op == 3) maka { tulis_teks(f, " * "); }
                            jika (op == 4) maka { tulis_teks(f, " / "); }
                            tulis_desimal(f, layar_kanan);
                            tulis_teks(f, " = ");
                            tulis_desimal(f, hasil_sementara);
                            tulis_teks(f, "\n");
                            tutup_file(f);

                            layar_kiri = hasil_sementara;
                            op = 0;
                            fokus = 2; 
                            ngetik_kanan = 0;
                        }
                    } lainnya {
                        // Cek Clear: C (67) atau c (99)
                        jika (tombol == 67 || tombol == 99) maka {
                            layar_kiri = 0.0;
                            layar_kanan = 0.0;
                            op = 0;
                            fokus = 0;
                            ngetik_kanan = 0;
                        } lainnya {
                            // Cek Off: Esc (27), Q (81), q (113)
                            jika (tombol == 81 || tombol == 113) maka {
                                jalan = 0;
                            }
                        }
                    }
                }
            }
        }
        }
        }
        
        jika (jalan == 1) maka {
            gambar_kalkulator(layar_kiri, layar_kanan, op, fokus, ngetik_kanan);
        }
    }
    
    // Disable mouse tracking & kembalikan kursor
    tui_matikan_mouse();
    tui_tampilkan_kursor();
    tui_bersihkan_layar();
    cetak_teks("\e[35;1mKalkulator Dimatikan. Sampai Jumpa!\e[0m\n");
    kembalikan 0;
}

utama();
```
Hasil Dari Kode Calculator TUI Telacore [Input Dari Mouse, Keyboard, Ada Suara Beep Saat Ditekan Angka]
---
<img width="546" height="519" alt="Calculator TUI Front" src="https://github.com/user-attachments/assets/915bfc00-c526-477e-a8bf-7b583494fd74" />

Jika Tekan "Shift+?" Akan Memunculkan TUI Menu Bantuan dan Cara Menggunakan Calculator Telacore
---
<img width="571" height="423" alt="Calculator TUI Help" src="https://github.com/user-attachments/assets/a773f67b-0962-4185-b673-ea7dcb72da78" />


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
3. **Contoh Proyek Dan Hasil Test Ada di : https://github.com/kasirom/tela-core/tree/main/Template%20Proyek

### LAMPIRAN E: SUMBER DAYA & KOMUNITAS
* Repositori Utama: `https://github.com/tela-core/tela`
* Komunitas Telegram: `@telacore_nusantara`[Menyusul]
* Kontribusi: Laporkan isu kompiler atau ajukan perubahan kode melalui *pull request* repositori.
