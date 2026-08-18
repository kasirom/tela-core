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
@_tela_argc = global i32 0, align 4
@_tela_argv = global ptr null, align 8
@.hex.byte_fmt = private unnamed_addr constant [5 x i8] c"%02x\00", align 1
@.str.mode_rb = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str.os_name = private unnamed_addr constant [8 x i8] c"Windows\00", align 1
@.str.arch_name = private unnamed_addr constant [7 x i8] c"x86_64\00", align 1
@.str.user_agent = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.empty = private unnamed_addr constant [1 x i8] c"\00", align 1
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

@.str.0 = private unnamed_addr constant [56 x i8] c"🔐 === SUITE KRIPTOGRAFI & KEAMANAN TELACORE === 🔐\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"Nusantara 2026\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c"Teks Sumber: \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\22\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\22\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"SHA-256\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.8 = private unnamed_addr constant [4 x i8] c"MD5\00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.11 = private unnamed_addr constant [10 x i8] c"DJB2 Hash\00", align 1
@.str.12 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.14 = private unnamed_addr constant [7 x i8] c"Base64\00", align 1
@.str.15 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.16 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.17 = private unnamed_addr constant [11 x i8] c"Hex String\00", align 1
@.str.18 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.19 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c"ROT13\00", align 1
@.str.21 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.22 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.23 = private unnamed_addr constant [57 x i8] c"✅ Seluruh kalkulasi kriptografi berhasil diselesaikan.\00", align 1
define void @utama() {
entry:
  %1 = call i64 @strlen(ptr @.str.0)
  %2 = add i64 %1, 32
  %3 = call ptr @malloc(i64 %2)
  %4 = call i32 (ptr, ptr, ...) @sprintf(ptr %3, ptr @.ansi.sian, ptr @.str.0)
  %5 = call i64 @strlen(ptr %3)
  %6 = add i64 %5, 32
  %7 = call ptr @malloc(i64 %6)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.ansi.tebal, ptr %3)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %7)
  %10 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %pesan_11 = alloca ptr
  store ptr @.str.1, ptr %pesan_11
  %12 = call i64 @strlen(ptr @.str.2)
  %13 = add i64 %12, 32
  %14 = call ptr @malloc(i64 %13)
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr @.ansi.kuning, ptr @.str.2)
  %17 = call i64 @strlen(ptr %14)
  %18 = call i64 @strlen(ptr @.str.3)
  %19 = add i64 %17, %18
  %20 = add i64 %19, 1
  %21 = call ptr @malloc(i64 %20)
  %22 = call ptr @strcpy(ptr %21, ptr %14)
  %23 = call ptr @strcat(ptr %21, ptr @.str.3)
  %24 = load ptr, ptr %pesan_11
  %26 = call i64 @strlen(ptr %21)
  %27 = call i64 @strlen(ptr %24)
  %28 = add i64 %26, %27
  %29 = add i64 %28, 1
  %30 = call ptr @malloc(i64 %29)
  %31 = call ptr @strcpy(ptr %30, ptr %21)
  %32 = call ptr @strcat(ptr %30, ptr %24)
  %34 = call i64 @strlen(ptr %30)
  %35 = call i64 @strlen(ptr @.str.4)
  %36 = add i64 %34, %35
  %37 = add i64 %36, 1
  %38 = call ptr @malloc(i64 %37)
  %39 = call ptr @strcpy(ptr %38, ptr %30)
  %40 = call ptr @strcat(ptr %38, ptr @.str.4)
  %41 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %38)
  %42 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %43 = load ptr, ptr %pesan_11
  %44 = alloca ptr
  %45 = alloca ptr
  %46 = alloca i32
  %47 = alloca [64 x i8]
  %48 = call i32 @CryptAcquireContextA(ptr %44, ptr null, ptr null, i32 24, i32 -268435456)
  %49 = load ptr, ptr %44
  %50 = call i32 @CryptCreateHash(ptr %49, i32 32780, ptr null, i32 0, ptr %45)
  %51 = load ptr, ptr %45
  %52 = call i64 @strlen(ptr %43)
  %53 = trunc i64 %52 to i32
  %54 = call i32 @CryptHashData(ptr %51, ptr %43, i32 %53, i32 0)
  store i32 32, ptr %46
  %55 = call i32 @CryptGetHashParam(ptr %51, i32 2, ptr %47, ptr %46, i32 0)
  %56 = call i32 @CryptDestroyHash(ptr %51)
  %57 = call i32 @CryptReleaseContext(ptr %49, i32 0)
  %58 = call ptr @malloc(i64 65)
  %59 = alloca i64
  store i64 0, ptr %59
  br label %lbl_1

