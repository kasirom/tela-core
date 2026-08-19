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

@.str.0 = private unnamed_addr constant [3 x i8] c"id\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"nama\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"email\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"peran\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"token\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"dibuat\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"-- \00", align 1
@.str.7 = private unnamed_addr constant [4 x i8] c" --\00", align 1
@.str.8 = private unnamed_addr constant [36 x i8] c"=== TELACORE FILE DATABASE CRUD ===\00", align 1
@.str.9 = private unnamed_addr constant [18 x i8] c"bangun/users.json\00", align 1
@.str.10 = private unnamed_addr constant [25 x i8] c"CREATE -- Membuat Record\00", align 1
@.str.11 = private unnamed_addr constant [8 x i8] c"USR-001\00", align 1
@.str.12 = private unnamed_addr constant [12 x i8] c"Ahmad Fauzi\00", align 1
@.str.13 = private unnamed_addr constant [19 x i8] c"ahmad@nusantara.id\00", align 1
@.str.14 = private unnamed_addr constant [6 x i8] c"admin\00", align 1
@.str.15 = private unnamed_addr constant [8 x i8] c"USR-002\00", align 1
@.str.16 = private unnamed_addr constant [12 x i8] c"Siti Rahmah\00", align 1
@.str.17 = private unnamed_addr constant [18 x i8] c"siti@nusantara.id\00", align 1
@.str.18 = private unnamed_addr constant [5 x i8] c"user\00", align 1
@.str.19 = private unnamed_addr constant [8 x i8] c"USR-003\00", align 1
@.str.20 = private unnamed_addr constant [13 x i8] c"Budi Santoso\00", align 1
@.str.21 = private unnamed_addr constant [18 x i8] c"budi@nusantara.id\00", align 1
@.str.22 = private unnamed_addr constant [10 x i8] c"moderator\00", align 1
@.str.23 = private unnamed_addr constant [8 x i8] c"USR-004\00", align 1
@.str.24 = private unnamed_addr constant [13 x i8] c"Dewi Lestari\00", align 1
@.str.25 = private unnamed_addr constant [18 x i8] c"dewi@nusantara.id\00", align 1
@.str.26 = private unnamed_addr constant [5 x i8] c"user\00", align 1
@.str.27 = private unnamed_addr constant [35 x i8] c"  + USR-001: Ahmad Fauzi   [admin]\00", align 1
@.str.28 = private unnamed_addr constant [34 x i8] c"  + USR-002: Siti Rahmah   [user]\00", align 1
@.str.29 = private unnamed_addr constant [39 x i8] c"  + USR-003: Budi Santoso  [moderator]\00", align 1
@.str.30 = private unnamed_addr constant [34 x i8] c"  + USR-004: Dewi Lestari  [user]\00", align 1
@.str.31 = private unnamed_addr constant [20 x i8] c"WRITE -- Simpan ke \00", align 1
@.str.32 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str.33 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.34 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.35 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.36 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@.str.37 = private unnamed_addr constant [14 x i8] c"  Tersimpan: \00", align 1
@.str.38 = private unnamed_addr constant [7 x i8] c" bytes\00", align 1
@.str.39 = private unnamed_addr constant [19 x i8] c"READ -- Baca dari \00", align 1
@.str.40 = private unnamed_addr constant [12 x i8] c"  Panjang: \00", align 1
@.str.41 = private unnamed_addr constant [10 x i8] c" karakter\00", align 1
@.str.42 = private unnamed_addr constant [30 x i8] c"INTEGRITY -- Checksum SHA-256\00", align 1
@.str.43 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.44 = private unnamed_addr constant [37 x i8] c"BACKUP -- Salin ke users_backup.json\00", align 1
@.str.45 = private unnamed_addr constant [25 x i8] c"bangun/users_backup.json\00", align 1
@.str.46 = private unnamed_addr constant [19 x i8] c"  Backup berhasil!\00", align 1
@.str.47 = private unnamed_addr constant [38 x i8] c"Semua operasi CRUD database berhasil!\00", align 1
define ptr @buat_user(ptr %arg_id, ptr %arg_nama, ptr %arg_email, ptr %arg_peran) {
entry:
  %id = alloca ptr
  store ptr %arg_id, ptr %id
  %nama = alloca ptr
  store ptr %arg_nama, ptr %nama
  %email = alloca ptr
  store ptr %arg_email, ptr %email
  %peran = alloca ptr
  store ptr %arg_peran, ptr %peran
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
  %8 = load ptr, ptr %id
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
  %19 = load ptr, ptr %nama
  %20 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 0
  %21 = load ptr, ptr %20
  %22 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 1
  %23 = load i64, ptr %22
  %24 = icmp eq i64 %23, 0
  %25 = select i1 %24, ptr @.json.str.init, ptr @.json.str.next
  %26 = getelementptr i8, ptr %21, i64 %23
  %27 = call i32 (ptr, ptr, ...) @sprintf(ptr %26, ptr %25, ptr @.str.1, ptr %19)
  %28 = call i64 @strlen(ptr %21)
  store i64 %28, ptr %22
  %29 = load ptr, ptr %o_6
  %30 = load ptr, ptr %email
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
  %41 = load ptr, ptr %peran
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
  %52 = load ptr, ptr %email
  %53 = load ptr, ptr %id
  %55 = call i64 @strlen(ptr %52)
  %56 = call i64 @strlen(ptr %53)
  %57 = add i64 %55, %56
  %58 = add i64 %57, 1
  %59 = call ptr @malloc(i64 %58)
  %60 = call ptr @strcpy(ptr %59, ptr %52)
  %61 = call ptr @strcat(ptr %59, ptr %53)
  %62 = alloca ptr
  %63 = alloca ptr
  %64 = alloca i32
  %65 = alloca [64 x i8]
  %66 = call i32 @CryptAcquireContextA(ptr %62, ptr null, ptr null, i32 24, i32 -268435456)
  %67 = load ptr, ptr %62
  %68 = call i32 @CryptCreateHash(ptr %67, i32 32780, ptr null, i32 0, ptr %63)
  %69 = load ptr, ptr %63
  %70 = call i64 @strlen(ptr %59)
  %71 = trunc i64 %70 to i32
  %72 = call i32 @CryptHashData(ptr %69, ptr %59, i32 %71, i32 0)
  store i32 32, ptr %64
  %73 = call i32 @CryptGetHashParam(ptr %69, i32 2, ptr %65, ptr %64, i32 0)
  %74 = call i32 @CryptDestroyHash(ptr %69)
  %75 = call i32 @CryptReleaseContext(ptr %67, i32 0)
  %76 = call ptr @malloc(i64 65)
  %77 = alloca i64
  store i64 0, ptr %77
  br label %lbl_1

lbl_1:
  %78 = load i64, ptr %77
  %79 = icmp slt i64 %78, 32
  br i1 %79, label %lbl_2, label %lbl_3

lbl_2:
  %80 = getelementptr [64 x i8], ptr %65, i64 0, i64 %78
  %81 = load i8, ptr %80
  %82 = zext i8 %81 to i32
  %83 = mul i64 %78, 2
  %84 = getelementptr i8, ptr %76, i64 %83
  %85 = call i32 (ptr, ptr, ...) @sprintf(ptr %84, ptr @.hex.byte_fmt, i32 %82)
  %86 = add i64 %78, 1
  store i64 %86, ptr %77
  br label %lbl_1

lbl_3:
  %87 = getelementptr i8, ptr %76, i64 64
  store i8 0, ptr %87
  %88 = getelementptr { ptr, i64, i64 }, ptr %51, i32 0, i32 0
  %89 = load ptr, ptr %88
  %90 = getelementptr { ptr, i64, i64 }, ptr %51, i32 0, i32 1
  %91 = load i64, ptr %90
  %92 = icmp eq i64 %91, 0
  %93 = select i1 %92, ptr @.json.str.init, ptr @.json.str.next
  %94 = getelementptr i8, ptr %89, i64 %91
  %95 = call i32 (ptr, ptr, ...) @sprintf(ptr %94, ptr %93, ptr @.str.4, ptr %76)
  %96 = call i64 @strlen(ptr %89)
  store i64 %96, ptr %90
  %97 = load ptr, ptr %o_6
  %98 = alloca i64
  %99 = call i64 @time(ptr null)
  store i64 %99, ptr %98
  %100 = call ptr @localtime(ptr %98)
  %101 = call ptr @malloc(i64 20)
  %102 = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0
  %103 = call i64 @strftime(ptr %101, i64 20, ptr %102, ptr %100)
  %104 = getelementptr { ptr, i64, i64 }, ptr %97, i32 0, i32 0
  %105 = load ptr, ptr %104
  %106 = getelementptr { ptr, i64, i64 }, ptr %97, i32 0, i32 1
  %107 = load i64, ptr %106
  %108 = icmp eq i64 %107, 0
  %109 = select i1 %108, ptr @.json.str.init, ptr @.json.str.next
  %110 = getelementptr i8, ptr %105, i64 %107
  %111 = call i32 (ptr, ptr, ...) @sprintf(ptr %110, ptr %109, ptr @.str.5, ptr %101)
  %112 = call i64 @strlen(ptr %105)
  store i64 %112, ptr %106
  %113 = load ptr, ptr %o_6
  %114 = getelementptr { ptr, i64, i64 }, ptr %113, i32 0, i32 0
  %115 = load ptr, ptr %114
  %116 = getelementptr { ptr, i64, i64 }, ptr %113, i32 0, i32 1
  %117 = load i64, ptr %116
  %118 = icmp eq i64 %117, 0
  %119 = alloca ptr
  br i1 %118, label %lbl_4, label %lbl_5

lbl_4:
  store ptr @.json.empty, ptr %119
  br label %lbl_6

lbl_5:
  %120 = add i64 %117, 8
  %121 = call ptr @malloc(i64 %120)
  %122 = call ptr @strcpy(ptr %121, ptr %115)
  %123 = getelementptr i8, ptr %121, i64 %117
  store i8 125, ptr %123
  %124 = getelementptr i8, ptr %123, i64 1
  store i8 0, ptr %124
  store ptr %121, ptr %119
  br label %lbl_6

lbl_6:
  %125 = load ptr, ptr %119
  ret ptr %125
}

