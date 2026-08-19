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

@.str.0 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.6 = private unnamed_addr constant [15 x i8] c"1. INFO SISTEM\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"OS\00", align 1
@.str.8 = private unnamed_addr constant [11 x i8] c"Arsitektur\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"Waktu\00", align 1
@.str.10 = private unnamed_addr constant [15 x i8] c"Unix Timestamp\00", align 1
@.str.11 = private unnamed_addr constant [14 x i8] c"2. MATEMATIKA\00", align 1
@.str.12 = private unnamed_addr constant [5 x i8] c"pi()\00", align 1
@.str.13 = private unnamed_addr constant [8 x i8] c"akar(2)\00", align 1
@.str.14 = private unnamed_addr constant [15 x i8] c"pangkat(2, 32)\00", align 1
@.str.15 = private unnamed_addr constant [10 x i8] c"sin(pi/2)\00", align 1
@.str.16 = private unnamed_addr constant [17 x i8] c"hipotenusa(5,12)\00", align 1
@.str.17 = private unnamed_addr constant [20 x i8] c"acak_rentang(1,100)\00", align 1
@.str.18 = private unnamed_addr constant [15 x i8] c"3. KRIPTOGRAFI\00", align 1
@.str.19 = private unnamed_addr constant [24 x i8] c"TelaCore Nusantara 2026\00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c"Pesan\00", align 1
@.str.21 = private unnamed_addr constant [8 x i8] c"SHA-256\00", align 1
@.str.22 = private unnamed_addr constant [4 x i8] c"...\00", align 1
@.str.23 = private unnamed_addr constant [4 x i8] c"MD5\00", align 1
@.str.24 = private unnamed_addr constant [7 x i8] c"Base64\00", align 1
@.str.25 = private unnamed_addr constant [6 x i8] c"ROT13\00", align 1
@.str.26 = private unnamed_addr constant [12 x i8] c"Acak Kripto\00", align 1
@.str.27 = private unnamed_addr constant [7 x i8] c"CRC-32\00", align 1
@.str.28 = private unnamed_addr constant [16 x i8] c"4. JSON BUILDER\00", align 1
@.str.29 = private unnamed_addr constant [7 x i8] c"bahasa\00", align 1
@.str.30 = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.31 = private unnamed_addr constant [6 x i8] c"versi\00", align 1
@.str.32 = private unnamed_addr constant [6 x i8] c"0.2.0\00", align 1
@.str.33 = private unnamed_addr constant [6 x i8] c"tahun\00", align 1
@.str.34 = private unnamed_addr constant [7 x i8] c"negara\00", align 1
@.str.35 = private unnamed_addr constant [10 x i8] c"Indonesia\00", align 1
@.str.36 = private unnamed_addr constant [6 x i8] c"dunia\00", align 1
@.str.37 = private unnamed_addr constant [7 x i8] c"dibuat\00", align 1
@.str.38 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.39 = private unnamed_addr constant [17 x i8] c"5. KOLEKSI KAMUS\00", align 1
@.str.40 = private unnamed_addr constant [5 x i8] c"Rust\00", align 1
@.str.41 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@.str.42 = private unnamed_addr constant [7 x i8] c"Python\00", align 1
@.str.43 = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.44 = private unnamed_addr constant [10 x i8] c"Skor Rust\00", align 1
@.str.45 = private unnamed_addr constant [5 x i8] c"Rust\00", align 1
@.str.46 = private unnamed_addr constant [7 x i8] c"Skor C\00", align 1
@.str.47 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@.str.48 = private unnamed_addr constant [12 x i8] c"Skor Python\00", align 1
@.str.49 = private unnamed_addr constant [7 x i8] c"Python\00", align 1
@.str.50 = private unnamed_addr constant [14 x i8] c"Skor TelaCore\00", align 1
@.str.51 = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.52 = private unnamed_addr constant [12 x i8] c"Total entri\00", align 1
@.str.53 = private unnamed_addr constant [21 x i8] c"6. UNIT TEST (Uji::)\00", align 1
@.str.54 = private unnamed_addr constant [10 x i8] c"1 + 1 = 2\00", align 1
@.str.55 = private unnamed_addr constant [20 x i8] c"maksimum(7,13) = 13\00", align 1
@.str.56 = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.57 = private unnamed_addr constant [21 x i8] c"panjang TelaCore = 8\00", align 1
@.str.58 = private unnamed_addr constant [10 x i8] c"nusantara\00", align 1
@.str.59 = private unnamed_addr constant [10 x i8] c"NUSANTARA\00", align 1
@.str.60 = private unnamed_addr constant [11 x i8] c"ubah_besar\00", align 1
@.str.61 = private unnamed_addr constant [17 x i8] c"Bahasa Indonesia\00", align 1
@.str.62 = private unnamed_addr constant [10 x i8] c"Indonesia\00", align 1
@.str.63 = private unnamed_addr constant [17 x i8] c"berisi Indonesia\00", align 1
@.str.64 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@.str.65 = private unnamed_addr constant [41 x i8] c"   DEMO NUSANTARA - TelaCore World-Class\00", align 1
@.str.66 = private unnamed_addr constant [40 x i8] c"   Bahasa LLVM Native Indonesia Pertama\00", align 1
@.str.67 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@.str.68 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.69 = private unnamed_addr constant [37 x i8] c"  TelaCore v0.2.0 - Semua sistem OK!\00", align 1
@.str.70 = private unnamed_addr constant [42 x i8] c"  Kompilasi LLVM native Bahasa Indonesia.\00", align 1
@.str.71 = private unnamed_addr constant [2 x i8] c"=\00", align 1
define ptr @garis(ptr %arg_simbol, i64 %arg_panjang_g) {
entry:
  %simbol = alloca ptr
  store ptr %arg_simbol, ptr %simbol
  %panjang_g = alloca i64
  store i64 %arg_panjang_g, ptr %panjang_g
  %1 = load ptr, ptr %simbol
  %2 = load i64, ptr %panjang_g
  %3 = call i64 @strlen(ptr %1)
  %4 = mul i64 %3, %2
  %5 = add i64 %4, 1
  %6 = call ptr @malloc(i64 %5)
  store i8 0, ptr %6
  %7 = alloca i64
  store i64 0, ptr %7
  br label %lbl_1

lbl_1:
  %8 = load i64, ptr %7
  %9 = icmp slt i64 %8, %2
  br i1 %9, label %lbl_2, label %lbl_3

lbl_2:
  %10 = call ptr @strcat(ptr %6, ptr %1)
  %11 = add i64 %8, 1
  store i64 %11, ptr %7
  br label %lbl_1

lbl_3:
  ret ptr %6
}

