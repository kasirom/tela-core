; --- TELA CORE LLVM IR ---
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

declare i32 @printf(ptr, ...)
declare i32 @scanf(ptr, ...)
@.fmt.desimal = private unnamed_addr constant [6 x i8] c"%.15g\00", align 1
@.fmt.input_desimal = private unnamed_addr constant [4 x i8] c"%lf\00", align 1
@.fmt.input_bilangan = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.fmt.string_nl = private unnamed_addr constant [3 x i8] c"%s\00", align 1

declare ptr @GetStdHandle(i32)
declare i32 @GetConsoleMode(ptr, ptr)
declare i32 @SetConsoleMode(ptr, i32)
declare i32 @SetConsoleOutputCP(i32)
declare i32 @getchar()
declare i32 @MessageBeep(i32)

declare ptr @fopen(ptr, ptr)
declare i32 @fprintf(ptr, ptr, ...)
declare i32 @fclose(ptr)

declare double @sqrt(double)
declare double @pow(double, double)
declare double @sin(double)
declare double @cos(double)
declare double @tan(double)
declare double @log10(double)

declare i64 @time(ptr)
declare ptr @localtime(ptr)
declare i64 @strftime(ptr, i64, ptr, ptr)
declare ptr @malloc(i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)
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

@.str.0 = private unnamed_addr constant [14 x i8] c"Panjang awal:\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"Kapasitas awal:\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"Menambahkan elemen...\00", align 1
@.str.3 = private unnamed_addr constant [26 x i8] c"Panjang setelah tambah 4:\00", align 1
@.str.4 = private unnamed_addr constant [11 x i8] c"Kapasitas:\00", align 1
@.str.5 = private unnamed_addr constant [40 x i8] c"Menambahkan elemen ke-5 (trigger grow):\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"Panjang:\00", align 1
@.str.7 = private unnamed_addr constant [16 x i8] c"Kapasitas baru:\00", align 1
@.str.8 = private unnamed_addr constant [15 x i8] c"Elemen-elemen:\00", align 1
@.str.9 = private unnamed_addr constant [29 x i8] c"Mengubah v[2] menjadi 999...\00", align 1
@.str.10 = private unnamed_addr constant [11 x i8] c"v[2] baru:\00", align 1
define void @utama() {
entry:
  %1 = call ptr @malloc(i64 24)
  %2 = call ptr @malloc(i64 32)
  %3 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 0
  store ptr %2, ptr %3
  %4 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 1
  store i64 0, ptr %4
  %5 = getelementptr { ptr, i64, i64 }, ptr %1, i32 0, i32 2
  store i64 4, ptr %5
  %v_6 = alloca ptr
  store ptr %1, ptr %v_6
  %7 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.0)
  %8 = load ptr, ptr %v_6
  %9 = getelementptr { ptr, i64, i64 }, ptr %8, i32 0, i32 1
  %10 = load i64, ptr %9
  %11 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %10)
  %12 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.1)
  %13 = load ptr, ptr %v_6
  %14 = getelementptr { ptr, i64, i64 }, ptr %13, i32 0, i32 2
  %15 = load i64, ptr %14
  %16 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %15)
  %17 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.2)
  %18 = load ptr, ptr %v_6
  %19 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 1
  %20 = load i64, ptr %19
  %21 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 2
  %22 = load i64, ptr %21
  %23 = icmp eq i64 %20, %22
  br i1 %23, label %lbl_1, label %lbl_2

lbl_1:
  %24 = mul i64 %22, 2
  %25 = mul i64 %24, 8
  %26 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 0
  %27 = load ptr, ptr %26
  %28 = call ptr @realloc(ptr %27, i64 %25)
  store ptr %28, ptr %26
  store i64 %24, ptr %21
  br label %lbl_2

lbl_2:
  %29 = getelementptr { ptr, i64, i64 }, ptr %18, i32 0, i32 0
  %30 = load ptr, ptr %29
  %31 = getelementptr i64, ptr %30, i64 %20
  store i64 100, ptr %31
  %32 = add i64 %20, 1
  store i64 %32, ptr %19
  br label %lbl_3