define void @bagian(ptr %arg_judul) {
entry:
  %judul = alloca ptr
  store ptr %arg_judul, ptr %judul
  %1 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %2 = load ptr, ptr %judul
  %4 = call i64 @strlen(ptr @.str.6)
  %5 = call i64 @strlen(ptr %2)
  %6 = add i64 %4, %5
  %7 = add i64 %6, 1
  %8 = call ptr @malloc(i64 %7)
  %9 = call ptr @strcpy(ptr %8, ptr @.str.6)
  %10 = call ptr @strcat(ptr %8, ptr %2)
  %12 = call i64 @strlen(ptr %8)
  %13 = call i64 @strlen(ptr @.str.7)
  %14 = add i64 %12, %13
  %15 = add i64 %14, 1
  %16 = call ptr @malloc(i64 %15)
  %17 = call ptr @strcpy(ptr %16, ptr %8)
  %18 = call ptr @strcat(ptr %16, ptr @.str.7)
  %19 = call i64 @strlen(ptr %16)
  %20 = add i64 %19, 32
  %21 = call ptr @malloc(i64 %20)
  %22 = call i32 (ptr, ptr, ...) @sprintf(ptr %21, ptr @.ansi.kuning, ptr %16)
  %23 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %21)
  ret void
}

define void @utama() {
entry:
  %1 = call i64 @strlen(ptr @.str.8)
  %2 = add i64 %1, 32
  %3 = call ptr @malloc(i64 %2)
  %4 = call i32 (ptr, ptr, ...) @sprintf(ptr %3, ptr @.ansi.sian, ptr @.str.8)
  %5 = call i64 @strlen(ptr %3)
  %6 = add i64 %5, 32
  %7 = call ptr @malloc(i64 %6)
  %8 = call i32 (ptr, ptr, ...) @sprintf(ptr %7, ptr @.ansi.tebal, ptr %3)
  %9 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %7)
  %db_file_10 = alloca ptr
  store ptr @.str.9, ptr %db_file_10
  call void @bagian(ptr @.str.10)
  %11 = call ptr @buat_user(ptr @.str.11, ptr @.str.12, ptr @.str.13, ptr @.str.14)
  %u1_12 = alloca ptr
  store ptr %11, ptr %u1_12
  %13 = call ptr @buat_user(ptr @.str.15, ptr @.str.16, ptr @.str.17, ptr @.str.18)
  %u2_14 = alloca ptr
  store ptr %13, ptr %u2_14
  %15 = call ptr @buat_user(ptr @.str.19, ptr @.str.20, ptr @.str.21, ptr @.str.22)
  %u3_16 = alloca ptr
  store ptr %15, ptr %u3_16
  %17 = call ptr @buat_user(ptr @.str.23, ptr @.str.24, ptr @.str.25, ptr @.str.26)
  %u4_18 = alloca ptr
  store ptr %17, ptr %u4_18
  %19 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.27)
  %20 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.28)
  %21 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.29)
  %22 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.30)
  %23 = load ptr, ptr %db_file_10
  %25 = call i64 @strlen(ptr @.str.31)
  %26 = call i64 @strlen(ptr %23)
  %27 = add i64 %25, %26
  %28 = add i64 %27, 1
  %29 = call ptr @malloc(i64 %28)
  %30 = call ptr @strcpy(ptr %29, ptr @.str.31)
  %31 = call ptr @strcat(ptr %29, ptr %23)
  call void @bagian(ptr %29)
  %32 = load ptr, ptr %u1_12
  %34 = call i64 @strlen(ptr @.str.32)
  %35 = call i64 @strlen(ptr %32)
  %36 = add i64 %34, %35
  %37 = add i64 %36, 1
  %38 = call ptr @malloc(i64 %37)
  %39 = call ptr @strcpy(ptr %38, ptr @.str.32)
  %40 = call ptr @strcat(ptr %38, ptr %32)
  %42 = call i64 @strlen(ptr %38)
  %43 = call i64 @strlen(ptr @.str.33)
  %44 = add i64 %42, %43
  %45 = add i64 %44, 1
  %46 = call ptr @malloc(i64 %45)
  %47 = call ptr @strcpy(ptr %46, ptr %38)
  %48 = call ptr @strcat(ptr %46, ptr @.str.33)
  %49 = load ptr, ptr %u2_14
  %51 = call i64 @strlen(ptr %46)
  %52 = call i64 @strlen(ptr %49)
  %53 = add i64 %51, %52
  %54 = add i64 %53, 1
  %55 = call ptr @malloc(i64 %54)
  %56 = call ptr @strcpy(ptr %55, ptr %46)
  %57 = call ptr @strcat(ptr %55, ptr %49)
  %59 = call i64 @strlen(ptr %55)
  %60 = call i64 @strlen(ptr @.str.34)
  %61 = add i64 %59, %60
  %62 = add i64 %61, 1
  %63 = call ptr @malloc(i64 %62)
  %64 = call ptr @strcpy(ptr %63, ptr %55)
  %65 = call ptr @strcat(ptr %63, ptr @.str.34)
  %66 = load ptr, ptr %u3_16
  %68 = call i64 @strlen(ptr %63)
  %69 = call i64 @strlen(ptr %66)
  %70 = add i64 %68, %69
  %71 = add i64 %70, 1
  %72 = call ptr @malloc(i64 %71)
  %73 = call ptr @strcpy(ptr %72, ptr %63)
  %74 = call ptr @strcat(ptr %72, ptr %66)
  %76 = call i64 @strlen(ptr %72)
  %77 = call i64 @strlen(ptr @.str.35)
  %78 = add i64 %76, %77
  %79 = add i64 %78, 1
  %80 = call ptr @malloc(i64 %79)
  %81 = call ptr @strcpy(ptr %80, ptr %72)
  %82 = call ptr @strcat(ptr %80, ptr @.str.35)
  %83 = load ptr, ptr %u4_18
  %85 = call i64 @strlen(ptr %80)
  %86 = call i64 @strlen(ptr %83)
  %87 = add i64 %85, %86
  %88 = add i64 %87, 1
  %89 = call ptr @malloc(i64 %88)
  %90 = call ptr @strcpy(ptr %89, ptr %80)
  %91 = call ptr @strcat(ptr %89, ptr %83)
  %93 = call i64 @strlen(ptr %89)
  %94 = call i64 @strlen(ptr @.str.36)
  %95 = add i64 %93, %94
  %96 = add i64 %95, 1
  %97 = call ptr @malloc(i64 %96)
  %98 = call ptr @strcpy(ptr %97, ptr %89)
  %99 = call ptr @strcat(ptr %97, ptr @.str.36)
  %isi_100 = alloca ptr
  store ptr %97, ptr %isi_100
  %101 = load ptr, ptr %db_file_10
  %102 = load ptr, ptr %isi_100
  %103 = call ptr @fopen(ptr %101, ptr @.str.mode_w)
  %104 = icmp eq ptr %103, null
  %105 = alloca i1
  br i1 %104, label %lbl_2, label %lbl_1

