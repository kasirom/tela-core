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

@.str.0 = private unnamed_addr constant [7 x i8] c"status\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"kode\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"pesan\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"data\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"waktu\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.6 = private unnamed_addr constant [7 x i8] c"sukses\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"API TelaCore berjalan!\00", align 1
@.str.8 = private unnamed_addr constant [7 x i8] c"v0.2.0\00", align 1
@.str.9 = private unnamed_addr constant [8 x i8] c"/health\00", align 1
@.str.10 = private unnamed_addr constant [7 x i8] c"sukses\00", align 1
@.str.11 = private unnamed_addr constant [10 x i8] c"Status OK\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"UP\00", align 1
@.str.13 = private unnamed_addr constant [7 x i8] c"/token\00", align 1
@.str.14 = private unnamed_addr constant [7 x i8] c"sukses\00", align 1
@.str.15 = private unnamed_addr constant [10 x i8] c"Token API\00", align 1
@.str.16 = private unnamed_addr constant [17 x i8] c"secret-nusantara\00", align 1
@.str.17 = private unnamed_addr constant [7 x i8] c"/waktu\00", align 1
@.str.18 = private unnamed_addr constant [7 x i8] c"sukses\00", align 1
@.str.19 = private unnamed_addr constant [13 x i8] c"Waktu server\00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c"error\00", align 1
@.str.21 = private unnamed_addr constant [25 x i8] c"Endpoint tidak ditemukan\00", align 1
@.str.22 = private unnamed_addr constant [33 x i8] c"=== TELACORE REST API ENGINE ===\00", align 1
@.str.23 = private unnamed_addr constant [17 x i8] c"GET /        -> \00", align 1
@.str.24 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.25 = private unnamed_addr constant [17 x i8] c"GET /health  -> \00", align 1
@.str.26 = private unnamed_addr constant [8 x i8] c"/health\00", align 1
@.str.27 = private unnamed_addr constant [17 x i8] c"GET /token   -> \00", align 1
@.str.28 = private unnamed_addr constant [7 x i8] c"/token\00", align 1
@.str.29 = private unnamed_addr constant [17 x i8] c"GET /waktu   -> \00", align 1
@.str.30 = private unnamed_addr constant [7 x i8] c"/waktu\00", align 1
@.str.31 = private unnamed_addr constant [17 x i8] c"GET /unknown -> \00", align 1
@.str.32 = private unnamed_addr constant [9 x i8] c"/unknown\00", align 1
@.str.33 = private unnamed_addr constant [30 x i8] c"API Engine berjalan sempurna!\00", align 1
define ptr @respons(ptr %arg_status, i64 %arg_kode, ptr %arg_pesan, ptr %arg_data) {
entry:
  %status = alloca ptr
  store ptr %arg_status, ptr %status
  %kode = alloca i64
  store i64 %arg_kode, ptr %kode
  %pesan = alloca ptr
  store ptr %arg_pesan, ptr %pesan
  %data = alloca ptr
  store ptr %arg_data, ptr %data
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
  %8 = load ptr, ptr %status
  %9 = getelementptr { ptr, i64, i64 }, ptr %7, i32 0, i32 0
  %10 = load ptr, ptr %9
  %11 = getelementptr { ptr, i64, i64 }, ptr %7, i32 0, i32 1
  %12 = load i64, ptr %11
  %13 = icmp eq i64 %12, 0
  %14 = select i1 %13, ptr @.json.str.init, ptr @.json.str.next
  %15 = getelementptr i8, ptr %10, i64 %12
  %16 = call i32 (ptr, ptr, ...) @sprintf(ptr %15, ptr %14, ptr @.str.0, ptr %8)
  %17 = call i64 @strlen(ptr %10)
  store i64 %17, ptr %11
  %18 = load ptr, ptr %o_6
  %19 = load i64, ptr %kode
  %20 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 0
  %21 = load ptr, ptr %20
  %22 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 1
  %23 = load i64, ptr %22
  %24 = icmp eq i64 %23, 0
  %25 = select i1 %24, ptr @.json.int.init, ptr @.json.int.next
  %26 = getelementptr i8, ptr %21, i64 %23
  %27 = call i32 (ptr, ptr, ...) @sprintf(ptr %26, ptr %25, ptr @.str.1, i64 %19)
  %28 = call i64 @strlen(ptr %21)
  store i64 %28, ptr %22
  %29 = load ptr, ptr %o_6
  %30 = load ptr, ptr %pesan
  %31 = getelementptr { ptr, i64, i64 }, ptr %29, i32 0, i32 0
  %32 = load ptr, ptr %31
  %33 = getelementptr { ptr, i64, i64 }, ptr %29, i32 0, i32 1
  %34 = load i64, ptr %33
  %35 = icmp eq i64 %34, 0
  %36 = select i1 %35, ptr @.json.str.init, ptr @.json.str.next
  %37 = getelementptr i8, ptr %32, i64 %34
  %38 = call i32 (ptr, ptr, ...) @sprintf(ptr %37, ptr %36, ptr @.str.2, ptr %30)
  %39 = call i64 @strlen(ptr %32)
  store i64 %39, ptr %33
  %40 = load ptr, ptr %o_6
  %41 = load ptr, ptr %data
  %42 = getelementptr { ptr, i64, i64 }, ptr %40, i32 0, i32 0
  %43 = load ptr, ptr %42
  %44 = getelementptr { ptr, i64, i64 }, ptr %40, i32 0, i32 1
  %45 = load i64, ptr %44
  %46 = icmp eq i64 %45, 0
  %47 = select i1 %46, ptr @.json.str.init, ptr @.json.str.next
  %48 = getelementptr i8, ptr %43, i64 %45
  %49 = call i32 (ptr, ptr, ...) @sprintf(ptr %48, ptr %47, ptr @.str.3, ptr %41)
  %50 = call i64 @strlen(ptr %43)
  store i64 %50, ptr %44
  %51 = load ptr, ptr %o_6
  %52 = alloca i64
  %53 = call i64 @time(ptr null)
  store i64 %53, ptr %52
  %54 = call ptr @localtime(ptr %52)
  %55 = call ptr @malloc(i64 20)
  %56 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %57 = call i64 @strftime(ptr %55, i64 20, ptr %56, ptr %54)
  %58 = getelementptr { ptr, i64, i64 }, ptr %51, i32 0, i32 0
  %59 = load ptr, ptr %58
  %60 = getelementptr { ptr, i64, i64 }, ptr %51, i32 0, i32 1
  %61 = load i64, ptr %60
  %62 = icmp eq i64 %61, 0
  %63 = select i1 %62, ptr @.json.str.init, ptr @.json.str.next
  %64 = getelementptr i8, ptr %59, i64 %61
  %65 = call i32 (ptr, ptr, ...) @sprintf(ptr %64, ptr %63, ptr @.str.4, ptr %55)
  %66 = call i64 @strlen(ptr %59)
  store i64 %66, ptr %60
  %67 = load ptr, ptr %o_6
  %68 = getelementptr { ptr, i64, i64 }, ptr %67, i32 0, i32 0
  %69 = load ptr, ptr %68
  %70 = getelementptr { ptr, i64, i64 }, ptr %67, i32 0, i32 1
  %71 = load i64, ptr %70
  %72 = icmp eq i64 %71, 0
  %73 = alloca ptr
  br i1 %72, label %lbl_1, label %lbl_2

lbl_1:
  store ptr @.json.empty, ptr %73
  br label %lbl_3

lbl_2:
  %74 = add i64 %71, 8
  %75 = call ptr @malloc(i64 %74)
  %76 = call ptr @strcpy(ptr %75, ptr %69)
  %77 = getelementptr i8, ptr %75, i64 %71
  store i8 125, ptr %77
  %78 = getelementptr i8, ptr %77, i64 1
  store i8 0, ptr %78
  store ptr %75, ptr %73
  br label %lbl_3

lbl_3:
  %79 = load ptr, ptr %73
  ret ptr %79
}