lbl_1:
  %60 = load i64, ptr %59
  %61 = icmp slt i64 %60, 32
  br i1 %61, label %lbl_2, label %lbl_3

lbl_2:
  %62 = getelementptr [64 x i8], ptr %47, i64 0, i64 %60
  %63 = load i8, ptr %62
  %64 = zext i8 %63 to i32
  %65 = mul i64 %60, 2
  %66 = getelementptr i8, ptr %58, i64 %65
  %67 = call i32 (ptr, ptr, ...) @sprintf(ptr %66, ptr @.hex.byte_fmt, i32 %64)
  %68 = add i64 %60, 1
  store i64 %68, ptr %59
  br label %lbl_1

lbl_3:
  %69 = getelementptr i8, ptr %58, i64 64
  store i8 0, ptr %69
  %sha_70 = alloca ptr
  store ptr %58, ptr %sha_70
  %71 = call i64 @strlen(ptr @.str.5)
  %72 = icmp sge i64 %71, 12
  %73 = alloca ptr
  br i1 %72, label %lbl_4, label %lbl_5

lbl_4:
  %74 = add i64 %71, 1
  %75 = call ptr @malloc(i64 %74)
  %76 = call ptr @strcpy(ptr %75, ptr @.str.5)
  store ptr %75, ptr %73
  br label %lbl_6

lbl_5:
  %77 = load i8, ptr @.str.6
  %78 = add i64 12, 1
  %79 = call ptr @malloc(i64 %78)
  %80 = call ptr @strcpy(ptr %79, ptr @.str.5)
  %81 = alloca i64
  store i64 %71, ptr %81
  br label %lbl_7

lbl_7:
  %82 = load i64, ptr %81
  %83 = icmp slt i64 %82, 12
  br i1 %83, label %lbl_8, label %lbl_9

lbl_8:
  %84 = getelementptr i8, ptr %79, i64 %82
  store i8 %77, ptr %84
  %85 = add i64 %82, 1
  store i64 %85, ptr %81
  br label %lbl_7

lbl_9:
  %86 = getelementptr i8, ptr %79, i64 12
  store i8 0, ptr %86
  store ptr %79, ptr %73
  br label %lbl_6

lbl_6:
  %87 = load ptr, ptr %73
  %89 = call i64 @strlen(ptr %87)
  %90 = call i64 @strlen(ptr @.str.7)
  %91 = add i64 %89, %90
  %92 = add i64 %91, 1
  %93 = call ptr @malloc(i64 %92)
  %94 = call ptr @strcpy(ptr %93, ptr %87)
  %95 = call ptr @strcat(ptr %93, ptr @.str.7)
  %96 = load ptr, ptr %sha_70
  %98 = call i64 @strlen(ptr %93)
  %99 = call i64 @strlen(ptr %96)
  %100 = add i64 %98, %99
  %101 = add i64 %100, 1
  %102 = call ptr @malloc(i64 %101)
  %103 = call ptr @strcpy(ptr %102, ptr %93)
  %104 = call ptr @strcat(ptr %102, ptr %96)
  %105 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %102)
  %106 = load ptr, ptr %pesan_11
  %107 = alloca ptr
  %108 = alloca ptr
  %109 = alloca i32
  %110 = alloca [64 x i8]
  %111 = call i32 @CryptAcquireContextA(ptr %107, ptr null, ptr null, i32 24, i32 -268435456)
  %112 = load ptr, ptr %107
  %113 = call i32 @CryptCreateHash(ptr %112, i32 32771, ptr null, i32 0, ptr %108)
  %114 = load ptr, ptr %108
  %115 = call i64 @strlen(ptr %106)
  %116 = trunc i64 %115 to i32
  %117 = call i32 @CryptHashData(ptr %114, ptr %106, i32 %116, i32 0)
  store i32 16, ptr %109
  %118 = call i32 @CryptGetHashParam(ptr %114, i32 2, ptr %110, ptr %109, i32 0)
  %119 = call i32 @CryptDestroyHash(ptr %114)
  %120 = call i32 @CryptReleaseContext(ptr %112, i32 0)
  %121 = call ptr @malloc(i64 33)
  %122 = alloca i64
  store i64 0, ptr %122
  br label %lbl_10

