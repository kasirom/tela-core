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

@.str.0 = private unnamed_addr constant [3 x i8] c"> \00", align 1
@.str.1 = private unnamed_addr constant [42 x i8] c"=== SHOWCASE PUSTAKA STANDAR TELACORE ===\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"Modul Teks::\00", align 1
@.str.3 = private unnamed_addr constant [24 x i8] c"Nusantara TelaCore 2026\00", align 1
@.str.4 = private unnamed_addr constant [18 x i8] c"  panjang()    = \00", align 1
@.str.5 = private unnamed_addr constant [18 x i8] c"  ubah_besar() = \00", align 1
@.str.6 = private unnamed_addr constant [18 x i8] c"  ubah_kecil() = \00", align 1
@.str.7 = private unnamed_addr constant [19 x i8] c"  trim()       = '\00", align 1
@.str.8 = private unnamed_addr constant [10 x i8] c"  spasi  \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"'\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"  berisi Tela  = \00", align 1
@.str.11 = private unnamed_addr constant [5 x i8] c"Tela\00", align 1
@.str.12 = private unnamed_addr constant [18 x i8] c"  ganti()      = \00", align 1
@.str.13 = private unnamed_addr constant [10 x i8] c"Nusantara\00", align 1
@.str.14 = private unnamed_addr constant [10 x i8] c"Indonesia\00", align 1
@.str.15 = private unnamed_addr constant [18 x i8] c"  ulangi()     = \00", align 1
@.str.16 = private unnamed_addr constant [3 x i8] c"Ha\00", align 1
@.str.17 = private unnamed_addr constant [19 x i8] c"  pad_kanan()  = '\00", align 1
@.str.18 = private unnamed_addr constant [5 x i8] c"Kiri\00", align 1
@.str.19 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.20 = private unnamed_addr constant [2 x i8] c"'\00", align 1
@.str.21 = private unnamed_addr constant [19 x i8] c"  pad_kiri()   = '\00", align 1
@.str.22 = private unnamed_addr constant [6 x i8] c"Kanan\00", align 1
@.str.23 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.24 = private unnamed_addr constant [2 x i8] c"'\00", align 1
@.str.25 = private unnamed_addr constant [19 x i8] c"Modul Matematika::\00", align 1
@.str.26 = private unnamed_addr constant [22 x i8] c"  pi()             = \00", align 1
@.str.27 = private unnamed_addr constant [22 x i8] c"  akar(144)        = \00", align 1
@.str.28 = private unnamed_addr constant [22 x i8] c"  pangkat(2, 16)   = \00", align 1
@.str.29 = private unnamed_addr constant [22 x i8] c"  hipotenusa(3, 4) = \00", align 1
@.str.30 = private unnamed_addr constant [22 x i8] c"  maksimum(17, 42) = \00", align 1
@.str.31 = private unnamed_addr constant [22 x i8] c"  minimum(17, 42)  = \00", align 1
@.str.32 = private unnamed_addr constant [14 x i8] c"Modul Waktu::\00", align 1
@.str.33 = private unnamed_addr constant [22 x i8] c"  waktu_sekarang() = \00", align 1
@.str.34 = private unnamed_addr constant [22 x i8] c"  waktu_unix()     = \00", align 1
@.str.35 = private unnamed_addr constant [24 x i8] c"Modul Koleksi:: (Kamus)\00", align 1
@.str.36 = private unnamed_addr constant [8 x i8] c"jakarta\00", align 1
@.str.37 = private unnamed_addr constant [8 x i8] c"bandung\00", align 1
@.str.38 = private unnamed_addr constant [9 x i8] c"surabaya\00", align 1
@.str.39 = private unnamed_addr constant [15 x i8] c"  jakarta   = \00", align 1
@.str.40 = private unnamed_addr constant [8 x i8] c"jakarta\00", align 1
@.str.41 = private unnamed_addr constant [15 x i8] c"  bandung   = \00", align 1
@.str.42 = private unnamed_addr constant [8 x i8] c"bandung\00", align 1
@.str.43 = private unnamed_addr constant [15 x i8] c"  ada bali  = \00", align 1
@.str.44 = private unnamed_addr constant [5 x i8] c"bali\00", align 1
@.str.45 = private unnamed_addr constant [12 x i8] c"Modul Bit::\00", align 1
@.str.46 = private unnamed_addr constant [22 x i8] c"  geser_kiri(1, 8) = \00", align 1
@.str.47 = private unnamed_addr constant [22 x i8] c"  dan(255, 15)     = \00", align 1
@.str.48 = private unnamed_addr constant [22 x i8] c"  xor(170, 85)     = \00", align 1
@.str.49 = private unnamed_addr constant [22 x i8] c"  hitung_satu(255) = \00", align 1
@.str.50 = private unnamed_addr constant [24 x i8] c"Modul Uji:: (Unit Test)\00", align 1
@.str.51 = private unnamed_addr constant [14 x i8] c"2 + 2 harus 4\00", align 1
@.str.52 = private unnamed_addr constant [21 x i8] c"maksimum(5,10) == 10\00", align 1
@.str.53 = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.54 = private unnamed_addr constant [5 x i8] c"Tela\00", align 1
@.str.55 = private unnamed_addr constant [14 x i8] c"berisi 'Tela'\00", align 1
@.str.56 = private unnamed_addr constant [5 x i8] c"halo\00", align 1
@.str.57 = private unnamed_addr constant [5 x i8] c"HALO\00", align 1
@.str.58 = private unnamed_addr constant [14 x i8] c"ubah_besar OK\00", align 1
@.str.59 = private unnamed_addr constant [47 x i8] c"Semua modul pustaka standar berjalan sempurna!\00", align 1
define void @judul(ptr %arg_t) {
entry:
  %t = alloca ptr
  store ptr %arg_t, ptr %t
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %2 = load ptr, ptr %t
  %4 = call i64 @strlen(ptr @.str.0)
  %5 = call i64 @strlen(ptr %2)
  %6 = add i64 %4, %5
  %7 = add i64 %6, 1
  %8 = call ptr @malloc(i64 %7)
  %9 = call ptr @strcpy(ptr %8, ptr @.str.0)
  %10 = call ptr @strcat(ptr %8, ptr %2)
  %11 = call i64 @strlen(ptr %8)
  %12 = add i64 %11, 32
  %13 = call ptr @malloc(i64 %12)
  %14 = call i32 (ptr, ptr, ...) @sprintf(ptr %13, ptr @.ansi.kuning, ptr %8)
  %15 = call i64 @strlen(ptr %13)
  %16 = add i64 %15, 32
  %17 = call ptr @malloc(i64 %16)
  %18 = call i32 (ptr, ptr, ...) @sprintf(ptr %17, ptr @.ansi.tebal, ptr %13)
  %19 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %17)
  ret void
}

