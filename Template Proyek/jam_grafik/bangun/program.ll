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

@.str.0 = private unnamed_addr constant [8 x i8] c"[2J[H\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"[\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c";\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"H\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"[\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"m\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"[\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"m\00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c"[0m\00", align 1
@.str.9 = private unnamed_addr constant [17 x i8] c"Waktunya bangun!\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"%d-%d-%d %d:%d:%d\00", align 1
@.str.11 = private unnamed_addr constant [42 x i8] c"=========================================\00", align 1
@.str.12 = private unnamed_addr constant [55 x i8] c"      🕰️ JAM DIGITAL TELA NUSANTARA 🕰️      \00", align 1
@.str.13 = private unnamed_addr constant [42 x i8] c"=========================================\00", align 1
@.str.14 = private unnamed_addr constant [11 x i8] c"Tanggal : \00", align 1
@.str.15 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.16 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.17 = private unnamed_addr constant [11 x i8] c"Waktu   : \00", align 1
@.str.18 = private unnamed_addr constant [2 x i8] c":\00", align 1
@.str.19 = private unnamed_addr constant [2 x i8] c":\00", align 1
@.str.20 = private unnamed_addr constant [4 x i8] c"   \00", align 1
@.str.21 = private unnamed_addr constant [42 x i8] c"-----------------------------------------\00", align 1
@.str.22 = private unnamed_addr constant [15 x i8] c"Status Alarm: \00", align 1
@.str.23 = private unnamed_addr constant [12 x i8] c"AKTIF PADA \00", align 1
@.str.24 = private unnamed_addr constant [2 x i8] c":\00", align 1
@.str.25 = private unnamed_addr constant [10 x i8] c"NON-AKTIF\00", align 1
@.str.26 = private unnamed_addr constant [15 x i8] c"Pengingat   : \00", align 1
@.str.27 = private unnamed_addr constant [42 x i8] c"-----------------------------------------\00", align 1
@.str.28 = private unnamed_addr constant [65 x i8] c"Info: [Simulasi] Detik 15 set alarm menit+1. Detik 35 uji suara.\00", align 1
@.str.29 = private unnamed_addr constant [15 x i8] c"SystemAsterisk\00", align 1
@.str.30 = private unnamed_addr constant [11 x i8] c"SystemHand\00", align 1
@.str.31 = private unnamed_addr constant [47 x i8] c"🚨 ALARM DIPICU! TAMPILKAN POPUP DI LAYAR...\00", align 1
@.str.32 = private unnamed_addr constant [21 x i8] c"ALARM TELA NUSANTARA\00", align 1
@.str.33 = private unnamed_addr constant [46 x i8] c"                                             \00", align 1
@.str.34 = private unnamed_addr constant [36 x i8] c"Waktunya coding TelaCore Nusantara!\00", align 1
@.str.35 = private unnamed_addr constant [19 x i8] c"SystemNotification\00", align 1
define void @tui_bersihkan() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.0)
  ret void
}

define void @tui_posisi(i64 %arg_baris, i64 %arg_kolom) {
entry:
  %baris = alloca i64
  store i64 %arg_baris, ptr %baris
  %kolom = alloca i64
  store i64 %arg_kolom, ptr %kolom
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  %2 = load i64, ptr %baris
  %3 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %2)
  %4 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.2)
  %5 = load i64, ptr %kolom
  %6 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %5)
  %7 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.3)
  ret void
}

define void @tui_warna_teks(i64 %arg_kode) {
entry:
  %kode = alloca i64
  store i64 %arg_kode, ptr %kode
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.4)
  %2 = load i64, ptr %kode
  %3 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %2)
  %4 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.5)
  ret void
}

define void @tui_warna_latar(i64 %arg_kode) {
entry:
  %kode = alloca i64
  store i64 %arg_kode, ptr %kode
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.6)
  %2 = load i64, ptr %kode
  %3 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %2)
  %4 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.7)
  ret void
}