lbl_10:
  %123 = load i64, ptr %122
  %124 = icmp slt i64 %123, 16
  br i1 %124, label %lbl_11, label %lbl_12

lbl_11:
  %125 = getelementptr [64 x i8], ptr %110, i64 0, i64 %123
  %126 = load i8, ptr %125
  %127 = zext i8 %126 to i32
  %128 = mul i64 %123, 2
  %129 = getelementptr i8, ptr %121, i64 %128
  %130 = call i32 (ptr, ptr, ...) @sprintf(ptr %129, ptr @.hex.byte_fmt, i32 %127)
  %131 = add i64 %123, 1
  store i64 %131, ptr %122
  br label %lbl_10

lbl_12:
  %132 = getelementptr i8, ptr %121, i64 32
  store i8 0, ptr %132
  %md5_val_133 = alloca ptr
  store ptr %121, ptr %md5_val_133
  %134 = call i64 @strlen(ptr @.str.8)
  %135 = icmp sge i64 %134, 12
  %136 = alloca ptr
  br i1 %135, label %lbl_13, label %lbl_14

lbl_13:
  %137 = add i64 %134, 1
  %138 = call ptr @malloc(i64 %137)
  %139 = call ptr @strcpy(ptr %138, ptr @.str.8)
  store ptr %138, ptr %136
  br label %lbl_15

lbl_14:
  %140 = load i8, ptr @.str.9
  %141 = add i64 12, 1
  %142 = call ptr @malloc(i64 %141)
  %143 = call ptr @strcpy(ptr %142, ptr @.str.8)
  %144 = alloca i64
  store i64 %134, ptr %144
  br label %lbl_16

lbl_16:
  %145 = load i64, ptr %144
  %146 = icmp slt i64 %145, 12
  br i1 %146, label %lbl_17, label %lbl_18

lbl_17:
  %147 = getelementptr i8, ptr %142, i64 %145
  store i8 %140, ptr %147
  %148 = add i64 %145, 1
  store i64 %148, ptr %144
  br label %lbl_16

lbl_18:
  %149 = getelementptr i8, ptr %142, i64 12
  store i8 0, ptr %149
  store ptr %142, ptr %136
  br label %lbl_15

lbl_15:
  %150 = load ptr, ptr %136
  %152 = call i64 @strlen(ptr %150)
  %153 = call i64 @strlen(ptr @.str.10)
  %154 = add i64 %152, %153
  %155 = add i64 %154, 1
  %156 = call ptr @malloc(i64 %155)
  %157 = call ptr @strcpy(ptr %156, ptr %150)
  %158 = call ptr @strcat(ptr %156, ptr @.str.10)
  %159 = load ptr, ptr %md5_val_133
  %161 = call i64 @strlen(ptr %156)
  %162 = call i64 @strlen(ptr %159)
  %163 = add i64 %161, %162
  %164 = add i64 %163, 1
  %165 = call ptr @malloc(i64 %164)
  %166 = call ptr @strcpy(ptr %165, ptr %156)
  %167 = call ptr @strcat(ptr %165, ptr %159)
  %168 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %165)
  %169 = load ptr, ptr %pesan_11
  %170 = call i64 @strlen(ptr %169)
  %171 = alloca i64
  store i64 5381, ptr %171
  %172 = alloca i64
  store i64 0, ptr %172
  br label %lbl_19