define void @utama() {
entry:
  %1 = call i64 @strlen(ptr @.str.1)
  %2 = add i64 %1, 32
  %3 = call ptr @malloc(i64 %2)
  %4 = call i32 (ptr, ptr, ...) @sprintf(ptr %3, ptr @.ansi.sian, ptr @.str.1)
  %5 = call i64 @strlen(ptr %3)
  %6 = add i64 %5, 32
  %7 = call ptr @malloc(i64 %6)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.ansi.tebal, ptr %3)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %7)
  call void @judul(ptr @.str.2)
  %kata_10 = alloca ptr
  store ptr @.str.3, ptr %kata_10
  %11 = load ptr, ptr %kata_10
  %12 = call i64 @strlen(ptr %11)
  %13 = call ptr @malloc(i64 32)
  %14 = call i32 (ptr, ptr, ...) @sprintf(ptr %13, ptr @.fmt.input_bilangan, i64 %12)
  %16 = call i64 @strlen(ptr @.str.4)
  %17 = call i64 @strlen(ptr %13)
  %18 = add i64 %16, %17
  %19 = add i64 %18, 1
  %20 = call ptr @malloc(i64 %19)
  %21 = call ptr @strcpy(ptr %20, ptr @.str.4)
  %22 = call ptr @strcat(ptr %20, ptr %13)
  %23 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %20)
  %24 = load ptr, ptr %kata_10
  %25 = call i64 @strlen(ptr %24)
  %26 = add i64 %25, 1
  %27 = call ptr @malloc(i64 %26)
  %28 = alloca i64
  store i64 0, ptr %28
  br label %lbl_1

lbl_1:
  %29 = load i64, ptr %28
  %30 = icmp slt i64 %29, %25
  br i1 %30, label %lbl_2, label %lbl_3

lbl_2:
  %31 = getelementptr i8, ptr %24, i64 %29
  %32 = load i8, ptr %31
  %33 = sext i8 %32 to i32
  %34 = call i32 @toupper(i32 %33)
  %35 = trunc i32 %34 to i8
  %36 = getelementptr i8, ptr %27, i64 %29
  store i8 %35, ptr %36
  %37 = add i64 %29, 1
  store i64 %37, ptr %28
  br label %lbl_1

lbl_3:
  %38 = getelementptr i8, ptr %27, i64 %25
  store i8 0, ptr %38
  %40 = call i64 @strlen(ptr @.str.5)
  %41 = call i64 @strlen(ptr %27)
  %42 = add i64 %40, %41
  %43 = add i64 %42, 1
  %44 = call ptr @malloc(i64 %43)
  %45 = call ptr @strcpy(ptr %44, ptr @.str.5)
  %46 = call ptr @strcat(ptr %44, ptr %27)
  %47 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %44)
  %48 = load ptr, ptr %kata_10
  %49 = call i64 @strlen(ptr %48)
  %50 = add i64 %49, 1
  %51 = call ptr @malloc(i64 %50)
  %52 = alloca i64
  store i64 0, ptr %52
  br label %lbl_4

