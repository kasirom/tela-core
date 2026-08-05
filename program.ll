; --- TELA CORE LLVM IR ---
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

define i32 @main() {
entry:
  %a = alloca double
  store double 3.14, ptr %a
  %b = alloca i64
  store i64 2, ptr %b
  %1 = load double, ptr %a
  %2 = load i64, ptr %b
  %4 = sitofp i64 %2 to double
  %3 = fmul double %1, %4
  %c = alloca double
  store double %3, ptr %c
  %5 = load double, ptr %c
  ret i32 0
}