lbl_2:
  store i1 0, ptr %105
  br label %lbl_3

lbl_1:
  %106 = call i32 @fputs(ptr %102, ptr %103)
  %107 = call i32 @fclose(ptr %103)
  store i1 1, ptr %105
  br label %lbl_3

lbl_3:
  %108 = load i1, ptr %105
  %109 = load ptr, ptr %db_file_10
  %110 = call ptr @fopen(ptr %109, ptr @.str.mode_rb)
  %111 = icmp eq ptr %110, null
  %112 = alloca i64
  br i1 %111, label %lbl_5, label %lbl_4

lbl_5:
  store i64 0, ptr %112
  br label %lbl_6

lbl_4:
  %113 = call i32 @fseek(ptr %110, i64 0, i32 2)
  %114 = call i64 @ftell(ptr %110)
  %115 = call i32 @fclose(ptr %110)
  store i64 %114, ptr %112
  br label %lbl_6

lbl_6:
  %116 = load i64, ptr %112
  %117 = call ptr @malloc(i64 32)
  %118 = call i32 (ptr, ptr, ...) @sprintf(ptr %117, ptr @.fmt.input_bilangan, i64 %116)
  %120 = call i64 @strlen(ptr @.str.37)
  %121 = call i64 @strlen(ptr %117)
  %122 = add i64 %120, %121
  %123 = add i64 %122, 1
  %124 = call ptr @malloc(i64 %123)
  %125 = call ptr @strcpy(ptr %124, ptr @.str.37)
  %126 = call ptr @strcat(ptr %124, ptr %117)
  %128 = call i64 @strlen(ptr %124)
  %129 = call i64 @strlen(ptr @.str.38)
  %130 = add i64 %128, %129
  %131 = add i64 %130, 1
  %132 = call ptr @malloc(i64 %131)
  %133 = call ptr @strcpy(ptr %132, ptr %124)
  %134 = call ptr @strcat(ptr %132, ptr @.str.38)
  %135 = call i64 @strlen(ptr %132)
  %136 = add i64 %135, 32
  %137 = call ptr @malloc(i64 %136)
  %138 = call i32 (ptr, ptr, ...) @sprintf(ptr %137, ptr @.ansi.hijau, ptr %132)
  %139 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %137)
  %140 = load ptr, ptr %db_file_10
  %142 = call i64 @strlen(ptr @.str.39)
  %143 = call i64 @strlen(ptr %140)
  %144 = add i64 %142, %143
  %145 = add i64 %144, 1
  %146 = call ptr @malloc(i64 %145)
  %147 = call ptr @strcpy(ptr %146, ptr @.str.39)
  %148 = call ptr @strcat(ptr %146, ptr %140)
  call void @bagian(ptr %146)
  %149 = load ptr, ptr %db_file_10
  %150 = call ptr @fopen(ptr %149, ptr @.mode.rb)
  %151 = icmp eq ptr %150, null
  %152 = alloca ptr
  br i1 %151, label %lbl_7, label %lbl_8