lbl_19:
  %173 = load i64, ptr %172
  %174 = icmp slt i64 %173, %170
  br i1 %174, label %lbl_20, label %lbl_21

lbl_20:
  %175 = getelementptr i8, ptr %169, i64 %173
  %176 = load i8, ptr %175
  %177 = zext i8 %176 to i64
  %178 = load i64, ptr %171
  %179 = shl i64 %178, 5
  %180 = add i64 %179, %178
  %181 = add i64 %180, %177
  store i64 %181, ptr %171
  %182 = add i64 %173, 1
  store i64 %182, ptr %172
  br label %lbl_19

lbl_21:
  %183 = load i64, ptr %171
  %djb_184 = alloca i64
  store i64 %183, ptr %djb_184
  %185 = call i64 @strlen(ptr @.str.11)
  %186 = icmp sge i64 %185, 12
  %187 = alloca ptr
  br i1 %186, label %lbl_22, label %lbl_23

lbl_22:
  %188 = add i64 %185, 1
  %189 = call ptr @malloc(i64 %188)
  %190 = call ptr @strcpy(ptr %189, ptr @.str.11)
  store ptr %189, ptr %187
  br label %lbl_24

lbl_23:
  %191 = load i8, ptr @.str.12
  %192 = add i64 12, 1
  %193 = call ptr @malloc(i64 %192)
  %194 = call ptr @strcpy(ptr %193, ptr @.str.11)
  %195 = alloca i64
  store i64 %185, ptr %195
  br label %lbl_25

lbl_25:
  %196 = load i64, ptr %195
  %197 = icmp slt i64 %196, 12
  br i1 %197, label %lbl_26, label %lbl_27

lbl_26:
  %198 = getelementptr i8, ptr %193, i64 %196
  store i8 %191, ptr %198
  %199 = add i64 %196, 1
  store i64 %199, ptr %195
  br label %lbl_25

lbl_27:
  %200 = getelementptr i8, ptr %193, i64 12
  store i8 0, ptr %200
  store ptr %193, ptr %187
  br label %lbl_24

lbl_24:
  %201 = load ptr, ptr %187
  %203 = call i64 @strlen(ptr %201)
  %204 = call i64 @strlen(ptr @.str.13)
  %205 = add i64 %203, %204
  %206 = add i64 %205, 1
  %207 = call ptr @malloc(i64 %206)
  %208 = call ptr @strcpy(ptr %207, ptr %201)
  %209 = call ptr @strcat(ptr %207, ptr @.str.13)
  %210 = load i64, ptr %djb_184
  %211 = call ptr @malloc(i64 32)
  %212 = call i32 (ptr, ptr, ...) @sprintf(ptr %211, ptr @.fmt.input_bilangan, i64 %210)
  %214 = call i64 @strlen(ptr %207)
  %215 = call i64 @strlen(ptr %211)
  %216 = add i64 %214, %215
  %217 = add i64 %216, 1
  %218 = call ptr @malloc(i64 %217)
  %219 = call ptr @strcpy(ptr %218, ptr %207)
  %220 = call ptr @strcat(ptr %218, ptr %211)
  %221 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %218)
  %222 = load ptr, ptr %pesan_11
  %223 = call i64 @strlen(ptr %222)
  %224 = add i64 %223, 2
  %225 = udiv i64 %224, 3
  %226 = mul i64 %225, 4
  %227 = add i64 %226, 1
  %228 = call ptr @malloc(i64 %227)
  %229 = alloca i64
  store i64 0, ptr %229
  %230 = alloca i64
  store i64 0, ptr %230
  br label %lbl_28

lbl_28:
  %231 = load i64, ptr %229
  %232 = icmp slt i64 %231, %223
  br i1 %232, label %lbl_29, label %lbl_30

