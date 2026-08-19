; --- TELA CORE LLVM IR ---
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

declare i32 @printf(ptr, ...)
declare i32 @scanf(ptr, ...)
@.fmt.desimal = private unnamed_addr constant [6 x i8] c"%.15g\00", align 1
@.fmt.desimal_nl = private unnamed_addr constant [7 x i8] c"%.15g\0A\00", align 1
@.fmt.input_desimal = private unnamed_addr constant [4 x i8] c"%lf\00", align 1
@.fmt.input_bilangan = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.fmt.bilangan_nl = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1
@.fmt.string_nl = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.fmt.newline = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.fmt.karakter = private unnamed_addr constant [4 x i8] c"%c\0A\00", align 1
@.str.true = private unnamed_addr constant [6 x i8] c"benar\00", align 1
@.str.false = private unnamed_addr constant [6 x i8] c"salah\00", align 1
@.mode.rb = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.mode.r = private unnamed_addr constant [2 x i8] c"r\00", align 1

@.ansi.merah = private unnamed_addr constant [12 x i8] c"\1B[31m%s\1B[0m\00", align 1
@.ansi.hijau = private unnamed_addr constant [12 x i8] c"\1B[32m%s\1B[0m\00", align 1
@.ansi.kuning = private unnamed_addr constant [12 x i8] c"\1B[33m%s\1B[0m\00", align 1
@.ansi.biru = private unnamed_addr constant [12 x i8] c"\1B[34m%s\1B[0m\00", align 1
@.ansi.magenta = private unnamed_addr constant [12 x i8] c"\1B[35m%s\1B[0m\00", align 1
@.ansi.sian = private unnamed_addr constant [12 x i8] c"\1B[36m%s\1B[0m\00", align 1
@.ansi.putih = private unnamed_addr constant [12 x i8] c"\1B[37m%s\1B[0m\00", align 1
@.ansi.tebal = private unnamed_addr constant [11 x i8] c"\1B[1m%s\1B[0m\00", align 1
@.ansi.miring = private unnamed_addr constant [11 x i8] c"\1B[3m%s\1B[0m\00", align 1
@.ansi.garis_bawah = private unnamed_addr constant [11 x i8] c"\1B[4m%s\1B[0m\00", align 1
@.ansi.reset = private unnamed_addr constant [5 x i8] c"\1B[0m\00", align 1