lbl_7:
  %153 = call ptr @malloc(i64 1)
  store i8 0, ptr %153
  store ptr %153, ptr %152
  br label %lbl_9

lbl_8:
  %154 = call i32 @fseek(ptr %150, i64 0, i32 2)
  %155 = call i64 @ftell(ptr %150)
  call void @rewind(ptr %150)
  %156 = add i64 %155, 1
  %157 = call ptr @malloc(i64 %156)
  %158 = call i64 @fread(ptr %157, i64 1, i64 %155, ptr %150)
  %159 = getelementptr i8, ptr %157, i64 %155
  store i8 0, ptr %159
  %160 = call i32 @fclose(ptr %150)
  store ptr %157, ptr %152
  br label %lbl_9

lbl_9:
  %161 = load ptr, ptr %152
  %data_162 = alloca ptr
  store ptr %161, ptr %data_162
  %163 = load ptr, ptr %data_162
  %164 = call i64 @strlen(ptr %163)
  %165 = call ptr @malloc(i64 32)
  %166 = call i32 (ptr, ptr, ...) @sprintf(ptr %165, ptr @.fmt.input_bilangan, i64 %164)
  %168 = call i64 @strlen(ptr @.str.40)
  %169 = call i64 @strlen(ptr %165)
  %170 = add i64 %168, %169
  %171 = add i64 %170, 1
  %172 = call ptr @malloc(i64 %171)
  %173 = call ptr @strcpy(ptr %172, ptr @.str.40)
  %174 = call ptr @strcat(ptr %172, ptr %165)
  %176 = call i64 @strlen(ptr %172)
  %177 = call i64 @strlen(ptr @.str.41)
  %178 = add i64 %176, %177
  %179 = add i64 %178, 1
  %180 = call ptr @malloc(i64 %179)
  %181 = call ptr @strcpy(ptr %180, ptr %172)
  %182 = call ptr @strcat(ptr %180, ptr @.str.41)
  %183 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %180)
  call void @bagian(ptr @.str.42)
  %184 = load ptr, ptr %data_162
  %185 = alloca ptr
  %186 = alloca ptr
  %187 = alloca i32
  %188 = alloca [64 x i8]
  %189 = call i32 @CryptAcquireContextA(ptr %185, ptr null, ptr null, i32 24, i32 -268435456)
  %190 = load ptr, ptr %185
  %191 = call i32 @CryptCreateHash(ptr %190, i32 32780, ptr null, i32 0, ptr %186)
  %192 = load ptr, ptr %186
  %193 = call i64 @strlen(ptr %184)
  %194 = trunc i64 %193 to i32
  %195 = call i32 @CryptHashData(ptr %192, ptr %184, i32 %194, i32 0)
  store i32 32, ptr %187
  %196 = call i32 @CryptGetHashParam(ptr %192, i32 2, ptr %188, ptr %187, i32 0)
  %197 = call i32 @CryptDestroyHash(ptr %192)
  %198 = call i32 @CryptReleaseContext(ptr %190, i32 0)
  %199 = call ptr @malloc(i64 65)
  %200 = alloca i64
  store i64 0, ptr %200
  br label %lbl_10