define void @banner(ptr %arg_judul) {
entry:
  %judul = alloca ptr
  store ptr %arg_judul, ptr %judul
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %2 = call ptr @garis(ptr @.str.0, i64 50)
  %3 = call i64 @strlen(ptr %2)
  %4 = add i64 %3, 32
  %5 = call ptr @malloc(i64 %4)
  %6 = call i32 (ptr, ptr, ...) @sprintf(ptr %5, ptr @.ansi.sian, ptr %2)
  %7 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %5)
  %8 = load ptr, ptr %judul
  %10 = call i64 @strlen(ptr @.str.1)
  %11 = call i64 @strlen(ptr %8)
  %12 = add i64 %10, %11
  %13 = add i64 %12, 1
  %14 = call ptr @malloc(i64 %13)
  %15 = call ptr @strcpy(ptr %14, ptr @.str.1)
  %16 = call ptr @strcat(ptr %14, ptr %8)
  %17 = call i64 @strlen(ptr %14)
  %18 = add i64 %17, 32
  %19 = call ptr @malloc(i64 %18)
  %20 = call i32 (ptr, ptr, ...) @sprintf(ptr %19, ptr @.ansi.kuning, ptr %14)
  %21 = call i64 @strlen(ptr %19)
  %22 = add i64 %21, 32
  %23 = call ptr @malloc(i64 %22)
  %24 = call i32 (ptr, ptr, ...) @sprintf(ptr %23, ptr @.ansi.tebal, ptr %19)
  %25 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %23)
  %26 = call ptr @garis(ptr @.str.2, i64 50)
  %27 = call i64 @strlen(ptr %26)
  %28 = add i64 %27, 32
  %29 = call ptr @malloc(i64 %28)
  %30 = call i32 (ptr, ptr, ...) @sprintf(ptr %29, ptr @.ansi.sian, ptr %26)
  %31 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %29)
  ret void
}

define void @info(ptr %arg_label, ptr %arg_nilai) {
entry:
  %label = alloca ptr
  store ptr %arg_label, ptr %label
  %nilai = alloca ptr
  store ptr %arg_nilai, ptr %nilai
  %1 = load ptr, ptr %label
  %2 = call i64 @strlen(ptr %1)
  %3 = icmp sge i64 %2, 22
  %4 = alloca ptr
  br i1 %3, label %lbl_1, label %lbl_2

lbl_1:
  %5 = add i64 %2, 1
  %6 = call ptr @malloc(i64 %5)
  %7 = call ptr @strcpy(ptr %6, ptr %1)
  store ptr %6, ptr %4
  br label %lbl_3

lbl_2:
  %8 = load i8, ptr @.str.4
  %9 = add i64 22, 1
  %10 = call ptr @malloc(i64 %9)
  %11 = call ptr @strcpy(ptr %10, ptr %1)
  %12 = alloca i64
  store i64 %2, ptr %12
  br label %lbl_4

lbl_4:
  %13 = load i64, ptr %12
  %14 = icmp slt i64 %13, 22
  br i1 %14, label %lbl_5, label %lbl_6

lbl_5:
  %15 = getelementptr i8, ptr %10, i64 %13
  store i8 %8, ptr %15
  %16 = add i64 %13, 1
  store i64 %16, ptr %12
  br label %lbl_4

lbl_6:
  %17 = getelementptr i8, ptr %10, i64 22
  store i8 0, ptr %17
  store ptr %10, ptr %4
  br label %lbl_3

lbl_3:
  %18 = load ptr, ptr %4
  %20 = call i64 @strlen(ptr @.str.3)
  %21 = call i64 @strlen(ptr %18)
  %22 = add i64 %20, %21
  %23 = add i64 %22, 1
  %24 = call ptr @malloc(i64 %23)
  %25 = call ptr @strcpy(ptr %24, ptr @.str.3)
  %26 = call ptr @strcat(ptr %24, ptr %18)
  %28 = call i64 @strlen(ptr %24)
  %29 = call i64 @strlen(ptr @.str.5)
  %30 = add i64 %28, %29
  %31 = add i64 %30, 1
  %32 = call ptr @malloc(i64 %31)
  %33 = call ptr @strcpy(ptr %32, ptr %24)
  %34 = call ptr @strcat(ptr %32, ptr @.str.5)
  %35 = load ptr, ptr %nilai
  %36 = call i64 @strlen(ptr %35)
  %37 = add i64 %36, 32
  %38 = call ptr @malloc(i64 %37)
  %39 = call i32 (ptr, ptr, ...) @sprintf(ptr %38, ptr @.ansi.hijau, ptr %35)
  %41 = call i64 @strlen(ptr %32)
  %42 = call i64 @strlen(ptr %38)
  %43 = add i64 %41, %42
  %44 = add i64 %43, 1
  %45 = call ptr @malloc(i64 %44)
  %46 = call ptr @strcpy(ptr %45, ptr %32)
  %47 = call ptr @strcat(ptr %45, ptr %38)
  %48 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %45)
  ret void
}

define void @bagian_sistem() {
entry:
  call void @banner(ptr @.str.6)
  call void @info(ptr @.str.7, ptr @.str.os_name)
  call void @info(ptr @.str.8, ptr @.str.arch_name)
  %1 = alloca i64
  %2 = call i64 @time(ptr null)
  store i64 %2, ptr %1
  %3 = call ptr @localtime(ptr %1)
  %4 = call ptr @malloc(i64 20)
  %5 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %6 = call i64 @strftime(ptr %4, i64 20, ptr %5, ptr %3)
  call void @info(ptr @.str.9, ptr %4)
  %7 = call i64 @time(ptr null)
  %8 = call ptr @malloc(i64 32)
  %9 = call i32 (ptr, ptr, ...) @sprintf(ptr %8, ptr @.fmt.input_bilangan, i64 %7)
  call void @info(ptr @.str.10, ptr %8)
  ret void
}

