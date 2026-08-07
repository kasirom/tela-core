; --- TELA CORE LLVM IR ---
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

declare i32 @printf(ptr, ...)
declare i32 @scanf(ptr, ...)
@.fmt.desimal = private unnamed_addr constant [6 x i8] c"%.15g\00", align 1
@.fmt.input_desimal = private unnamed_addr constant [4 x i8] c"%lf\00", align 1
@.fmt.input_bilangan = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.fmt.string_nl = private unnamed_addr constant [3 x i8] c"%s\00", align 1

declare ptr @GetStdHandle(i32)
declare i32 @GetConsoleMode(ptr, ptr)
declare i32 @SetConsoleMode(ptr, i32)
declare i32 @SetConsoleOutputCP(i32)
declare i32 @getchar()
declare i32 @MessageBeep(i32)

declare ptr @fopen(ptr, ptr)
declare i32 @fprintf(ptr, ptr, ...)
declare i32 @fclose(ptr)

declare double @sqrt(double)
declare double @pow(double, double)
declare double @sin(double)
declare double @cos(double)
declare double @tan(double)
declare double @log10(double)

declare i64 @time(ptr)
declare ptr @localtime(ptr)
declare i64 @strftime(ptr, i64, ptr, ptr)
declare ptr @malloc(i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)
declare ptr @CreateThread(ptr, i64, ptr, ptr, i32, ptr)
declare i32 @WaitForSingleObject(ptr, i32)
declare i32 @CloseHandle(ptr)

@.fmt.string = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.fmt.waktu = private unnamed_addr constant [18 x i8] c"%Y-%m-%d %H:%M:%S\00", align 1
@.fmt.test.header = private unnamed_addr constant [32 x i8] c"==============================\0A\00", align 1
@.fmt.test.start = private unnamed_addr constant [27 x i8] c"Menjalankan pengujian...\0A\0A\00", align 1
@.fmt.test.running = private unnamed_addr constant [12 x i8] c"TES %s ... \00", align 1
@.fmt.test.ok = private unnamed_addr constant [4 x i8] c"OK\0A\00", align 1
@.fmt.test.gagal = private unnamed_addr constant [7 x i8] c"GAGAL\0A\00", align 1
@.fmt.test.summary = private unnamed_addr constant [50 x i8] c"\0AHasil Pengujian: %d lulus, %d gagal dari %d tes\0A\00", align 1
@.fmt.pantau.header = private unnamed_addr constant [42 x i8] c"========================================\0A\00", align 1
@.fmt.pantau.title = private unnamed_addr constant [21 x i8] c"[PANTAU MEMORI: %s]\0A\00", align 1
@.fmt.pantau.addr = private unnamed_addr constant [23 x i8] c"  Alamat Pointer : %p\0A\00", align 1
@.fmt.pantau.type = private unnamed_addr constant [23 x i8] c"  Tipe Data      : %s\0A\00", align 1
@.fmt.pantau.size = private unnamed_addr constant [30 x i8] c"  Ukuran Memori  : %lld byte\0A\00", align 1
@.fmt.aman.divzero = private unnamed_addr constant [70 x i8] c"  Peringatan (Aman): Pembagian dengan nol terdeteksi. Hasil diset 0.\0A\00", align 1