lbl_4:
  %53 = load i64, ptr %52
  %54 = icmp slt i64 %53, %49
  br i1 %54, label %lbl_5, label %lbl_6

lbl_5:
  %55 = getelementptr i8, ptr %48, i64 %53
  %56 = load i8, ptr %55
  %57 = sext i8 %56 to i32
  %58 = call i32 @tolower(i32 %57)
  %59 = trunc i32 %58 to i8
  %60 = getelementptr i8, ptr %51, i64 %53
  store i8 %59, ptr %60
  %61 = add i64 %53, 1
  store i64 %61, ptr %52
  br label %lbl_4

lbl_6:
  %62 = getelementptr i8, ptr %51, i64 %49
  store i8 0, ptr %62
  %64 = call i64 @strlen(ptr @.str.6)
  %65 = call i64 @strlen(ptr %51)
  %66 = add i64 %64, %65
  %67 = add i64 %66, 1
  %68 = call ptr @malloc(i64 %67)
  %69 = call ptr @strcpy(ptr %68, ptr @.str.6)
  %70 = call ptr @strcat(ptr %68, ptr %51)
  %71 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %68)
  %72 = call i64 @strlen(ptr @.str.8)
  %73 = add i64 %72, 1
  %74 = call ptr @malloc(i64 %73)
  %75 = call ptr @strcpy(ptr %74, ptr @.str.8)
  %77 = call i64 @strlen(ptr @.str.7)
  %78 = call i64 @strlen(ptr %74)
  %79 = add i64 %77, %78
  %80 = add i64 %79, 1
  %81 = call ptr @malloc(i64 %80)
  %82 = call ptr @strcpy(ptr %81, ptr @.str.7)
  %83 = call ptr @strcat(ptr %81, ptr %74)
  %85 = call i64 @strlen(ptr %81)
  %86 = call i64 @strlen(ptr @.str.9)
  %87 = add i64 %85, %86
  %88 = add i64 %87, 1
  %89 = call ptr @malloc(i64 %88)
  %90 = call ptr @strcpy(ptr %89, ptr %81)
  %91 = call ptr @strcat(ptr %89, ptr @.str.9)
  %92 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %89)
  %93 = load ptr, ptr %kata_10
  %94 = call ptr @strstr(ptr %93, ptr @.str.11)
  %95 = icmp ne ptr %94, null
  %96 = select i1 %95, ptr @.str.true, ptr @.str.false
  %98 = call i64 @strlen(ptr @.str.10)
  %99 = call i64 @strlen(ptr %96)
  %100 = add i64 %98, %99
  %101 = add i64 %100, 1
  %102 = call ptr @malloc(i64 %101)
  %103 = call ptr @strcpy(ptr %102, ptr @.str.10)
  %104 = call ptr @strcat(ptr %102, ptr %96)
  %105 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %102)
  %106 = load ptr, ptr %kata_10
  %107 = call i64 @strlen(ptr %106)
  %108 = call i64 @strlen(ptr @.str.14)
  %109 = add i64 %107, %108
  %110 = add i64 %109, 32
  %111 = call ptr @malloc(i64 %110)
  %112 = call ptr @strstr(ptr %106, ptr @.str.13)
  %113 = icmp ne ptr %112, null
  br i1 %113, label %lbl_7, label %lbl_8

lbl_7:
  %114 = ptrtoint ptr %112 to i64
  %115 = ptrtoint ptr %106 to i64
  %116 = sub i64 %114, %115
  %117 = call ptr @strncpy(ptr %111, ptr %106, i64 %116)
  %118 = getelementptr i8, ptr %111, i64 %116
  store i8 0, ptr %118
  %119 = call ptr @strcat(ptr %111, ptr @.str.14)
  %120 = call i64 @strlen(ptr @.str.13)
  %121 = getelementptr i8, ptr %112, i64 %120
  %122 = call ptr @strcat(ptr %111, ptr %121)
  br label %lbl_9

lbl_8:
  %123 = call ptr @strcpy(ptr %111, ptr %106)
  br label %lbl_9

lbl_9:
  %125 = call i64 @strlen(ptr @.str.12)
  %126 = call i64 @strlen(ptr %111)
  %127 = add i64 %125, %126
  %128 = add i64 %127, 1
  %129 = call ptr @malloc(i64 %128)
  %130 = call ptr @strcpy(ptr %129, ptr @.str.12)
  %131 = call ptr @strcat(ptr %129, ptr %111)
  %132 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %129)
  %133 = call i64 @strlen(ptr @.str.16)
  %134 = mul i64 %133, 4
  %135 = add i64 %134, 1
  %136 = call ptr @malloc(i64 %135)
  store i8 0, ptr %136
  %137 = alloca i64
  store i64 0, ptr %137
  br label %lbl_10

