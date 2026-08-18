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
declare i32 @system(ptr)
@_tela_argc = global i32 0, align 4
@_tela_argv = global ptr null, align 8
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

@.str.0 = private unnamed_addr constant [49 x i8] c"🌐 === KLIEN REST API & JSON TELACORE === 🌐\00", align 1
@.str.1 = private unnamed_addr constant [24 x i8] c"https://httpbin.org/get\00", align 1
@.str.2 = private unnamed_addr constant [28 x i8] c"📡 Mengirim HTTP GET ke: \00", align 1
@.str.3 = private unnamed_addr constant [1 x i8] c"\00", align 1
@.str.4 = private unnamed_addr constant [53 x i8] c"❌ Gagal terhubung ke jaringan atau server offline.\00", align 1
@.str.5 = private unnamed_addr constant [26 x i8] c"✅ Respon HTTP Diterima:\00", align 1
@.str.6 = private unnamed_addr constant [32 x i8] c"🔐 Informasi Keamanan & Hash:\00", align 1
@.str.7 = private unnamed_addr constant [15 x i8] c"  DJB2 Hash : \00", align 1
@.str.8 = private unnamed_addr constant [21 x i8] c"TelaCore Rest Client\00", align 1
@.str.9 = private unnamed_addr constant [15 x i8] c"  Header Hex: \00", align 1
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
  %url_11 = alloca ptr
  store ptr @.str.1, ptr %url_11
  %12 = call i64 @strlen(ptr @.str.2)
  %13 = add i64 %12, 32
  %14 = call ptr @malloc(i64 %13)
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr @.ansi.kuning, ptr @.str.2)
  %16 = load ptr, ptr %url_11
  %18 = call i64 @strlen(ptr %14)
  %19 = call i64 @strlen(ptr %16)
  %20 = add i64 %18, %19
  %21 = add i64 %20, 1
  %22 = call ptr @malloc(i64 %21)
  %23 = call ptr @strcpy(ptr %22, ptr %14)
  %24 = call ptr @strcat(ptr %22, ptr %16)
  %25 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %22)
  %26 = load ptr, ptr %url_11
  %27 = call ptr @InternetOpenA(ptr @.str.user_agent, i32 1, ptr null, ptr null, i32 0)
  %28 = icmp eq ptr %27, null
  %29 = alloca ptr
  br i1 %28, label %lbl_2, label %lbl_1

lbl_2:
  store ptr @.str.empty, ptr %29
  br label %lbl_3

lbl_1:
  %30 = call ptr @InternetOpenUrlA(ptr %27, ptr %26, ptr null, i32 0, i32 -2147483648, i64 0)
  %31 = icmp eq ptr %30, null
  br i1 %31, label %lbl_5, label %lbl_4

lbl_5:
  %32 = call i32 @InternetCloseHandle(ptr %27)
  store ptr @.str.empty, ptr %29
  br label %lbl_3

lbl_4:
  %33 = call ptr @malloc(i64 65536)
  %34 = alloca i32
  %35 = call i32 @InternetReadFile(ptr %30, ptr %33, i32 65535, ptr %34)
  %36 = load i32, ptr %34
  %37 = zext i32 %36 to i64
  %38 = getelementptr i8, ptr %33, i64 %37
  store i8 0, ptr %38
  %39 = call i32 @InternetCloseHandle(ptr %30)
  %40 = call i32 @InternetCloseHandle(ptr %27)
  store ptr %33, ptr %29
  br label %lbl_3

lbl_3:
  %41 = load ptr, ptr %29
  %respon_42 = alloca ptr
  store ptr %41, ptr %respon_42
  %43 = load ptr, ptr %respon_42
  %45 = call i32 @strcmp(ptr %43, ptr @.str.3)
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %lbl_6, label %lbl_7

lbl_6:
  %47 = call i64 @strlen(ptr @.str.4)
  %48 = add i64 %47, 32
  %49 = call ptr @malloc(i64 %48)
  %50 = call i32 (ptr, ptr, ...) @sprintf(ptr %49, ptr @.ansi.merah, ptr @.str.4)
  %51 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %49)
  br label %lbl_8