@.str.0 = private unnamed_addr constant [4 x i8] c"[H\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"[2J[H\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"[?25l\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"[?25h\00", align 1
@.str.4 = private unnamed_addr constant [25 x i8] c"[?1000l[?1015l[?1006l\00", align 1
@.str.5 = private unnamed_addr constant [25 x i8] c"[?1000h[?1015h[?1006h\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"[0m\00", align 1
@.str.7 = private unnamed_addr constant [6 x i8] c"[31m\00", align 1
@.str.8 = private unnamed_addr constant [6 x i8] c"[32m\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"[33m\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"[34m\00", align 1
@.str.11 = private unnamed_addr constant [6 x i8] c"[35m\00", align 1
@.str.12 = private unnamed_addr constant [6 x i8] c"[36m\00", align 1
@.str.13 = private unnamed_addr constant [6 x i8] c"[37m\00", align 1
@.str.14 = private unnamed_addr constant [6 x i8] c"[30m\00", align 1
@.str.15 = private unnamed_addr constant [8 x i8] c"[31;1m\00", align 1
@.str.16 = private unnamed_addr constant [8 x i8] c"[33;1m\00", align 1
@.str.17 = private unnamed_addr constant [8 x i8] c"[35;1m\00", align 1
@.str.18 = private unnamed_addr constant [8 x i8] c"[37;1m\00", align 1
@.str.19 = private unnamed_addr constant [6 x i8] c"[40m\00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c"[41m\00", align 1
@.str.21 = private unnamed_addr constant [6 x i8] c"[44m\00", align 1
@.str.22 = private unnamed_addr constant [6 x i8] c"[46m\00", align 1
@.str.23 = private unnamed_addr constant [6 x i8] c"[47m\00", align 1
@.str.24 = private unnamed_addr constant [5 x i8] c"[9G\00", align 1
@.str.25 = private unnamed_addr constant [6 x i8] c"[46G\00", align 1
@.str.26 = private unnamed_addr constant [611 x i8] c"[H[?25l[44m[37;1m ╔════════════════════════════════════════════════════════════╗ \0A ║                   Calculator Telacore                      ║ \0A ╠════════════════════════════════════════════════════════════╣ \0A ║                                                            ║ \0A ║    [ [47m[30m                                                 [9G\00", align 1
@.str.27 = private unnamed_addr constant [4 x i8] c" + \00", align 1
@.str.28 = private unnamed_addr constant [4 x i8] c" - \00", align 1
@.str.29 = private unnamed_addr constant [4 x i8] c" * \00", align 1
@.str.30 = private unnamed_addr constant [4 x i8] c" / \00", align 1
@.str.31 = private unnamed_addr constant [4 x i8] c" ^ \00", align 1
@.str.32 = private unnamed_addr constant [1890 x i8] c"[58G[44m[37;1m ]   ║ \0A ║                                                            ║ \0A ║    [45m[37;1m sin  [44m[37;1m     [46m[31;1m  M+  [44m[37;1m     [46m[31;1m  M-  [44m[37;1m     [46m[31;1m  MR  [44m[37;1m     [46m[31;1m  MC  [44m[37;1m      ║ \0A ║                                                            ║ \0A ║    [45m[37;1m cos  [44m[37;1m     [46m[30m  +   [44m[37;1m     [46m[30m  -   [44m[37;1m     [46m[30m  *   [44m[37;1m     [46m[30m  /   [44m[37;1m      ║ \0A ║                                                            ║ \0A ║    [45m[37;1m tan  [44m[37;1m     [46m[30m  7   [44m[37;1m     [46m[30m  8   [44m[37;1m     [46m[30m  9   [44m[37;1m     [46m[31;1m Off  [44m[37;1m      ║ \0A ║                                                            ║ \0A ║    [45m[37;1m log  [44m[37;1m     [46m[30m  4   [44m[37;1m     [46m[30m  5   [44m[37;1m     [46m[30m  6   [44m[37;1m     [46m[31;1m  C   [44m[37;1m      ║ \0A ║                                                            ║ \0A ║    [45m[37;1m sqrt [44m[37;1m     [46m[30m  1   [44m[37;1m     [46m[30m  2   [44m[37;1m     [46m[30m  3   [44m[37;1m     [46m[31;1m  CE  [44m[37;1m      ║ \0A ║                                                            ║ \0A ║    [45m[37;1m ^    [44m[37;1m     [46m[30m  0   [44m[37;1m     [46m[30m  .   [44m[37;1m     [46m[30m Del  [44m[37;1m     [46m[30m  =   [44m[37;1m      ║ \0A ╚════════════════════════════════════════════════════════════╝ \0A[0m\0A [33mInfo:[0m Klik langsung di GUI kalkulator! \0A Tekan [31m[?][0m di keyboard untuk Menu Bantuan.\0A Ini Adalah Aplikasi Yg Dibuat Dari Telacore Ashura\0A\00", align 1
@.str.33 = private unnamed_addr constant [8 x i8] c"[2J[H\00", align 1
@.str.34 = private unnamed_addr constant [13 x i8] c"[44m[37;1m\00", align 1
@.str.35 = private unnamed_addr constant [214 x i8] c" ╔════════════════════════════════════════════════════════════════════╗ \0A\00", align 1
@.str.36 = private unnamed_addr constant [78 x i8] c" ║                         MENU BANTUAN TELA                          ║ \0A\00", align 1
@.str.37 = private unnamed_addr constant [214 x i8] c" ╠════════════════════════════════════════════════════════════════════╣ \0A\00", align 1
@.str.38 = private unnamed_addr constant [78 x i8] c" ║ Made In Mbah Suro | Kontak: 085325399007                           ║ \0A\00", align 1
@.str.39 = private unnamed_addr constant [78 x i8] c" ║ Email   : kasirom97@gmail.com                                      ║ \0A\00", align 1
@.str.40 = private unnamed_addr constant [78 x i8] c" ║                                                                    ║ \0A\00", align 1
@.str.41 = private unnamed_addr constant [78 x i8] c" ║ PETUNJUK TOMBOL SPESIAL & SCIENTIFIC:                              ║ \0A\00", align 1
@.str.42 = private unnamed_addr constant [78 x i8] c" ║ 1. M+   : Menambahkan nilai layar ke memori                        ║ \0A\00", align 1
@.str.43 = private unnamed_addr constant [78 x i8] c" ║    Cth  : Ketik 10, klik M+, memori jadi 10                        ║ \0A\00", align 1
@.str.44 = private unnamed_addr constant [78 x i8] c" ║ 2. M-   : Mengurangi nilai layar dari memori                       ║ \0A\00", align 1
@.str.45 = private unnamed_addr constant [78 x i8] c" ║    Cth  : Ketik 2, klik M-, memori jadi 8                          ║ \0A\00", align 1
@.str.46 = private unnamed_addr constant [78 x i8] c" ║ 3. MR   : Menampilkan (Recall) nilai memori                        ║ \0A\00", align 1
@.str.47 = private unnamed_addr constant [78 x i8] c" ║ 4. MC   : Menghapus (Clear) isi memori jadi 0                      ║ \0A\00", align 1
@.str.48 = private unnamed_addr constant [78 x i8] c" ║ 5. sin  : Menghitung nilai Sinus (dalam radian). Cth: 0 sin = 0    ║ \0A\00", align 1
@.str.49 = private unnamed_addr constant [78 x i8] c" ║ 6. cos  : Menghitung nilai Cosinus. Cth: 0 cos = 1                 ║ \0A\00", align 1
@.str.50 = private unnamed_addr constant [78 x i8] c" ║ 7. tan  : Menghitung nilai Tangen.                                 ║ \0A\00", align 1
@.str.51 = private unnamed_addr constant [78 x i8] c" ║ 8. log  : Menghitung Logaritma (basis 10). Cth: 100 log = 2        ║ \0A\00", align 1
@.str.52 = private unnamed_addr constant [78 x i8] c" ║ 9. sqrt : Menghitung Akar Kuadrat. Cth: 144 sqrt = 12              ║ \0A\00", align 1
@.str.53 = private unnamed_addr constant [78 x i8] c" ║ 10. ^   : Menghitung Pangkat. Cth: 2 ^ 3 = 8                       ║ \0A\00", align 1
@.str.54 = private unnamed_addr constant [78 x i8] c" ║ 11. CE  : Clear Error (Hapus angka ketikan saat ini saja)          ║ \0A\00", align 1
@.str.55 = private unnamed_addr constant [78 x i8] c" ║ 12. C   : Clear All (Reset semua perhitungan awal)                 ║ \0A\00", align 1
@.str.56 = private unnamed_addr constant [78 x i8] c" ║ 13. Off : Keluar dari Aplikasi Kalkulator                          ║ \0A\00", align 1
@.str.57 = private unnamed_addr constant [78 x i8] c" ║                                                                    ║ \0A\00", align 1
@.str.58 = private unnamed_addr constant [78 x i8] c" ║ Tekan sembarang tombol untuk kembali...                            ║ \0A\00", align 1
@.str.59 = private unnamed_addr constant [214 x i8] c" ╚════════════════════════════════════════════════════════════════════╝ \0A\00", align 1
@.str.60 = private unnamed_addr constant [6 x i8] c"[0m\0A\00", align 1
@.str.61 = private unnamed_addr constant [5 x i8] c"[2J\00", align 1
@.str.62 = private unnamed_addr constant [25 x i8] c"[?1000h[?1015h[?1006h\00", align 1
@.str.63 = private unnamed_addr constant [5 x i8] c"[2J\00", align 1
@.str.64 = private unnamed_addr constant [12 x i8] c"riwayat.txt\00", align 1
@.str.65 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.66 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str.67 = private unnamed_addr constant [3 x i8] c"] \00", align 1
@.str.68 = private unnamed_addr constant [4 x i8] c" + \00", align 1
@.str.69 = private unnamed_addr constant [4 x i8] c" - \00", align 1
@.str.70 = private unnamed_addr constant [4 x i8] c" * \00", align 1
@.str.71 = private unnamed_addr constant [4 x i8] c" / \00", align 1
@.str.72 = private unnamed_addr constant [4 x i8] c" = \00", align 1
@.str.73 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.74 = private unnamed_addr constant [48 x i8] c"[35;1mKalkulator Dimatikan. Sampai Jumpa![0m\0A\00", align 1
define void @tui_ke_atas() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.0)
  ret void
}

define void @tui_bersihkan_layar() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  ret void
}

define void @tui_sembunyikan_kursor() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.2)
  ret void
}

define void @tui_tampilkan_kursor() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.3)
  ret void
}

define void @tui_matikan_mouse() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.4)
  ret void
}

define void @tui_hidupkan_mouse() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.5)
  ret void
}

define void @tui_reset_gaya() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.6)
  ret void
}

define void @tui_warna_merah() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.7)
  ret void
}

define void @tui_warna_hijau() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.8)
  ret void
}

define void @tui_warna_kuning() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.9)
  ret void
}

define void @tui_warna_biru() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.10)
  ret void
}

define void @tui_warna_magenta() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.11)
  ret void
}

define void @tui_warna_cyan() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.12)
  ret void
}

define void @tui_warna_putih() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.13)
  ret void
}

define void @tui_warna_hitam() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.14)
  ret void
}

define void @tui_warna_merah_tebal() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.15)
  ret void
}

define void @tui_warna_kuning_tebal() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.16)
  ret void
}

define void @tui_warna_magenta_tebal() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.17)
  ret void
}

define void @tui_warna_putih_tebal() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.18)
  ret void
}

define void @tui_latar_hitam() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.19)
  ret void
}

define void @tui_latar_merah() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.20)
  ret void
}

define void @tui_latar_biru() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.21)
  ret void
}

define void @tui_latar_cyan() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.22)
  ret void
}

define void @tui_latar_putih() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.23)
  ret void
}

define void @tui_kursor_kolom_9() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.24)
  ret void
}

define void @tui_kursor_kolom_46() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.25)
  ret void
}