define ptr @router(ptr %arg_path) {
entry:
  %path = alloca ptr
  store ptr %arg_path, ptr %path
  %1 = load ptr, ptr %path
  %3 = call i32 @strcmp(ptr %1, ptr @.str.5)
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %lbl_1, label %lbl_2

lbl_1:
  %5 = call ptr @respons(ptr @.str.6, i64 200, ptr @.str.7, ptr @.str.8)
  ret ptr %5

lbl_2:
  br label %lbl_3

lbl_3:
  %6 = load ptr, ptr %path
  %8 = call i32 @strcmp(ptr %6, ptr @.str.9)
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %lbl_4, label %lbl_5

lbl_4:
  %10 = call ptr @respons(ptr @.str.10, i64 200, ptr @.str.11, ptr @.str.12)
  ret ptr %10

lbl_5:
  br label %lbl_6

lbl_6:
  %11 = load ptr, ptr %path
  %13 = call i32 @strcmp(ptr %11, ptr @.str.13)
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %lbl_7, label %lbl_8

lbl_7:
  %15 = alloca ptr
  %16 = alloca ptr
  %17 = alloca i32
  %18 = alloca [64 x i8]
  %19 = call i32 @CryptAcquireContextA(ptr %15, ptr null, ptr null, i32 24, i32 -268435456)
  %20 = load ptr, ptr %15
  %21 = call i32 @CryptCreateHash(ptr %20, i32 32780, ptr null, i32 0, ptr %16)
  %22 = load ptr, ptr %16
  %23 = call i64 @strlen(ptr @.str.16)
  %24 = trunc i64 %23 to i32
  %25 = call i32 @CryptHashData(ptr %22, ptr @.str.16, i32 %24, i32 0)
  store i32 32, ptr %17
  %26 = call i32 @CryptGetHashParam(ptr %22, i32 2, ptr %18, ptr %17, i32 0)
  %27 = call i32 @CryptDestroyHash(ptr %22)
  %28 = call i32 @CryptReleaseContext(ptr %20, i32 0)
  %29 = call ptr @malloc(i64 65)
  %30 = alloca i64
  store i64 0, ptr %30
  br label %lbl_10

lbl_10:
  %31 = load i64, ptr %30
  %32 = icmp slt i64 %31, 32
  br i1 %32, label %lbl_11, label %lbl_12

lbl_11:
  %33 = getelementptr [64 x i8], ptr %18, i64 0, i64 %31
  %34 = load i8, ptr %33
  %35 = zext i8 %34 to i32
  %36 = mul i64 %31, 2
  %37 = getelementptr i8, ptr %29, i64 %36
  %38 = call i32 (ptr, ptr, ...) @sprintf(ptr %37, ptr @.hex.byte_fmt, i32 %35)
  %39 = add i64 %31, 1
  store i64 %39, ptr %30
  br label %lbl_10

lbl_12:
  %40 = getelementptr i8, ptr %29, i64 64
  store i8 0, ptr %40
  %41 = call ptr @respons(ptr @.str.14, i64 200, ptr @.str.15, ptr %29)
  ret ptr %41

lbl_8:
  br label %lbl_9

lbl_9:
  %42 = load ptr, ptr %path
  %44 = call i32 @strcmp(ptr %42, ptr @.str.17)
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %lbl_13, label %lbl_14

lbl_13:
  %46 = alloca i64
  %47 = call i64 @time(ptr null)
  store i64 %47, ptr %46
  %48 = call ptr @localtime(ptr %46)
  %49 = call ptr @malloc(i64 20)
  %50 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %51 = call i64 @strftime(ptr %49, i64 20, ptr %50, ptr %48)
  %52 = call ptr @respons(ptr @.str.18, i64 200, ptr @.str.19, ptr %49)
  ret ptr %52

lbl_14:
  br label %lbl_15

lbl_15:
  %53 = load ptr, ptr %path
  %54 = call ptr @respons(ptr @.str.20, i64 404, ptr @.str.21, ptr %53)
  ret ptr %54
}