@.b64.table = private unnamed_addr constant [65 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/\00", align 1
@.json.empty = private unnamed_addr constant [3 x i8] c"{}\00", align 1
@.json.str.init = private unnamed_addr constant [11 x i8] c"{\22%s\22:\22%s\22\00", align 1
@.json.str.next = private unnamed_addr constant [11 x i8] c",\22%s\22:\22%s\22\00", align 1
@.json.int.init = private unnamed_addr constant [11 x i8] c"{\22%s\22:%lld\00", align 1
@.json.int.next = private unnamed_addr constant [11 x i8] c",\22%s\22:%lld\00", align 1
@.json.des.init = private unnamed_addr constant [12 x i8] c"{\22%s\22:%.15g\00", align 1
@.json.des.next = private unnamed_addr constant [12 x i8] c",\22%s\22:%.15g\00", align 1
@.json.true.init = private unnamed_addr constant [11 x i8] c"{\22%s\22:true\00", align 1
@.json.true.next = private unnamed_addr constant [11 x i8] c",\22%s\22:true\00", align 1
@.json.false.init = private unnamed_addr constant [12 x i8] c"{\22%s\22:false\00", align 1
@.json.false.next = private unnamed_addr constant [12 x i8] c",\22%s\22:false\00", align 1

declare ptr @GetStdHandle(i32)
declare i32 @GetConsoleMode(ptr, ptr)
declare i32 @SetConsoleMode(ptr, i32)
declare i32 @SetConsoleOutputCP(i32)
declare i32 @getchar()
declare i32 @MessageBeep(i32)
declare void @Sleep(i32)
declare void @exit(i32)

declare ptr @fopen(ptr, ptr)
declare i32 @fprintf(ptr, ptr, ...)
declare i32 @fclose(ptr)
declare i32 @fseek(ptr, i64, i32)
declare i64 @ftell(ptr)
declare void @rewind(ptr)
declare i64 @fread(ptr, i64, i64, ptr)

declare double @sqrt(double)
declare double @pow(double, double)
declare double @sin(double)
declare double @cos(double)
declare double @tan(double)
declare double @asin(double)
declare double @acos(double)
declare double @atan(double)
declare double @atan2(double, double)
declare double @hypot(double, double)
declare double @log10(double)
declare double @floor(double)
declare double @ceil(double)

declare i64 @time(ptr)
declare ptr @localtime(ptr)
declare i64 @strftime(ptr, i64, ptr, ptr)
declare ptr @malloc(i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)

declare ptr @InternetOpenA(ptr, i32, ptr, ptr, i32)
declare ptr @InternetOpenUrlA(ptr, ptr, ptr, i32, i32, i64)
declare i32 @InternetReadFile(ptr, ptr, i32, ptr)
declare i32 @InternetCloseHandle(ptr)
declare i32 @MessageBoxA(ptr, ptr, ptr, i32)
declare i32 @GetCurrentThreadId()
declare void @GetSystemInfo(ptr)
declare i32 @Beep(i32, i32)
declare i32 @PlaySoundA(ptr, ptr, i32)
declare ptr @getenv(ptr)
declare i32 @SetEnvironmentVariableA(ptr, ptr)
declare i32 @GetCurrentDirectoryA(i32, ptr)
declare i32 @CreateDirectoryA(ptr, ptr)
declare i32 @DeleteFileA(ptr)
declare i32 @CopyFileA(ptr, ptr, i32)
declare i32 @MoveFileA(ptr, ptr)
declare i32 @fputs(ptr, ptr)
declare i64 @GetTickCount64()
declare i32 @system(ptr)
declare i32 @CryptAcquireContextA(ptr, ptr, ptr, i32, i32)
declare i32 @CryptCreateHash(ptr, i32, ptr, i32, ptr)
declare i32 @CryptHashData(ptr, ptr, i32, i32)
declare i32 @CryptGetHashParam(ptr, i32, ptr, ptr, i32)
declare i32 @CryptDestroyHash(ptr)
declare i32 @CryptReleaseContext(ptr, i32)
declare i32 @CryptGenRandom(ptr, i32, ptr)
declare i32 @GetFileAttributesA(ptr)
declare i64 @llvm.ctpop.i64(i64)
@_tela_argc = global i32 0, align 4
@_tela_argv = global ptr null, align 8
@_tela_last_http_status = global i64 200, align 8
@.hex.byte_fmt = private unnamed_addr constant [5 x i8] c"%02x\00", align 1
@.str.mode_rb = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str.mode_w = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.os_name = private unnamed_addr constant [8 x i8] c"Windows\00", align 1
@.str.arch_name = private unnamed_addr constant [7 x i8] c"x86_64\00", align 1
@.str.user_agent = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.empty = private unnamed_addr constant [1 x i8] c"\00", align 1
@.str.cls = private unnamed_addr constant [4 x i8] c"cls\00", align 1
@.str.username = private unnamed_addr constant [9 x i8] c"USERNAME\00", align 1
@.test.lulus = private unnamed_addr constant [25 x i8] c"\1B[1;32m  [LULUS]\1B[0m %s\0A\00", align 1
@.test.gagal = private unnamed_addr constant [25 x i8] c"\1B[1;31m  [GAGAL]\1B[0m %s\0A\00", align 1
declare i64 @strlen(ptr)
declare ptr @strcpy(ptr, ptr)
declare ptr @strcat(ptr, ptr)
declare ptr @strncpy(ptr, ptr, i64)
declare i32 @strcmp(ptr, ptr)
declare i32 @strncmp(ptr, ptr, i64)
declare ptr @strstr(ptr, ptr)
declare ptr @strchr(ptr, i32)
declare i32 @tolower(i32)
declare i32 @toupper(i32)
declare i32 @sprintf(ptr, ptr, ...)
declare i32 @sscanf(ptr, ptr, ...)
declare i64 @strtol(ptr, ptr, i32)
declare double @strtod(ptr, ptr)
declare ptr @CreateThread(ptr, i64, ptr, ptr, i32, ptr)
declare i32 @WaitForSingleObject(ptr, i32)
declare i32 @CloseHandle(ptr)

@.hex.chars = private unnamed_addr constant [17 x i8] c"0123456789abcdef\00", align 1
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

@.str.0 = private unnamed_addr constant [2 x i8] c"#\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c" [\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"] \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"%\00", align 1
@.str.5 = private unnamed_addr constant [33 x i8] c"=== TELACORE AI - PERCEPTRON ===\00", align 1
@.str.6 = private unnamed_addr constant [43 x i8] c"Model: 2 Input, 1 Neuron, Aktivasi Sigmoid\00", align 1
@.str.7 = private unnamed_addr constant [12 x i8] c"Gerbang OR:\00", align 1
@.str.8 = private unnamed_addr constant [8 x i8] c"OR(0,0)\00", align 1
@.str.9 = private unnamed_addr constant [8 x i8] c"OR(1,0)\00", align 1
@.str.10 = private unnamed_addr constant [8 x i8] c"OR(0,1)\00", align 1
@.str.11 = private unnamed_addr constant [8 x i8] c"OR(1,1)\00", align 1
@.str.12 = private unnamed_addr constant [13 x i8] c"Gerbang AND:\00", align 1
@.str.13 = private unnamed_addr constant [9 x i8] c"AND(0,0)\00", align 1
@.str.14 = private unnamed_addr constant [9 x i8] c"AND(1,0)\00", align 1
@.str.15 = private unnamed_addr constant [9 x i8] c"AND(0,1)\00", align 1
@.str.16 = private unnamed_addr constant [9 x i8] c"AND(1,1)\00", align 1
@.str.17 = private unnamed_addr constant [34 x i8] c"Perceptron AI selesai dijalankan!\00", align 1
define double @sigmoid(double %arg_x) {
entry:
  %x = alloca double
  store double %arg_x, ptr %x
  %1 = load double, ptr %x
  %2 = fneg double 1.0
  %3 = fmul double %1, %2
  %4 = call double @pow(double 2.718281828459045, double %3)
  %e_5 = alloca double
  store double %4, ptr %e_5
  %6 = load double, ptr %e_5
  %7 = fadd double 1.0, %6
  %8 = fdiv double 1.0, %7
  ret double %8
}

define double @prediksi(double %arg_x1, double %arg_x2, double %arg_w1, double %arg_w2, double %arg_bias) {
entry:
  %x1 = alloca double
  store double %arg_x1, ptr %x1
  %x2 = alloca double
  store double %arg_x2, ptr %x2
  %w1 = alloca double
  store double %arg_w1, ptr %w1
  %w2 = alloca double
  store double %arg_w2, ptr %w2
  %bias = alloca double
  store double %arg_bias, ptr %bias
  %1 = load double, ptr %x1
  %2 = load double, ptr %w1
  %3 = fmul double %1, %2
  %4 = load double, ptr %x2
  %5 = load double, ptr %w2
  %6 = fmul double %4, %5
  %7 = fadd double %3, %6
  %8 = load double, ptr %bias
  %9 = fadd double %7, %8
  %z_10 = alloca double
  store double %9, ptr %z_10
  %11 = load double, ptr %z_10
  %12 = call double @sigmoid(double %11)
  ret double %12
}

define ptr @isi_bar(double %arg_v) {
entry:
  %v = alloca double
  store double %arg_v, ptr %v
  %1 = load double, ptr %v
  %2 = fmul double %1, 20.0
  %3 = fadd double %2, 0.5
  %4 = fptosi double %3 to i64
  %persen_5 = alloca i64
  store i64 %4, ptr %persen_5
  %6 = load i64, ptr %persen_5
  %7 = call i64 @strlen(ptr @.str.0)
  %8 = mul i64 %7, %6
  %9 = add i64 %8, 1
  %10 = call ptr @malloc(i64 %9)
  store i8 0, ptr %10
  %11 = alloca i64
  store i64 0, ptr %11
  br label %lbl_1

lbl_1:
  %12 = load i64, ptr %11
  %13 = icmp slt i64 %12, %6
  br i1 %13, label %lbl_2, label %lbl_3

lbl_2:
  %14 = call ptr @strcat(ptr %10, ptr @.str.0)
  %15 = add i64 %12, 1
  store i64 %15, ptr %11
  br label %lbl_1

lbl_3:
  %blok_16 = alloca ptr
  store ptr %10, ptr %blok_16
  %17 = load i64, ptr %persen_5
  %18 = sub i64 20, %17
  %19 = call i64 @strlen(ptr @.str.1)
  %20 = mul i64 %19, %18
  %21 = add i64 %20, 1
  %22 = call ptr @malloc(i64 %21)
  store i8 0, ptr %22
  %23 = alloca i64
  store i64 0, ptr %23
  br label %lbl_4

lbl_4:
  %24 = load i64, ptr %23
  %25 = icmp slt i64 %24, %18
  br i1 %25, label %lbl_5, label %lbl_6

lbl_5:
  %26 = call ptr @strcat(ptr %22, ptr @.str.1)
  %27 = add i64 %24, 1
  store i64 %27, ptr %23
  br label %lbl_4

lbl_6:
  %kosong_bar_28 = alloca ptr
  store ptr %22, ptr %kosong_bar_28
  %29 = load ptr, ptr %blok_16
  %30 = load ptr, ptr %kosong_bar_28
  %32 = call i64 @strlen(ptr %29)
  %33 = call i64 @strlen(ptr %30)
  %34 = add i64 %32, %33
  %35 = add i64 %34, 1
  %36 = call ptr @malloc(i64 %35)
  %37 = call ptr @strcpy(ptr %36, ptr %29)
  %38 = call ptr @strcat(ptr %36, ptr %30)
  ret ptr %36
}

define void @tampil(ptr %arg_label, double %arg_h) {
entry:
  %label = alloca ptr
  store ptr %arg_label, ptr %label
  %h = alloca double
  store double %arg_h, ptr %h
  %1 = load double, ptr %h
  %2 = fmul double %1, 100.0
  %pct_3 = alloca double
  store double %2, ptr %pct_3
  %4 = load ptr, ptr %label
  %6 = call i64 @strlen(ptr %4)
  %7 = call i64 @strlen(ptr @.str.2)
  %8 = add i64 %6, %7
  %9 = add i64 %8, 1
  %10 = call ptr @malloc(i64 %9)
  %11 = call ptr @strcpy(ptr %10, ptr %4)
  %12 = call ptr @strcat(ptr %10, ptr @.str.2)
  %13 = load double, ptr %h
  %14 = call ptr @isi_bar(double %13)
  %16 = call i64 @strlen(ptr %10)
  %17 = call i64 @strlen(ptr %14)
  %18 = add i64 %16, %17
  %19 = add i64 %18, 1
  %20 = call ptr @malloc(i64 %19)
  %21 = call ptr @strcpy(ptr %20, ptr %10)
  %22 = call ptr @strcat(ptr %20, ptr %14)
  %24 = call i64 @strlen(ptr %20)
  %25 = call i64 @strlen(ptr @.str.3)
  %26 = add i64 %24, %25
  %27 = add i64 %26, 1
  %28 = call ptr @malloc(i64 %27)
  %29 = call ptr @strcpy(ptr %28, ptr %20)
  %30 = call ptr @strcat(ptr %28, ptr @.str.3)
  %31 = load double, ptr %pct_3
  %32 = call ptr @malloc(i64 32)
  %33 = call i32 (ptr, ptr, ...) @sprintf(ptr %32, ptr @.fmt.desimal, double %31)
  %35 = call i64 @strlen(ptr %28)
  %36 = call i64 @strlen(ptr %32)
  %37 = add i64 %35, %36
  %38 = add i64 %37, 1
  %39 = call ptr @malloc(i64 %38)
  %40 = call ptr @strcpy(ptr %39, ptr %28)
  %41 = call ptr @strcat(ptr %39, ptr %32)
  %43 = call i64 @strlen(ptr %39)
  %44 = call i64 @strlen(ptr @.str.4)
  %45 = add i64 %43, %44
  %46 = add i64 %45, 1
  %47 = call ptr @malloc(i64 %46)
  %48 = call ptr @strcpy(ptr %47, ptr %39)
  %49 = call ptr @strcat(ptr %47, ptr @.str.4)
  %50 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %47)
  ret void
}

define void @utama() {
entry:
  %1 = call i64 @strlen(ptr @.str.5)
  %2 = add i64 %1, 32
  %3 = call ptr @malloc(i64 %2)
  %4 = call i32 (ptr, ptr, ...) @sprintf(ptr %3, ptr @.ansi.sian, ptr @.str.5)
  %5 = call i64 @strlen(ptr %3)
  %6 = add i64 %5, 32
  %7 = call ptr @malloc(i64 %6)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.ansi.tebal, ptr %3)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %7)
  %10 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.6)
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %w1_12 = alloca double
  store double 0.9, ptr %w1_12
  %w2_13 = alloca double
  store double 0.9, ptr %w2_13
  %14 = fneg double 0.4
  %bias_15 = alloca double
  store double %14, ptr %bias_15
  %16 = call i64 @strlen(ptr @.str.7)
  %17 = add i64 %16, 32
  %18 = call ptr @malloc(i64 %17)
  %19 = call i32 (ptr, ptr, ...) @sprintf(ptr %18, ptr @.ansi.kuning, ptr @.str.7)
  %20 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %18)
  %21 = load double, ptr %w1_12
  %22 = load double, ptr %w2_13
  %23 = load double, ptr %bias_15
  %24 = call double @prediksi(double 0.0, double 0.0, double %21, double %22, double %23)
  call void @tampil(ptr @.str.8, double %24)
  %25 = load double, ptr %w1_12
  %26 = load double, ptr %w2_13
  %27 = load double, ptr %bias_15
  %28 = call double @prediksi(double 1.0, double 0.0, double %25, double %26, double %27)
  call void @tampil(ptr @.str.9, double %28)
  %29 = load double, ptr %w1_12
  %30 = load double, ptr %w2_13
  %31 = load double, ptr %bias_15
  %32 = call double @prediksi(double 0.0, double 1.0, double %29, double %30, double %31)
  call void @tampil(ptr @.str.10, double %32)
  %33 = load double, ptr %w1_12
  %34 = load double, ptr %w2_13
  %35 = load double, ptr %bias_15
  %36 = call double @prediksi(double 1.0, double 1.0, double %33, double %34, double %35)
  call void @tampil(ptr @.str.11, double %36)
  %37 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %wa1_38 = alloca double
  store double 1.0, ptr %wa1_38
  %wa2_39 = alloca double
  store double 1.0, ptr %wa2_39
  %40 = fneg double 1.5
  %bias_and_41 = alloca double
  store double %40, ptr %bias_and_41
  %42 = call i64 @strlen(ptr @.str.12)
  %43 = add i64 %42, 32
  %44 = call ptr @malloc(i64 %43)
  %45 = call i32 (ptr, ptr, ...) @sprintf(ptr %44, ptr @.ansi.kuning, ptr @.str.12)
  %46 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %44)
  %47 = load double, ptr %wa1_38
  %48 = load double, ptr %wa2_39
  %49 = load double, ptr %bias_and_41
  %50 = call double @prediksi(double 0.0, double 0.0, double %47, double %48, double %49)
  call void @tampil(ptr @.str.13, double %50)
  %51 = load double, ptr %wa1_38
  %52 = load double, ptr %wa2_39
  %53 = load double, ptr %bias_and_41
  %54 = call double @prediksi(double 1.0, double 0.0, double %51, double %52, double %53)
  call void @tampil(ptr @.str.14, double %54)
  %55 = load double, ptr %wa1_38
  %56 = load double, ptr %wa2_39
  %57 = load double, ptr %bias_and_41
  %58 = call double @prediksi(double 0.0, double 1.0, double %55, double %56, double %57)
  call void @tampil(ptr @.str.15, double %58)
  %59 = load double, ptr %wa1_38
  %60 = load double, ptr %wa2_39
  %61 = load double, ptr %bias_and_41
  %62 = call double @prediksi(double 1.0, double 1.0, double %59, double %60, double %61)
  call void @tampil(ptr @.str.16, double %62)
  %63 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %64 = call i64 @strlen(ptr @.str.17)
  %65 = add i64 %64, 32
  %66 = call ptr @malloc(i64 %65)
  %67 = call i32 (ptr, ptr, ...) @sprintf(ptr %66, ptr @.ansi.hijau, ptr @.str.17)
  %68 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %66)
  ret void
}


define i32 @main(i32 %argc, ptr %argv) {
entry:
  store i32 %argc, ptr @_tela_argc
  store ptr %argv, ptr @_tela_argv
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