define void @bagian_matematika() {
entry:
  call void @banner(ptr @.str.11)
  %1 = call ptr @malloc(i64 32)
  %2 = call i32 (ptr, ptr, ...) @sprintf(ptr %1, ptr @.fmt.desimal, double 3.141592653589793)
  call void @info(ptr @.str.12, ptr %1)
  %3 = call double @sqrt(double 2.0)
  %4 = call ptr @malloc(i64 32)
  %5 = call i32 (ptr, ptr, ...) @sprintf(ptr %4, ptr @.fmt.desimal, double %3)
  call void @info(ptr @.str.13, ptr %4)
  %6 = call double @pow(double 2.0, double 32.0)
  %7 = call ptr @malloc(i64 32)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.fmt.desimal, double %6)
  call void @info(ptr @.str.14, ptr %7)
  %9 = fdiv double 3.141592653589793, 2.0
  %10 = call double @sin(double %9)
  %11 = call ptr @malloc(i64 32)
  %12 = call i32 (ptr, ptr, ...) @sprintf(ptr %11, ptr @.fmt.desimal, double %10)
  call void @info(ptr @.str.15, ptr %11)
  %13 = call double @hypot(double 5.0, double 12.0)
  %14 = call ptr @malloc(i64 32)
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr @.fmt.desimal, double %13)
  call void @info(ptr @.str.16, ptr %14)
  %16 = sub i64 100, 1
  %17 = add i64 %16, 1
  %18 = call i64 @time(ptr null)
  %19 = srem i64 %18, %17
  %20 = add i64 %19, 1
  %21 = call ptr @malloc(i64 32)
  %22 = call i32 (ptr, ptr, ...) @sprintf(ptr %21, ptr @.fmt.input_bilangan, i64 %20)
  call void @info(ptr @.str.17, ptr %21)
  ret void
}