define void @utama() {
entry:
  %1 = call i64 @strlen(ptr @.str.22)
  %2 = add i64 %1, 32
  %3 = call ptr @malloc(i64 %2)
  %4 = call i32 (ptr, ptr, ...) @sprintf(ptr %3, ptr @.ansi.sian, ptr @.str.22)
  %5 = call i64 @strlen(ptr %3)
  %6 = add i64 %5, 32
  %7 = call ptr @malloc(i64 %6)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.ansi.tebal, ptr %3)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %7)
  %10 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %11 = call ptr @router(ptr @.str.24)
  %13 = call i64 @strlen(ptr @.str.23)
  %14 = call i64 @strlen(ptr %11)
  %15 = add i64 %13, %14
  %16 = add i64 %15, 1
  %17 = call ptr @malloc(i64 %16)
  %18 = call ptr @strcpy(ptr %17, ptr @.str.23)
  %19 = call ptr @strcat(ptr %17, ptr %11)
  %20 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %17)
  %21 = call ptr @router(ptr @.str.26)
  %23 = call i64 @strlen(ptr @.str.25)
  %24 = call i64 @strlen(ptr %21)
  %25 = add i64 %23, %24
  %26 = add i64 %25, 1
  %27 = call ptr @malloc(i64 %26)
  %28 = call ptr @strcpy(ptr %27, ptr @.str.25)
  %29 = call ptr @strcat(ptr %27, ptr %21)
  %30 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %27)
  %31 = call ptr @router(ptr @.str.28)
  %33 = call i64 @strlen(ptr @.str.27)
  %34 = call i64 @strlen(ptr %31)
  %35 = add i64 %33, %34
  %36 = add i64 %35, 1
  %37 = call ptr @malloc(i64 %36)
  %38 = call ptr @strcpy(ptr %37, ptr @.str.27)
  %39 = call ptr @strcat(ptr %37, ptr %31)
  %40 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %37)
  %41 = call ptr @router(ptr @.str.30)
  %43 = call i64 @strlen(ptr @.str.29)
  %44 = call i64 @strlen(ptr %41)
  %45 = add i64 %43, %44
  %46 = add i64 %45, 1
  %47 = call ptr @malloc(i64 %46)
  %48 = call ptr @strcpy(ptr %47, ptr @.str.29)
  %49 = call ptr @strcat(ptr %47, ptr %41)
  %50 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %47)
  %51 = call ptr @router(ptr @.str.32)
  %53 = call i64 @strlen(ptr @.str.31)
  %54 = call i64 @strlen(ptr %51)
  %55 = add i64 %53, %54
  %56 = add i64 %55, 1
  %57 = call ptr @malloc(i64 %56)
  %58 = call ptr @strcpy(ptr %57, ptr @.str.31)
  %59 = call ptr @strcat(ptr %57, ptr %51)
  %60 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %57)
  %61 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %62 = call i64 @strlen(ptr @.str.33)
  %63 = add i64 %62, 32
  %64 = call ptr @malloc(i64 %63)
  %65 = call i32 (ptr, ptr, ...) @sprintf(ptr %64, ptr @.ansi.hijau, ptr @.str.33)
  %66 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %64)
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