define void @gambar_kalkulator(double %arg_kiri, double %arg_kanan, i64 %arg_op, i64 %arg_fokus, i64 %arg_ngetik_kanan) {
entry:
  %kiri = alloca double
  store double %arg_kiri, ptr %kiri
  %kanan = alloca double
  store double %arg_kanan, ptr %kanan
  %op = alloca i64
  store i64 %arg_op, ptr %op
  %fokus = alloca i64
  store i64 %arg_fokus, ptr %fokus
  %ngetik_kanan = alloca i64
  store i64 %arg_ngetik_kanan, ptr %ngetik_kanan
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.26)
  %2 = load i64, ptr %fokus
  %3 = icmp eq i64 %2, 0
  br i1 %3, label %lbl_1, label %lbl_2

lbl_1:
  %4 = load double, ptr %kiri
  %5 = call i32 (ptr, ...) @printf(ptr @.fmt.desimal, double %4)
  br label %lbl_3

lbl_2:
  %6 = load i64, ptr %fokus
  %7 = icmp eq i64 %6, 1
  br i1 %7, label %lbl_4, label %lbl_5

lbl_4:
  %8 = load double, ptr %kiri
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.desimal, double %8)
  %10 = load i64, ptr %op
  %11 = icmp eq i64 %10, 1
  br i1 %11, label %lbl_7, label %lbl_8

lbl_7:
  %12 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.27)
  br label %lbl_9

lbl_8:
  br label %lbl_9

lbl_9:
  %13 = load i64, ptr %op
  %14 = icmp eq i64 %13, 2
  br i1 %14, label %lbl_10, label %lbl_11

lbl_10:
  %15 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.28)
  br label %lbl_12

lbl_11:
  br label %lbl_12

lbl_12:
  %16 = load i64, ptr %op
  %17 = icmp eq i64 %16, 3
  br i1 %17, label %lbl_13, label %lbl_14

lbl_13:
  %18 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.29)
  br label %lbl_15

lbl_14:
  br label %lbl_15

lbl_15:
  %19 = load i64, ptr %op
  %20 = icmp eq i64 %19, 4
  br i1 %20, label %lbl_16, label %lbl_17

lbl_16:
  %21 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.30)
  br label %lbl_18

lbl_17:
  br label %lbl_18

lbl_18:
  %22 = load i64, ptr %op
  %23 = icmp eq i64 %22, 5
  br i1 %23, label %lbl_19, label %lbl_20

lbl_19:
  %24 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.31)
  br label %lbl_21

lbl_20:
  br label %lbl_21

lbl_21:
  %25 = load i64, ptr %ngetik_kanan
  %26 = icmp eq i64 %25, 1
  br i1 %26, label %lbl_22, label %lbl_23

lbl_22:
  %27 = load double, ptr %kanan
  %28 = call i32 (ptr, ...) @printf(ptr @.fmt.desimal, double %27)
  br label %lbl_24

lbl_23:
  br label %lbl_24

lbl_24:
  br label %lbl_6

lbl_5:
  %29 = load double, ptr %kiri
  %30 = call i32 (ptr, ...) @printf(ptr @.fmt.desimal, double %29)
  br label %lbl_6

lbl_6:
  br label %lbl_3

lbl_3:
  %31 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.32)
  ret void
}

define void @layar_bantuan() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.33)
  %2 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.34)
  %3 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.35)
  %4 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.36)
  %5 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.37)
  %6 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.38)
  %7 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.39)
  %8 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.40)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.41)
  %10 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.42)
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.43)
  %12 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.44)
  %13 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.45)
  %14 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.46)
  %15 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.47)
  %16 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.48)
  %17 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.49)
  %18 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.50)
  %19 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.51)
  %20 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.52)
  %21 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.53)
  %22 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.54)
  %23 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.55)
  %24 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.56)
  %25 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.57)
  %26 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.58)
  %27 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.59)
  %28 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.60)
  %29 = call i32 @getchar()
  %30 = sext i32 %29 to i64
  ret void
}

define double @hitung(double %arg_a, double %arg_b, i64 %arg_op) {
entry:
  %a = alloca double
  store double %arg_a, ptr %a
  %b = alloca double
  store double %arg_b, ptr %b
  %op = alloca i64
  store i64 %arg_op, ptr %op
  %1 = load i64, ptr %op
  %2 = icmp eq i64 %1, 1
  br i1 %2, label %lbl_1, label %lbl_2

lbl_1:
  %3 = load double, ptr %a
  %4 = load double, ptr %b
  %5 = fadd double %3, %4
  ret double %5

lbl_2:
  br label %lbl_3

lbl_3:
  %6 = load i64, ptr %op
  %7 = icmp eq i64 %6, 2
  br i1 %7, label %lbl_4, label %lbl_5

lbl_4:
  %8 = load double, ptr %a
  %9 = load double, ptr %b
  %10 = fsub double %8, %9
  ret double %10

lbl_5:
  br label %lbl_6

lbl_6:
  %11 = load i64, ptr %op
  %12 = icmp eq i64 %11, 3
  br i1 %12, label %lbl_7, label %lbl_8

lbl_7:
  %13 = load double, ptr %a
  %14 = load double, ptr %b
  %15 = fmul double %13, %14
  ret double %15

lbl_8:
  br label %lbl_9

lbl_9:
  %16 = load i64, ptr %op
  %17 = icmp eq i64 %16, 4
  br i1 %17, label %lbl_10, label %lbl_11

lbl_10:
  %18 = load double, ptr %b
  %19 = sitofp i64 0 to double
  %20 = fcmp oeq double %18, %19
  br i1 %20, label %lbl_13, label %lbl_14

lbl_13:
  %21 = load double, ptr %a
  ret double %21

lbl_14:
  br label %lbl_15

lbl_15:
  %22 = load double, ptr %a
  %23 = load double, ptr %b
  %24 = fdiv double %22, %23
  ret double %24

lbl_11:
  br label %lbl_12

lbl_12:
  %25 = load i64, ptr %op
  %26 = icmp eq i64 %25, 5
  br i1 %26, label %lbl_16, label %lbl_17

lbl_16:
  %27 = load double, ptr %a
  %28 = load double, ptr %b
  %29 = call double @pow(double %27, double %28)
  ret double %29

lbl_17:
  br label %lbl_18

lbl_18:
  %30 = load double, ptr %a
  ret double %30
}