define void @bagian_kripto() {
entry:
  call void @banner(ptr @.str.18)
  %pesan_1 = alloca ptr
  store ptr @.str.19, ptr %pesan_1
  %2 = load ptr, ptr %pesan_1
  call void @info(ptr @.str.20, ptr %2)
  %3 = load ptr, ptr %pesan_1
  %4 = alloca ptr
  %5 = alloca ptr
  %6 = alloca i32
  %7 = alloca [64 x i8]
  %8 = call i32 @CryptAcquireContextA(ptr %4, ptr null, ptr null, i32 24, i32 -268435456)
  %9 = load ptr, ptr %4
  %10 = call i32 @CryptCreateHash(ptr %9, i32 32780, ptr null, i32 0, ptr %5)
  %11 = load ptr, ptr %5
  %12 = call i64 @strlen(ptr %3)
  %13 = trunc i64 %12 to i32
  %14 = call i32 @CryptHashData(ptr %11, ptr %3, i32 %13, i32 0)
  store i32 32, ptr %6
  %15 = call i32 @CryptGetHashParam(ptr %11, i32 2, ptr %7, ptr %6, i32 0)
  %16 = call i32 @CryptDestroyHash(ptr %11)
  %17 = call i32 @CryptReleaseContext(ptr %9, i32 0)
  %18 = call ptr @malloc(i64 65)
  %19 = alloca i64
  store i64 0, ptr %19
  br label %lbl_1

lbl_1:
  %20 = load i64, ptr %19
  %21 = icmp slt i64 %20, 32
  br i1 %21, label %lbl_2, label %lbl_3

lbl_2:
  %22 = getelementptr [64 x i8], ptr %7, i64 0, i64 %20
  %23 = load i8, ptr %22
  %24 = zext i8 %23 to i32
  %25 = mul i64 %20, 2
  %26 = getelementptr i8, ptr %18, i64 %25
  %27 = call i32 (ptr, ptr, ...) @sprintf(ptr %26, ptr @.hex.byte_fmt, i32 %24)
  %28 = add i64 %20, 1
  store i64 %28, ptr %19
  br label %lbl_1

lbl_3:
  %29 = getelementptr i8, ptr %18, i64 64
  store i8 0, ptr %29
  %30 = add i64 32, 1
  %31 = call ptr @malloc(i64 %30)
  %32 = getelementptr i8, ptr %18, i64 0
  %33 = call ptr @strncpy(ptr %31, ptr %32, i64 32)
  %34 = getelementptr i8, ptr %31, i64 32
  store i8 0, ptr %34
  %36 = call i64 @strlen(ptr %31)
  %37 = call i64 @strlen(ptr @.str.22)
  %38 = add i64 %36, %37
  %39 = add i64 %38, 1
  %40 = call ptr @malloc(i64 %39)
  %41 = call ptr @strcpy(ptr %40, ptr %31)
  %42 = call ptr @strcat(ptr %40, ptr @.str.22)
  call void @info(ptr @.str.21, ptr %40)
  %43 = load ptr, ptr %pesan_1
  %44 = alloca ptr
  %45 = alloca ptr
  %46 = alloca i32
  %47 = alloca [64 x i8]
  %48 = call i32 @CryptAcquireContextA(ptr %44, ptr null, ptr null, i32 24, i32 -268435456)
  %49 = load ptr, ptr %44
  %50 = call i32 @CryptCreateHash(ptr %49, i32 32771, ptr null, i32 0, ptr %45)
  %51 = load ptr, ptr %45
  %52 = call i64 @strlen(ptr %43)
  %53 = trunc i64 %52 to i32
  %54 = call i32 @CryptHashData(ptr %51, ptr %43, i32 %53, i32 0)
  store i32 16, ptr %46
  %55 = call i32 @CryptGetHashParam(ptr %51, i32 2, ptr %47, ptr %46, i32 0)
  %56 = call i32 @CryptDestroyHash(ptr %51)
  %57 = call i32 @CryptReleaseContext(ptr %49, i32 0)
  %58 = call ptr @malloc(i64 33)
  %59 = alloca i64
  store i64 0, ptr %59
  br label %lbl_4

lbl_4:
  %60 = load i64, ptr %59
  %61 = icmp slt i64 %60, 16
  br i1 %61, label %lbl_5, label %lbl_6

lbl_5:
  %62 = getelementptr [64 x i8], ptr %47, i64 0, i64 %60
  %63 = load i8, ptr %62
  %64 = zext i8 %63 to i32
  %65 = mul i64 %60, 2
  %66 = getelementptr i8, ptr %58, i64 %65
  %67 = call i32 (ptr, ptr, ...) @sprintf(ptr %66, ptr @.hex.byte_fmt, i32 %64)
  %68 = add i64 %60, 1
  store i64 %68, ptr %59
  br label %lbl_4

lbl_6:
  %69 = getelementptr i8, ptr %58, i64 32
  store i8 0, ptr %69
  call void @info(ptr @.str.23, ptr %58)
  %70 = load ptr, ptr %pesan_1
  %71 = call i64 @strlen(ptr %70)
  %72 = add i64 %71, 2
  %73 = udiv i64 %72, 3
  %74 = mul i64 %73, 4
  %75 = add i64 %74, 1
  %76 = call ptr @malloc(i64 %75)
  %77 = alloca i64
  store i64 0, ptr %77
  %78 = alloca i64
  store i64 0, ptr %78
  br label %lbl_7

lbl_7:
  %79 = load i64, ptr %77
  %80 = icmp slt i64 %79, %71
  br i1 %80, label %lbl_8, label %lbl_9

lbl_8:
  %81 = getelementptr i8, ptr %70, i64 %79
  %82 = load i8, ptr %81
  %83 = zext i8 %82 to i32
  %84 = add i64 %79, 1
  %85 = icmp slt i64 %84, %71
  %86 = getelementptr i8, ptr %70, i64 %84
  %87 = select i1 %85, ptr %86, ptr @.fmt.newline
  %88 = load i8, ptr %87
  %89 = zext i8 %88 to i32
  %90 = select i1 %85, i32 %89, i32 0
  %91 = add i64 %79, 2
  %92 = icmp slt i64 %91, %71
  %93 = getelementptr i8, ptr %70, i64 %91
  %94 = select i1 %92, ptr %93, ptr @.fmt.newline
  %95 = load i8, ptr %94
  %96 = zext i8 %95 to i32
  %97 = select i1 %92, i32 %96, i32 0
  %98 = shl i32 %83, 16
  %99 = shl i32 %90, 8
  %100 = or i32 %98, %99
  %101 = or i32 %100, %97
  %102 = lshr i32 %101, 18
  %103 = and i32 %102, 63
  %104 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %103
  %105 = load i8, ptr %104
  %106 = lshr i32 %101, 12
  %107 = and i32 %106, 63
  %108 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %107
  %109 = load i8, ptr %108
  %110 = lshr i32 %101, 6
  %111 = and i32 %110, 63
  %112 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %111
  %113 = load i8, ptr %112
  %114 = select i1 %85, i8 %113, i8 61
  %115 = and i32 %101, 63
  %116 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %115
  %117 = load i8, ptr %116
  %118 = select i1 %92, i8 %117, i8 61
  %119 = load i64, ptr %78
  %120 = getelementptr i8, ptr %76, i64 %119
  store i8 %105, ptr %120
  %121 = getelementptr i8, ptr %120, i64 1
  store i8 %109, ptr %121
  %122 = getelementptr i8, ptr %120, i64 2
  store i8 %114, ptr %122
  %123 = getelementptr i8, ptr %120, i64 3
  store i8 %118, ptr %123
  %124 = add i64 %79, 3
  store i64 %124, ptr %77
  %125 = add i64 %119, 4
  store i64 %125, ptr %78
  br label %lbl_7

lbl_9:
  %126 = load i64, ptr %78
  %127 = getelementptr i8, ptr %76, i64 %126
  store i8 0, ptr %127
  call void @info(ptr @.str.24, ptr %76)
  %128 = load ptr, ptr %pesan_1
  %129 = call i64 @strlen(ptr %128)
  %130 = add i64 %129, 1
  %131 = call ptr @malloc(i64 %130)
  %132 = alloca i64
  store i64 0, ptr %132
  br label %lbl_10

lbl_10:
  %133 = load i64, ptr %132
  %134 = icmp slt i64 %133, %129
  br i1 %134, label %lbl_11, label %lbl_12

lbl_11:
  %135 = getelementptr i8, ptr %128, i64 %133
  %136 = load i8, ptr %135
  %137 = icmp sge i8 %136, 97
  %138 = icmp sle i8 %136, 122
  %139 = and i1 %137, %138
  %140 = icmp sge i8 %136, 65
  %141 = icmp sle i8 %136, 90
  %142 = and i1 %140, %141
  %143 = sub i8 %136, 97
  %144 = add i8 %143, 13
  %145 = srem i8 %144, 26
  %146 = add i8 %145, 97
  %147 = sub i8 %136, 65
  %148 = add i8 %147, 13
  %149 = srem i8 %148, 26
  %150 = add i8 %149, 65
  %151 = select i1 %139, i8 %146, i8 %136
  %152 = select i1 %142, i8 %150, i8 %151
  %153 = getelementptr i8, ptr %131, i64 %133
  store i8 %152, ptr %153
  %154 = add i64 %133, 1
  store i64 %154, ptr %132
  br label %lbl_10

lbl_12:
  %155 = getelementptr i8, ptr %131, i64 %129
  store i8 0, ptr %155
  call void @info(ptr @.str.25, ptr %131)
  %156 = mul i64 16, 2
  %157 = add i64 %156, 1
  %158 = call ptr @malloc(i64 %157)
  %159 = call ptr @malloc(i64 16)
  %160 = alloca ptr
  %161 = call i32 @CryptAcquireContextA(ptr %160, ptr null, ptr null, i32 1, i32 -268435456)
  %162 = load ptr, ptr %160
  %163 = trunc i64 16 to i32
  %164 = call i32 @CryptGenRandom(ptr %162, i32 %163, ptr %159)
  %165 = call i32 @CryptReleaseContext(ptr %162, i32 0)
  %166 = alloca i64
  store i64 0, ptr %166
  br label %lbl_13

lbl_13:
  %167 = load i64, ptr %166
  %168 = icmp slt i64 %167, 16
  br i1 %168, label %lbl_14, label %lbl_15

lbl_14:
  %169 = getelementptr i8, ptr %159, i64 %167
  %170 = load i8, ptr %169
  %171 = zext i8 %170 to i32
  %172 = mul i64 %167, 2
  %173 = getelementptr i8, ptr %158, i64 %172
  %174 = call i32 (ptr, ptr, ...) @sprintf(ptr %173, ptr @.hex.byte_fmt, i32 %171)
  %175 = add i64 %167, 1
  store i64 %175, ptr %166
  br label %lbl_13

lbl_15:
  %176 = getelementptr i8, ptr %158, i64 %156
  store i8 0, ptr %176
  call void @free(ptr %159)
  call void @info(ptr @.str.26, ptr %158)
  %178 = load ptr, ptr %pesan_1
  %179 = call i64 @strlen(ptr %178)
  %180 = alloca i64
  store i64 4294967295, ptr %180
  %181 = alloca i64
  store i64 0, ptr %181
  br label %lbl_16

lbl_16:
  %182 = load i64, ptr %181
  %183 = icmp slt i64 %182, %179
  br i1 %183, label %lbl_17, label %lbl_18

lbl_17:
  %184 = getelementptr i8, ptr %178, i64 %182
  %185 = load i8, ptr %184
  %186 = zext i8 %185 to i64
  %187 = load i64, ptr %180
  %188 = xor i64 %187, %186
  %189 = and i64 %188, 1
  %190 = icmp ne i64 %189, 0
  %191 = lshr i64 %188, 1
  %192 = xor i64 %191, 3988292384
  %193 = select i1 %190, i64 %192, i64 %191
  %194 = and i64 %193, 1
  %195 = icmp ne i64 %194, 0
  %196 = lshr i64 %193, 1
  %197 = xor i64 %196, 3988292384
  %198 = select i1 %195, i64 %197, i64 %196
  %199 = and i64 %198, 1
  %200 = icmp ne i64 %199, 0
  %201 = lshr i64 %198, 1
  %202 = xor i64 %201, 3988292384
  %203 = select i1 %200, i64 %202, i64 %201
  %204 = and i64 %203, 1
  %205 = icmp ne i64 %204, 0
  %206 = lshr i64 %203, 1
  %207 = xor i64 %206, 3988292384
  %208 = select i1 %205, i64 %207, i64 %206
  %209 = and i64 %208, 1
  %210 = icmp ne i64 %209, 0
  %211 = lshr i64 %208, 1
  %212 = xor i64 %211, 3988292384
  %213 = select i1 %210, i64 %212, i64 %211
  %214 = and i64 %213, 1
  %215 = icmp ne i64 %214, 0
  %216 = lshr i64 %213, 1
  %217 = xor i64 %216, 3988292384
  %218 = select i1 %215, i64 %217, i64 %216
  %219 = and i64 %218, 1
  %220 = icmp ne i64 %219, 0
  %221 = lshr i64 %218, 1
  %222 = xor i64 %221, 3988292384
  %223 = select i1 %220, i64 %222, i64 %221
  %224 = and i64 %223, 1
  %225 = icmp ne i64 %224, 0
  %226 = lshr i64 %223, 1
  %227 = xor i64 %226, 3988292384
  %228 = select i1 %225, i64 %227, i64 %226
  store i64 %228, ptr %180
  %229 = add i64 %182, 1
  store i64 %229, ptr %181
  br label %lbl_16

lbl_18:
  %230 = load i64, ptr %180
  %231 = xor i64 %230, 4294967295
  %232 = call ptr @malloc(i64 32)
  %233 = call i32 (ptr, ptr, ...) @sprintf(ptr %232, ptr @.fmt.input_bilangan, i64 %231)
  call void @info(ptr @.str.27, ptr %232)
  ret void
}