lbl_29:
  %233 = getelementptr i8, ptr %222, i64 %231
  %234 = load i8, ptr %233
  %235 = zext i8 %234 to i32
  %236 = add i64 %231, 1
  %237 = icmp slt i64 %236, %223
  %238 = getelementptr i8, ptr %222, i64 %236
  %239 = select i1 %237, ptr %238, ptr @.fmt.newline
  %240 = load i8, ptr %239
  %241 = zext i8 %240 to i32
  %242 = select i1 %237, i32 %241, i32 0
  %243 = add i64 %231, 2
  %244 = icmp slt i64 %243, %223
  %245 = getelementptr i8, ptr %222, i64 %243
  %246 = select i1 %244, ptr %245, ptr @.fmt.newline
  %247 = load i8, ptr %246
  %248 = zext i8 %247 to i32
  %249 = select i1 %244, i32 %248, i32 0
  %250 = shl i32 %235, 16
  %251 = shl i32 %242, 8
  %252 = or i32 %250, %251
  %253 = or i32 %252, %249
  %254 = lshr i32 %253, 18
  %255 = and i32 %254, 63
  %256 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %255
  %257 = load i8, ptr %256
  %258 = lshr i32 %253, 12
  %259 = and i32 %258, 63
  %260 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %259
  %261 = load i8, ptr %260
  %262 = lshr i32 %253, 6
  %263 = and i32 %262, 63
  %264 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %263
  %265 = load i8, ptr %264
  %266 = select i1 %237, i8 %265, i8 61
  %267 = and i32 %253, 63
  %268 = getelementptr [65 x i8], ptr @.b64.table, i32 0, i32 %267
  %269 = load i8, ptr %268
  %270 = select i1 %244, i8 %269, i8 61
  %271 = load i64, ptr %230
  %272 = getelementptr i8, ptr %228, i64 %271
  store i8 %257, ptr %272
  %273 = getelementptr i8, ptr %272, i64 1
  store i8 %261, ptr %273
  %274 = getelementptr i8, ptr %272, i64 2
  store i8 %266, ptr %274
  %275 = getelementptr i8, ptr %272, i64 3
  store i8 %270, ptr %275
  %276 = add i64 %231, 3
  store i64 %276, ptr %229
  %277 = add i64 %271, 4
  store i64 %277, ptr %230
  br label %lbl_28

lbl_30:
  %278 = load i64, ptr %230
  %279 = getelementptr i8, ptr %228, i64 %278
  store i8 0, ptr %279
  %b64_280 = alloca ptr
  store ptr %228, ptr %b64_280
  %281 = call i64 @strlen(ptr @.str.14)
  %282 = icmp sge i64 %281, 12
  %283 = alloca ptr
  br i1 %282, label %lbl_31, label %lbl_32

lbl_31:
  %284 = add i64 %281, 1
  %285 = call ptr @malloc(i64 %284)
  %286 = call ptr @strcpy(ptr %285, ptr @.str.14)
  store ptr %285, ptr %283
  br label %lbl_33

lbl_32:
  %287 = load i8, ptr @.str.15
  %288 = add i64 12, 1
  %289 = call ptr @malloc(i64 %288)
  %290 = call ptr @strcpy(ptr %289, ptr @.str.14)
  %291 = alloca i64
  store i64 %281, ptr %291
  br label %lbl_34

lbl_34:
  %292 = load i64, ptr %291
  %293 = icmp slt i64 %292, 12
  br i1 %293, label %lbl_35, label %lbl_36

lbl_35:
  %294 = getelementptr i8, ptr %289, i64 %292
  store i8 %287, ptr %294
  %295 = add i64 %292, 1
  store i64 %295, ptr %291
  br label %lbl_34

lbl_36:
  %296 = getelementptr i8, ptr %289, i64 12
  store i8 0, ptr %296
  store ptr %289, ptr %283
  br label %lbl_33

lbl_33:
  %297 = load ptr, ptr %283
  %299 = call i64 @strlen(ptr %297)
  %300 = call i64 @strlen(ptr @.str.16)
  %301 = add i64 %299, %300
  %302 = add i64 %301, 1
  %303 = call ptr @malloc(i64 %302)
  %304 = call ptr @strcpy(ptr %303, ptr %297)
  %305 = call ptr @strcat(ptr %303, ptr @.str.16)
  %306 = load ptr, ptr %b64_280
  %308 = call i64 @strlen(ptr %303)
  %309 = call i64 @strlen(ptr %306)
  %310 = add i64 %308, %309
  %311 = add i64 %310, 1
  %312 = call ptr @malloc(i64 %311)
  %313 = call ptr @strcpy(ptr %312, ptr %303)
  %314 = call ptr @strcat(ptr %312, ptr %306)
  %315 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %312)
  %316 = load ptr, ptr %pesan_11
  %317 = call i64 @strlen(ptr %316)
  %318 = shl i64 %317, 1
  %319 = add i64 %318, 1
  %320 = call ptr @malloc(i64 %319)
  %321 = alloca i64
  store i64 0, ptr %321
  br label %lbl_37