define i64 @tangkap_mouse(i64 %arg_koordinat) {
entry:
  %koordinat = alloca i64
  store i64 %arg_koordinat, ptr %koordinat
  %1 = load i64, ptr %koordinat
  %2 = load i64, ptr %koordinat
  %3 = sdiv i64 %2, 1000
  %4 = mul i64 %3, 1000
  %5 = sub i64 %1, %4
  %y_6 = alloca i64
  store i64 %5, ptr %y_6
  %7 = load i64, ptr %koordinat
  %8 = sdiv i64 %7, 1000
  %x_9 = alloca i64
  store i64 %8, ptr %x_9
  %kol_10 = alloca i64
  store i64 0, ptr %kol_10
  %11 = load i64, ptr %x_9
  %12 = icmp sge i64 %11, 7
  %13 = load i64, ptr %x_9
  %14 = icmp sle i64 %13, 12
  %15 = and i1 %12, %14
  br i1 %15, label %lbl_1, label %lbl_2

lbl_1:
  store i64 1, ptr %kol_10
  br label %lbl_3

lbl_2:
  br label %lbl_3

lbl_3:
  %16 = load i64, ptr %x_9
  %17 = icmp sge i64 %16, 18
  %18 = load i64, ptr %x_9
  %19 = icmp sle i64 %18, 23
  %20 = and i1 %17, %19
  br i1 %20, label %lbl_4, label %lbl_5

lbl_4:
  store i64 2, ptr %kol_10
  br label %lbl_6

lbl_5:
  br label %lbl_6

lbl_6:
  %21 = load i64, ptr %x_9
  %22 = icmp sge i64 %21, 29
  %23 = load i64, ptr %x_9
  %24 = icmp sle i64 %23, 34
  %25 = and i1 %22, %24
  br i1 %25, label %lbl_7, label %lbl_8

lbl_7:
  store i64 3, ptr %kol_10
  br label %lbl_9

lbl_8:
  br label %lbl_9

lbl_9:
  %26 = load i64, ptr %x_9
  %27 = icmp sge i64 %26, 40
  %28 = load i64, ptr %x_9
  %29 = icmp sle i64 %28, 45
  %30 = and i1 %27, %29
  br i1 %30, label %lbl_10, label %lbl_11

lbl_10:
  store i64 4, ptr %kol_10
  br label %lbl_12

lbl_11:
  br label %lbl_12

lbl_12:
  %31 = load i64, ptr %x_9
  %32 = icmp sge i64 %31, 51
  %33 = load i64, ptr %x_9
  %34 = icmp sle i64 %33, 56
  %35 = and i1 %32, %34
  br i1 %35, label %lbl_13, label %lbl_14

lbl_13:
  store i64 5, ptr %kol_10
  br label %lbl_15

lbl_14:
  br label %lbl_15

lbl_15:
  %36 = load i64, ptr %kol_10
  %37 = icmp eq i64 %36, 0
  br i1 %37, label %lbl_16, label %lbl_17

lbl_16:
  ret i64 0

lbl_17:
  br label %lbl_18

lbl_18:
  %38 = load i64, ptr %y_6
  %39 = icmp eq i64 %38, 7
  br i1 %39, label %lbl_19, label %lbl_20

lbl_19:
  %40 = load i64, ptr %kol_10
  %41 = icmp eq i64 %40, 1
  br i1 %41, label %lbl_22, label %lbl_23

lbl_22:
  ret i64 301

lbl_23:
  br label %lbl_24

lbl_24:
  %42 = load i64, ptr %kol_10
  %43 = icmp eq i64 %42, 2
  br i1 %43, label %lbl_25, label %lbl_26

lbl_25:
  ret i64 201

lbl_26:
  br label %lbl_27

lbl_27:
  %44 = load i64, ptr %kol_10
  %45 = icmp eq i64 %44, 3
  br i1 %45, label %lbl_28, label %lbl_29

lbl_28:
  ret i64 202

lbl_29:
  br label %lbl_30

lbl_30:
  %46 = load i64, ptr %kol_10
  %47 = icmp eq i64 %46, 4
  br i1 %47, label %lbl_31, label %lbl_32

lbl_31:
  ret i64 203

lbl_32:
  br label %lbl_33

lbl_33:
  %48 = load i64, ptr %kol_10
  %49 = icmp eq i64 %48, 5
  br i1 %49, label %lbl_34, label %lbl_35

lbl_34:
  ret i64 204

lbl_35:
  br label %lbl_36

lbl_36:
  br label %lbl_21

lbl_20:
  br label %lbl_21

lbl_21:
  %50 = load i64, ptr %y_6
  %51 = icmp eq i64 %50, 9
  br i1 %51, label %lbl_37, label %lbl_38

lbl_37:
  %52 = load i64, ptr %kol_10
  %53 = icmp eq i64 %52, 1
  br i1 %53, label %lbl_40, label %lbl_41

lbl_40:
  ret i64 302

lbl_41:
  br label %lbl_42

lbl_42:
  %54 = load i64, ptr %kol_10
  %55 = icmp eq i64 %54, 2
  br i1 %55, label %lbl_43, label %lbl_44

lbl_43:
  ret i64 43

lbl_44:
  br label %lbl_45

lbl_45:
  %56 = load i64, ptr %kol_10
  %57 = icmp eq i64 %56, 3
  br i1 %57, label %lbl_46, label %lbl_47

lbl_46:
  ret i64 45

lbl_47:
  br label %lbl_48

lbl_48:
  %58 = load i64, ptr %kol_10
  %59 = icmp eq i64 %58, 4
  br i1 %59, label %lbl_49, label %lbl_50

lbl_49:
  ret i64 42

lbl_50:
  br label %lbl_51

lbl_51:
  %60 = load i64, ptr %kol_10
  %61 = icmp eq i64 %60, 5
  br i1 %61, label %lbl_52, label %lbl_53

lbl_52:
  ret i64 47

lbl_53:
  br label %lbl_54

lbl_54:
  br label %lbl_39

lbl_38:
  br label %lbl_39

lbl_39:
  %62 = load i64, ptr %y_6
  %63 = icmp eq i64 %62, 11
  br i1 %63, label %lbl_55, label %lbl_56

lbl_55:
  %64 = load i64, ptr %kol_10
  %65 = icmp eq i64 %64, 1
  br i1 %65, label %lbl_58, label %lbl_59

lbl_58:
  ret i64 303

lbl_59:
  br label %lbl_60

lbl_60:
  %66 = load i64, ptr %kol_10
  %67 = icmp eq i64 %66, 2
  br i1 %67, label %lbl_61, label %lbl_62

lbl_61:
  ret i64 55

lbl_62:
  br label %lbl_63

lbl_63:
  %68 = load i64, ptr %kol_10
  %69 = icmp eq i64 %68, 3
  br i1 %69, label %lbl_64, label %lbl_65

lbl_64:
  ret i64 56

lbl_65:
  br label %lbl_66

lbl_66:
  %70 = load i64, ptr %kol_10
  %71 = icmp eq i64 %70, 4
  br i1 %71, label %lbl_67, label %lbl_68

lbl_67:
  ret i64 57

lbl_68:
  br label %lbl_69

lbl_69:
  %72 = load i64, ptr %kol_10
  %73 = icmp eq i64 %72, 5
  br i1 %73, label %lbl_70, label %lbl_71

lbl_70:
  ret i64 113

lbl_71:
  br label %lbl_72

lbl_72:
  br label %lbl_57

lbl_56:
  br label %lbl_57

lbl_57:
  %74 = load i64, ptr %y_6
  %75 = icmp eq i64 %74, 13
  br i1 %75, label %lbl_73, label %lbl_74

lbl_73:
  %76 = load i64, ptr %kol_10
  %77 = icmp eq i64 %76, 1
  br i1 %77, label %lbl_76, label %lbl_77

lbl_76:
  ret i64 304

lbl_77:
  br label %lbl_78

lbl_78:
  %78 = load i64, ptr %kol_10
  %79 = icmp eq i64 %78, 2
  br i1 %79, label %lbl_79, label %lbl_80

lbl_79:
  ret i64 52

lbl_80:
  br label %lbl_81

lbl_81:
  %80 = load i64, ptr %kol_10
  %81 = icmp eq i64 %80, 3
  br i1 %81, label %lbl_82, label %lbl_83

lbl_82:
  ret i64 53

lbl_83:
  br label %lbl_84

lbl_84:
  %82 = load i64, ptr %kol_10
  %83 = icmp eq i64 %82, 4
  br i1 %83, label %lbl_85, label %lbl_86

lbl_85:
  ret i64 54

lbl_86:
  br label %lbl_87

lbl_87:
  %84 = load i64, ptr %kol_10
  %85 = icmp eq i64 %84, 5
  br i1 %85, label %lbl_88, label %lbl_89

lbl_88:
  ret i64 99

lbl_89:
  br label %lbl_90

lbl_90:
  br label %lbl_75

lbl_74:
  br label %lbl_75

lbl_75:
  %86 = load i64, ptr %y_6
  %87 = icmp eq i64 %86, 15
  br i1 %87, label %lbl_91, label %lbl_92

lbl_91:
  %88 = load i64, ptr %kol_10
  %89 = icmp eq i64 %88, 1
  br i1 %89, label %lbl_94, label %lbl_95

lbl_94:
  ret i64 305

lbl_95:
  br label %lbl_96

lbl_96:
  %90 = load i64, ptr %kol_10
  %91 = icmp eq i64 %90, 2
  br i1 %91, label %lbl_97, label %lbl_98

lbl_97:
  ret i64 49

lbl_98:
  br label %lbl_99

lbl_99:
  %92 = load i64, ptr %kol_10
  %93 = icmp eq i64 %92, 3
  br i1 %93, label %lbl_100, label %lbl_101

lbl_100:
  ret i64 50

lbl_101:
  br label %lbl_102

lbl_102:
  %94 = load i64, ptr %kol_10
  %95 = icmp eq i64 %94, 4
  br i1 %95, label %lbl_103, label %lbl_104

lbl_103:
  ret i64 51

lbl_104:
  br label %lbl_105

lbl_105:
  %96 = load i64, ptr %kol_10
  %97 = icmp eq i64 %96, 5
  br i1 %97, label %lbl_106, label %lbl_107

lbl_106:
  ret i64 101

lbl_107:
  br label %lbl_108

lbl_108:
  br label %lbl_93

lbl_92:
  br label %lbl_93

lbl_93:
  %98 = load i64, ptr %y_6
  %99 = icmp eq i64 %98, 17
  br i1 %99, label %lbl_109, label %lbl_110

lbl_109:
  %100 = load i64, ptr %kol_10
  %101 = icmp eq i64 %100, 1
  br i1 %101, label %lbl_112, label %lbl_113

lbl_112:
  ret i64 306

lbl_113:
  br label %lbl_114

lbl_114:
  %102 = load i64, ptr %kol_10
  %103 = icmp eq i64 %102, 2
  br i1 %103, label %lbl_115, label %lbl_116

lbl_115:
  ret i64 48

lbl_116:
  br label %lbl_117

lbl_117:
  %104 = load i64, ptr %kol_10
  %105 = icmp eq i64 %104, 3
  br i1 %105, label %lbl_118, label %lbl_119

lbl_118:
  ret i64 46

lbl_119:
  br label %lbl_120

lbl_120:
  %106 = load i64, ptr %kol_10
  %107 = icmp eq i64 %106, 4
  br i1 %107, label %lbl_121, label %lbl_122

lbl_121:
  ret i64 8

lbl_122:
  br label %lbl_123

lbl_123:
  %108 = load i64, ptr %kol_10
  %109 = icmp eq i64 %108, 5
  br i1 %109, label %lbl_124, label %lbl_125

lbl_124:
  ret i64 61

lbl_125:
  br label %lbl_126

lbl_126:
  br label %lbl_111

lbl_110:
  br label %lbl_111

lbl_111:
  ret i64 0
}