lbl_7:
  %52 = call i64 @strlen(ptr @.str.5)
  %53 = add i64 %52, 32
  %54 = call ptr @malloc(i64 %53)
  %55 = call i32 (ptr, ptr, ...) @sprintf(ptr %54, ptr @.ansi.hijau, ptr @.str.5)
  %56 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %54)
  %57 = load ptr, ptr %respon_42
  %58 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %57)
  %59 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %60 = call i64 @strlen(ptr @.str.6)
  %61 = add i64 %60, 32
  %62 = call ptr @malloc(i64 %61)
  %63 = call i32 (ptr, ptr, ...) @sprintf(ptr %62, ptr @.ansi.sian, ptr @.str.6)
  %64 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %62)
  %65 = load ptr, ptr %respon_42
  %66 = call i64 @strlen(ptr %65)
  %67 = alloca i64
  store i64 5381, ptr %67
  %68 = alloca i64
  store i64 0, ptr %68
  br label %lbl_9

lbl_9:
  %69 = load i64, ptr %68
  %70 = icmp slt i64 %69, %66
  br i1 %70, label %lbl_10, label %lbl_11

lbl_10:
  %71 = getelementptr i8, ptr %65, i64 %69
  %72 = load i8, ptr %71
  %73 = zext i8 %72 to i64
  %74 = load i64, ptr %67
  %75 = shl i64 %74, 5
  %76 = add i64 %75, %74
  %77 = add i64 %76, %73
  store i64 %77, ptr %67
  %78 = add i64 %69, 1
  store i64 %78, ptr %68
  br label %lbl_9

lbl_11:
  %79 = load i64, ptr %67
  %hash_80 = alloca i64
  store i64 %79, ptr %hash_80
  %81 = load i64, ptr %hash_80
  %82 = call ptr @malloc(i64 32)
  %83 = call i32 (ptr, ptr, ...) @sprintf(ptr %82, ptr @.fmt.input_bilangan, i64 %81)
  %85 = call i64 @strlen(ptr @.str.7)
  %86 = call i64 @strlen(ptr %82)
  %87 = add i64 %85, %86
  %88 = add i64 %87, 1
  %89 = call ptr @malloc(i64 %88)
  %90 = call ptr @strcpy(ptr %89, ptr @.str.7)
  %91 = call ptr @strcat(ptr %89, ptr %82)
  %92 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %89)
  %93 = call i64 @strlen(ptr @.str.8)
  %94 = shl i64 %93, 1
  %95 = add i64 %94, 1
  %96 = call ptr @malloc(i64 %95)
  %97 = alloca i64
  store i64 0, ptr %97
  br label %lbl_12

lbl_12:
  %98 = load i64, ptr %97
  %99 = icmp slt i64 %98, %93
  br i1 %99, label %lbl_13, label %lbl_14

lbl_13:
  %100 = getelementptr i8, ptr @.str.8, i64 %98
  %101 = load i8, ptr %100
  %102 = zext i8 %101 to i64
  %103 = lshr i64 %102, 4
  %104 = and i64 %102, 15
  %105 = getelementptr [17 x i8], ptr @.hex.chars, i64 0, i64 %103
  %106 = load i8, ptr %105
  %107 = getelementptr [17 x i8], ptr @.hex.chars, i64 0, i64 %104
  %108 = load i8, ptr %107
  %109 = shl i64 %98, 1
  %110 = add i64 %109, 1
  %111 = getelementptr i8, ptr %96, i64 %109
  store i8 %106, ptr %111
  %112 = getelementptr i8, ptr %96, i64 %110
  store i8 %108, ptr %112
  %113 = add i64 %98, 1
  store i64 %113, ptr %97
  br label %lbl_12

lbl_14:
  %114 = getelementptr i8, ptr %96, i64 %94
  store i8 0, ptr %114
  %hex_val_115 = alloca ptr
  store ptr %96, ptr %hex_val_115
  %116 = load ptr, ptr %hex_val_115
  %118 = call i64 @strlen(ptr @.str.9)
  %119 = call i64 @strlen(ptr %116)
  %120 = add i64 %118, %119
  %121 = add i64 %120, 1
  %122 = call ptr @malloc(i64 %121)
  %123 = call ptr @strcpy(ptr %122, ptr @.str.9)
  %124 = call ptr @strcat(ptr %122, ptr %116)
  %125 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %122)
  br label %lbl_8

lbl_8:
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

