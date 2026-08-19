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

@.str.0 = private unnamed_addr constant [2 x i8] c"|\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"|\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"BLOK #\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"  Data  : \00", align 1
@.str.4 = private unnamed_addr constant [11 x i8] c"  Prev  : \00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"...\00", align 1
@.str.6 = private unnamed_addr constant [11 x i8] c"  Hash  : \00", align 1
@.str.7 = private unnamed_addr constant [4 x i8] c"...\00", align 1
@.str.8 = private unnamed_addr constant [11 x i8] c"  Waktu : \00", align 1
@.str.9 = private unnamed_addr constant [35 x i8] c"----------------------------------\00", align 1
@.str.10 = private unnamed_addr constant [34 x i8] c"=== NUSANTARA BLOCKCHAIN v1.0 ===\00", align 1
@.str.11 = private unnamed_addr constant [40 x i8] c"Menggunakan SHA-256 via Win32 CryptoAPI\00", align 1
@.str.12 = private unnamed_addr constant [65 x i8] c"0000000000000000000000000000000000000000000000000000000000000000\00", align 1
@.str.13 = private unnamed_addr constant [33 x i8] c"Genesis: Nusantara Chain Dimulai\00", align 1
@.str.14 = private unnamed_addr constant [33 x i8] c"Genesis: Nusantara Chain Dimulai\00", align 1
@.str.15 = private unnamed_addr constant [30 x i8] c"Tx: Budi -> Siti Rp 1.500.000\00", align 1
@.str.16 = private unnamed_addr constant [30 x i8] c"Tx: Budi -> Siti Rp 1.500.000\00", align 1
@.str.17 = private unnamed_addr constant [29 x i8] c"Tx: SmartContract Umroh 2026\00", align 1
@.str.18 = private unnamed_addr constant [29 x i8] c"Tx: SmartContract Umroh 2026\00", align 1
@.str.19 = private unnamed_addr constant [35 x i8] c"Tx: Wakaf Digital Masjid Nusantara\00", align 1
@.str.20 = private unnamed_addr constant [35 x i8] c"Tx: Wakaf Digital Masjid Nusantara\00", align 1
@.str.21 = private unnamed_addr constant [39 x i8] c"Blockchain 4 blok berhasil divalidasi!\00", align 1
@.str.22 = private unnamed_addr constant [35 x i8] c"Setiap blok terhubung via SHA-256.\00", align 1
define ptr @hash_blok(i64 %arg_idx, ptr %arg_data, ptr %arg_prev) {
entry:
  %idx = alloca i64
  store i64 %arg_idx, ptr %idx
  %data = alloca ptr
  store ptr %arg_data, ptr %data
  %prev = alloca ptr
  store ptr %arg_prev, ptr %prev
  %1 = load i64, ptr %idx
  %2 = call ptr @malloc(i64 32)
  %3 = call i32 (ptr, ptr, ...) @sprintf(ptr %2, ptr @.fmt.input_bilangan, i64 %1)
  %5 = call i64 @strlen(ptr %2)
  %6 = call i64 @strlen(ptr @.str.0)
  %7 = add i64 %5, %6
  %8 = add i64 %7, 1
  %9 = call ptr @malloc(i64 %8)
  %10 = call ptr @strcpy(ptr %9, ptr %2)
  %11 = call ptr @strcat(ptr %9, ptr @.str.0)
  %12 = load ptr, ptr %data
  %14 = call i64 @strlen(ptr %9)
  %15 = call i64 @strlen(ptr %12)
  %16 = add i64 %14, %15
  %17 = add i64 %16, 1
  %18 = call ptr @malloc(i64 %17)
  %19 = call ptr @strcpy(ptr %18, ptr %9)
  %20 = call ptr @strcat(ptr %18, ptr %12)
  %22 = call i64 @strlen(ptr %18)
  %23 = call i64 @strlen(ptr @.str.1)
  %24 = add i64 %22, %23
  %25 = add i64 %24, 1
  %26 = call ptr @malloc(i64 %25)
  %27 = call ptr @strcpy(ptr %26, ptr %18)
  %28 = call ptr @strcat(ptr %26, ptr @.str.1)
  %29 = load ptr, ptr %prev
  %31 = call i64 @strlen(ptr %26)
  %32 = call i64 @strlen(ptr %29)
  %33 = add i64 %31, %32
  %34 = add i64 %33, 1
  %35 = call ptr @malloc(i64 %34)
  %36 = call ptr @strcpy(ptr %35, ptr %26)
  %37 = call ptr @strcat(ptr %35, ptr %29)
  %38 = alloca ptr
  %39 = alloca ptr
  %40 = alloca i32
  %41 = alloca [64 x i8]
  %42 = call i32 @CryptAcquireContextA(ptr %38, ptr null, ptr null, i32 24, i32 -268435456)
  %43 = load ptr, ptr %38
  %44 = call i32 @CryptCreateHash(ptr %43, i32 32780, ptr null, i32 0, ptr %39)
  %45 = load ptr, ptr %39
  %46 = call i64 @strlen(ptr %35)
  %47 = trunc i64 %46 to i32
  %48 = call i32 @CryptHashData(ptr %45, ptr %35, i32 %47, i32 0)
  store i32 32, ptr %40
  %49 = call i32 @CryptGetHashParam(ptr %45, i32 2, ptr %41, ptr %40, i32 0)
  %50 = call i32 @CryptDestroyHash(ptr %45)
  %51 = call i32 @CryptReleaseContext(ptr %43, i32 0)
  %52 = call ptr @malloc(i64 65)
  %53 = alloca i64
  store i64 0, ptr %53
  br label %lbl_1

lbl_1:
  %54 = load i64, ptr %53
  %55 = icmp slt i64 %54, 32
  br i1 %55, label %lbl_2, label %lbl_3

lbl_2:
  %56 = getelementptr [64 x i8], ptr %41, i64 0, i64 %54
  %57 = load i8, ptr %56
  %58 = zext i8 %57 to i32
  %59 = mul i64 %54, 2
  %60 = getelementptr i8, ptr %52, i64 %59
  %61 = call i32 (ptr, ptr, ...) @sprintf(ptr %60, ptr @.hex.byte_fmt, i32 %58)
  %62 = add i64 %54, 1
  store i64 %62, ptr %53
  br label %lbl_1

lbl_3:
  %63 = getelementptr i8, ptr %52, i64 64
  store i8 0, ptr %63
  ret ptr %52
}