define i64 @utama() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.61)
  %2 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.62)
  %jalan_3 = alloca i64
  store i64 1, ptr %jalan_3
  %layar_kiri_4 = alloca double
  store double 0.0, ptr %layar_kiri_4
  %layar_kanan_5 = alloca double
  store double 0.0, ptr %layar_kanan_5
  %memori_6 = alloca double
  store double 0.0, ptr %memori_6
  %op_7 = alloca i64
  store i64 0, ptr %op_7
  %fokus_8 = alloca i64
  store i64 0, ptr %fokus_8
  %ngetik_kanan_9 = alloca i64
  store i64 0, ptr %ngetik_kanan_9
  %10 = load double, ptr %layar_kiri_4
  %11 = load double, ptr %layar_kanan_5
  %12 = load i64, ptr %op_7
  %13 = load i64, ptr %fokus_8
  %14 = load i64, ptr %ngetik_kanan_9
  call void @gambar_kalkulator(double %10, double %11, i64 %12, i64 %13, i64 %14)
  br label %lbl_1

lbl_1:
  %15 = load i64, ptr %jalan_3
  %16 = icmp eq i64 %15, 1
  br i1 %16, label %lbl_2, label %lbl_3

lbl_2:
  %17 = call i32 @getchar()
  %18 = sext i32 %17 to i64
  %tombol_19 = alloca i64
  store i64 %18, ptr %tombol_19
  %20 = load i64, ptr %tombol_19
  %21 = icmp eq i64 %20, 63
  br i1 %21, label %lbl_4, label %lbl_5

lbl_4:
  call void @layar_bantuan()
  %22 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.63)
  %23 = load double, ptr %layar_kiri_4
  %24 = load double, ptr %layar_kanan_5
  %25 = load i64, ptr %op_7
  %26 = load i64, ptr %fokus_8
  %27 = load i64, ptr %ngetik_kanan_9
  call void @gambar_kalkulator(double %23, double %24, i64 %25, i64 %26, i64 %27)
  store i64 0, ptr %tombol_19
  br label %lbl_6

lbl_5:
  br label %lbl_6

lbl_6:
  %28 = load i64, ptr %tombol_19
  %29 = icmp eq i64 %28, 27
  br i1 %29, label %lbl_7, label %lbl_8

lbl_7:
  %30 = call i32 @getchar()
  %31 = sext i32 %30 to i64
  %c1_32 = alloca i64
  store i64 %31, ptr %c1_32
  %33 = load i64, ptr %c1_32
  %34 = icmp eq i64 %33, 91
  br i1 %34, label %lbl_10, label %lbl_11

lbl_10:
  %35 = call i32 @getchar()
  %36 = sext i32 %35 to i64
  %c2_37 = alloca i64
  store i64 %36, ptr %c2_37
  %38 = load i64, ptr %c2_37
  %39 = icmp eq i64 %38, 60
  br i1 %39, label %lbl_13, label %lbl_14

lbl_13:
  %l_loop_40 = alloca i64
  store i64 1, ptr %l_loop_40
  br label %lbl_16

lbl_16:
  %41 = load i64, ptr %l_loop_40
  %42 = icmp eq i64 %41, 1
  br i1 %42, label %lbl_17, label %lbl_18

lbl_17:
  %43 = call i32 @getchar()
  %44 = sext i32 %43 to i64
  %cb_45 = alloca i64
  store i64 %44, ptr %cb_45
  %46 = load i64, ptr %cb_45
  %47 = icmp eq i64 %46, 59
  br i1 %47, label %lbl_19, label %lbl_20

lbl_19:
  store i64 0, ptr %l_loop_40
  br label %lbl_21

lbl_20:
  br label %lbl_21

lbl_21:
  br label %lbl_16

lbl_18:
  %x_48 = alloca i64
  store i64 0, ptr %x_48
  %l_loop2_49 = alloca i64
  store i64 1, ptr %l_loop2_49
  br label %lbl_22

lbl_22:
  %50 = load i64, ptr %l_loop2_49
  %51 = icmp eq i64 %50, 1
  br i1 %51, label %lbl_23, label %lbl_24

lbl_23:
  %52 = call i32 @getchar()
  %53 = sext i32 %52 to i64
  %cx_54 = alloca i64
  store i64 %53, ptr %cx_54
  %55 = load i64, ptr %cx_54
  %56 = icmp eq i64 %55, 59
  br i1 %56, label %lbl_25, label %lbl_26

lbl_25:
  store i64 0, ptr %l_loop2_49
  br label %lbl_27

lbl_26:
  %57 = load i64, ptr %x_48
  %58 = mul i64 %57, 10
  %59 = load i64, ptr %cx_54
  %60 = sub i64 %59, 48
  %61 = add i64 %58, %60
  store i64 %61, ptr %x_48
  br label %lbl_27

lbl_27:
  br label %lbl_22

lbl_24:
  %y_62 = alloca i64
  store i64 0, ptr %y_62
  %is_press_63 = alloca i64
  store i64 0, ptr %is_press_63
  %l_loop3_64 = alloca i64
  store i64 1, ptr %l_loop3_64
  br label %lbl_28