lbl_37:
  %322 = load i64, ptr %321
  %323 = icmp slt i64 %322, %317
  br i1 %323, label %lbl_38, label %lbl_39

lbl_38:
  %324 = getelementptr i8, ptr %316, i64 %322
  %325 = load i8, ptr %324
  %326 = zext i8 %325 to i64
  %327 = lshr i64 %326, 4
  %328 = and i64 %326, 15
  %329 = getelementptr [17 x i8], ptr @.hex.chars, i64 0, i64 %327
  %330 = load i8, ptr %329
  %331 = getelementptr [17 x i8], ptr @.hex.chars, i64 0, i64 %328
  %332 = load i8, ptr %331
  %333 = shl i64 %322, 1
  %334 = add i64 %333, 1
  %335 = getelementptr i8, ptr %320, i64 %333
  store i8 %330, ptr %335
  %336 = getelementptr i8, ptr %320, i64 %334
  store i8 %332, ptr %336
  %337 = add i64 %322, 1
  store i64 %337, ptr %321
  br label %lbl_37

lbl_39:
  %338 = getelementptr i8, ptr %320, i64 %318
  store i8 0, ptr %338
  %hex_339 = alloca ptr
  store ptr %320, ptr %hex_339
  %340 = call i64 @strlen(ptr @.str.17)
  %341 = icmp sge i64 %340, 12
  %342 = alloca ptr
  br i1 %341, label %lbl_40, label %lbl_41

lbl_40:
  %343 = add i64 %340, 1
  %344 = call ptr @malloc(i64 %343)
  %345 = call ptr @strcpy(ptr %344, ptr @.str.17)
  store ptr %344, ptr %342
  br label %lbl_42

lbl_41:
  %346 = load i8, ptr @.str.18
  %347 = add i64 12, 1
  %348 = call ptr @malloc(i64 %347)
  %349 = call ptr @strcpy(ptr %348, ptr @.str.17)
  %350 = alloca i64
  store i64 %340, ptr %350
  br label %lbl_43

lbl_43:
  %351 = load i64, ptr %350
  %352 = icmp slt i64 %351, 12
  br i1 %352, label %lbl_44, label %lbl_45

lbl_44:
  %353 = getelementptr i8, ptr %348, i64 %351
  store i8 %346, ptr %353
  %354 = add i64 %351, 1
  store i64 %354, ptr %350
  br label %lbl_43

lbl_45:
  %355 = getelementptr i8, ptr %348, i64 12
  store i8 0, ptr %355
  store ptr %348, ptr %342
  br label %lbl_42

lbl_42:
  %356 = load ptr, ptr %342
  %358 = call i64 @strlen(ptr %356)
  %359 = call i64 @strlen(ptr @.str.19)
  %360 = add i64 %358, %359
  %361 = add i64 %360, 1
  %362 = call ptr @malloc(i64 %361)
  %363 = call ptr @strcpy(ptr %362, ptr %356)
  %364 = call ptr @strcat(ptr %362, ptr @.str.19)
  %365 = load ptr, ptr %hex_339
  %367 = call i64 @strlen(ptr %362)
  %368 = call i64 @strlen(ptr %365)
  %369 = add i64 %367, %368
  %370 = add i64 %369, 1
  %371 = call ptr @malloc(i64 %370)
  %372 = call ptr @strcpy(ptr %371, ptr %362)
  %373 = call ptr @strcat(ptr %371, ptr %365)
  %374 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %371)
  %375 = load ptr, ptr %pesan_11
  %376 = call i64 @strlen(ptr %375)
  %377 = add i64 %376, 1
  %378 = call ptr @malloc(i64 %377)
  %379 = alloca i64
  store i64 0, ptr %379
  br label %lbl_46