define void @tampil_blok(i64 %arg_idx, ptr %arg_data, ptr %arg_hash, ptr %arg_prev) {
entry:
  %idx = alloca i64
  store i64 %arg_idx, ptr %idx
  %data = alloca ptr
  store ptr %arg_data, ptr %data
  %hash = alloca ptr
  store ptr %arg_hash, ptr %hash
  %prev = alloca ptr
  store ptr %arg_prev, ptr %prev
  %1 = load i64, ptr %idx
  %2 = call ptr @malloc(i64 32)
  %3 = call i32 (ptr, ptr, ...) @sprintf(ptr %2, ptr @.fmt.input_bilangan, i64 %1)
  %5 = call i64 @strlen(ptr @.str.2)
  %6 = call i64 @strlen(ptr %2)
  %7 = add i64 %5, %6
  %8 = add i64 %7, 1
  %9 = call ptr @malloc(i64 %8)
  %10 = call ptr @strcpy(ptr %9, ptr @.str.2)
  %11 = call ptr @strcat(ptr %9, ptr %2)
  %12 = call i64 @strlen(ptr %9)
  %13 = add i64 %12, 32
  %14 = call ptr @malloc(i64 %13)
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr @.ansi.sian, ptr %9)
  %16 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %14)
  %17 = load ptr, ptr %data
  %19 = call i64 @strlen(ptr @.str.3)
  %20 = call i64 @strlen(ptr %17)
  %21 = add i64 %19, %20
  %22 = add i64 %21, 1
  %23 = call ptr @malloc(i64 %22)
  %24 = call ptr @strcpy(ptr %23, ptr @.str.3)
  %25 = call ptr @strcat(ptr %23, ptr %17)
  %26 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %23)
  %27 = load ptr, ptr %prev
  %28 = add i64 16, 1
  %29 = call ptr @malloc(i64 %28)
  %30 = getelementptr i8, ptr %27, i64 0
  %31 = call ptr @strncpy(ptr %29, ptr %30, i64 16)
  %32 = getelementptr i8, ptr %29, i64 16
  store i8 0, ptr %32
  %34 = call i64 @strlen(ptr @.str.4)
  %35 = call i64 @strlen(ptr %29)
  %36 = add i64 %34, %35
  %37 = add i64 %36, 1
  %38 = call ptr @malloc(i64 %37)
  %39 = call ptr @strcpy(ptr %38, ptr @.str.4)
  %40 = call ptr @strcat(ptr %38, ptr %29)
  %42 = call i64 @strlen(ptr %38)
  %43 = call i64 @strlen(ptr @.str.5)
  %44 = add i64 %42, %43
  %45 = add i64 %44, 1
  %46 = call ptr @malloc(i64 %45)
  %47 = call ptr @strcpy(ptr %46, ptr %38)
  %48 = call ptr @strcat(ptr %46, ptr @.str.5)
  %49 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %46)
  %50 = load ptr, ptr %hash
  %51 = add i64 16, 1
  %52 = call ptr @malloc(i64 %51)
  %53 = getelementptr i8, ptr %50, i64 0
  %54 = call ptr @strncpy(ptr %52, ptr %53, i64 16)
  %55 = getelementptr i8, ptr %52, i64 16
  store i8 0, ptr %55
  %57 = call i64 @strlen(ptr @.str.6)
  %58 = call i64 @strlen(ptr %52)
  %59 = add i64 %57, %58
  %60 = add i64 %59, 1
  %61 = call ptr @malloc(i64 %60)
  %62 = call ptr @strcpy(ptr %61, ptr @.str.6)
  %63 = call ptr @strcat(ptr %61, ptr %52)
  %65 = call i64 @strlen(ptr %61)
  %66 = call i64 @strlen(ptr @.str.7)
  %67 = add i64 %65, %66
  %68 = add i64 %67, 1
  %69 = call ptr @malloc(i64 %68)
  %70 = call ptr @strcpy(ptr %69, ptr %61)
  %71 = call ptr @strcat(ptr %69, ptr @.str.7)
  %72 = call i64 @strlen(ptr %69)
  %73 = add i64 %72, 32
  %74 = call ptr @malloc(i64 %73)
  %75 = call i32 (ptr, ptr, ...) @sprintf(ptr %74, ptr @.ansi.hijau, ptr %69)
  %76 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %74)
  %77 = alloca i64
  %78 = call i64 @time(ptr null)
  store i64 %78, ptr %77
  %79 = call ptr @localtime(ptr %77)
  %80 = call ptr @malloc(i64 20)
  %81 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %82 = call i64 @strftime(ptr %80, i64 20, ptr %81, ptr %79)
  %84 = call i64 @strlen(ptr @.str.8)
  %85 = call i64 @strlen(ptr %80)
  %86 = add i64 %84, %85
  %87 = add i64 %86, 1
  %88 = call ptr @malloc(i64 %87)
  %89 = call ptr @strcpy(ptr %88, ptr @.str.8)
  %90 = call ptr @strcat(ptr %88, ptr %80)
  %91 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %88)
  %92 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.9)
  ret void
}

