// src/lib.rs — Library entry point Telacore Compiler
//
// File ini mengekspor semua modul compiler agar bisa diakses
// oleh binary (main.rs) dan integration tests (tests/).

pub mod lexer;
pub mod ast;
pub mod parser;
pub mod semantik;
pub mod llvm_codegen;
pub mod objek;
pub mod lingkungan;
pub mod evaluator;
pub mod token;
pub mod konkurensi;