define void @bagian_json() {
entry:
  call void @banner(ptr @.str.28)
  %1 = call ptr @malloc(i64 24)
  %2 = call ptr @malloc(i64 4096)
  store i8 0, ptr %2
  %3 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 0
  store ptr %2, ptr %3
  %4 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 1
  store i64 0, ptr %4
  %5 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 2
  store i64 4096, ptr %5
  %o_6 = alloca ptr
  store ptr %1, ptr %o_6
  %7 = load ptr, ptr %o_6
  %8 = getelementptr { ptr, i64, i64 }, ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %8
  %10 = getelementptr { ptr, i64, i64 }, ptr %7, i32 0, i32 1
  %11 = load i64, ptr %10
  %12 = icmp eq i64 %11, 0
  %13 = select i1 %12, ptr @.json.str.init, ptr @.json.str.next
  %14 = getelementptr i8, ptr %9, i64 %11
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr %13, ptr @.str.29, ptr @.str.30)
  %16 = call i64 @strlen(ptr %9)
  store i64 %16, ptr %10
  %17 = load ptr, ptr %o_6
  %18 = getelementptr { ptr, i64, i64 }, ptr %17, i32 0, i32 0
  %19 = load ptr, ptr %18
  %20 = getelementptr { ptr, i64, i64 }, ptr %17, i32 0, i32 1
  %21 = load i64, ptr %20
  %22 = icmp eq i64 %21, 0
  %23 = select i1 %22, ptr @.json.str.init, ptr @.json.str.next
  %24 = getelementptr i8, ptr %19, i64 %21
  %25 = call i32 (ptr, ptr, ...) @sprintf(ptr %24, ptr %23, ptr @.str.31, ptr @.str.32)
  %26 = call i64 @strlen(ptr %19)
  store i64 %26, ptr %20
  %27 = load ptr, ptr %o_6
  %28 = getelementptr { ptr, i64, i64 }, ptr %27, i32 0, i32 0
  %29 = load ptr, ptr %28
  %30 = getelementptr { ptr, i64, i64 }, ptr %27, i32 0, i32 1
  %31 = load i64, ptr %30
  %32 = icmp eq i64 %31, 0
  %33 = select i1 %32, ptr @.json.int.init, ptr @.json.int.next
  %34 = getelementptr i8, ptr %29, i64 %31
  %35 = call i32 (ptr, ptr, ...) @sprintf(ptr %34, ptr %33, ptr @.str.33, i64 2026)
  %36 = call i64 @strlen(ptr %29)
  store i64 %36, ptr %30
  %37 = load ptr, ptr %o_6
  %38 = getelementptr { ptr, i64, i64 }, ptr %37, i32 0, i32 0
  %39 = load ptr, ptr %38
  %40 = getelementptr { ptr, i64, i64 }, ptr %37, i32 0, i32 1
  %41 = load i64, ptr %40
  %42 = icmp eq i64 %41, 0
  %43 = select i1 %42, ptr @.json.str.init, ptr @.json.str.next
  %44 = getelementptr i8, ptr %39, i64 %41
  %45 = call i32 (ptr, ptr, ...) @sprintf(ptr %44, ptr %43, ptr @.str.34, ptr @.str.35)
  %46 = call i64 @strlen(ptr %39)
  store i64 %46, ptr %40
  %47 = load ptr, ptr %o_6
  %48 = getelementptr { ptr, i64, i64 }, ptr %47, i32 0, i32 0
  %49 = load ptr, ptr %48
  %50 = getelementptr { ptr, i64, i64 }, ptr %47, i32 0, i32 1
  %51 = load i64, ptr %50
  %52 = icmp eq i64 %51, 0
  %53 = select i1 1, ptr @.json.true.init, ptr @.json.false.init
  %54 = select i1 1, ptr @.json.true.next, ptr @.json.false.next
  %55 = select i1 %52, ptr %53, ptr %54
  %56 = getelementptr i8, ptr %49, i64 %51
  %57 = call i32 (ptr, ptr, ...) @sprintf(ptr %56, ptr %55, ptr @.str.36)
  %58 = call i64 @strlen(ptr %49)
  store i64 %58, ptr %50
  %59 = load ptr, ptr %o_6
  %60 = alloca i64
  %61 = call i64 @time(ptr null)
  store i64 %61, ptr %60
  %62 = call ptr @localtime(ptr %60)
  %63 = call ptr @malloc(i64 20)
  %64 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %65 = call i64 @strftime(ptr %63, i64 20, ptr %64, ptr %62)
  %66 = getelementptr { ptr, i64, i64 }, ptr %59, i32 0, i32 0
  %67 = load ptr, ptr %66
  %68 = getelementptr { ptr, i64, i64 }, ptr %59, i32 0, i32 1
  %69 = load i64, ptr %68
  %70 = icmp eq i64 %69, 0
  %71 = select i1 %70, ptr @.json.str.init, ptr @.json.str.next
  %72 = getelementptr i8, ptr %67, i64 %69
  %73 = call i32 (ptr, ptr, ...) @sprintf(ptr %72, ptr %71, ptr @.str.37, ptr %63)
  %74 = call i64 @strlen(ptr %67)
  store i64 %74, ptr %68
  %75 = load ptr, ptr %o_6
  %76 = getelementptr { ptr, i64, i64 }, ptr %75, i32 0, i32 0
  %77 = load ptr, ptr %76
  %78 = getelementptr { ptr, i64, i64 }, ptr %75, i32 0, i32 1
  %79 = load i64, ptr %78
  %80 = icmp eq i64 %79, 0
  %81 = alloca ptr
  br i1 %80, label %lbl_1, label %lbl_2