lbl_10:
  %138 = load i64, ptr %137
  %139 = icmp slt i64 %138, 4
  br i1 %139, label %lbl_11, label %lbl_12

lbl_11:
  %140 = call ptr @strcat(ptr %136, ptr @.str.16)
  %141 = add i64 %138, 1
  store i64 %141, ptr %137
  br label %lbl_10

lbl_12:
  %143 = call i64 @strlen(ptr @.str.15)
  %144 = call i64 @strlen(ptr %136)
  %145 = add i64 %143, %144
  %146 = add i64 %145, 1
  %147 = call ptr @malloc(i64 %146)
  %148 = call ptr @strcpy(ptr %147, ptr @.str.15)
  %149 = call ptr @strcat(ptr %147, ptr %136)
  %150 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %147)
  %151 = call i64 @strlen(ptr @.str.18)
  %152 = icmp sge i64 %151, 12
  %153 = alloca ptr
  br i1 %152, label %lbl_13, label %lbl_14

lbl_13:
  %154 = add i64 %151, 1
  %155 = call ptr @malloc(i64 %154)
  %156 = call ptr @strcpy(ptr %155, ptr @.str.18)
  store ptr %155, ptr %153
  br label %lbl_15

lbl_14:
  %157 = load i8, ptr @.str.19
  %158 = add i64 12, 1
  %159 = call ptr @malloc(i64 %158)
  %160 = call ptr @strcpy(ptr %159, ptr @.str.18)
  %161 = alloca i64
  store i64 %151, ptr %161
  br label %lbl_16

lbl_16:
  %162 = load i64, ptr %161
  %163 = icmp slt i64 %162, 12
  br i1 %163, label %lbl_17, label %lbl_18

lbl_17:
  %164 = getelementptr i8, ptr %159, i64 %162
  store i8 %157, ptr %164
  %165 = add i64 %162, 1
  store i64 %165, ptr %161
  br label %lbl_16

lbl_18:
  %166 = getelementptr i8, ptr %159, i64 12
  store i8 0, ptr %166
  store ptr %159, ptr %153
  br label %lbl_15

lbl_15:
  %167 = load ptr, ptr %153
  %169 = call i64 @strlen(ptr @.str.17)
  %170 = call i64 @strlen(ptr %167)
  %171 = add i64 %169, %170
  %172 = add i64 %171, 1
  %173 = call ptr @malloc(i64 %172)
  %174 = call ptr @strcpy(ptr %173, ptr @.str.17)
  %175 = call ptr @strcat(ptr %173, ptr %167)
  %177 = call i64 @strlen(ptr %173)
  %178 = call i64 @strlen(ptr @.str.20)
  %179 = add i64 %177, %178
  %180 = add i64 %179, 1
  %181 = call ptr @malloc(i64 %180)
  %182 = call ptr @strcpy(ptr %181, ptr %173)
  %183 = call ptr @strcat(ptr %181, ptr @.str.20)
  %184 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %181)
  %185 = call i64 @strlen(ptr @.str.22)
  %186 = icmp sge i64 %185, 12
  %187 = alloca ptr
  br i1 %186, label %lbl_19, label %lbl_20

lbl_19:
  %188 = add i64 %185, 1
  %189 = call ptr @malloc(i64 %188)
  %190 = call ptr @strcpy(ptr %189, ptr @.str.22)
  store ptr %189, ptr %187
  br label %lbl_21

lbl_20:
  %191 = sub i64 12, %185
  %192 = load i8, ptr @.str.23
  %193 = add i64 12, 1
  %194 = call ptr @malloc(i64 %193)
  %195 = alloca i64
  store i64 0, ptr %195
  br label %lbl_22

lbl_22:
  %196 = load i64, ptr %195
  %197 = icmp slt i64 %196, %191
  br i1 %197, label %lbl_23, label %lbl_24

lbl_23:
  %198 = getelementptr i8, ptr %194, i64 %196
  store i8 %192, ptr %198
  %199 = add i64 %196, 1
  store i64 %199, ptr %195
  br label %lbl_22

lbl_24:
  %200 = getelementptr i8, ptr %194, i64 %191
  %201 = call ptr @strcpy(ptr %200, ptr @.str.22)
  store ptr %194, ptr %187
  br label %lbl_21

