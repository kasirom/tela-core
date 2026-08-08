// src/konkurensi/task.rs
// Representasi sebuah tugas asinkron dalam Telacore

use std::future::Future;
use std::pin::Pin;

/// `Tugas<T>` membungkus sebuah future yang bisa dijalankan oleh eksekutor.
/// Future harus `Send` dan `'static` karena bisa dijalankan di thread lain.
pub struct Tugas<T> {
    pub future: Pin<Box<dyn Future<Output = T> + Send>>,
}

impl<T> Tugas<T> {
    /// Buat `Tugas` baru dari future apapun.
    pub fn baru<F>(future: F) -> Self
    where
        F: Future<Output = T> + Send + 'static,
    {
        Tugas {
            future: Box::pin(future),
        }
    }
}