define void @tui_reset() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.8)
  ret void
}

declare i64 @sscanf(ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr)

declare i64 @MessageBoxA(i64, ptr, ptr, i64)

declare i64 @PlaySoundA(ptr, i64, i64)

declare void @Sleep(i64)

define void @main_clock_loop() {
entry:
  %alarm_jam_1 = alloca i64
  store i64 0, ptr %alarm_jam_1
  %alarm_menit_2 = alloca i64
  store i64 0, ptr %alarm_menit_2
  %pengingat_3 = alloca ptr
  store ptr @.str.9, ptr %pengingat_3
  %alarm_aktif_4 = alloca i1
  store i1 0, ptr %alarm_aktif_4
  %fmt_parse_5 = alloca ptr
  store ptr @.str.10, ptr %fmt_parse_5
  call void @tui_bersihkan()
  %loop_run_6 = alloca i64
  store i64 1, ptr %loop_run_6
  br label %lbl_1

lbl_1:
  %7 = load i64, ptr %loop_run_6
  %8 = icmp eq i64 %7, 1
  br i1 %8, label %lbl_2, label %lbl_3

lbl_2:
  %9 = alloca i64
  %10 = call i64 @time(ptr null)
  store i64 %10, ptr %9
  %11 = call ptr @localtime(ptr %9)
  %12 = call ptr @malloc(i64 20)
  %13 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %14 = call i64 @strftime(ptr %12, i64 20, ptr %13, ptr %11)
  %waktu_str_15 = alloca ptr
  store ptr %12, ptr %waktu_str_15
  %y_16 = alloca i64
  store i64 0, ptr %y_16
  %m_17 = alloca i64
  store i64 0, ptr %m_17
  %d_18 = alloca i64
  store i64 0, ptr %d_18
  %hr_19 = alloca i64
  store i64 0, ptr %hr_19
  %min_20 = alloca i64
  store i64 0, ptr %min_20
  %sec_21 = alloca i64
  store i64 0, ptr %sec_21
  %22 = load ptr, ptr %waktu_str_15
  %23 = load ptr, ptr %fmt_parse_5
  %24 = call i64 @sscanf(ptr %22, ptr %23, ptr %y_16, ptr %m_17, ptr %d_18, ptr %hr_19, ptr %min_20, ptr %sec_21)
  call void @tui_posisi(i64 2, i64 5)
  call void @tui_warna_teks(i64 36)
  %25 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.11)
  call void @tui_posisi(i64 3, i64 5)
  %26 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.12)
  call void @tui_posisi(i64 4, i64 5)
  %27 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.13)
  call void @tui_posisi(i64 6, i64 10)
  call void @tui_warna_teks(i64 32)
  %28 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.14)
  %29 = load i64, ptr %d_18
  %30 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %29)
  %31 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.15)
  %32 = load i64, ptr %m_17
  %33 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %32)
  %34 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.16)
  %35 = load i64, ptr %y_16
  %36 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %35)
  call void @tui_posisi(i64 7, i64 10)
  call void @tui_warna_teks(i64 33)
  %37 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.17)
  %38 = load i64, ptr %hr_19
  %39 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %38)
  %40 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.18)
  %41 = load i64, ptr %min_20
  %42 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %41)
  %43 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.19)
  %44 = load i64, ptr %sec_21
  %45 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %44)
  %46 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.20)
  call void @tui_posisi(i64 9, i64 5)
  call void @tui_warna_teks(i64 35)
  %47 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.21)
  call void @tui_posisi(i64 10, i64 5)
  %48 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.22)
  %49 = load i1, ptr %alarm_aktif_4
  br i1 %49, label %lbl_4, label %lbl_5

lbl_4:
  call void @tui_warna_teks(i64 32)
  %50 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.23)
  %51 = load i64, ptr %alarm_jam_1
  %52 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %51)
  %53 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.24)
  %54 = load i64, ptr %alarm_menit_2
  %55 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %54)
  br label %lbl_6