lbl_21:
  %202 = load ptr, ptr %187
  %204 = call i64 @strlen(ptr @.str.21)
  %205 = call i64 @strlen(ptr %202)
  %206 = add i64 %204, %205
  %207 = add i64 %206, 1
  %208 = call ptr @malloc(i64 %207)
  %209 = call ptr @strcpy(ptr %208, ptr @.str.21)
  %210 = call ptr @strcat(ptr %208, ptr %202)
  %212 = call i64 @strlen(ptr %208)
  %213 = call i64 @strlen(ptr @.str.24)
  %214 = add i64 %212, %213
  %215 = add i64 %214, 1
  %216 = call ptr @malloc(i64 %215)
  %217 = call ptr @strcpy(ptr %216, ptr %208)
  %218 = call ptr @strcat(ptr %216, ptr @.str.24)
  %219 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %216)
  call void @judul(ptr @.str.25)
  %220 = call ptr @malloc(i64 32)
  %221 = call i32 (ptr, ptr, ...) @sprintf(ptr %220, ptr @.fmt.desimal, double 3.141592653589793)
  %223 = call i64 @strlen(ptr @.str.26)
  %224 = call i64 @strlen(ptr %220)
  %225 = add i64 %223, %224
  %226 = add i64 %225, 1
  %227 = call ptr @malloc(i64 %226)
  %228 = call ptr @strcpy(ptr %227, ptr @.str.26)
  %229 = call ptr @strcat(ptr %227, ptr %220)
  %230 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %227)
  %231 = call double @sqrt(double 144.0)
  %232 = call ptr @malloc(i64 32)
  %233 = call i32 (ptr, ptr, ...) @sprintf(ptr %232, ptr @.fmt.desimal, double %231)
  %235 = call i64 @strlen(ptr @.str.27)
  %236 = call i64 @strlen(ptr %232)
  %237 = add i64 %235, %236
  %238 = add i64 %237, 1
  %239 = call ptr @malloc(i64 %238)
  %240 = call ptr @strcpy(ptr %239, ptr @.str.27)
  %241 = call ptr @strcat(ptr %239, ptr %232)
  %242 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %239)
  %243 = call double @pow(double 2.0, double 16.0)
  %244 = call ptr @malloc(i64 32)
  %245 = call i32 (ptr, ptr, ...) @sprintf(ptr %244, ptr @.fmt.desimal, double %243)
  %247 = call i64 @strlen(ptr @.str.28)
  %248 = call i64 @strlen(ptr %244)
  %249 = add i64 %247, %248
  %250 = add i64 %249, 1
  %251 = call ptr @malloc(i64 %250)
  %252 = call ptr @strcpy(ptr %251, ptr @.str.28)
  %253 = call ptr @strcat(ptr %251, ptr %244)
  %254 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %251)
  %255 = call double @hypot(double 3.0, double 4.0)
  %256 = call ptr @malloc(i64 32)
  %257 = call i32 (ptr, ptr, ...) @sprintf(ptr %256, ptr @.fmt.desimal, double %255)
  %259 = call i64 @strlen(ptr @.str.29)
  %260 = call i64 @strlen(ptr %256)
  %261 = add i64 %259, %260
  %262 = add i64 %261, 1
  %263 = call ptr @malloc(i64 %262)
  %264 = call ptr @strcpy(ptr %263, ptr @.str.29)
  %265 = call ptr @strcat(ptr %263, ptr %256)
  %266 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %263)
  %267 = icmp sgt i64 17, 42
  %268 = select i1 %267, i64 17, i64 42
  %269 = call ptr @malloc(i64 32)
  %270 = call i32 (ptr, ptr, ...) @sprintf(ptr %269, ptr @.fmt.input_bilangan, i64 %268)
  %272 = call i64 @strlen(ptr @.str.30)
  %273 = call i64 @strlen(ptr %269)
  %274 = add i64 %272, %273
  %275 = add i64 %274, 1
  %276 = call ptr @malloc(i64 %275)
  %277 = call ptr @strcpy(ptr %276, ptr @.str.30)
  %278 = call ptr @strcat(ptr %276, ptr %269)
  %279 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %276)
  %280 = icmp slt i64 17, 42
  %281 = select i1 %280, i64 17, i64 42
  %282 = call ptr @malloc(i64 32)
  %283 = call i32 (ptr, ptr, ...) @sprintf(ptr %282, ptr @.fmt.input_bilangan, i64 %281)
  %285 = call i64 @strlen(ptr @.str.31)
  %286 = call i64 @strlen(ptr %282)
  %287 = add i64 %285, %286
  %288 = add i64 %287, 1
  %289 = call ptr @malloc(i64 %288)
  %290 = call ptr @strcpy(ptr %289, ptr @.str.31)
  %291 = call ptr @strcat(ptr %289, ptr %282)
  %292 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %289)
  call void @judul(ptr @.str.32)
  %293 = alloca i64
  %294 = call i64 @time(ptr null)
  store i64 %294, ptr %293
  %295 = call ptr @localtime(ptr %293)
  %296 = call ptr @malloc(i64 20)
  %297 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %298 = call i64 @strftime(ptr %296, i64 20, ptr %297, ptr %295)
  %300 = call i64 @strlen(ptr @.str.33)
  %301 = call i64 @strlen(ptr %296)
  %302 = add i64 %300, %301
  %303 = add i64 %302, 1
  %304 = call ptr @malloc(i64 %303)
  %305 = call ptr @strcpy(ptr %304, ptr @.str.33)
  %306 = call ptr @strcat(ptr %304, ptr %296)
  %307 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %304)
  %308 = call i64 @time(ptr null)
  %309 = call ptr @malloc(i64 32)
  %310 = call i32 (ptr, ptr, ...) @sprintf(ptr %309, ptr @.fmt.input_bilangan, i64 %308)
  %312 = call i64 @strlen(ptr @.str.34)
  %313 = call i64 @strlen(ptr %309)
  %314 = add i64 %312, %313
  %315 = add i64 %314, 1
  %316 = call ptr @malloc(i64 %315)
  %317 = call ptr @strcpy(ptr %316, ptr @.str.34)
  %318 = call ptr @strcat(ptr %316, ptr %309)
  %319 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %316)
  call void @judul(ptr @.str.35)
  %320 = call ptr @malloc(i64 24)
  %321 = call ptr @malloc(i64 64)
  %322 = getelementptr { ptr, i64, i64 }, ptr %320, i32 0, i32 0
  store ptr %321, ptr %322
  %323 = getelementptr { ptr, i64, i64 }, ptr %320, i32 0, i32 1
  store i64 0, ptr %323
  %324 = getelementptr { ptr, i64, i64 }, ptr %320, i32 0, i32 2
  store i64 8, ptr %324
  %km_325 = alloca ptr
  store ptr %320, ptr %km_325
  %326 = load ptr, ptr %km_325
  %327 = getelementptr { ptr, i64, i64 }, ptr %326, i32 0, i32 1
  %328 = load i64, ptr %327
  %329 = getelementptr { ptr, i64, i64 }, ptr %326, i32 0, i32 0
  %330 = load ptr, ptr %329
  %331 = mul i64 %328, 2
  %332 = getelementptr ptr, ptr %330, i64 %331
  store ptr @.str.36, ptr %332
  %333 = add i64 %331, 1
  %334 = getelementptr ptr, ptr %330, i64 %333
  %335 = call ptr @malloc(i64 8)
  store i64 28, ptr %335
  store ptr %335, ptr %334
  %336 = add i64 %328, 1
  store i64 %336, ptr %327
  %337 = load ptr, ptr %km_325
  %338 = getelementptr { ptr, i64, i64 }, ptr %337, i32 0, i32 1
  %339 = load i64, ptr %338
  %340 = getelementptr { ptr, i64, i64 }, ptr %337, i32 0, i32 0
  %341 = load ptr, ptr %340
  %342 = mul i64 %339, 2
  %343 = getelementptr ptr, ptr %341, i64 %342
  store ptr @.str.37, ptr %343
  %344 = add i64 %342, 1
  %345 = getelementptr ptr, ptr %341, i64 %344
  %346 = call ptr @malloc(i64 8)
  store i64 22, ptr %346
  store ptr %346, ptr %345
  %347 = add i64 %339, 1
  store i64 %347, ptr %338
  %348 = load ptr, ptr %km_325
  %349 = getelementptr { ptr, i64, i64 }, ptr %348, i32 0, i32 1
  %350 = load i64, ptr %349
  %351 = getelementptr { ptr, i64, i64 }, ptr %348, i32 0, i32 0
  %352 = load ptr, ptr %351
  %353 = mul i64 %350, 2
  %354 = getelementptr ptr, ptr %352, i64 %353
  store ptr @.str.38, ptr %354
  %355 = add i64 %353, 1
  %356 = getelementptr ptr, ptr %352, i64 %355
  %357 = call ptr @malloc(i64 8)
  store i64 31, ptr %357
  store ptr %357, ptr %356
  %358 = add i64 %350, 1
  store i64 %358, ptr %349
  %359 = load ptr, ptr %km_325
  %360 = getelementptr { ptr, i64, i64 }, ptr %359, i32 0, i32 0
  %361 = load ptr, ptr %360
  %362 = getelementptr { ptr, i64, i64 }, ptr %359, i32 0, i32 1
  %363 = load i64, ptr %362
  %364 = alloca i64
  store i64 0, ptr %364
  %365 = alloca i64
  store i64 0, ptr %365
  br label %lbl_25