lbl_1:
  store ptr @.json.empty, ptr %81
  br label %lbl_3

lbl_2:
  %82 = add i64 %79, 8
  %83 = call ptr @malloc(i64 %82)
  %84 = call ptr @strcpy(ptr %83, ptr %77)
  %85 = getelementptr i8, ptr %83, i64 %79
  store i8 125, ptr %85
  %86 = getelementptr i8, ptr %85, i64 1
  store i8 0, ptr %86
  store ptr %83, ptr %81
  br label %lbl_3

lbl_3:
  %87 = load ptr, ptr %81
  %89 = call i64 @strlen(ptr @.str.38)
  %90 = call i64 @strlen(ptr %87)
  %91 = add i64 %89, %90
  %92 = add i64 %91, 1
  %93 = call ptr @malloc(i64 %92)
  %94 = call ptr @strcpy(ptr %93, ptr @.str.38)
  %95 = call ptr @strcat(ptr %93, ptr %87)
  %96 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %93)
  ret void
}

define void @bagian_koleksi() {
entry:
  call void @banner(ptr @.str.39)
  %1 = call ptr @malloc(i64 24)
  %2 = call ptr @malloc(i64 64)
  %3 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 0
  store ptr %2, ptr %3
  %4 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 1
  store i64 0, ptr %4
  %5 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 2
  store i64 8, ptr %5
  %km_6 = alloca ptr
  store ptr %1, ptr %km_6
  %7 = load ptr, ptr %km_6
  %8 = getelementptr { ptr, i64, i64 }, ptr %7, i32 0, i32 1
  %9 = load i64, ptr %8
  %10 = getelementptr { ptr, i64, i64 }, ptr %7, i32 0, i32 0
  %11 = load ptr, ptr %10
  %12 = mul i64 %9, 2
  %13 = getelementptr ptr, ptr %11, i64 %12
  store ptr @.str.40, ptr %13
  %14 = add i64 %12, 1
  %15 = getelementptr ptr, ptr %11, i64 %14
  %16 = call ptr @malloc(i64 8)
  store i64 100, ptr %16
  store ptr %16, ptr %15
  %17 = add i64 %9, 1
  store i64 %17, ptr %8
  %18 = load ptr, ptr %km_6
  %19 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 1
  %20 = load i64, ptr %19
  %21 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 0
  %22 = load ptr, ptr %21
  %23 = mul i64 %20, 2
  %24 = getelementptr ptr, ptr %22, i64 %23
  store ptr @.str.41, ptr %24
  %25 = add i64 %23, 1
  %26 = getelementptr ptr, ptr %22, i64 %25
  %27 = call ptr @malloc(i64 8)
  store i64 98, ptr %27
  store ptr %27, ptr %26
  %28 = add i64 %20, 1
  store i64 %28, ptr %19
  %29 = load ptr, ptr %km_6
  %30 = getelementptr { ptr, i64, i64 }, ptr %29, i32 0, i32 1
  %31 = load i64, ptr %30
  %32 = getelementptr { ptr, i64, i64 }, ptr %29, i32 0, i32 0
  %33 = load ptr, ptr %32
  %34 = mul i64 %31, 2
  %35 = getelementptr ptr, ptr %33, i64 %34
  store ptr @.str.42, ptr %35
  %36 = add i64 %34, 1
  %37 = getelementptr ptr, ptr %33, i64 %36
  %38 = call ptr @malloc(i64 8)
  store i64 70, ptr %38
  store ptr %38, ptr %37
  %39 = add i64 %31, 1
  store i64 %39, ptr %30
  %40 = load ptr, ptr %km_6
  %41 = getelementptr { ptr, i64, i64 }, ptr %40, i32 0, i32 1
  %42 = load i64, ptr %41
  %43 = getelementptr { ptr, i64, i64 }, ptr %40, i32 0, i32 0
  %44 = load ptr, ptr %43
  %45 = mul i64 %42, 2
  %46 = getelementptr ptr, ptr %44, i64 %45
  store ptr @.str.43, ptr %46
  %47 = add i64 %45, 1
  %48 = getelementptr ptr, ptr %44, i64 %47
  %49 = call ptr @malloc(i64 8)
  store i64 100, ptr %49
  store ptr %49, ptr %48
  %50 = add i64 %42, 1
  store i64 %50, ptr %41
  %51 = load ptr, ptr %km_6
  %52 = getelementptr { ptr, i64, i64 }, ptr %51, i32 0, i32 0
  %53 = load ptr, ptr %52
  %54 = getelementptr { ptr, i64, i64 }, ptr %51, i32 0, i32 1
  %55 = load i64, ptr %54
  %56 = alloca i64
  store i64 0, ptr %56
  %57 = alloca i64
  store i64 0, ptr %57
  br label %lbl_1

lbl_1:
  %58 = load i64, ptr %57
  %59 = icmp slt i64 %58, %55
  br i1 %59, label %lbl_2, label %lbl_5

lbl_2:
  %60 = mul i64 %58, 2
  %61 = getelementptr ptr, ptr %53, i64 %60
  %62 = load ptr, ptr %61
  %63 = call i32 @strcmp(ptr %62, ptr @.str.45)
  %64 = icmp eq i32 %63, 0
  br i1 %64, label %lbl_3, label %lbl_4

lbl_3:
  %65 = add i64 %60, 1
  %66 = getelementptr ptr, ptr %53, i64 %65
  %67 = load ptr, ptr %66
  %68 = load i64, ptr %67
  store i64 %68, ptr %56
  br label %lbl_5

lbl_4:
  %69 = add i64 %58, 1
  store i64 %69, ptr %57
  br label %lbl_1

lbl_5:
  %70 = load i64, ptr %56
  %71 = call ptr @malloc(i64 32)
  %72 = call i32 (ptr, ptr, ...) @sprintf(ptr %71, ptr @.fmt.input_bilangan, i64 %70)
  call void @info(ptr @.str.44, ptr %71)
  %73 = load ptr, ptr %km_6
  %74 = getelementptr { ptr, i64, i64 }, ptr %73, i32 0, i32 0
  %75 = load ptr, ptr %74
  %76 = getelementptr { ptr, i64, i64 }, ptr %73, i32 0, i32 1
  %77 = load i64, ptr %76
  %78 = alloca i64
  store i64 0, ptr %78
  %79 = alloca i64
  store i64 0, ptr %79
  br label %lbl_6

lbl_6:
  %80 = load i64, ptr %79
  %81 = icmp slt i64 %80, %77
  br i1 %81, label %lbl_7, label %lbl_10

lbl_7:
  %82 = mul i64 %80, 2
  %83 = getelementptr ptr, ptr %75, i64 %82
  %84 = load ptr, ptr %83
  %85 = call i32 @strcmp(ptr %84, ptr @.str.47)
  %86 = icmp eq i32 %85, 0
  br i1 %86, label %lbl_8, label %lbl_9

lbl_8:
  %87 = add i64 %82, 1
  %88 = getelementptr ptr, ptr %75, i64 %87
  %89 = load ptr, ptr %88
  %90 = load i64, ptr %89
  store i64 %90, ptr %78
  br label %lbl_10

lbl_9:
  %91 = add i64 %80, 1
  store i64 %91, ptr %79
  br label %lbl_6

lbl_10:
  %92 = load i64, ptr %78
  %93 = call ptr @malloc(i64 32)
  %94 = call i32 (ptr, ptr, ...) @sprintf(ptr %93, ptr @.fmt.input_bilangan, i64 %92)
  call void @info(ptr @.str.46, ptr %93)
  %95 = load ptr, ptr %km_6
  %96 = getelementptr { ptr, i64, i64 }, ptr %95, i32 0, i32 0
  %97 = load ptr, ptr %96
  %98 = getelementptr { ptr, i64, i64 }, ptr %95, i32 0, i32 1
  %99 = load i64, ptr %98
  %100 = alloca i64
  store i64 0, ptr %100
  %101 = alloca i64
  store i64 0, ptr %101
  br label %lbl_11

lbl_11:
  %102 = load i64, ptr %101
  %103 = icmp slt i64 %102, %99
  br i1 %103, label %lbl_12, label %lbl_15

lbl_12:
  %104 = mul i64 %102, 2
  %105 = getelementptr ptr, ptr %97, i64 %104
  %106 = load ptr, ptr %105
  %107 = call i32 @strcmp(ptr %106, ptr @.str.49)
  %108 = icmp eq i32 %107, 0
  br i1 %108, label %lbl_13, label %lbl_14

lbl_13:
  %109 = add i64 %104, 1
  %110 = getelementptr ptr, ptr %97, i64 %109
  %111 = load ptr, ptr %110
  %112 = load i64, ptr %111
  store i64 %112, ptr %100
  br label %lbl_15

lbl_14:
  %113 = add i64 %102, 1
  store i64 %113, ptr %101
  br label %lbl_11

lbl_15:
  %114 = load i64, ptr %100
  %115 = call ptr @malloc(i64 32)
  %116 = call i32 (ptr, ptr, ...) @sprintf(ptr %115, ptr @.fmt.input_bilangan, i64 %114)
  call void @info(ptr @.str.48, ptr %115)
  %117 = load ptr, ptr %km_6
  %118 = getelementptr { ptr, i64, i64 }, ptr %117, i32 0, i32 0
  %119 = load ptr, ptr %118
  %120 = getelementptr { ptr, i64, i64 }, ptr %117, i32 0, i32 1
  %121 = load i64, ptr %120
  %122 = alloca i64
  store i64 0, ptr %122
  %123 = alloca i64
  store i64 0, ptr %123
  br label %lbl_16

lbl_16:
  %124 = load i64, ptr %123
  %125 = icmp slt i64 %124, %121
  br i1 %125, label %lbl_17, label %lbl_20

lbl_17:
  %126 = mul i64 %124, 2
  %127 = getelementptr ptr, ptr %119, i64 %126
  %128 = load ptr, ptr %127
  %129 = call i32 @strcmp(ptr %128, ptr @.str.51)
  %130 = icmp eq i32 %129, 0
  br i1 %130, label %lbl_18, label %lbl_19

lbl_18:
  %131 = add i64 %126, 1
  %132 = getelementptr ptr, ptr %119, i64 %131
  %133 = load ptr, ptr %132
  %134 = load i64, ptr %133
  store i64 %134, ptr %122
  br label %lbl_20

lbl_19:
  %135 = add i64 %124, 1
  store i64 %135, ptr %123
  br label %lbl_16

lbl_20:
  %136 = load i64, ptr %122
  %137 = call ptr @malloc(i64 32)
  %138 = call i32 (ptr, ptr, ...) @sprintf(ptr %137, ptr @.fmt.input_bilangan, i64 %136)
  call void @info(ptr @.str.50, ptr %137)
  %139 = load ptr, ptr %km_6
  %140 = getelementptr { ptr, i64, i64 }, ptr %139, i32 0, i32 1
  %141 = load i64, ptr %140
  %142 = call ptr @malloc(i64 32)
  %143 = call i32 (ptr, ptr, ...) @sprintf(ptr %142, ptr @.fmt.input_bilangan, i64 %141)
  call void @info(ptr @.str.52, ptr %142)
  ret void
}

