// src/konkurensi/executor.rs
// Eksekutor sederhana untuk menjalankan tugas asinkron Telacore
//
// Implementasi ini menggunakan thread OS baru untuk setiap tugas.
// Di masa depan bisa diganti dengan work-stealing thread pool.

use std::future::Future;
use std::pin::Pin;
use std::task::{Context, Poll, RawWaker, RawWakerVTable, Waker};
use std::thread::{self, JoinHandle};
use super::task::Tugas;

/// Eksekutor sederhana yang menjalankan future hingga selesai.
pub struct Eksekutor;

// --- Waker sederhana (no-op) untuk polling ---
// Waker ini langsung menganggap future siap di-poll lagi.

fn noop_clone(data: *const ()) -> RawWaker {
    RawWaker::new(data, &NOOP_VTABLE)
}
fn noop(_data: *const ()) {}

const NOOP_VTABLE: RawWakerVTable = RawWakerVTable::new(
    noop_clone, // clone
    noop,       // wake
    noop,       // wake_by_ref
    noop,       // drop
);

/// Jalankan sebuah future hingga selesai secara sinkron (blocking).
/// Ini adalah implementasi minimal tanpa dependency eksternal.
pub fn blokir_hingga_selesai<T>(mut future: Pin<Box<dyn Future<Output = T> + Send>>) -> T {
    let raw_waker = RawWaker::new(std::ptr::null(), &NOOP_VTABLE);
    let waker = unsafe { Waker::from_raw(raw_waker) };
    let mut cx = Context::from_waker(&waker);

    loop {
        match future.as_mut().poll(&mut cx) {
            Poll::Ready(val) => return val,
            Poll::Pending => {
                // Dalam implementasi nyata, kita akan park thread di sini.
                // Untuk sekarang, kita busy-loop (cukup untuk tugas sederhana).
                std::thread::yield_now();
            }
        }
    }
}

impl Eksekutor {
    /// Spawn tugas ke thread baru dan kembalikan JoinHandle.
    pub fn spawn<T>(tugas: Tugas<T>) -> JoinHandle<T>
    where
        T: Send + 'static,
    {
        thread::spawn(move || {
            blokir_hingga_selesai(tugas.future)
        })
    }
}

/// Fungsi convenience — jalankan future di thread baru tanpa perlu membuat Tugas secara manual.
pub fn jalankan_async<F, T>(future: F) -> JoinHandle<T>
where
    F: Future<Output = T> + Send + 'static,
    T: Send + 'static,
{
    let tugas = Tugas::baru(future);
    Eksekutor::spawn(tugas)
}
