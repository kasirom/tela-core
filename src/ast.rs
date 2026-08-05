use crate::token::{Token, TokenType};
use std::any::Any;

// Semua Node dalam AST
pub trait Node: Any {
    fn nilai_string(&self) -> String;
    fn as_any(&self) -> &dyn Any;
}

pub trait Pernyataan: Node {
    fn pernyataan_node(&self);
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan>;
}

impl Clone for Box<dyn Pernyataan> {
    fn clone(&self) -> Self {
        self.kloning_pernyataan()
    }
}

pub trait Ekspresi: Node {
    fn ekspresi_node(&self);
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi>;
}

impl Clone for Box<dyn Ekspresi> {
    fn clone(&self) -> Self {
        self.kloning_ekspresi()
    }
}

// Program adalah root dari AST
#[derive(Clone)]
pub struct Program {
    pub pernyataan_pernyataan: Vec<Box<dyn Pernyataan>>,
}

impl Node for Program {
    fn nilai_string(&self) -> String {
        let mut hasil = String::new();
        for p in &self.pernyataan_pernyataan {
            hasil.push_str(&p.nilai_string());
        }
        hasil
    }
    fn as_any(&self) -> &dyn Any { self }
}

// --- PERNYATAAN (Statements) ---

#[derive(Clone)]
pub struct PernyataanDeklarasi {
    pub token: Token, // 'ubah' atau 'konstanta'
    pub nama: Identitas,
    pub tipe_data: String,
    pub nilai: Box<dyn Ekspresi>,
    pub is_publik: bool,
}
impl Pernyataan for PernyataanDeklarasi { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanDeklarasi {
    fn nilai_string(&self) -> String {
        let pub_str = if self.is_publik { "publik " } else { "" };
        format!("{}{} {}: {} = {};\n", 
            pub_str,
            self.token.nilai_string(),
            self.nama.nilai_string(),
            self.tipe_data,
            self.nilai.nilai_string()
        )
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanPenugasan {
    pub token: Token, // '=', '+=', dll
    pub nama: Box<dyn Ekspresi>,
    pub operator: String,
    pub nilai: Box<dyn Ekspresi>,
}
impl Pernyataan for PernyataanPenugasan { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanPenugasan {
    fn nilai_string(&self) -> String {
        format!("{} {} {};\n", self.nama.nilai_string(), self.operator, self.nilai.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanKembalikan {
    pub token: Token,
    pub nilai: Box<dyn Ekspresi>,
}
impl Pernyataan for PernyataanKembalikan { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanKembalikan {
    fn nilai_string(&self) -> String {
        format!("kembalikan {};\n", self.nilai.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanEkspresi {
    pub token: Token,
    pub ekspresi: Box<dyn Ekspresi>,
}
impl Pernyataan for PernyataanEkspresi { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanEkspresi {
    fn nilai_string(&self) -> String {
        format!("{};\n", self.ekspresi.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanBlok {
    pub token: Token, // '{'
    pub pernyataan_pernyataan: Vec<Box<dyn Pernyataan>>,
}
impl Pernyataan for PernyataanBlok { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanBlok {
    fn nilai_string(&self) -> String {
        let mut hasil = String::from("{\n");
        for p in &self.pernyataan_pernyataan {
            hasil.push_str("  ");
            hasil.push_str(&p.nilai_string());
        }
        hasil.push_str("}\n");
        hasil
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanJika {
    pub token: Token, // 'jika' atau 'jikalau'
    pub kondisi: Box<dyn Ekspresi>,
    pub konsekuensi: PernyataanBlok,
    pub alternatif: Option<Box<dyn Pernyataan>>,
}
impl Pernyataan for PernyataanJika { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanJika {
    fn nilai_string(&self) -> String {
        let mut hasil = format!("jika {} maka {}", self.kondisi.nilai_string(), self.konsekuensi.nilai_string());
        if let Some(alt) = &self.alternatif {
            hasil.push_str(" lainnya ");
            hasil.push_str(&alt.nilai_string());
        }
        hasil
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanSelama {
    pub token: Token, // 'selama'
    pub kondisi: Box<dyn Ekspresi>,
    pub blok: PernyataanBlok,
}
impl Pernyataan for PernyataanSelama { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanSelama {
    fn nilai_string(&self) -> String {
        format!("selama {} lakukan {}", self.kondisi.nilai_string(), self.blok.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanPutar {
    pub token: Token, // 'putar'
    pub blok: PernyataanBlok,
}
impl Pernyataan for PernyataanPutar { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanPutar {
    fn nilai_string(&self) -> String {
        format!("putar {}", self.blok.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanHenti {
    pub token: Token,
}
impl Pernyataan for PernyataanHenti { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanHenti {
    fn nilai_string(&self) -> String { "henti;\n".to_string() }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanLanjut {
    pub token: Token,
}
impl Pernyataan for PernyataanLanjut { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanLanjut {
    fn nilai_string(&self) -> String { "lanjut;\n".to_string() }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanUntukDalam {
    pub token: Token, // 'untuk'
    pub variabel: Identitas, // 'x'
    pub iterable: Box<dyn Ekspresi>, // 'koleksi'
    pub blok: PernyataanBlok,
}
impl Pernyataan for PernyataanUntukDalam { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanUntukDalam {
    fn nilai_string(&self) -> String {
        format!("untuk {} dalam {} {}", self.variabel.nilai_string(), self.iterable.nilai_string(), self.blok.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct Parameter {
    pub nama: Identitas,
    pub tipe_data: String,
}

#[derive(Clone)]
pub struct PernyataanFungsi {
    pub token: Token, // 'fungsi'
    pub nama: Identitas,
    pub parameter: Vec<Parameter>,
    pub tipe_kembalian: String,
    pub tubuh: PernyataanBlok,
    pub is_publik: bool,
    pub is_async: bool,
    pub is_uji: bool,
    pub is_asing: bool,
}
impl Pernyataan for PernyataanFungsi { 
    fn pernyataan_node(&self) {} 
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanFungsi {
    fn nilai_string(&self) -> String {
        let mut params = Vec::new();
        for p in &self.parameter {
            params.push(format!("{}: {}", p.nama.nilai_string(), p.tipe_data));
        }
        let pub_str = if self.is_publik { "publik " } else { "" };
        let async_str = if self.is_async { "tugas " } else { "" };
        let uji_str = if self.is_uji { "uji " } else { "" };
        let asing_str = if self.is_asing { "asing " } else { "" };
        format!("{}{}{}{}fungsi {}({}) -> {} {}", pub_str, async_str, uji_str, asing_str, self.nama.nilai_string(), params.join(", "), self.tipe_kembalian, self.tubuh.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}


#[derive(Clone)]
pub struct PernyataanAliasTipe {
    pub token: Token, // 'tipe'
    pub nama: Identitas,
    pub tipe_asli: String,
    pub is_publik: bool,
}
impl Pernyataan for PernyataanAliasTipe {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanAliasTipe {
    fn nilai_string(&self) -> String {
        let pub_str = if self.is_publik { "publik " } else { "" };
        format!("{}tipe {} = {};", pub_str, self.nama.nilai_string(), self.tipe_asli)
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanSifat {
    pub token: Token, // 'sifat'
    pub nama: Identitas,
    pub metode: Vec<PernyataanFungsi>,
    pub is_publik: bool,
}
impl Pernyataan for PernyataanSifat {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanSifat {
    fn nilai_string(&self) -> String {
        let pub_str = if self.is_publik { "publik " } else { "" };
        format!("{}sifat {} {{\n}}\n", pub_str, self.nama.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanImplementasiSifat {
    pub token: Token, // 'implementasi'
    pub nama_sifat: Identitas,
    pub nama_target: Identitas,
    pub metode: Vec<PernyataanFungsi>,
}
impl Pernyataan for PernyataanImplementasiSifat {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanImplementasiSifat {
    fn nilai_string(&self) -> String {
        format!("implementasi {} untuk {} {{\n}}\n", self.nama_sifat.nilai_string(), self.nama_target.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}




// --- EKSPRESI (Expressions) ---

#[derive(Clone)]
pub struct Identitas {
    pub token: Token,
    pub nilai: String,
}
impl Ekspresi for Identitas { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for Identitas { 
    fn nilai_string(&self) -> String { self.nilai.clone() }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralBilangan {
    pub token: Token,
    pub nilai: i64,
}
impl Ekspresi for LiteralBilangan { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralBilangan { 
    fn nilai_string(&self) -> String { self.nilai.to_string() }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralDesimal {
    pub token: Token,
    pub nilai: f64,
}
impl Ekspresi for LiteralDesimal { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralDesimal { 
    fn nilai_string(&self) -> String { self.nilai.to_string() }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralTeks {
    pub token: Token,
    pub nilai: String,
}
impl Ekspresi for LiteralTeks { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralTeks { 
    fn nilai_string(&self) -> String { format!("\"{}\"", self.nilai) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralKarakter {
    pub token: Token,
    pub nilai: char,
}
impl Ekspresi for LiteralKarakter { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralKarakter { 
    fn nilai_string(&self) -> String { format!("'{}'", self.nilai) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralLogika {
    pub token: Token,
    pub nilai: bool,
}
impl Ekspresi for LiteralLogika { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralLogika { 
    fn nilai_string(&self) -> String { 
        if self.nilai { "benar".to_string() } else { "salah".to_string() }
    } 
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralDaftar {
    pub token: Token, // '['
    pub elemen: Vec<Box<dyn Ekspresi>>,
}
impl Ekspresi for LiteralDaftar { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralDaftar {
    fn nilai_string(&self) -> String {
        let mut list = Vec::new();
        for e in &self.elemen {
            list.push(e.nilai_string());
        }
        format!("[{}]", list.join(", "))
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralTuple {
    pub token: Token, // '('
    pub elemen: Vec<Box<dyn Ekspresi>>,
}
impl Ekspresi for LiteralTuple {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralTuple {
    fn nilai_string(&self) -> String {
        let mut list = Vec::new();
        for e in &self.elemen {
            list.push(e.nilai_string());
        }
        format!("({})", list.join(", "))
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct LiteralKamus {
    pub token: Token, // '{'
    pub pasangan: Vec<(Box<dyn Ekspresi>, Box<dyn Ekspresi>)>,
}
impl Ekspresi for LiteralKamus { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for LiteralKamus {
    fn nilai_string(&self) -> String {
        let mut isi = Vec::new();
        for (k, v) in &self.pasangan {
            isi.push(format!("{}: {}", k.nilai_string(), v.nilai_string()));
        }
        format!("{{{}}}", isi.join(", "))
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiPrefix {
    pub token: Token,
    pub operator: String,
    pub kanan: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiPrefix { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiPrefix {
    fn nilai_string(&self) -> String {
        format!("({}{})", self.operator, self.kanan.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiInfix {
    pub token: Token,
    pub kiri: Box<dyn Ekspresi>,
    pub operator: String,
    pub kanan: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiInfix { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiInfix {
    fn nilai_string(&self) -> String {
        format!("({} {} {})", self.kiri.nilai_string(), self.operator, self.kanan.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiPanggil {
    pub token: Token, // '('
    pub fungsi: Box<dyn Ekspresi>,
    pub argumen: Vec<Box<dyn Ekspresi>>,
}
impl Ekspresi for EkspresiPanggil { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiPanggil {
    fn nilai_string(&self) -> String {
        let mut args = Vec::new();
        for a in &self.argumen {
            args.push(a.nilai_string());
        }
        format!("{}({})", self.fungsi.nilai_string(), args.join(", "))
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiIndeks {
    pub token: Token, // '['
    pub kiri: Box<dyn Ekspresi>,
    pub indeks: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiIndeks {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiIndeks {
    fn nilai_string(&self) -> String {
        format!("{}[{}]", self.kiri.nilai_string(), self.indeks.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiAksesProperti {
    pub token: Token, // '.'
    pub kiri: Box<dyn Ekspresi>,
    pub properti: Token, // bisa berupa Identitas atau Bilangan (untuk tuple)
}
impl Ekspresi for EkspresiAksesProperti {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiAksesProperti {
    fn nilai_string(&self) -> String {
        let prop_str = match &self.properti.tipe {
            TokenType::Identitas(nama) => nama.clone(),
            TokenType::Bilangan(n) => n.to_string(),
            _ => format!("{:?}", self.properti.tipe),
        };
        format!("{}.{}", self.kiri.nilai_string(), prop_str)
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiKosong;
impl Ekspresi for EkspresiKosong { 
    fn ekspresi_node(&self) {} 
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiKosong { 
    fn nilai_string(&self) -> String { String::from("") } 
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiPath {
    pub token: Token, // Token pertama (Identitas atau ::)
    pub bagian: Vec<String>,
}
impl Ekspresi for EkspresiPath {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiPath {
    fn nilai_string(&self) -> String {
        self.bagian.join("::")
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiKonversi {
    pub token: Token, // 'sebagai'
    pub ekspresi: Box<dyn Ekspresi>,
    pub tipe_tujuan: String,
}
impl Ekspresi for EkspresiKonversi {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiKonversi {
    fn nilai_string(&self) -> String {
        format!("{} sebagai {}", self.ekspresi.nilai_string(), self.tipe_tujuan)
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiBlok {
    pub token: Token, // '{'
    pub blok: PernyataanBlok,
}
impl Ekspresi for EkspresiBlok {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiBlok {
    fn nilai_string(&self) -> String {
        self.blok.nilai_string()
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanModul {
    pub token: Token, // 'modul'
    pub nama: String,
    pub blok: Option<PernyataanBlok>, // None jika modul file: `modul nama;`
    pub is_publik: bool,
}
impl Pernyataan for PernyataanModul {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanModul {
    fn nilai_string(&self) -> String {
        let pub_str = if self.is_publik { "publik " } else { "" };
        if let Some(b) = &self.blok {
            format!("{}modul {} {}", pub_str, self.nama, b.nilai_string())
        } else {
            format!("{}modul {};\n", pub_str, self.nama)
        }
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanGunakan {
    pub token: Token, // 'gunakan'
    pub jalur: Vec<String>,
    pub semua: bool, // true jika diakhiri dengan ::*
}
impl Pernyataan for PernyataanGunakan {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanGunakan {
    fn nilai_string(&self) -> String {
        let mut j = self.jalur.join("::");
        if self.semua {
            j.push_str("::*");
        }
        format!("gunakan {};\n", j)
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanStruktur {
    pub token: Token,
    pub nama: Identitas,
    pub properti: Vec<(Identitas, String)>,
    pub is_publik: bool,
}
impl Pernyataan for PernyataanStruktur {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanStruktur {
    fn nilai_string(&self) -> String {
        let mut prop = Vec::new();
        for (n, t) in &self.properti {
            prop.push(format!("{}: {}", n.nilai_string(), t));
        }
        let pub_str = if self.is_publik { "publik " } else { "" };
        format!("{}struktur {} {{\n  {}\n}}\n", pub_str, self.nama.nilai_string(), prop.join(",\n  "))
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct VarianEnum {
    pub nama: Identitas,
    pub tipe_data: Option<Vec<String>>,
}

#[derive(Clone)]
pub struct PernyataanEnum {
    pub token: Token,
    pub nama: Identitas,
    pub varian: Vec<VarianEnum>,
    pub is_publik: bool,
}
impl Pernyataan for PernyataanEnum {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanEnum {
    fn nilai_string(&self) -> String {
        let pub_str = if self.is_publik { "publik " } else { "" };
        format!("{}enum {} {{ ... }}\n", pub_str, self.nama.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanImplementasi {
    pub token: Token,
    pub nama: Identitas,
    pub metode: Vec<Box<dyn Pernyataan>>,
}
impl Pernyataan for PernyataanImplementasi {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanImplementasi {
    fn nilai_string(&self) -> String {
        format!("implementasi {} {{ ... }}\n", self.nama.nilai_string())
    }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiInisiasiStruktur {
    pub token: Token,
    pub nama: Identitas,
    pub properti: Vec<(Identitas, Box<dyn Ekspresi>)>,
}
impl Ekspresi for EkspresiInisiasiStruktur {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiInisiasiStruktur {
    fn nilai_string(&self) -> String {
        let mut prop = Vec::new();
        for (n, e) in &self.properti {
            prop.push(format!("{}: {}", n.nilai_string(), e.nilai_string()));
        }
        format!("{} {{ {} }}", self.nama.nilai_string(), prop.join(", "))
    }
    fn as_any(&self) -> &dyn Any { self }
}

// --- Fase 6A: Referensi (&) dan Dereference (*) ---

/// Ekspresi Referensi: `&x` - menghasilkan pointer ke x
#[derive(Clone)]
pub struct EkspresiReferensi {
    pub token: Token, // token '&'
    pub nilai: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiReferensi {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiReferensi {
    fn nilai_string(&self) -> String { format!("&{}", self.nilai.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

/// Ekspresi Deref: `*x` - mengambil nilai dari pointer
#[derive(Clone)]
pub struct EkspresiDeref {
    pub token: Token, // token '*'
    pub nilai: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiDeref {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiDeref {
    fn nilai_string(&self) -> String { format!("*{}", self.nilai.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

/// Ekspresi Kotak: `kotak(nilai)` - alokasi di heap
#[derive(Clone)]
pub struct EkspresiKotak {
    pub token: Token, // token 'kotak'
    pub nilai: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiKotak {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiKotak {
    fn nilai_string(&self) -> String { format!("kotak({})", self.nilai.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

// --- Fase 6B: Referensi Mutable (&ubah) ---

/// Ekspresi Referensi Mutable: `&ubah x` - pointer yang bisa mengubah nilai
#[derive(Clone)]
pub struct EkspresiReferensiUbah {
    pub token: Token, // token '&'
    pub nilai: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiReferensiUbah {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiReferensiUbah {
    fn nilai_string(&self) -> String { format!("&ubah {}", self.nilai.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

// --- Fase 7: Pattern Matching (cocokkan) & Error Handling (coba) ---

#[derive(Clone)]
pub enum Pola {
    Literal(Box<dyn Ekspresi>),
    Varian { nama: String, variabel: Vec<String> },
    Variabel(String),
    Wildcard,
}

#[derive(Clone)]
pub struct CabangCocokkan {
    pub pola: Pola,
    pub ekspresi: Box<dyn Ekspresi>,
}

#[derive(Clone)]
pub struct EkspresiCocokkan {
    pub token: Token, // token 'cocokkan'
    pub target: Box<dyn Ekspresi>,
    pub cabang: Vec<CabangCocokkan>,
}
impl Ekspresi for EkspresiCocokkan {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiCocokkan {
    fn nilai_string(&self) -> String { format!("cocokkan {}", self.target.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiCoba {
    pub token: Token, // token 'coba'
    pub ekspresi: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiCoba {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiCoba {
    fn nilai_string(&self) -> String { format!("coba {}", self.ekspresi.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiVektorBaru {
    pub token: Token, // 'vektor_baru'
    pub tipe_elemen: String,
}
impl Ekspresi for EkspresiVektorBaru {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiVektorBaru {
    fn nilai_string(&self) -> String { format!("vektor_baru<{}>()", self.tipe_elemen) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct EkspresiTunggu {
    pub token: Token, // 'tunggu'
    pub ekspresi: Box<dyn Ekspresi>,
}
impl Ekspresi for EkspresiTunggu {
    fn ekspresi_node(&self) {}
    fn kloning_ekspresi(&self) -> Box<dyn Ekspresi> { Box::new(self.clone()) }
}
impl Node for EkspresiTunggu {
    fn nilai_string(&self) -> String { format!("tunggu {}", self.ekspresi.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanPantauMemori {
    pub token: Token, // 'pantau_memori'
    pub nama: Identitas,
}
impl Pernyataan for PernyataanPantauMemori {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanPantauMemori {
    fn nilai_string(&self) -> String { format!("pantau_memori {};", self.nama.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

#[derive(Clone)]
pub struct PernyataanAman {
    pub token: Token, // 'aman'
    pub blok: PernyataanBlok,
}
impl Pernyataan for PernyataanAman {
    fn pernyataan_node(&self) {}
    fn kloning_pernyataan(&self) -> Box<dyn Pernyataan> { Box::new(self.clone()) }
}
impl Node for PernyataanAman {
    fn nilai_string(&self) -> String { format!("aman {}", self.blok.nilai_string()) }
    fn as_any(&self) -> &dyn Any { self }
}

