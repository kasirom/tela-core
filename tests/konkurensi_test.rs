// tests/konkurensi_test.rs
// Test modul konkurensi Telacore

use telacore_compiler::konkurensi::executor::jalankan_async;

async fn tambah_satu(angka: i32) -> i32 {
    angka + 1
}

async fn kali_dua(angka: i32) -> i32 {
    angka * 2
}

#[test]
fn test_tugas_async_dasar() {
    let handle = jalankan_async(tambah_satu(5));
    let hasil = handle.join().expect("Tugas panik");
    assert_eq!(hasil, 6);
}

#[test]
fn test_tugas_async_kali() {
    let handle = jalankan_async(kali_dua(10));
    let hasil = handle.join().expect("Tugas panik");
    assert_eq!(hasil, 20);
}

#[test]
fn test_banyak_tugas_paralel() {
    let h1 = jalankan_async(tambah_satu(100));
    let h2 = jalankan_async(kali_dua(50));
    let h3 = jalankan_async(tambah_satu(0));

    assert_eq!(h1.join().unwrap(), 101);
    assert_eq!(h2.join().unwrap(), 100);
    assert_eq!(h3.join().unwrap(), 1);
}
