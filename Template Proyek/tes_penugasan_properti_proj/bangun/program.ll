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

@.str.0 = private unnamed_addr constant [5 x i8] c"Budi\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"Sebelum ubah:\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"Budi Santoso\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"Setelah ubah:\00", align 1
%Pengguna = type { ptr, i64 }
define void @utama() {
entry:
  %1 = alloca %Pengguna
  %2 = getelementptr %Pengguna, ptr %1, i32 0, i32 0
  store ptr @.str.0, ptr %2
  %3 = getelementptr %Pengguna, ptr %1, i32 0, i32 1
  store i64 30, ptr %3
  %4 = load %Pengguna, ptr %1
  %budi_5 = alloca %Pengguna
  store %Pengguna %4, ptr %budi_5
  %6 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  %7 = load %Pengguna, ptr %budi_5
  %8 = load %Pengguna, ptr %budi_5
  %9 = alloca %Pengguna
  store %Pengguna %8, ptr %9
  %10 = getelementptr %Pengguna, ptr %9, i32 0, i32 0
  %11 = load ptr, ptr %10
  %12 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %11)
  %13 = load %Pengguna, ptr %budi_5
  %14 = load %Pengguna, ptr %budi_5
  %15 = alloca %Pengguna
  store %Pengguna %14, ptr %15
  %16 = getelementptr %Pengguna, ptr %15, i32 0, i32 1
  %17 = load i64, ptr %16
  %18 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %17)
  %19 = getelementptr %Pengguna, ptr %budi_5, i32 0, i32 0
  store ptr @.str.2, ptr %19
  %20 = getelementptr %Pengguna, ptr %budi_5, i32 0, i32 1
  store i64 31, ptr %20
  %21 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.3)
  %22 = load %Pengguna, ptr %budi_5
  %23 = load %Pengguna, ptr %budi_5
  %24 = alloca %Pengguna
  store %Pengguna %23, ptr %24
  %25 = getelementptr %Pengguna, ptr %24, i32 0, i32 0
  %26 = load ptr, ptr %25
  %27 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %26)
  %28 = load %Pengguna, ptr %budi_5
  %29 = load %Pengguna, ptr %budi_5
  %30 = alloca %Pengguna
  store %Pengguna %29, ptr %30
  %31 = getelementptr %Pengguna, ptr %30, i32 0, i32 1
  %32 = load i64, ptr %31
  %33 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %32)
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