lbl_5:
  call void @tui_warna_teks(i64 31)
  %56 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.25)
  br label %lbl_6

lbl_6:
  call void @tui_posisi(i64 11, i64 5)
  call void @tui_warna_teks(i64 35)
  %57 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.26)
  %58 = load ptr, ptr %pengingat_3
  %59 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %58)
  call void @tui_posisi(i64 12, i64 5)
  %60 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.27)
  call void @tui_posisi(i64 14, i64 5)
  call void @tui_warna_teks(i64 37)
  %61 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.28)
  %62 = load i1, ptr %alarm_aktif_4
  br i1 %62, label %lbl_7, label %lbl_8

lbl_7:
  %63 = load i64, ptr %hr_19
  %64 = load i64, ptr %alarm_jam_1
  %65 = icmp eq i64 %63, %64
  br i1 %65, label %lbl_10, label %lbl_11

lbl_10:
  %66 = load i64, ptr %min_20
  %67 = load i64, ptr %alarm_menit_2
  %68 = icmp eq i64 %66, %67
  br i1 %68, label %lbl_13, label %lbl_14

lbl_13:
  store i1 0, ptr %alarm_aktif_4
  %69 = call i64 @PlaySoundA(ptr @.str.29, i64 0, i64 1)
  %70 = call i64 @PlaySoundA(ptr @.str.30, i64 0, i64 1)
  call void @tui_posisi(i64 16, i64 5)
  call void @tui_warna_teks(i64 31)
  %71 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.31)
  %72 = load ptr, ptr %pengingat_3
  %73 = call i64 @MessageBoxA(i64 0, ptr %72, ptr @.str.32, i64 48)
  call void @tui_posisi(i64 16, i64 5)
  %74 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.33)
  br label %lbl_15

lbl_14:
  br label %lbl_15

lbl_15:
  br label %lbl_12

lbl_11:
  br label %lbl_12

lbl_12:
  br label %lbl_9

lbl_8:
  br label %lbl_9

lbl_9:
  call void @Sleep(i64 1000)
  %75 = load i64, ptr %sec_21
  %76 = icmp eq i64 %75, 15
  br i1 %76, label %lbl_16, label %lbl_17

lbl_16:
  %77 = load i64, ptr %hr_19
  store i64 %77, ptr %alarm_jam_1
  %78 = load i64, ptr %min_20
  %79 = add i64 %78, 1
  store i64 %79, ptr %alarm_menit_2
  %80 = load i64, ptr %alarm_menit_2
  %81 = icmp sge i64 %80, 60
  br i1 %81, label %lbl_19, label %lbl_20

lbl_19:
  store i64 0, ptr %alarm_menit_2
  %82 = load i64, ptr %alarm_jam_1
  %83 = add i64 %82, 1
  store i64 %83, ptr %alarm_jam_1
  br label %lbl_21

lbl_20:
  br label %lbl_21

lbl_21:
  store ptr @.str.34, ptr %pengingat_3
  store i1 1, ptr %alarm_aktif_4
  br label %lbl_18

lbl_17:
  br label %lbl_18

lbl_18:
  %84 = load i64, ptr %sec_21
  %85 = icmp eq i64 %84, 35
  br i1 %85, label %lbl_22, label %lbl_23

lbl_22:
  %86 = call i64 @PlaySoundA(ptr @.str.35, i64 0, i64 1)
  br label %lbl_24

lbl_23:
  br label %lbl_24

lbl_24:
  %87 = load i64, ptr %hr_19
  %88 = icmp sge i64 %87, 24
  br i1 %88, label %lbl_25, label %lbl_26

lbl_25:
  store i64 0, ptr %loop_run_6
  br label %lbl_27

lbl_26:
  br label %lbl_27

lbl_27:
  br label %lbl_1

lbl_3:
  ret void
}

define void @utama() {
entry:
  call void @main_clock_loop()
  ret void
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
  call void @utama()
  ret i32 0
}

