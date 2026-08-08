#[derive(Debug, PartialEq, Clone)]
pub enum TokenType {
    // --- KATA KUNCI (Keywords) ---
    Ubah,           // ubah
    Konstanta,      // konstanta
    Fungsi,         // fungsi
    Kembalikan,     // kembalikan
    Jika,           // jika
    Jikalau,        // jikalau (else if)
    Maka,           // maka
    Lainnya,        // lainnya
    Selama,         // selama
    Putar,          // putar (loop)
    Untuk,          // untuk
    Dalam,          // dalam
    Henti,          // henti (break)
    Lanjut,         // lanjut
    Impor,          // impor
    Dari,           // dari
    Eksternal,      // eksternal
    Ekspor,         // ekspor
    Paket,          // paket
    Kelas,          // kelas
    Antarmuka,      // antarmuka
    Pilihan,        // pilihan
    Coba,           // coba
    Tangkap,        // tangkap
    Lempar,         // lempar
    Modul,          // modul
    Gunakan,        // gunakan
    Baru,           // baru
    Ini,            // ini
    Warisan,        // warisan
    Publik,         // publik
    Pribadi,        // pribadi
    Terlindungi,    // terlindungi
    Statis,         // statis
    Struktur,       // struktur
    Enum,           // enum
    Implementasi,   // implementasi
    Paralel,        // paralel (konkurensi block)
    Async,          // async (async/await)
    Makro,          // makro (macro definition)
    DiriKecil,      // diri
    DiriBesar,      // Diri
    Tipe,           // tipe
    Sebagai,        // sebagai
    PantauMemori,   // pantau_memori
    Kotak,          // kotak (Box/smart pointer)
    Cocokkan,       // cocokkan
    PanahTebal,     // =>
    GarisBawah,     // _
    Sifat,          // sifat (Trait)
    Tugas,          // tugas (async function)
    Tunggu,         // tunggu (await)
    Bahaya,         // bahaya (unsafe block)
    Panik,          // panik (panic)
    Vektor,         // vektor (Vec - dynamic array)
    VektorBaru,     // vektor_baru (dynamic array constructor)
    Potongan,       // potongan (slice)
    RefBersama,     // ref_bersama (Rc/Arc)
    Uji,            // uji (test attribute)
    Asing,          // asing (extern/FFI)
    Pakai,          // pakai (use/import alias)
    Bentuk,         // bentuk (struct alias)
    Aman,           // aman (auto-safe block)

    // --- TIPE DATA ---
    TipeBilangan,   // bilangan
    TipeDesimal,    // desimal
    TipeTeks,       // teks
    TipeLogika,     // logika
    TipeKosong,     // kosong
    TipeKarakter,   // karakter
    TipeDaftar,     // daftar
    TipeKamus,      // kamus

    // --- LITERAL ---
    Identitas(String),
    Bilangan(i64),
    Desimal(f64),
    Teks(String),
    Karakter(char),
    Benar,          // benar
    Salah,          // salah

    // --- OPERATOR MATEMATIKA & LOGIKA ---
    Tambah,         // +
    Kurang,         // -
    Kali,           // *
    Bagi,           // /
    SisaBagi,       // %
    Pangkat,        // ^
    
    // Increment & Decrement
    TambahSatu,     // ++
    KurangSatu,     // --
    
    // Assignment (Penugasan)
    SamaDengan,     // =
    TambahSama,     // +=
    KurangSama,     // -=
    KaliSama,       // *=
    BagiSama,       // /=
    SisaBagiSama,   // %=
    PangkatSama,    // ^=

    // Perbandingan
    Setara,         // ==
    TidakSetara,    // !=
    LebihBesar,     // >
    LebihKecil,     // <
    LebihBesarSetara, // >=
    LebihKecilSetara, // <=

    // Logika Simbolik
    LogikaDan,      // &&
    LogikaAtau,     // ||
    Tidak,          // !
    
    // Logika Teks
    Dan,            // dan
    Atau,           // atau

    // --- OPERATOR BITWISE ---
    BitDan,         // &
    BitAtau,        // |
    BitTidak,       // ~
    BitXor,         // ^ (Note: Tela Core map ^ to Pangkat, you can decide later)
    GeserKiri,      // <<
    GeserKanan,     // >>
    GeserKiriSama,  // <<=
    GeserKananSama, // >>=

    // --- SIMBOL & TANDA BACA ---
    KurungBuka,     // (
    KurungTutup,    // )
    KurungSikuBuka, // [
    KurungSikuTutup,// ]
    KurungKurawalBuka, // {
    KurungKurawalTutup,// }
    TitikDua,       // :
    TitikKoma,      // ;
    Koma,           // ,
    Titik,          // .
    TitikTitikDua,  // ::
    Rentang,        // ..
    Panah,          // ->
    TandaTanya,     // ?
    TandaAt,        // @

    Eof,            // Akhir dari file
    Illegal(char),  // Karakter tak dikenal
}

#[derive(Debug, PartialEq, Clone)]
pub struct Token {
    pub tipe: TokenType,
    pub baris: usize,
    pub kolom: usize,
}

impl Token {
    pub fn new(tipe: TokenType, baris: usize, kolom: usize) -> Self {
        Token { tipe, baris, kolom }
    }
    
    pub fn nilai_string(&self) -> String {
        match &self.tipe {
            TokenType::Ubah => "ubah".to_string(),
            TokenType::Konstanta => "konstanta".to_string(),
            TokenType::Fungsi => "fungsi".to_string(),
            TokenType::Kembalikan => "kembalikan".to_string(),
            TokenType::Jika => "jika".to_string(),
            TokenType::Jikalau => "jikalau".to_string(),
            TokenType::Maka => "maka".to_string(),
            TokenType::Lainnya => "lainnya".to_string(),
            TokenType::Selama => "selama".to_string(),
            TokenType::Dalam => "dalam".to_string(),
            TokenType::Henti => "henti".to_string(),
            TokenType::Lanjut => "lanjut".to_string(),
            TokenType::Rentang => "..".to_string(),
            TokenType::TitikTitikDua => "::".to_string(),
            TokenType::Panah => "->".to_string(),
            TokenType::Modul => "modul".to_string(),
            TokenType::Gunakan => "gunakan".to_string(),
            TokenType::Tipe => "tipe".to_string(),
            TokenType::Sebagai => "sebagai".to_string(),
            TokenType::Pribadi => "pribadi".to_string(),
            TokenType::PantauMemori => "pantau_memori".to_string(),
            TokenType::Kotak => "kotak".to_string(),
            TokenType::Vektor => "vektor".to_string(),
            TokenType::VektorBaru => "vektor_baru".to_string(),
            TokenType::Identitas(nama) => nama.clone(),
            TokenType::Paralel => "paralel".to_string(),
            TokenType::Async => "async".to_string(),
            TokenType::Makro => "makro".to_string(),
            TokenType::Aman => "aman".to_string(),
            _ => format!("{:?}", self.tipe),
        }
    }
}