define void @utama() {
entry:
  %1 = call i64 @strlen(ptr @.str.10)
  %2 = add i64 %1, 32
  %3 = call ptr @malloc(i64 %2)
  %4 = call i32 (ptr, ptr, ...) @sprintf(ptr %3, ptr @.ansi.kuning, ptr @.str.10)
  %5 = call i64 @strlen(ptr %3)
  %6 = add i64 %5, 32
  %7 = call ptr @malloc(i64 %6)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.ansi.tebal, ptr %3)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %7)
  %10 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.11)
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %genesis_prev_12 = alloca ptr
  store ptr @.str.12, ptr %genesis_prev_12
  %13 = load ptr, ptr %genesis_prev_12
  %14 = call ptr @hash_blok(i64 0, ptr @.str.13, ptr %13)
  %h0_15 = alloca ptr
  store ptr %14, ptr %h0_15
  %16 = load ptr, ptr %h0_15
  %17 = load ptr, ptr %genesis_prev_12
  call void @tampil_blok(i64 0, ptr @.str.14, ptr %16, ptr %17)
  %18 = load ptr, ptr %h0_15
  %19 = call ptr @hash_blok(i64 1, ptr @.str.15, ptr %18)
  %h1_20 = alloca ptr
  store ptr %19, ptr %h1_20
  %21 = load ptr, ptr %h1_20
  %22 = load ptr, ptr %h0_15
  call void @tampil_blok(i64 1, ptr @.str.16, ptr %21, ptr %22)
  %23 = load ptr, ptr %h1_20
  %24 = call ptr @hash_blok(i64 2, ptr @.str.17, ptr %23)
  %h2_25 = alloca ptr
  store ptr %24, ptr %h2_25
  %26 = load ptr, ptr %h2_25
  %27 = load ptr, ptr %h1_20
  call void @tampil_blok(i64 2, ptr @.str.18, ptr %26, ptr %27)
  %28 = load ptr, ptr %h2_25
  %29 = call ptr @hash_blok(i64 3, ptr @.str.19, ptr %28)
  %h3_30 = alloca ptr
  store ptr %29, ptr %h3_30
  %31 = load ptr, ptr %h3_30
  %32 = load ptr, ptr %h2_25
  call void @tampil_blok(i64 3, ptr @.str.20, ptr %31, ptr %32)
  %33 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %34 = call i64 @strlen(ptr @.str.21)
  %35 = add i64 %34, 32
  %36 = call ptr @malloc(i64 %35)
  %37 = call i32 (ptr, ptr, ...) @sprintf(ptr %36, ptr @.ansi.hijau, ptr @.str.21)
  %38 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %36)
  %39 = call i64 @strlen(ptr @.str.22)
  %40 = add i64 %39, 32
  %41 = call ptr @malloc(i64 %40)
  %42 = call i32 (ptr, ptr, ...) @sprintf(ptr %41, ptr @.ansi.sian, ptr @.str.22)
  %43 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %41)
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