lbl_3:
  %33 = load ptr, ptr %v_6
  %34 = getelementptr { ptr, i64, i64 }, ptr %33, i32 0, i32 1
  %35 = load i64, ptr %34
  %36 = getelementptr { ptr, i64, i64 }, ptr %33, i32 0, i32 2
  %37 = load i64, ptr %36
  %38 = icmp eq i64 %35, %37
  br i1 %38, label %lbl_4, label %lbl_5

lbl_4:
  %39 = mul i64 %37, 2
  %40 = mul i64 %39, 8
  %41 = getelementptr { ptr, i64, i64 }, ptr %33, i32 0, i32 0
  %42 = load ptr, ptr %41
  %43 = call ptr @realloc(ptr %42, i64 %40)
  store ptr %43, ptr %41
  store i64 %39, ptr %36
  br label %lbl_5

lbl_5:
  %44 = getelementptr { ptr, i64, i64 }, ptr %33, i32 0, i32 0
  %45 = load ptr, ptr %44
  %46 = getelementptr i64, ptr %45, i64 %35
  store i64 200, ptr %46
  %47 = add i64 %35, 1
  store i64 %47, ptr %34
  br label %lbl_6

lbl_6:
  %48 = load ptr, ptr %v_6
  %49 = getelementptr { ptr, i64, i64 }, ptr %48, i32 0, i32 1
  %50 = load i64, ptr %49
  %51 = getelementptr { ptr, i64, i64 }, ptr %48, i32 0, i32 2
  %52 = load i64, ptr %51
  %53 = icmp eq i64 %50, %52
  br i1 %53, label %lbl_7, label %lbl_8

lbl_7:
  %54 = mul i64 %52, 2
  %55 = mul i64 %54, 8
  %56 = getelementptr { ptr, i64, i64 }, ptr %48, i32 0, i32 0
  %57 = load ptr, ptr %56
  %58 = call ptr @realloc(ptr %57, i64 %55)
  store ptr %58, ptr %56
  store i64 %54, ptr %51
  br label %lbl_8

lbl_8:
  %59 = getelementptr { ptr, i64, i64 }, ptr %48, i32 0, i32 0
  %60 = load ptr, ptr %59
  %61 = getelementptr i64, ptr %60, i64 %50
  store i64 300, ptr %61
  %62 = add i64 %50, 1
  store i64 %62, ptr %49
  br label %lbl_9

lbl_9:
  %63 = load ptr, ptr %v_6
  %64 = getelementptr { ptr, i64, i64 }, ptr %63, i32 0, i32 1
  %65 = load i64, ptr %64
  %66 = getelementptr { ptr, i64, i64 }, ptr %63, i32 0, i32 2
  %67 = load i64, ptr %66
  %68 = icmp eq i64 %65, %67
  br i1 %68, label %lbl_10, label %lbl_11

lbl_10:
  %69 = mul i64 %67, 2
  %70 = mul i64 %69, 8
  %71 = getelementptr { ptr, i64, i64 }, ptr %63, i32 0, i32 0
  %72 = load ptr, ptr %71
  %73 = call ptr @realloc(ptr %72, i64 %70)
  store ptr %73, ptr %71
  store i64 %69, ptr %66
  br label %lbl_11

lbl_11:
  %74 = getelementptr { ptr, i64, i64 }, ptr %63, i32 0, i32 0
  %75 = load ptr, ptr %74
  %76 = getelementptr i64, ptr %75, i64 %65
  store i64 400, ptr %76
  %77 = add i64 %65, 1
  store i64 %77, ptr %64
  br label %lbl_12