lbl_25:
  %366 = load i64, ptr %365
  %367 = icmp slt i64 %366, %363
  br i1 %367, label %lbl_26, label %lbl_29

lbl_26:
  %368 = mul i64 %366, 2
  %369 = getelementptr ptr, ptr %361, i64 %368
  %370 = load ptr, ptr %369
  %371 = call i32 @strcmp(ptr %370, ptr @.str.40)
  %372 = icmp eq i32 %371, 0
  br i1 %372, label %lbl_27, label %lbl_28

lbl_27:
  %373 = add i64 %368, 1
  %374 = getelementptr ptr, ptr %361, i64 %373
  %375 = load ptr, ptr %374
  %376 = load i64, ptr %375
  store i64 %376, ptr %364
  br label %lbl_29

lbl_28:
  %377 = add i64 %366, 1
  store i64 %377, ptr %365
  br label %lbl_25

lbl_29:
  %378 = load i64, ptr %364
  %379 = call ptr @malloc(i64 32)
  %380 = call i32 (ptr, ptr, ...) @sprintf(ptr %379, ptr @.fmt.input_bilangan, i64 %378)
  %382 = call i64 @strlen(ptr @.str.39)
  %383 = call i64 @strlen(ptr %379)
  %384 = add i64 %382, %383
  %385 = add i64 %384, 1
  %386 = call ptr @malloc(i64 %385)
  %387 = call ptr @strcpy(ptr %386, ptr @.str.39)
  %388 = call ptr @strcat(ptr %386, ptr %379)
  %389 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %386)
  %390 = load ptr, ptr %km_325
  %391 = getelementptr { ptr, i64, i64 }, ptr %390, i32 0, i32 0
  %392 = load ptr, ptr %391
  %393 = getelementptr { ptr, i64, i64 }, ptr %390, i32 0, i32 1
  %394 = load i64, ptr %393
  %395 = alloca i64
  store i64 0, ptr %395
  %396 = alloca i64
  store i64 0, ptr %396
  br label %lbl_30

