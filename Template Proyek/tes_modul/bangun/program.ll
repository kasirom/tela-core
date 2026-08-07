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

@.str.0 = private unnamed_addr constant [26 x i8] c"Memanggil tambah(10, 20)\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"Memanggil kali(5, 5)\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define i64 @matematika_tambah(i64 %arg_a, i64 %arg_b) {
entry:
  %a = alloca i64
  store i64 %arg_a, ptr %a
  %b = alloca i64
  store i64 %arg_b, ptr %b
  %1 = load i64, ptr %a
  %2 = load i64, ptr %b
  %3 = add i64 %1, %2
  ret i64 %3
}

define i64 @matematika_kali(i64 %arg_a, i64 %arg_b) {
entry:
  %a = alloca i64
  store i64 %arg_a, ptr %a
  %b = alloca i64
  store i64 %arg_b, ptr %b
  %1 = load i64, ptr %a
  %2 = load i64, ptr %b
  %3 = mul i64 %1, %2
  ret i64 %3
}

define i64 @utama() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.0)
  %2 = call i64 @matematika_tambah(i64 10, i64 20)
  %hasil_tambah_3 = alloca i64
  store i64 %2, ptr %hasil_tambah_3
  %4 = load i64, ptr %hasil_tambah_3
  %5 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %4)
  %6 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  %7 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.2)
  %8 = call i64 @matematika_kali(i64 5, i64 5)
  %hasil_kali_9 = alloca i64
  store i64 %8, ptr %hasil_kali_9
  %10 = load i64, ptr %hasil_kali_9
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %10)
  %12 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.3)
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
  %utama_res = call i64 @utama()
  %main_res = trunc i64 %utama_res to i32
  ret i32 %main_res
}