define void @bagian_uji() {
entry:
  call void @banner(ptr @.str.53)
  %1 = add i64 1, 1
  %2 = icmp eq i64 %1, 2
  br i1 %2, label %lbl_1, label %lbl_2

lbl_1:
  %3 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.54)
  br label %lbl_3

lbl_2:
  %4 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.54)
  br label %lbl_3

lbl_3:
  %5 = icmp sgt i64 7, 13
  %6 = select i1 %5, i64 7, i64 13
  %7 = icmp eq i64 %6, 13
  br i1 %7, label %lbl_4, label %lbl_5

lbl_4:
  %8 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.55)
  br label %lbl_6

lbl_5:
  %9 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.55)
  br label %lbl_6

lbl_6:
  %10 = call i64 @strlen(ptr @.str.56)
  %11 = icmp eq i64 %10, 8
  br i1 %11, label %lbl_7, label %lbl_8

lbl_7:
  %12 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.57)
  br label %lbl_9

lbl_8:
  %13 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.57)
  br label %lbl_9

lbl_9:
  %14 = call i64 @strlen(ptr @.str.58)
  %15 = add i64 %14, 1
  %16 = call ptr @malloc(i64 %15)
  %17 = alloca i64
  store i64 0, ptr %17
  br label %lbl_10