lbl_30:
  %397 = load i64, ptr %396
  %398 = icmp slt i64 %397, %394
  br i1 %398, label %lbl_31, label %lbl_34

lbl_31:
  %399 = mul i64 %397, 2
  %400 = getelementptr ptr, ptr %392, i64 %399
  %401 = load ptr, ptr %400
  %402 = call i32 @strcmp(ptr %401, ptr @.str.42)
  %403 = icmp eq i32 %402, 0
  br i1 %403, label %lbl_32, label %lbl_33

lbl_32:
  %404 = add i64 %399, 1
  %405 = getelementptr ptr, ptr %392, i64 %404
  %406 = load ptr, ptr %405
  %407 = load i64, ptr %406
  store i64 %407, ptr %395
  br label %lbl_34

lbl_33:
  %408 = add i64 %397, 1
  store i64 %408, ptr %396
  br label %lbl_30

lbl_34:
  %409 = load i64, ptr %395
  %410 = call ptr @malloc(i64 32)
  %411 = call i32 (ptr, ptr, ...) @sprintf(ptr %410, ptr @.fmt.input_bilangan, i64 %409)
  %413 = call i64 @strlen(ptr @.str.41)
  %414 = call i64 @strlen(ptr %410)
  %415 = add i64 %413, %414
  %416 = add i64 %415, 1
  %417 = call ptr @malloc(i64 %416)
  %418 = call ptr @strcpy(ptr %417, ptr @.str.41)
  %419 = call ptr @strcat(ptr %417, ptr %410)
  %420 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %417)
  %421 = load ptr, ptr %km_325
  %422 = getelementptr { ptr, i64, i64 }, ptr %421, i32 0, i32 0
  %423 = load ptr, ptr %422
  %424 = getelementptr { ptr, i64, i64 }, ptr %421, i32 0, i32 1
  %425 = load i64, ptr %424
  %426 = alloca i1
  store i1 0, ptr %426
  %427 = alloca i64
  store i64 0, ptr %427
  br label %lbl_35

lbl_35:
  %428 = load i64, ptr %427
  %429 = icmp slt i64 %428, %425
  br i1 %429, label %lbl_36, label %lbl_39

lbl_36:
  %430 = mul i64 %428, 2
  %431 = getelementptr ptr, ptr %423, i64 %430
  %432 = load ptr, ptr %431
  %433 = call i32 @strcmp(ptr %432, ptr @.str.44)
  %434 = icmp eq i32 %433, 0
  br i1 %434, label %lbl_37, label %lbl_38

lbl_37:
  store i1 1, ptr %426
  br label %lbl_39

lbl_38:
  %435 = add i64 %428, 1
  store i64 %435, ptr %427
  br label %lbl_35

