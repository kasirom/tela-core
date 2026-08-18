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

@.str.0 = private unnamed_addr constant [53 x i8] c"⚡ === PERKAKAS BARIS PERINTAH TELACORE CLI === ⚡\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"Jumlah argumen: \00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"ℹ️  Petunjuk Penggunaan:\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"   \00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c" <perintah> [opsi]\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"Contoh:\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"   \00", align 1
@.str.7 = private unnamed_addr constant [16 x i8] c" halo nusantara\00", align 1
@.str.8 = private unnamed_addr constant [29 x i8] c"✅ Daftar Argumen Diterima:\00", align 1
@.str.9 = private unnamed_addr constant [4 x i8] c"  [\00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c"] \00", align 1
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
  %10 = load i32, ptr @_tela_argc
  %11 = zext i32 %10 to i64
  %jumlah_12 = alloca i64
  store i64 %11, ptr %jumlah_12
  %13 = load i64, ptr %jumlah_12
  %14 = call ptr @malloc(i64 32)
  %15 = call i32 (ptr, ptr, ...) @sprintf(ptr %14, ptr @.fmt.input_bilangan, i64 %13)
  %17 = call i64 @strlen(ptr @.str.1)
  %18 = call i64 @strlen(ptr %14)
  %19 = add i64 %17, %18
  %20 = add i64 %19, 1
  %21 = call ptr @malloc(i64 %20)
  %22 = call ptr @strcpy(ptr %21, ptr @.str.1)
  %23 = call ptr @strcat(ptr %21, ptr %14)
  %24 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %21)
  %25 = load i64, ptr %jumlah_12
  %26 = icmp sle i64 %25, 1
  br i1 %26, label %lbl_1, label %lbl_2

lbl_1:
  %27 = call i64 @strlen(ptr @.str.2)
  %28 = add i64 %27, 32
  %29 = call ptr @malloc(i64 %28)
  %30 = call i32 (ptr, ptr, ...) @sprintf(ptr %29, ptr @.ansi.kuning, ptr @.str.2)
  %31 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %29)
  %32 = load i32, ptr @_tela_argc
  %33 = trunc i64 0 to i32
  %34 = icmp ult i32 %33, %32
  %35 = alloca ptr
  br i1 %34, label %lbl_4, label %lbl_5

lbl_4:
  %36 = load ptr, ptr @_tela_argv
  %37 = getelementptr ptr, ptr %36, i32 %33
  %38 = load ptr, ptr %37
  store ptr %38, ptr %35
  br label %lbl_6

lbl_5:
  store ptr @.str.empty, ptr %35
  br label %lbl_6

lbl_6:
  %39 = load ptr, ptr %35
  %41 = call i64 @strlen(ptr @.str.3)
  %42 = call i64 @strlen(ptr %39)
  %43 = add i64 %41, %42
  %44 = add i64 %43, 1
  %45 = call ptr @malloc(i64 %44)
  %46 = call ptr @strcpy(ptr %45, ptr @.str.3)
  %47 = call ptr @strcat(ptr %45, ptr %39)
  %49 = call i64 @strlen(ptr %45)
  %50 = call i64 @strlen(ptr @.str.4)
  %51 = add i64 %49, %50
  %52 = add i64 %51, 1
  %53 = call ptr @malloc(i64 %52)
  %54 = call ptr @strcpy(ptr %53, ptr %45)
  %55 = call ptr @strcat(ptr %53, ptr @.str.4)
  %56 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %53)
  %57 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.5)
  %58 = load i32, ptr @_tela_argc
  %59 = trunc i64 0 to i32
  %60 = icmp ult i32 %59, %58
  %61 = alloca ptr
  br i1 %60, label %lbl_7, label %lbl_8

lbl_7:
  %62 = load ptr, ptr @_tela_argv
  %63 = getelementptr ptr, ptr %62, i32 %59
  %64 = load ptr, ptr %63
  store ptr %64, ptr %61
  br label %lbl_9

lbl_8:
  store ptr @.str.empty, ptr %61
  br label %lbl_9

