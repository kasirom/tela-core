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
@_tela_argc = global i32 0, align 4
@_tela_argv = global ptr null, align 8
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

@.str.0 = private unnamed_addr constant [55 x i8] c"📁 === UTILITAS SISTEM BERKAS & OS TELACORE === 📁\00", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"🖥️  Informasi Sistem Operasi:\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"  OS         : \00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"  Arsitektur : \00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"  Uptime (ms): \00", align 1
@.str.5 = private unnamed_addr constant [9 x i8] c"data_uji\00", align 1
@.str.6 = private unnamed_addr constant [21 x i8] c"data_uji/catatan.txt\00", align 1
@.str.7 = private unnamed_addr constant [28 x i8] c"data_uji/catatan_backup.txt\00", align 1
@.str.8 = private unnamed_addr constant [30 x i8] c"📂 Mengelola Folder & File:\00", align 1
@.str.9 = private unnamed_addr constant [15 x i8] c"  ✅ Folder '\00", align 1
@.str.10 = private unnamed_addr constant [19 x i8] c"' berhasil dibuat.\00", align 1
@.str.11 = private unnamed_addr constant [19 x i8] c"  ℹ️  Folder '\00", align 1
@.str.12 = private unnamed_addr constant [13 x i8] c"' sudah ada.\00", align 1
@.str.13 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.14 = private unnamed_addr constant [57 x i8] c"Halo dari TelaCore File Manager!\0ABaris kedua data teks.\0A\00", align 1
@.str.15 = private unnamed_addr constant [15 x i8] c"  ✅ Berkas '\00", align 1
@.str.16 = private unnamed_addr constant [20 x i8] c"' berhasil ditulis.\00", align 1
@.str.17 = private unnamed_addr constant [23 x i8] c"  📊 Ukuran berkas: \00", align 1
@.str.18 = private unnamed_addr constant [7 x i8] c" bytes\00", align 1
@.str.19 = private unnamed_addr constant [35 x i8] c"  ✅ Berkas berhasil disalin ke '\00", align 1
@.str.20 = private unnamed_addr constant [3 x i8] c"'.\00", align 1
@.str.21 = private unnamed_addr constant [25 x i8] c"📄 Isi Berkas Salinan:\00", align 1
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
  %11 = call i64 @strlen(ptr @.str.1)
  %12 = add i64 %11, 32
  %13 = call ptr @malloc(i64 %12)
  %14 = call i32 (ptr, ptr, ...) @sprintf(ptr %13, ptr @.ansi.kuning, ptr @.str.1)
  %15 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %13)
  %17 = call i64 @strlen(ptr @.str.2)
  %18 = call i64 @strlen(ptr @.str.os_name)
  %19 = add i64 %17, %18
  %20 = add i64 %19, 1
  %21 = call ptr @malloc(i64 %20)
  %22 = call ptr @strcpy(ptr %21, ptr @.str.2)
  %23 = call ptr @strcat(ptr %21, ptr @.str.os_name)
  %24 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %21)
  %26 = call i64 @strlen(ptr @.str.3)
  %27 = call i64 @strlen(ptr @.str.arch_name)
  %28 = add i64 %26, %27
  %29 = add i64 %28, 1
  %30 = call ptr @malloc(i64 %29)
  %31 = call ptr @strcpy(ptr %30, ptr @.str.3)
  %32 = call ptr @strcat(ptr %30, ptr @.str.arch_name)
  %33 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %30)
  %34 = call i64 @GetTickCount64()
  %35 = call ptr @malloc(i64 32)
  %36 = call i32 (ptr, ptr, ...) @sprintf(ptr %35, ptr @.fmt.input_bilangan, i64 %34)
  %38 = call i64 @strlen(ptr @.str.4)
  %39 = call i64 @strlen(ptr %35)
  %40 = add i64 %38, %39
  %41 = add i64 %40, 1
  %42 = call ptr @malloc(i64 %41)
  %43 = call ptr @strcpy(ptr %42, ptr @.str.4)
  %44 = call ptr @strcat(ptr %42, ptr %35)
  %45 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %42)
  %46 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %folder_47 = alloca ptr
  store ptr @.str.5, ptr %folder_47
  %file_asal_48 = alloca ptr
  store ptr @.str.6, ptr %file_asal_48
  %file_salin_49 = alloca ptr
  store ptr @.str.7, ptr %file_salin_49
  %50 = call i64 @strlen(ptr @.str.8)
  %51 = add i64 %50, 32
  %52 = call ptr @malloc(i64 %51)
  %53 = call i32 (ptr, ptr, ...) @sprintf(ptr %52, ptr @.ansi.kuning, ptr @.str.8)
  %54 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %52)
  %55 = load ptr, ptr %folder_47
  %56 = call i32 @CreateDirectoryA(ptr %55, ptr null)
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %lbl_1, label %lbl_2