lbl_46:
  %380 = load i64, ptr %379
  %381 = icmp slt i64 %380, %376
  br i1 %381, label %lbl_47, label %lbl_48

lbl_47:
  %382 = getelementptr i8, ptr %375, i64 %380
  %383 = load i8, ptr %382
  %384 = icmp sge i8 %383, 97
  %385 = icmp sle i8 %383, 122
  %386 = and i1 %384, %385
  %387 = icmp sge i8 %383, 65
  %388 = icmp sle i8 %383, 90
  %389 = and i1 %387, %388
  %390 = sub i8 %383, 97
  %391 = add i8 %390, 13
  %392 = srem i8 %391, 26
  %393 = add i8 %392, 97
  %394 = sub i8 %383, 65
  %395 = add i8 %394, 13
  %396 = srem i8 %395, 26
  %397 = add i8 %396, 65
  %398 = select i1 %386, i8 %393, i8 %383
  %399 = select i1 %389, i8 %397, i8 %398
  %400 = getelementptr i8, ptr %378, i64 %380
  store i8 %399, ptr %400
  %401 = add i64 %380, 1
  store i64 %401, ptr %379
  br label %lbl_46

lbl_48:
  %402 = getelementptr i8, ptr %378, i64 %376
  store i8 0, ptr %402
  %rot_403 = alloca ptr
  store ptr %378, ptr %rot_403
  %404 = call i64 @strlen(ptr @.str.20)
  %405 = icmp sge i64 %404, 12
  %406 = alloca ptr
  br i1 %405, label %lbl_49, label %lbl_50

lbl_49:
  %407 = add i64 %404, 1
  %408 = call ptr @malloc(i64 %407)
  %409 = call ptr @strcpy(ptr %408, ptr @.str.20)
  store ptr %408, ptr %406
  br label %lbl_51

lbl_50:
  %410 = load i8, ptr @.str.21
  %411 = add i64 12, 1
  %412 = call ptr @malloc(i64 %411)
  %413 = call ptr @strcpy(ptr %412, ptr @.str.20)
  %414 = alloca i64
  store i64 %404, ptr %414
  br label %lbl_52

lbl_52:
  %415 = load i64, ptr %414
  %416 = icmp slt i64 %415, 12
  br i1 %416, label %lbl_53, label %lbl_54

lbl_53:
  %417 = getelementptr i8, ptr %412, i64 %415
  store i8 %410, ptr %417
  %418 = add i64 %415, 1
  store i64 %418, ptr %414
  br label %lbl_52

lbl_54:
  %419 = getelementptr i8, ptr %412, i64 12
  store i8 0, ptr %419
  store ptr %412, ptr %406
  br label %lbl_51

lbl_51:
  %420 = load ptr, ptr %406
  %422 = call i64 @strlen(ptr %420)
  %423 = call i64 @strlen(ptr @.str.22)
  %424 = add i64 %422, %423
  %425 = add i64 %424, 1
  %426 = call ptr @malloc(i64 %425)
  %427 = call ptr @strcpy(ptr %426, ptr %420)
  %428 = call ptr @strcat(ptr %426, ptr @.str.22)
  %429 = load ptr, ptr %rot_403
  %431 = call i64 @strlen(ptr %426)
  %432 = call i64 @strlen(ptr %429)
  %433 = add i64 %431, %432
  %434 = add i64 %433, 1
  %435 = call ptr @malloc(i64 %434)
  %436 = call ptr @strcpy(ptr %435, ptr %426)
  %437 = call ptr @strcat(ptr %435, ptr %429)
  %438 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %435)
  %439 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %440 = call i64 @strlen(ptr @.str.23)
  %441 = add i64 %440, 32
  %442 = call ptr @malloc(i64 %441)
  %443 = call i32 (ptr, ptr, ...) @sprintf(ptr %442, ptr @.ansi.hijau, ptr @.str.23)
  %444 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %442)
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