lbl_10:
  %18 = load i64, ptr %17
  %19 = icmp slt i64 %18, %14
  br i1 %19, label %lbl_11, label %lbl_12

lbl_11:
  %20 = getelementptr i8, ptr @.str.58, i64 %18
  %21 = load i8, ptr %20
  %22 = sext i8 %21 to i32
  %23 = call i32 @toupper(i32 %22)
  %24 = trunc i32 %23 to i8
  %25 = getelementptr i8, ptr %16, i64 %18
  store i8 %24, ptr %25
  %26 = add i64 %18, 1
  store i64 %26, ptr %17
  br label %lbl_10

lbl_12:
  %27 = getelementptr i8, ptr %16, i64 %14
  store i8 0, ptr %27
  %28 = call i32 @strcmp(ptr %16, ptr @.str.59)
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %lbl_13, label %lbl_14

lbl_13:
  %30 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.60)
  br label %lbl_15

lbl_14:
  %31 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.60)
  br label %lbl_15

lbl_15:
  %32 = call ptr @strstr(ptr @.str.61, ptr @.str.62)
  %33 = icmp ne ptr %32, null
  br i1 %33, label %lbl_16, label %lbl_17

lbl_16:
  %34 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.63)
  br label %lbl_18

lbl_17:
  %35 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.63)
  br label %lbl_18

lbl_18:
  ret void
}

define void @utama() {
entry:
  %1 = call i32 @system(ptr @.str.cls)
  %2 = call ptr @garis(ptr @.str.64, i64 50)
  %3 = call i64 @strlen(ptr %2)
  %4 = add i64 %3, 32
  %5 = call ptr @malloc(i64 %4)
  %6 = call i32 (ptr, ptr, ...) @sprintf(ptr %5, ptr @.ansi.sian, ptr %2)
  %7 = call i64 @strlen(ptr %5)
  %8 = add i64 %7, 32
  %9 = call ptr @malloc(i64 %8)
  %10 = call i32 (ptr, ptr, ...) @sprintf(ptr %9, ptr @.ansi.tebal, ptr %5)
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %9)
  %12 = call i64 @strlen(ptr @.str.65)
  %13 = add i64 %12, 32
  %14 = call ptr @malloc(i64 %13)
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr @.ansi.kuning, ptr @.str.65)
  %16 = call i64 @strlen(ptr %14)
  %17 = add i64 %16, 32
  %18 = call ptr @malloc(i64 %17)
  %19 = call i32 (ptr, ptr, ...) @sprintf(ptr %18, ptr @.ansi.tebal, ptr %14)
  %20 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %18)
  %21 = call i64 @strlen(ptr @.str.66)
  %22 = add i64 %21, 32
  %23 = call ptr @malloc(i64 %22)
  %24 = call i32 (ptr, ptr, ...) @sprintf(ptr %23, ptr @.ansi.kuning, ptr @.str.66)
  %25 = call i64 @strlen(ptr %23)
  %26 = add i64 %25, 32
  %27 = call ptr @malloc(i64 %26)
  %28 = call i32 (ptr, ptr, ...) @sprintf(ptr %27, ptr @.ansi.tebal, ptr %23)
  %29 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %27)
  %30 = call ptr @garis(ptr @.str.67, i64 50)
  %31 = call i64 @strlen(ptr %30)
  %32 = add i64 %31, 32
  %33 = call ptr @malloc(i64 %32)
  %34 = call i32 (ptr, ptr, ...) @sprintf(ptr %33, ptr @.ansi.sian, ptr %30)
  %35 = call i64 @strlen(ptr %33)
  %36 = add i64 %35, 32
  %37 = call ptr @malloc(i64 %36)
  %38 = call i32 (ptr, ptr, ...) @sprintf(ptr %37, ptr @.ansi.tebal, ptr %33)
  %39 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %37)
  call void @bagian_sistem()
  call void @bagian_matematika()
  call void @bagian_kripto()
  call void @bagian_json()
  call void @bagian_koleksi()
  call void @bagian_uji()
  %40 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %41 = call ptr @garis(ptr @.str.68, i64 50)
  %42 = call i64 @strlen(ptr %41)
  %43 = add i64 %42, 32
  %44 = call ptr @malloc(i64 %43)
  %45 = call i32 (ptr, ptr, ...) @sprintf(ptr %44, ptr @.ansi.sian, ptr %41)
  %46 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %44)
  %47 = call i64 @strlen(ptr @.str.69)
  %48 = add i64 %47, 32
  %49 = call ptr @malloc(i64 %48)
  %50 = call i32 (ptr, ptr, ...) @sprintf(ptr %49, ptr @.ansi.hijau, ptr @.str.69)
  %51 = call i64 @strlen(ptr %49)
  %52 = add i64 %51, 32
  %53 = call ptr @malloc(i64 %52)
  %54 = call i32 (ptr, ptr, ...) @sprintf(ptr %53, ptr @.ansi.tebal, ptr %49)
  %55 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %53)
  %56 = call i64 @strlen(ptr @.str.70)
  %57 = add i64 %56, 32
  %58 = call ptr @malloc(i64 %57)
  %59 = call i32 (ptr, ptr, ...) @sprintf(ptr %58, ptr @.ansi.hijau, ptr @.str.70)
  %60 = call i64 @strlen(ptr %58)
  %61 = add i64 %60, 32
  %62 = call ptr @malloc(i64 %61)
  %63 = call i32 (ptr, ptr, ...) @sprintf(ptr %62, ptr @.ansi.tebal, ptr %58)
  %64 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %62)
  %65 = call ptr @garis(ptr @.str.71, i64 50)
  %66 = call i64 @strlen(ptr %65)
  %67 = add i64 %66, 32
  %68 = call ptr @malloc(i64 %67)
  %69 = call i32 (ptr, ptr, ...) @sprintf(ptr %68, ptr @.ansi.sian, ptr %65)
  %70 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %68)
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