lbl_1:
  %58 = load ptr, ptr %folder_47
  %60 = call i64 @strlen(ptr @.str.9)
  %61 = call i64 @strlen(ptr %58)
  %62 = add i64 %60, %61
  %63 = add i64 %62, 1
  %64 = call ptr @malloc(i64 %63)
  %65 = call ptr @strcpy(ptr %64, ptr @.str.9)
  %66 = call ptr @strcat(ptr %64, ptr %58)
  %68 = call i64 @strlen(ptr %64)
  %69 = call i64 @strlen(ptr @.str.10)
  %70 = add i64 %68, %69
  %71 = add i64 %70, 1
  %72 = call ptr @malloc(i64 %71)
  %73 = call ptr @strcpy(ptr %72, ptr %64)
  %74 = call ptr @strcat(ptr %72, ptr @.str.10)
  %75 = call i64 @strlen(ptr %72)
  %76 = add i64 %75, 32
  %77 = call ptr @malloc(i64 %76)
  %78 = call i32 (ptr, ptr, ...) @sprintf(ptr %77, ptr @.ansi.hijau, ptr %72)
  %79 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %77)
  br label %lbl_3

lbl_2:
  %80 = load ptr, ptr %folder_47
  %82 = call i64 @strlen(ptr @.str.11)
  %83 = call i64 @strlen(ptr %80)
  %84 = add i64 %82, %83
  %85 = add i64 %84, 1
  %86 = call ptr @malloc(i64 %85)
  %87 = call ptr @strcpy(ptr %86, ptr @.str.11)
  %88 = call ptr @strcat(ptr %86, ptr %80)
  %90 = call i64 @strlen(ptr %86)
  %91 = call i64 @strlen(ptr @.str.12)
  %92 = add i64 %90, %91
  %93 = add i64 %92, 1
  %94 = call ptr @malloc(i64 %93)
  %95 = call ptr @strcpy(ptr %94, ptr %86)
  %96 = call ptr @strcat(ptr %94, ptr @.str.12)
  %97 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %94)
  br label %lbl_3

lbl_3:
  %98 = load ptr, ptr %file_asal_48
  %99 = call ptr @fopen(ptr %98, ptr @.str.13)
  %fp_100 = alloca ptr
  store ptr %99, ptr %fp_100
  %101 = load ptr, ptr %fp_100
  %102 = call i32 (ptr, ptr, ...) @fprintf(ptr %101, ptr @.fmt.string, ptr @.str.14)
  %103 = sext i32 %102 to i64
  %104 = load ptr, ptr %fp_100
  %105 = call i32 @fclose(ptr %104)
  %106 = sext i32 %105 to i64
  %107 = load ptr, ptr %file_asal_48
  %109 = call i64 @strlen(ptr @.str.15)
  %110 = call i64 @strlen(ptr %107)
  %111 = add i64 %109, %110
  %112 = add i64 %111, 1
  %113 = call ptr @malloc(i64 %112)
  %114 = call ptr @strcpy(ptr %113, ptr @.str.15)
  %115 = call ptr @strcat(ptr %113, ptr %107)
  %117 = call i64 @strlen(ptr %113)
  %118 = call i64 @strlen(ptr @.str.16)
  %119 = add i64 %117, %118
  %120 = add i64 %119, 1
  %121 = call ptr @malloc(i64 %120)
  %122 = call ptr @strcpy(ptr %121, ptr %113)
  %123 = call ptr @strcat(ptr %121, ptr @.str.16)
  %124 = call i64 @strlen(ptr %121)
  %125 = add i64 %124, 32
  %126 = call ptr @malloc(i64 %125)
  %127 = call i32 (ptr, ptr, ...) @sprintf(ptr %126, ptr @.ansi.hijau, ptr %121)
  %128 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %126)
  %129 = load ptr, ptr %file_asal_48
  %130 = call ptr @fopen(ptr %129, ptr @.str.mode_rb)
  %131 = icmp eq ptr %130, null
  %132 = alloca i64
  br i1 %131, label %lbl_5, label %lbl_4

lbl_5:
  store i64 0, ptr %132
  br label %lbl_6