lbl_12:
  %78 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.3)
  %79 = load ptr, ptr %v_6
  %80 = getelementptr { ptr, i64, i64 }, ptr %79, i32 0, i32 1
  %81 = load i64, ptr %80
  %82 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %81)
  %83 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.4)
  %84 = load ptr, ptr %v_6
  %85 = getelementptr { ptr, i64, i64 }, ptr %84, i32 0, i32 2
  %86 = load i64, ptr %85
  %87 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %86)
  %88 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.5)
  %89 = load ptr, ptr %v_6
  %90 = getelementptr { ptr, i64, i64 }, ptr %89, i32 0, i32 1
  %91 = load i64, ptr %90
  %92 = getelementptr { ptr, i64, i64 }, ptr %89, i32 0, i32 2
  %93 = load i64, ptr %92
  %94 = icmp eq i64 %91, %93
  br i1 %94, label %lbl_13, label %lbl_14

lbl_13:
  %95 = mul i64 %93, 2
  %96 = mul i64 %95, 8
  %97 = getelementptr { ptr, i64, i64 }, ptr %89, i32 0, i32 0
  %98 = load ptr, ptr %97
  %99 = call ptr @realloc(ptr %98, i64 %96)
  store ptr %99, ptr %97
  store i64 %95, ptr %92
  br label %lbl_14

lbl_14:
  %100 = getelementptr { ptr, i64, i64 }, ptr %89, i32 0, i32 0
  %101 = load ptr, ptr %100
  %102 = getelementptr i64, ptr %101, i64 %91
  store i64 500, ptr %102
  %103 = add i64 %91, 1
  store i64 %103, ptr %90
  br label %lbl_15

lbl_15:
  %104 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.6)
  %105 = load ptr, ptr %v_6
  %106 = getelementptr { ptr, i64, i64 }, ptr %105, i32 0, i32 1
  %107 = load i64, ptr %106
  %108 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %107)
  %109 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.7)
  %110 = load ptr, ptr %v_6
  %111 = getelementptr { ptr, i64, i64 }, ptr %110, i32 0, i32 2
  %112 = load i64, ptr %111
  %113 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %112)
  %114 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.8)
  %115 = load ptr, ptr %v_6
  %116 = getelementptr { ptr, i64, i64 }, ptr %115, i32 0, i32 0
  %117 = load ptr, ptr %116
  %118 = getelementptr i64, ptr %117, i64 0
  %119 = load i64, ptr %118
  %120 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %119)
  %121 = load ptr, ptr %v_6
  %122 = getelementptr { ptr, i64, i64 }, ptr %121, i32 0, i32 0
  %123 = load ptr, ptr %122
  %124 = getelementptr i64, ptr %123, i64 1
  %125 = load i64, ptr %124
  %126 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %125)
  %127 = load ptr, ptr %v_6
  %128 = getelementptr { ptr, i64, i64 }, ptr %127, i32 0, i32 0
  %129 = load ptr, ptr %128
  %130 = getelementptr i64, ptr %129, i64 2
  %131 = load i64, ptr %130
  %132 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %131)
  %133 = load ptr, ptr %v_6
  %134 = getelementptr { ptr, i64, i64 }, ptr %133, i32 0, i32 0
  %135 = load ptr, ptr %134
  %136 = getelementptr i64, ptr %135, i64 3
  %137 = load i64, ptr %136
  %138 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %137)
  %139 = load ptr, ptr %v_6
  %140 = getelementptr { ptr, i64, i64 }, ptr %139, i32 0, i32 0
  %141 = load ptr, ptr %140
  %142 = getelementptr i64, ptr %141, i64 4
  %143 = load i64, ptr %142
  %144 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %143)
  %145 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.9)
  %146 = load ptr, ptr %v_6
  %147 = getelementptr { ptr, i64, i64 }, ptr %146, i32 0, i32 0
  %148 = load ptr, ptr %147
  %149 = getelementptr i64, ptr %148, i64 2
  store i64 999, ptr %149
  %150 = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr @.str.10)
  %151 = load ptr, ptr %v_6
  %152 = getelementptr { ptr, i64, i64 }, ptr %151, i32 0, i32 0
  %153 = load ptr, ptr %152
  %154 = getelementptr i64, ptr %153, i64 2
  %155 = load i64, ptr %154
  %156 = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 %155)
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