lbl_39:
  %436 = load i1, ptr %426
  %437 = select i1 %436, ptr @.str.true, ptr @.str.false
  %439 = call i64 @strlen(ptr @.str.43)
  %440 = call i64 @strlen(ptr %437)
  %441 = add i64 %439, %440
  %442 = add i64 %441, 1
  %443 = call ptr @malloc(i64 %442)
  %444 = call ptr @strcpy(ptr %443, ptr @.str.43)
  %445 = call ptr @strcat(ptr %443, ptr %437)
  %446 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %443)
  call void @judul(ptr @.str.45)
  %447 = shl i64 1, 8
  %448 = call ptr @malloc(i64 32)
  %449 = call i32 (ptr, ptr, ...) @sprintf(ptr %448, ptr @.fmt.input_bilangan, i64 %447)
  %451 = call i64 @strlen(ptr @.str.46)
  %452 = call i64 @strlen(ptr %448)
  %453 = add i64 %451, %452
  %454 = add i64 %453, 1
  %455 = call ptr @malloc(i64 %454)
  %456 = call ptr @strcpy(ptr %455, ptr @.str.46)
  %457 = call ptr @strcat(ptr %455, ptr %448)
  %458 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %455)
  %459 = and i64 255, 15
  %460 = call ptr @malloc(i64 32)
  %461 = call i32 (ptr, ptr, ...) @sprintf(ptr %460, ptr @.fmt.input_bilangan, i64 %459)
  %463 = call i64 @strlen(ptr @.str.47)
  %464 = call i64 @strlen(ptr %460)
  %465 = add i64 %463, %464
  %466 = add i64 %465, 1
  %467 = call ptr @malloc(i64 %466)
  %468 = call ptr @strcpy(ptr %467, ptr @.str.47)
  %469 = call ptr @strcat(ptr %467, ptr %460)
  %470 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %467)
  %471 = xor i64 170, 85
  %472 = call ptr @malloc(i64 32)
  %473 = call i32 (ptr, ptr, ...) @sprintf(ptr %472, ptr @.fmt.input_bilangan, i64 %471)
  %475 = call i64 @strlen(ptr @.str.48)
  %476 = call i64 @strlen(ptr %472)
  %477 = add i64 %475, %476
  %478 = add i64 %477, 1
  %479 = call ptr @malloc(i64 %478)
  %480 = call ptr @strcpy(ptr %479, ptr @.str.48)
  %481 = call ptr @strcat(ptr %479, ptr %472)
  %482 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %479)
  %483 = call i64 @llvm.ctpop.i64(i64 255)
  %484 = call ptr @malloc(i64 32)
  %485 = call i32 (ptr, ptr, ...) @sprintf(ptr %484, ptr @.fmt.input_bilangan, i64 %483)
  %487 = call i64 @strlen(ptr @.str.49)
  %488 = call i64 @strlen(ptr %484)
  %489 = add i64 %487, %488
  %490 = add i64 %489, 1
  %491 = call ptr @malloc(i64 %490)
  %492 = call ptr @strcpy(ptr %491, ptr @.str.49)
  %493 = call ptr @strcat(ptr %491, ptr %484)
  %494 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %491)
  call void @judul(ptr @.str.50)
  %495 = add i64 2, 2
  %496 = icmp eq i64 %495, 4
  br i1 %496, label %lbl_40, label %lbl_41

lbl_40:
  %497 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.51)
  br label %lbl_42

lbl_41:
  %498 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.51)
  br label %lbl_42

lbl_42:
  %499 = icmp sgt i64 5, 10
  %500 = select i1 %499, i64 5, i64 10
  %501 = icmp eq i64 %500, 10
  br i1 %501, label %lbl_43, label %lbl_44

lbl_43:
  %502 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.52)
  br label %lbl_45

lbl_44:
  %503 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.52)
  br label %lbl_45

lbl_45:
  %504 = call ptr @strstr(ptr @.str.53, ptr @.str.54)
  %505 = icmp ne ptr %504, null
  br i1 %505, label %lbl_46, label %lbl_47

lbl_46:
  %506 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.55)
  br label %lbl_48

lbl_47:
  %507 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.55)
  br label %lbl_48

lbl_48:
  %508 = call i64 @strlen(ptr @.str.56)
  %509 = add i64 %508, 1
  %510 = call ptr @malloc(i64 %509)
  %511 = alloca i64
  store i64 0, ptr %511
  br label %lbl_49

lbl_49:
  %512 = load i64, ptr %511
  %513 = icmp slt i64 %512, %508
  br i1 %513, label %lbl_50, label %lbl_51

lbl_50:
  %514 = getelementptr i8, ptr @.str.56, i64 %512
  %515 = load i8, ptr %514
  %516 = sext i8 %515 to i32
  %517 = call i32 @toupper(i32 %516)
  %518 = trunc i32 %517 to i8
  %519 = getelementptr i8, ptr %510, i64 %512
  store i8 %518, ptr %519
  %520 = add i64 %512, 1
  store i64 %520, ptr %511
  br label %lbl_49

lbl_51:
  %521 = getelementptr i8, ptr %510, i64 %508
  store i8 0, ptr %521
  %522 = call i32 @strcmp(ptr %510, ptr @.str.57)
  %523 = icmp eq i32 %522, 0
  br i1 %523, label %lbl_52, label %lbl_53

lbl_52:
  %524 = call i32 (ptr, ...) @printf(ptr @.test.lulus, ptr @.str.58)
  br label %lbl_54

lbl_53:
  %525 = call i32 (ptr, ...) @printf(ptr @.test.gagal, ptr @.str.58)
  br label %lbl_54

lbl_54:
  %526 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %527 = call i64 @strlen(ptr @.str.59)
  %528 = add i64 %527, 32
  %529 = call ptr @malloc(i64 %528)
  %530 = call i32 (ptr, ptr, ...) @sprintf(ptr %529, ptr @.ansi.hijau, ptr @.str.59)
  %531 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %529)
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

