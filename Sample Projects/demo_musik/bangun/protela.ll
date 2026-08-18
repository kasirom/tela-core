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

@.str.0 = private unnamed_addr constant [47 x i8] c"🎵 === PEMUTAR NADA MELODI TELACORE === 🎵\00", align 1
@.str.1 = private unnamed_addr constant [64 x i8] c"Memainkan tangga nada Do - Re - Mi - Fa - Sol - La - Si - Do...\00", align 1
@.str.2 = private unnamed_addr constant [17 x i8] c"🎶 Do (261 Hz)\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"🎶 Re (294 Hz)\00", align 1
@.str.4 = private unnamed_addr constant [17 x i8] c"🎶 Mi (329 Hz)\00", align 1
@.str.5 = private unnamed_addr constant [17 x i8] c"🎶 Fa (349 Hz)\00", align 1
@.str.6 = private unnamed_addr constant [18 x i8] c"🎶 Sol (392 Hz)\00", align 1
@.str.7 = private unnamed_addr constant [17 x i8] c"🎶 La (440 Hz)\00", align 1
@.str.8 = private unnamed_addr constant [17 x i8] c"🎶 Si (493 Hz)\00", align 1
@.str.9 = private unnamed_addr constant [24 x i8] c"🎶 Do Tinggi (523 Hz)\00", align 1
@.str.10 = private unnamed_addr constant [30 x i8] c"✨ Melodi selesai dimainkan!\00", align 1
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
  %10 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %NADA_DO_12 = alloca i64
  store i64 261, ptr %NADA_DO_12
  %NADA_RE_13 = alloca i64
  store i64 294, ptr %NADA_RE_13
  %NADA_MI_14 = alloca i64
  store i64 329, ptr %NADA_MI_14
  %NADA_FA_15 = alloca i64
  store i64 349, ptr %NADA_FA_15
  %NADA_SOL_16 = alloca i64
  store i64 392, ptr %NADA_SOL_16
  %NADA_LA_17 = alloca i64
  store i64 440, ptr %NADA_LA_17
  %NADA_SI_18 = alloca i64
  store i64 493, ptr %NADA_SI_18
  %NADA_DO_TINGGI_19 = alloca i64
  store i64 523, ptr %NADA_DO_TINGGI_19
  %20 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.2)
  %21 = load i64, ptr %NADA_DO_12
  %22 = trunc i64 %21 to i32
  %23 = trunc i64 300 to i32
  %24 = call i32 @Beep(i32 %22, i32 %23)
  %25 = trunc i64 50 to i32
  call void @Sleep(i32 %25)
  %26 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.3)
  %27 = load i64, ptr %NADA_RE_13
  %28 = trunc i64 %27 to i32
  %29 = trunc i64 300 to i32
  %30 = call i32 @Beep(i32 %28, i32 %29)
  %31 = trunc i64 50 to i32
  call void @Sleep(i32 %31)
  %32 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.4)
  %33 = load i64, ptr %NADA_MI_14
  %34 = trunc i64 %33 to i32
  %35 = trunc i64 300 to i32
  %36 = call i32 @Beep(i32 %34, i32 %35)
  %37 = trunc i64 50 to i32
  call void @Sleep(i32 %37)
  %38 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.5)
  %39 = load i64, ptr %NADA_FA_15
  %40 = trunc i64 %39 to i32
  %41 = trunc i64 300 to i32
  %42 = call i32 @Beep(i32 %40, i32 %41)
  %43 = trunc i64 50 to i32
  call void @Sleep(i32 %43)
  %44 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.6)
  %45 = load i64, ptr %NADA_SOL_16
  %46 = trunc i64 %45 to i32
  %47 = trunc i64 300 to i32
  %48 = call i32 @Beep(i32 %46, i32 %47)
  %49 = trunc i64 50 to i32
  call void @Sleep(i32 %49)
  %50 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.7)
  %51 = load i64, ptr %NADA_LA_17
  %52 = trunc i64 %51 to i32
  %53 = trunc i64 300 to i32
  %54 = call i32 @Beep(i32 %52, i32 %53)
  %55 = trunc i64 50 to i32
  call void @Sleep(i32 %55)
  %56 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.8)
  %57 = load i64, ptr %NADA_SI_18
  %58 = trunc i64 %57 to i32
  %59 = trunc i64 300 to i32
  %60 = call i32 @Beep(i32 %58, i32 %59)
  %61 = trunc i64 50 to i32
  call void @Sleep(i32 %61)
  %62 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.9)
  %63 = load i64, ptr %NADA_DO_TINGGI_19
  %64 = trunc i64 %63 to i32
  %65 = trunc i64 600 to i32
  %66 = call i32 @Beep(i32 %64, i32 %65)
  %67 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %68 = call i64 @strlen(ptr @.str.10)
  %69 = add i64 %68, 32
  %70 = call ptr @malloc(i64 %69)
  %71 = call i32 (ptr, ptr, ...) @sprintf(ptr %70, ptr @.ansi.hijau, ptr @.str.10)
  %72 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %70)
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