lbl_10:
  %201 = load i64, ptr %200
  %202 = icmp slt i64 %201, 32
  br i1 %202, label %lbl_11, label %lbl_12

lbl_11:
  %203 = getelementptr [64 x i8], ptr %188, i64 0, i64 %201
  %204 = load i8, ptr %203
  %205 = zext i8 %204 to i32
  %206 = mul i64 %201, 2
  %207 = getelementptr i8, ptr %199, i64 %206
  %208 = call i32 (ptr, ptr, ...) @sprintf(ptr %207, ptr @.hex.byte_fmt, i32 %205)
  %209 = add i64 %201, 1
  store i64 %209, ptr %200
  br label %lbl_10

lbl_12:
  %210 = getelementptr i8, ptr %199, i64 64
  store i8 0, ptr %210
  %212 = call i64 @strlen(ptr @.str.43)
  %213 = call i64 @strlen(ptr %199)
  %214 = add i64 %212, %213
  %215 = add i64 %214, 1
  %216 = call ptr @malloc(i64 %215)
  %217 = call ptr @strcpy(ptr %216, ptr @.str.43)
  %218 = call ptr @strcat(ptr %216, ptr %199)
  %219 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %216)
  call void @bagian(ptr @.str.44)
  %220 = load ptr, ptr %db_file_10
  %221 = call i32 @CopyFileA(ptr %220, ptr @.str.45, i32 0)
  %222 = icmp ne i32 %221, 0
  %223 = call i64 @strlen(ptr @.str.46)
  %224 = add i64 %223, 32
  %225 = call ptr @malloc(i64 %224)
  %226 = call i32 (ptr, ptr, ...) @sprintf(ptr %225, ptr @.ansi.hijau, ptr @.str.46)
  %227 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %225)
  %228 = call i32 (ptr, ...) @printf(ptr @.fmt.newline)
  %229 = call i64 @strlen(ptr @.str.47)
  %230 = add i64 %229, 32
  %231 = call ptr @malloc(i64 %230)
  %232 = call i32 (ptr, ptr, ...) @sprintf(ptr %231, ptr @.ansi.hijau, ptr @.str.47)
  %233 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr %231)
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