lbl_28:
  %65 = load i64, ptr %l_loop3_64
  %66 = icmp eq i64 %65, 1
  br i1 %66, label %lbl_29, label %lbl_30

lbl_29:
  %67 = call i32 @getchar()
  %68 = sext i32 %67 to i64
  %cy_69 = alloca i64
  store i64 %68, ptr %cy_69
  %70 = load i64, ptr %cy_69
  %71 = icmp eq i64 %70, 77
  %72 = load i64, ptr %cy_69
  %73 = icmp eq i64 %72, 109
  %74 = or i1 %71, %73
  br i1 %74, label %lbl_31, label %lbl_32

lbl_31:
  %75 = load i64, ptr %cy_69
  %76 = icmp eq i64 %75, 77
  br i1 %76, label %lbl_34, label %lbl_35

lbl_34:
  store i64 1, ptr %is_press_63
  br label %lbl_36

lbl_35:
  br label %lbl_36

lbl_36:
  store i64 0, ptr %l_loop3_64
  br label %lbl_33

lbl_32:
  %77 = load i64, ptr %y_62
  %78 = mul i64 %77, 10
  %79 = load i64, ptr %cy_69
  %80 = sub i64 %79, 48
  %81 = add i64 %78, %80
  store i64 %81, ptr %y_62
  br label %lbl_33

lbl_33:
  br label %lbl_28

lbl_30:
  %82 = load i64, ptr %is_press_63
  %83 = icmp eq i64 %82, 1
  br i1 %83, label %lbl_37, label %lbl_38

lbl_37:
  %84 = load i64, ptr %x_48
  %85 = mul i64 %84, 1000
  %86 = load i64, ptr %y_62
  %87 = add i64 %85, %86
  %88 = call i64 @tangkap_mouse(i64 %87)
  store i64 %88, ptr %tombol_19
  %89 = load i64, ptr %tombol_19
  %90 = icmp ne i64 %89, 0
  br i1 %90, label %lbl_40, label %lbl_41

lbl_40:
  br label %lbl_42

lbl_41:
  br label %lbl_42

lbl_42:
  br label %lbl_39

lbl_38:
  store i64 0, ptr %tombol_19
  br label %lbl_39

lbl_39:
  br label %lbl_15

lbl_14:
  %91 = load i64, ptr %c2_37
  %92 = icmp eq i64 %91, 27
  %93 = load i64, ptr %c2_37
  %94 = icmp eq i64 %93, 81
  %95 = or i1 %92, %94
  %96 = load i64, ptr %c2_37
  %97 = icmp eq i64 %96, 113
  %98 = or i1 %95, %97
  br i1 %98, label %lbl_43, label %lbl_44

lbl_43:
  store i64 0, ptr %jalan_3
  br label %lbl_45

lbl_44:
  br label %lbl_45

lbl_45:
  br label %lbl_15

lbl_15:
  br label %lbl_12

lbl_11:
  store i64 0, ptr %jalan_3
  br label %lbl_12

lbl_12:
  br label %lbl_9

lbl_8:
  br label %lbl_9

lbl_9:
  %99 = load i64, ptr %tombol_19
  %100 = icmp ne i64 %99, 0
  br i1 %100, label %lbl_46, label %lbl_47

lbl_46:
  %101 = call i32 @MessageBeep(i32 0)
  %102 = load i64, ptr %tombol_19
  %103 = icmp sge i64 %102, 201
  %104 = load i64, ptr %tombol_19
  %105 = icmp sle i64 %104, 204
  %106 = and i1 %103, %105
  br i1 %106, label %lbl_49, label %lbl_50

lbl_49:
  %107 = load i64, ptr %tombol_19
  %108 = icmp eq i64 %107, 201
  br i1 %108, label %lbl_52, label %lbl_53

lbl_52:
  %109 = load double, ptr %memori_6
  %110 = load double, ptr %layar_kiri_4
  %111 = fadd double %109, %110
  store double %111, ptr %memori_6
  br label %lbl_54

lbl_53:
  br label %lbl_54

lbl_54:
  %112 = load i64, ptr %tombol_19
  %113 = icmp eq i64 %112, 202
  br i1 %113, label %lbl_55, label %lbl_56

lbl_55:
  %114 = load double, ptr %memori_6
  %115 = load double, ptr %layar_kiri_4
  %116 = fsub double %114, %115
  store double %116, ptr %memori_6
  br label %lbl_57

lbl_56:
  br label %lbl_57

lbl_57:
  %117 = load i64, ptr %tombol_19
  %118 = icmp eq i64 %117, 203
  br i1 %118, label %lbl_58, label %lbl_59

lbl_58:
  %119 = load i64, ptr %fokus_8
  %120 = icmp eq i64 %119, 0
  %121 = load i64, ptr %fokus_8
  %122 = icmp eq i64 %121, 2
  %123 = or i1 %120, %122
  br i1 %123, label %lbl_61, label %lbl_62

lbl_61:
  %124 = load double, ptr %memori_6
  store double %124, ptr %layar_kiri_4
  br label %lbl_63

lbl_62:
  %125 = load double, ptr %memori_6
  store double %125, ptr %layar_kanan_5
  store i64 1, ptr %ngetik_kanan_9
  br label %lbl_63

lbl_63:
  br label %lbl_60

lbl_59:
  br label %lbl_60

lbl_60:
  %126 = load i64, ptr %tombol_19
  %127 = icmp eq i64 %126, 204
  br i1 %127, label %lbl_64, label %lbl_65

lbl_64:
  store double 0.0, ptr %memori_6
  br label %lbl_66

lbl_65:
  br label %lbl_66

lbl_66:
  br label %lbl_51

lbl_50:
  %128 = load i64, ptr %tombol_19
  %129 = icmp sge i64 %128, 301
  %130 = load i64, ptr %tombol_19
  %131 = icmp sle i64 %130, 305
  %132 = and i1 %129, %131
  br i1 %132, label %lbl_67, label %lbl_68

lbl_67:
  %133 = load double, ptr %layar_kiri_4
  %target_134 = alloca double
  store double %133, ptr %target_134
  %135 = load i64, ptr %fokus_8
  %136 = icmp eq i64 %135, 1
  %137 = load i64, ptr %ngetik_kanan_9
  %138 = icmp eq i64 %137, 1
  %139 = and i1 %136, %138
  br i1 %139, label %lbl_70, label %lbl_71

lbl_70:
  %140 = load double, ptr %layar_kanan_5
  store double %140, ptr %target_134
  br label %lbl_72

lbl_71:
  br label %lbl_72

lbl_72:
  %141 = load i64, ptr %tombol_19
  %142 = icmp eq i64 %141, 301
  br i1 %142, label %lbl_73, label %lbl_74

lbl_73:
  %143 = load double, ptr %target_134
  %144 = call double @sin(double %143)
  store double %144, ptr %target_134
  br label %lbl_75

lbl_74:
  br label %lbl_75

lbl_75:
  %145 = load i64, ptr %tombol_19
  %146 = icmp eq i64 %145, 302
  br i1 %146, label %lbl_76, label %lbl_77

lbl_76:
  %147 = load double, ptr %target_134
  %148 = call double @cos(double %147)
  store double %148, ptr %target_134
  br label %lbl_78

lbl_77:
  br label %lbl_78

lbl_78:
  %149 = load i64, ptr %tombol_19
  %150 = icmp eq i64 %149, 303
  br i1 %150, label %lbl_79, label %lbl_80

lbl_79:
  %151 = load double, ptr %target_134
  %152 = call double @tan(double %151)
  store double %152, ptr %target_134
  br label %lbl_81

lbl_80:
  br label %lbl_81

lbl_81:
  %153 = load i64, ptr %tombol_19
  %154 = icmp eq i64 %153, 304
  br i1 %154, label %lbl_82, label %lbl_83

