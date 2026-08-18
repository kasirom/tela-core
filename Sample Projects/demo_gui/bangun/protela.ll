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
@.str.user_agent = private unnamed_addr constant [9 x i8] c"TelaCore\00", align 1
@.str.empty = private unnamed_addr constant [1 x i8] c"\00", align 1
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

@.str.0 = private unnamed_addr constant [15 x i8] c"Selamat Datang\00", align 1
@.str.1 = private unnamed_addr constant [58 x i8] c"Aplikasi Desktop TelaCore GUI Native Berhasil Dijalankan!\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"Konfirmasi\00", align 1
@.str.3 = private unnamed_addr constant [41 x i8] c"Apakah Anda ingin melanjutkan pengujian?\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"Informasi\00", align 1
@.str.5 = private unnamed_addr constant [38 x i8] c"Anda memilih 'Ya'! Memproses tugas...\00", align 1
@.str.6 = private unnamed_addr constant [37 x i8] c"[OK] Pengguna menyetujui konfirmasi.\00", align 1
@.str.7 = private unnamed_addr constant [11 x i8] c"Dibatalkan\00", align 1
@.str.8 = private unnamed_addr constant [40 x i8] c"Operasi telah dibatalkan oleh pengguna.\00", align 1
@.str.9 = private unnamed_addr constant [37 x i8] c"[INFO] Pengguna membatalkan operasi.\00", align 1
define void @utama() {
entry:
  %1 = call i32 @MessageBoxA(ptr null, ptr @.str.1, ptr @.str.0, i32 64)
  %2 = call i32 @MessageBoxA(ptr null, ptr @.str.3, ptr @.str.2, i32 36)
  %3 = icmp eq i32 %2, 6
  %setuju_4 = alloca i1
  store i1 %3, ptr %setuju_4
  %5 = load i1, ptr %setuju_4
  br i1 %5, label %lbl_1, label %lbl_2

lbl_1:
  %6 = call i32 @MessageBoxA(ptr null, ptr @.str.5, ptr @.str.4, i32 48)
  %7 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.6)
  br label %lbl_3

lbl_2:
  %8 = call i32 @MessageBoxA(ptr null, ptr @.str.8, ptr @.str.7, i32 16)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.9)
  br label %lbl_3

lbl_3:
  ret void
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