lbl_4:
  %133 = call i32 @fseek(ptr %130, i64 0, i32 2)
  %134 = call i64 @ftell(ptr %130)
  %135 = call i32 @fclose(ptr %130)
  store i64 %134, ptr %132
  br label %lbl_6

lbl_6:
  %136 = load i64, ptr %132
  %ukuran_137 = alloca i64
  store i64 %136, ptr %ukuran_137
  %138 = load i64, ptr %ukuran_137
  %139 = call ptr @malloc(i64 32)
  %140 = call i32 (ptr, ptr, ...) @sprintf(ptr %139, ptr @.fmt.input_bilangan, i64 %138)
  %142 = call i64 @strlen(ptr @.str.17)
  %143 = call i64 @strlen(ptr %139)
  %144 = add i64 %142, %143
  %145 = add i64 %144, 1
  %146 = call ptr @malloc(i64 %145)
  %147 = call ptr @strcpy(ptr %146, ptr @.str.17)
  %148 = call ptr @strcat(ptr %146, ptr %139)
  %150 = call i64 @strlen(ptr %146)
  %151 = call i64 @strlen(ptr @.str.18)
  %152 = add i64 %150, %151
  %153 = add i64 %152, 1
  %154 = call ptr @malloc(i64 %153)
  %155 = call ptr @strcpy(ptr %154, ptr %146)
  %156 = call ptr @strcat(ptr %154, ptr @.str.18)
  %157 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %154)
  %158 = load ptr, ptr %file_asal_48
  %159 = load ptr, ptr %file_salin_49
  %160 = call i32 @CopyFileA(ptr %158, ptr %159, i32 0)
  %161 = icmp ne i32 %160, 0
  br i1 %161, label %lbl_7, label %lbl_8

lbl_7:
  %162 = load ptr, ptr %file_salin_49
  %164 = call i64 @strlen(ptr @.str.19)
  %165 = call i64 @strlen(ptr %162)
  %166 = add i64 %164, %165
  %167 = add i64 %166, 1
  %168 = call ptr @malloc(i64 %167)
  %169 = call ptr @strcpy(ptr %168, ptr @.str.19)
  %170 = call ptr @strcat(ptr %168, ptr %162)
  %172 = call i64 @strlen(ptr %168)
  %173 = call i64 @strlen(ptr @.str.20)
  %174 = add i64 %172, %173
  %175 = add i64 %174, 1
  %176 = call ptr @malloc(i64 %175)
  %177 = call ptr @strcpy(ptr %176, ptr %168)
  %178 = call ptr @strcat(ptr %176, ptr @.str.20)
  %179 = call i64 @strlen(ptr %176)
  %180 = add i64 %179, 32
  %181 = call ptr @malloc(i64 %180)
  %182 = call i32 (ptr, ptr, ...) @sprintf(ptr %181, ptr @.ansi.hijau, ptr %176)
  %183 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %181)
  br label %lbl_9

lbl_8:
  br label %lbl_9

lbl_9:
  %184 = load ptr, ptr %file_salin_49
  %185 = call ptr @fopen(ptr %184, ptr @.mode.rb)
  %186 = icmp eq ptr %185, null
  %187 = alloca ptr
  br i1 %186, label %lbl_10, label %lbl_11

lbl_10:
  %188 = call ptr @malloc(i64 1)
  store i8 0, ptr %188
  store ptr %188, ptr %187
  br label %lbl_12

lbl_11:
  %189 = call i32 @fseek(ptr %185, i64 0, i32 2)
  %190 = call i64 @ftell(ptr %185)
  call void @rewind(ptr %185)
  %191 = add i64 %190, 1
  %192 = call ptr @malloc(i64 %191)
  %193 = call i64 @fread(ptr %192, i64 1, i64 %190, ptr %185)
  %194 = getelementptr i8, ptr %192, i64 %190
  store i8 0, ptr %194
  %195 = call i32 @fclose(ptr %185)
  store ptr %192, ptr %187
  br label %lbl_12

lbl_12:
  %196 = load ptr, ptr %187
  %isi_197 = alloca ptr
  store ptr %196, ptr %isi_197
  %198 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %199 = call i64 @strlen(ptr @.str.21)
  %200 = add i64 %199, 32
  %201 = call ptr @malloc(i64 %200)
  %202 = call i32 (ptr, ptr, ...) @sprintf(ptr %201, ptr @.ansi.sian, ptr @.str.21)
  %203 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %201)
  %204 = load ptr, ptr %isi_197
  %205 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %204)
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