lbl_82:
  %155 = load double, ptr %target_134
  %156 = call double @log10(double %155)
  store double %156, ptr %target_134
  br label %lbl_84

lbl_83:
  br label %lbl_84

lbl_84:
  %157 = load i64, ptr %tombol_19
  %158 = icmp eq i64 %157, 305
  br i1 %158, label %lbl_85, label %lbl_86

lbl_85:
  %159 = load double, ptr %target_134
  %160 = call double @sqrt(double %159)
  store double %160, ptr %target_134
  br label %lbl_87

lbl_86:
  br label %lbl_87

lbl_87:
  %161 = load i64, ptr %fokus_8
  %162 = icmp eq i64 %161, 1
  %163 = load i64, ptr %ngetik_kanan_9
  %164 = icmp eq i64 %163, 1
  %165 = and i1 %162, %164
  br i1 %165, label %lbl_88, label %lbl_89

lbl_88:
  %166 = load double, ptr %target_134
  store double %166, ptr %layar_kanan_5
  br label %lbl_90

lbl_89:
  %167 = load double, ptr %target_134
  store double %167, ptr %layar_kiri_4
  store i64 2, ptr %fokus_8
  br label %lbl_90

lbl_90:
  br label %lbl_69

lbl_68:
  %168 = load i64, ptr %tombol_19
  %169 = icmp sge i64 %168, 48
  %170 = load i64, ptr %tombol_19
  %171 = icmp sle i64 %170, 57
  %172 = and i1 %169, %171
  br i1 %172, label %lbl_91, label %lbl_92

lbl_91:
  %173 = load i64, ptr %tombol_19
  %174 = sub i64 %173, 48
  %digit_175 = alloca i64
  store i64 %174, ptr %digit_175
  %176 = load i64, ptr %fokus_8
  %177 = icmp eq i64 %176, 2
  br i1 %177, label %lbl_94, label %lbl_95

lbl_94:
  %178 = load i64, ptr %digit_175
  %179 = sitofp i64 %178 to double
  %180 = fadd double 0.0, %179
  store double %180, ptr %layar_kiri_4
  store i64 0, ptr %fokus_8
  store i64 0, ptr %op_7
  br label %lbl_96

lbl_95:
  %181 = load i64, ptr %fokus_8
  %182 = icmp eq i64 %181, 0
  br i1 %182, label %lbl_97, label %lbl_98

lbl_97:
  %183 = load double, ptr %layar_kiri_4
  %184 = fmul double %183, 10.0
  %185 = load i64, ptr %digit_175
  %186 = sitofp i64 %185 to double
  %187 = fadd double %184, %186
  store double %187, ptr %layar_kiri_4
  br label %lbl_99

lbl_98:
  %188 = load double, ptr %layar_kanan_5
  %189 = fmul double %188, 10.0
  %190 = load i64, ptr %digit_175
  %191 = sitofp i64 %190 to double
  %192 = fadd double %189, %191
  store double %192, ptr %layar_kanan_5
  store i64 1, ptr %ngetik_kanan_9
  br label %lbl_99

lbl_99:
  br label %lbl_96

lbl_96:
  br label %lbl_93

lbl_92:
  %193 = load i64, ptr %tombol_19
  %194 = icmp eq i64 %193, 43
  %195 = load i64, ptr %tombol_19
  %196 = icmp eq i64 %195, 45
  %197 = or i1 %194, %196
  %198 = load i64, ptr %tombol_19
  %199 = icmp eq i64 %198, 42
  %200 = or i1 %197, %199
  %201 = load i64, ptr %tombol_19
  %202 = icmp eq i64 %201, 47
  %203 = or i1 %200, %202
  %204 = load i64, ptr %tombol_19
  %205 = icmp eq i64 %204, 306
  %206 = or i1 %203, %205
  br i1 %206, label %lbl_100, label %lbl_101

lbl_100:
  %new_op_207 = alloca i64
  store i64 0, ptr %new_op_207
  %208 = load i64, ptr %tombol_19
  %209 = icmp eq i64 %208, 43
  br i1 %209, label %lbl_103, label %lbl_104

lbl_103:
  store i64 1, ptr %new_op_207
  br label %lbl_105

lbl_104:
  br label %lbl_105

lbl_105:
  %210 = load i64, ptr %tombol_19
  %211 = icmp eq i64 %210, 45
  br i1 %211, label %lbl_106, label %lbl_107

lbl_106:
  store i64 2, ptr %new_op_207
  br label %lbl_108

lbl_107:
  br label %lbl_108

lbl_108:
  %212 = load i64, ptr %tombol_19
  %213 = icmp eq i64 %212, 42
  br i1 %213, label %lbl_109, label %lbl_110

lbl_109:
  store i64 3, ptr %new_op_207
  br label %lbl_111

lbl_110:
  br label %lbl_111

lbl_111:
  %214 = load i64, ptr %tombol_19
  %215 = icmp eq i64 %214, 47
  br i1 %215, label %lbl_112, label %lbl_113

lbl_112:
  store i64 4, ptr %new_op_207
  br label %lbl_114

lbl_113:
  br label %lbl_114

lbl_114:
  %216 = load i64, ptr %tombol_19
  %217 = icmp eq i64 %216, 306
  br i1 %217, label %lbl_115, label %lbl_116

lbl_115:
  store i64 5, ptr %new_op_207
  br label %lbl_117

lbl_116:
  br label %lbl_117

lbl_117:
  %218 = load i64, ptr %fokus_8
  %219 = icmp eq i64 %218, 1
  %220 = load i64, ptr %ngetik_kanan_9
  %221 = icmp eq i64 %220, 1
  %222 = and i1 %219, %221
  br i1 %222, label %lbl_118, label %lbl_119

lbl_118:
  %223 = load double, ptr %layar_kiri_4
  %224 = load double, ptr %layar_kanan_5
  %225 = load i64, ptr %op_7
  %226 = call double @hitung(double %223, double %224, i64 %225)
  store double %226, ptr %layar_kiri_4
  br label %lbl_120

lbl_119:
  br label %lbl_120

lbl_120:
  store double 0.0, ptr %layar_kanan_5
  %227 = load i64, ptr %new_op_207
  store i64 %227, ptr %op_7
  store i64 1, ptr %fokus_8
  store i64 0, ptr %ngetik_kanan_9
  br label %lbl_102

lbl_101:
  %228 = load i64, ptr %tombol_19
  %229 = icmp eq i64 %228, 61
  %230 = load i64, ptr %tombol_19
  %231 = icmp eq i64 %230, 13
  %232 = or i1 %229, %231
  %233 = load i64, ptr %tombol_19
  %234 = icmp eq i64 %233, 10
  %235 = or i1 %232, %234
  br i1 %235, label %lbl_121, label %lbl_122

lbl_121:
  %236 = load i64, ptr %fokus_8
  %237 = icmp eq i64 %236, 1
  %238 = load i64, ptr %op_7
  %239 = icmp ne i64 %238, 0
  %240 = and i1 %237, %239
  br i1 %240, label %lbl_124, label %lbl_125

