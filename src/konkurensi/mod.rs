// src/konkurensi/mod.rs
// Modul Konkurensi Telacore — Abstraksi untuk multi-threading dan async

pub mod task;
pub mod executor;

pub use task::Tugas;
pub use executor::Eksekutor;
