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

@.str.0 = private unnamed_addr constant [26 x i8] c"Memulai tugas asinkron...\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"Hasil 1 (100 + 1):\00", align 1
@.str.2 = private unnamed_addr constant [18 x i8] c"Hasil 2 (50 * 2):\00", align 1
define i64 @tambah_satu(i64 %arg_angka) {
entry:
  %angka = alloca i64
  store i64 %arg_angka, ptr %angka
  %1 = load i64, ptr %angka
  %2 = add i64 %1, 1
  ret i64 %2
}

define i32 @tambah_satu_async_wrapper(ptr %arg_struct_ptr) {
entry:
  %arg_0 = getelementptr { i64, i64 }, ptr %arg_struct_ptr, i32 0, i32 1
  %val_0 = load i64, ptr %arg_0
  %res_temp = call i64 @tambah_satu(i64 %val_0)
  %ret_ptr = getelementptr { i64, i64 }, ptr %arg_struct_ptr, i32 0, i32 0
  store i64 %res_temp, ptr %ret_ptr
  ret i32 0
}

define i64 @kali_dua(i64 %arg_angka) {
entry:
  %angka = alloca i64
  store i64 %arg_angka, ptr %angka
  %1 = load i64, ptr %angka
  %2 = mul i64 %1, 2
  ret i64 %2
}

define i32 @kali_dua_async_wrapper(ptr %arg_struct_ptr) {
entry:
  %arg_0 = getelementptr { i64, i64 }, ptr %arg_struct_ptr, i32 0, i32 1
  %val_0 = load i64, ptr %arg_0
  %res_temp = call i64 @kali_dua(i64 %val_0)
  %ret_ptr = getelementptr { i64, i64 }, ptr %arg_struct_ptr, i32 0, i32 0
  store i64 %res_temp, ptr %ret_ptr
  ret i32 0
}

define void @utama() {
entry:
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.0)
  %2 = call ptr @malloc(i64 16)
  %3 = getelementptr { i64, i64 }, ptr %2, i32 0, i32 1
  store i64 100, ptr %3
  %4 = call ptr @CreateThread(ptr null, i64 0, ptr @tambah_satu_async_wrapper, ptr %2, i32 0, ptr null)
  %5 = insertvalue { ptr, ptr } undef, ptr %4, 0
  %6 = insertvalue { ptr, ptr } %5, ptr %2, 1
  %t1_7 = alloca { ptr, ptr }
  store { ptr, ptr } %6, ptr %t1_7
  %8 = call ptr @malloc(i64 16)
  %9 = getelementptr { i64, i64 }, ptr %8, i32 0, i32 1
  store i64 50, ptr %9
  %10 = call ptr @CreateThread(ptr null, i64 0, ptr @kali_dua_async_wrapper, ptr %8, i32 0, ptr null)
  %11 = insertvalue { ptr, ptr } undef, ptr %10, 0
  %12 = insertvalue { ptr, ptr } %11, ptr %8, 1
  %t2_13 = alloca { ptr, ptr }
  store { ptr, ptr } %12, ptr %t2_13
  %14 = load { ptr, ptr }, ptr %t1_7
  %15 = extractvalue { ptr, ptr } %14, 0
  %16 = extractvalue { ptr, ptr } %14, 1
  %17 = call i32 @WaitForSingleObject(ptr %15, i32 -1)
  %18 = load i64, ptr %16
  %19 = call i32 @CloseHandle(ptr %15)
  call void @free(ptr %16)
  %hasil1_20 = alloca i64
  store i64 %18, ptr %hasil1_20
  %21 = load { ptr, ptr }, ptr %t2_13
  %22 = extractvalue { ptr, ptr } %21, 0
  %23 = extractvalue { ptr, ptr } %21, 1
  %24 = call i32 @WaitForSingleObject(ptr %22, i32 -1)
  %25 = load i64, ptr %23
  %26 = call i32 @CloseHandle(ptr %22)
  call void @free(ptr %23)
  %hasil2_27 = alloca i64
  store i64 %25, ptr %hasil2_27
  %28 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  %29 = load i64, ptr %hasil1_20
  %30 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %29)
  %31 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.2)
  %32 = load i64, ptr %hasil2_27
  %33 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %32)
  ret void
}

define i32 @utama_async_wrapper(ptr %arg_struct_ptr) {
entry:
  call void @utama()
  ret i32 0
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