lbl_124:
  %241 = load double, ptr %layar_kiri_4
  %242 = load double, ptr %layar_kanan_5
  %243 = load i64, ptr %op_7
  %244 = call double @hitung(double %241, double %242, i64 %243)
  %hasil_sementara_245 = alloca double
  store double %244, ptr %hasil_sementara_245
  %246 = call ptr @fopen(ptr @.str.64, ptr @.str.65)
  %f_247 = alloca ptr
  store ptr %246, ptr %f_247
  %248 = load ptr, ptr %f_247
  %249 = call i32 (ptr, ptr, ...) @fprintf(ptr %248, ptr @.fmt.string, ptr @.str.66)
  %250 = sext i32 %249 to i64
  %251 = load ptr, ptr %f_247
  %252 = alloca i64
  %253 = call i64 @time(ptr null)
  store i64 %253, ptr %252
  %254 = call ptr @localtime(ptr %252)
  %255 = call ptr @malloc(i64 20)
  %256 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %257 = call i64 @strftime(ptr %255, i64 20, ptr %256, ptr %254)
  %258 = call i32 (ptr, ptr, ...) @fprintf(ptr %251, ptr @.fmt.string, ptr %255)
  %259 = sext i32 %258 to i64
  %260 = load ptr, ptr %f_247
  %261 = call i32 (ptr, ptr, ...) @fprintf(ptr %260, ptr @.fmt.string, ptr @.str.67)
  %262 = sext i32 %261 to i64
  %263 = load ptr, ptr %f_247
  %264 = load double, ptr %layar_kiri_4
  %265 = call i32 (ptr, ptr, ...) @fprintf(ptr %263, ptr @.fmt.desimal, double %264)
  %266 = sext i32 %265 to i64
  %267 = load i64, ptr %op_7
  %268 = icmp eq i64 %267, 1
  br i1 %268, label %lbl_127, label %lbl_128

lbl_127:
  %269 = load ptr, ptr %f_247
  %270 = call i32 (ptr, ptr, ...) @fprintf(ptr %269, ptr @.fmt.string, ptr @.str.68)
  %271 = sext i32 %270 to i64
  br label %lbl_129

lbl_128:
  br label %lbl_129

lbl_129:
  %272 = load i64, ptr %op_7
  %273 = icmp eq i64 %272, 2
  br i1 %273, label %lbl_130, label %lbl_131

lbl_130:
  %274 = load ptr, ptr %f_247
  %275 = call i32 (ptr, ptr, ...) @fprintf(ptr %274, ptr @.fmt.string, ptr @.str.69)
  %276 = sext i32 %275 to i64
  br label %lbl_132

lbl_131:
  br label %lbl_132

lbl_132:
  %277 = load i64, ptr %op_7
  %278 = icmp eq i64 %277, 3
  br i1 %278, label %lbl_133, label %lbl_134

lbl_133:
  %279 = load ptr, ptr %f_247
  %280 = call i32 (ptr, ptr, ...) @fprintf(ptr %279, ptr @.fmt.string, ptr @.str.70)
  %281 = sext i32 %280 to i64
  br label %lbl_135

lbl_134:
  br label %lbl_135

lbl_135:
  %282 = load i64, ptr %op_7
  %283 = icmp eq i64 %282, 4
  br i1 %283, label %lbl_136, label %lbl_137

lbl_136:
  %284 = load ptr, ptr %f_247
  %285 = call i32 (ptr, ptr, ...) @fprintf(ptr %284, ptr @.fmt.string, ptr @.str.71)
  %286 = sext i32 %285 to i64
  br label %lbl_138

lbl_137:
  br label %lbl_138

lbl_138:
  %287 = load ptr, ptr %f_247
  %288 = load double, ptr %layar_kanan_5
  %289 = call i32 (ptr, ptr, ...) @fprintf(ptr %287, ptr @.fmt.desimal, double %288)
  %290 = sext i32 %289 to i64
  %291 = load ptr, ptr %f_247
  %292 = call i32 (ptr, ptr, ...) @fprintf(ptr %291, ptr @.fmt.string, ptr @.str.72)
  %293 = sext i32 %292 to i64
  %294 = load ptr, ptr %f_247
  %295 = load double, ptr %hasil_sementara_245
  %296 = call i32 (ptr, ptr, ...) @fprintf(ptr %294, ptr @.fmt.desimal, double %295)
  %297 = sext i32 %296 to i64
  %298 = load ptr, ptr %f_247
  %299 = call i32 (ptr, ptr, ...) @fprintf(ptr %298, ptr @.fmt.string, ptr @.str.73)
  %300 = sext i32 %299 to i64
  %301 = load ptr, ptr %f_247
  %302 = call i32 @fclose(ptr %301)
  %303 = sext i32 %302 to i64
  %304 = load double, ptr %hasil_sementara_245
  store double %304, ptr %layar_kiri_4
  store i64 0, ptr %op_7
  store i64 2, ptr %fokus_8
  store i64 0, ptr %ngetik_kanan_9
  br label %lbl_126

lbl_125:
  br label %lbl_126

lbl_126:
  br label %lbl_123

lbl_122:
  %305 = load i64, ptr %tombol_19
  %306 = icmp eq i64 %305, 67
  %307 = load i64, ptr %tombol_19
  %308 = icmp eq i64 %307, 99
  %309 = or i1 %306, %308
  br i1 %309, label %lbl_139, label %lbl_140

lbl_139:
  store double 0.0, ptr %layar_kiri_4
  store double 0.0, ptr %layar_kanan_5
  store i64 0, ptr %op_7
  store i64 0, ptr %fokus_8
  store i64 0, ptr %ngetik_kanan_9
  br label %lbl_141

lbl_140:
  %310 = load i64, ptr %tombol_19
  %311 = icmp eq i64 %310, 81
  %312 = load i64, ptr %tombol_19
  %313 = icmp eq i64 %312, 113
  %314 = or i1 %311, %313
  br i1 %314, label %lbl_142, label %lbl_143

lbl_142:
  store i64 0, ptr %jalan_3
  br label %lbl_144

lbl_143:
  br label %lbl_144

lbl_144:
  br label %lbl_141

lbl_141:
  br label %lbl_123

lbl_123:
  br label %lbl_102

lbl_102:
  br label %lbl_93

lbl_93:
  br label %lbl_69

lbl_69:
  br label %lbl_51

lbl_51:
  br label %lbl_48

lbl_47:
  br label %lbl_48

lbl_48:
  %315 = load i64, ptr %jalan_3
  %316 = icmp eq i64 %315, 1
  br i1 %316, label %lbl_145, label %lbl_146

lbl_145:
  %317 = load double, ptr %layar_kiri_4
  %318 = load double, ptr %layar_kanan_5
  %319 = load i64, ptr %op_7
  %320 = load i64, ptr %fokus_8
  %321 = load i64, ptr %ngetik_kanan_9
  call void @gambar_kalkulator(double %317, double %318, i64 %319, i64 %320, i64 %321)
  br label %lbl_147

lbl_146:
  br label %lbl_147

lbl_147:
  br label %lbl_1

lbl_3:
  call void @tui_matikan_mouse()
  call void @tui_tampilkan_kursor()
  call void @tui_bersihkan_layar()
  %322 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.74)
  ret i64 0
}


define i32 @main() {
entry:
  call i32 @SetConsoleOutputCP(i32 65001)
  %hOut = call ptr @GetStdHandle(i32 -11)
  %dwMode = alloca i32
  %mode_res = call i32 @GetConsoleMode(ptr %hOut, ptr %dwMode)
  %current_mode = load i32, ptr %dwMode
  %new_mode = or i32 %current_mode, 4
  %set_res = call i32 @SetConsoleMode(ptr %hOut, i32 %new_mode)

  %hIn = call ptr @GetStdHandle(i32 -10)
  %dwModeIn = alloca i32
  %mode_res_in = call i32 @GetConsoleMode(ptr %hIn, ptr %dwModeIn)
  %current_mode_in = load i32, ptr %dwModeIn
  %and_mode_in = and i32 %current_mode_in, -71
  %new_mode_in = or i32 %and_mode_in, 528
  %set_res_in = call i32 @SetConsoleMode(ptr %hIn, i32 %new_mode_in)
  %1 = call i64 @utama()
  %utama_res = call i64 @utama()
  %main_res = trunc i64 %utama_res to i32
  ret i32 %main_res
}