lbl_9:
  %65 = load ptr, ptr %61
  %67 = call i64 @strlen(ptr @.str.6)
  %68 = call i64 @strlen(ptr %65)
  %69 = add i64 %67, %68
  %70 = add i64 %69, 1
  %71 = call ptr @malloc(i64 %70)
  %72 = call ptr @strcpy(ptr %71, ptr @.str.6)
  %73 = call ptr @strcat(ptr %71, ptr %65)
  %75 = call i64 @strlen(ptr %71)
  %76 = call i64 @strlen(ptr @.str.7)
  %77 = add i64 %75, %76
  %78 = add i64 %77, 1
  %79 = call ptr @malloc(i64 %78)
  %80 = call ptr @strcpy(ptr %79, ptr %71)
  %81 = call ptr @strcat(ptr %79, ptr @.str.7)
  %82 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %79)
  br label %lbl_3

lbl_2:
  %83 = call i64 @strlen(ptr @.str.8)
  %84 = add i64 %83, 32
  %85 = call ptr @malloc(i64 %84)
  %86 = call i32 (ptr, ptr, ...) @sprintf(ptr %85, ptr @.ansi.hijau, ptr @.str.8)
  %87 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %85)
  %88 = load i64, ptr %jumlah_12
  %i_89 = alloca i64
  store i64 0, ptr %i_89
  br label %lbl_10

lbl_10:
  %tmp_90 = load i64, ptr %i_89
  %tmp_91 = icmp slt i64 %tmp_90, %88
  br i1 %tmp_91, label %lbl_11, label %lbl_12

lbl_11:
  %92 = load i64, ptr %i_89
  %93 = load i32, ptr @_tela_argc
  %94 = trunc i64 %92 to i32
  %95 = icmp ult i32 %94, %93
  %96 = alloca ptr
  br i1 %95, label %lbl_14, label %lbl_15

lbl_14:
  %97 = load ptr, ptr @_tela_argv
  %98 = getelementptr ptr, ptr %97, i32 %94
  %99 = load ptr, ptr %98
  store ptr %99, ptr %96
  br label %lbl_16

lbl_15:
  store ptr @.str.empty, ptr %96
  br label %lbl_16

lbl_16:
  %100 = load ptr, ptr %96
  %val_101 = alloca ptr
  store ptr %100, ptr %val_101
  %102 = load i64, ptr %i_89
  %103 = call ptr @malloc(i64 32)
  %104 = call i32 (ptr, ptr, ...) @sprintf(ptr %103, ptr @.fmt.input_bilangan, i64 %102)
  %106 = call i64 @strlen(ptr @.str.9)
  %107 = call i64 @strlen(ptr %103)
  %108 = add i64 %106, %107
  %109 = add i64 %108, 1
  %110 = call ptr @malloc(i64 %109)
  %111 = call ptr @strcpy(ptr %110, ptr @.str.9)
  %112 = call ptr @strcat(ptr %110, ptr %103)
  %114 = call i64 @strlen(ptr %110)
  %115 = call i64 @strlen(ptr @.str.10)
  %116 = add i64 %114, %115
  %117 = add i64 %116, 1
  %118 = call ptr @malloc(i64 %117)
  %119 = call ptr @strcpy(ptr %118, ptr %110)
  %120 = call ptr @strcat(ptr %118, ptr @.str.10)
  %121 = load ptr, ptr %val_101
  %123 = call i64 @strlen(ptr %118)
  %124 = call i64 @strlen(ptr %121)
  %125 = add i64 %123, %124
  %126 = add i64 %125, 1
  %127 = call ptr @malloc(i64 %126)
  %128 = call ptr @strcpy(ptr %127, ptr %118)
  %129 = call ptr @strcat(ptr %127, ptr %121)
  %130 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %127)
  br label %lbl_13

lbl_13:
  %tmp_131 = load i64, ptr %i_89
  %tmp_132 = add i64 %tmp_131, 1
  store i64 %tmp_132, ptr %i_89
  br label %lbl_10

lbl_12:
  br label %lbl_3

lbl_3:
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

