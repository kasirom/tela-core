use crate::ast::*;
use crate::lexer::Lexer;
use crate::token::{Token, TokenType};
use std::path::{Path, PathBuf};

#[derive(PartialEq, PartialOrd, Clone, Copy)]
pub enum Prioritas {
    Terendah = 1,
    Rentang,    // ..
    Atau,       // ||
    Dan,        // &&
    Setara,     // == !=
    Banding,    // > < >= <=
    Bitwise,    // &, |, ^, <<, >>
    Jumlah,     // + -
    Kali,       // * / %
    Pangkat,    // ^
    Sebagai,    // sebagai
    Prefix,     // -X !X ~X
    Pemanggilan,// fungsi(x)
    Properti,   // a.b atau a.0
    Path,       // a::b
}

fn prioritas_token(tipe: &TokenType) -> Prioritas {
    match tipe {
        TokenType::LogikaAtau => Prioritas::Atau,
        TokenType::LogikaDan => Prioritas::Dan,
        TokenType::Setara | TokenType::TidakSetara => Prioritas::Setara,
        TokenType::LebihBesar | TokenType::LebihKecil | TokenType::LebihBesarSetara | TokenType::LebihKecilSetara => Prioritas::Banding,
        TokenType::BitDan | TokenType::BitAtau | TokenType::BitXor | TokenType::GeserKiri | TokenType::GeserKanan => Prioritas::Bitwise,
        TokenType::Tambah | TokenType::Kurang => Prioritas::Jumlah,
        TokenType::Kali | TokenType::Bagi | TokenType::SisaBagi => Prioritas::Kali,
        TokenType::Pangkat => Prioritas::Pangkat,
        TokenType::Sebagai => Prioritas::Sebagai,
        TokenType::KurungBuka | TokenType::KurungSikuBuka => Prioritas::Pemanggilan,
        TokenType::Titik => Prioritas::Properti,
        TokenType::TitikTitikDua => Prioritas::Path,
        TokenType::Rentang => Prioritas::Rentang,
        _ => Prioritas::Terendah,
    }
}

pub struct Parser<'a> {
    lexer: &'a mut Lexer,
    token_sekarang: Token,
    token_intip: Token,
    pub pesan_error: Vec<String>,
    base_dir: Option<PathBuf>,
}

impl<'a> Parser<'a> {
    pub fn new(lexer: &'a mut Lexer) -> Self {
        Self::new_with_base_dir(lexer, None)
    }

    pub fn new_with_base_dir(lexer: &'a mut Lexer, base_dir: Option<PathBuf>) -> Self {
        let mut p = Parser {
            lexer,
            token_sekarang: Token::new(TokenType::Eof, 0, 0),
            token_intip: Token::new(TokenType::Eof, 0, 0),
            pesan_error: Vec::new(),
            base_dir: base_dir.or_else(|| std::env::current_dir().ok()),
        };
        p.lanjut_token();
        p.lanjut_token();
        p
    }

    pub fn lanjut_token(&mut self) {
        self.token_sekarang = self.token_intip.clone();
        self.token_intip = self.lexer.token_selanjutnya();
    }

    fn cek_tipe_sekarang(&self, harapan: &TokenType) -> bool {
        std::mem::discriminant(&self.token_sekarang.tipe) == std::mem::discriminant(harapan)
    }

    fn cocokkan(&mut self, harapan: &TokenType) -> bool {
        if self.cek_tipe_sekarang(harapan) {
            self.lanjut_token();
            true
        } else {
            false
        }
    }

    fn harapkan(&mut self, harapan: &TokenType, pesan: &str) -> bool {
        if !self.cocokkan(harapan) {
            self.pesan_error.push(format!(
                "{} di baris {}, kolom {}",
                pesan, self.token_sekarang.baris, self.token_sekarang.kolom
            ));
            false
        } else {
            true
        }
    }

    fn sinkronkan(&mut self) {
        while self.token_sekarang.tipe != TokenType::TitikKoma 
              && self.token_sekarang.tipe != TokenType::Eof {
            self.lanjut_token();
        }
        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        }
    }

    pub fn parse_program(&mut self) -> Program {
        let mut program = Program {
            pernyataan_pernyataan: Vec::new(),
        };

        while self.token_sekarang.tipe != TokenType::Eof {
            if self.token_sekarang.tipe == TokenType::Impor {
                self.parse_impor(&mut program.pernyataan_pernyataan);
            } else if let Some(pernyataan) = self.parse_pernyataan() {
                program.pernyataan_pernyataan.push(pernyataan);
            }
        }

        program
    }

    fn parse_pernyataan(&mut self) -> Option<Box<dyn Pernyataan>> {
        let mut is_publik = false;
        let mut is_async = false;
        let mut is_uji = false;
        let mut is_asing = false;
        
        loop {
            match self.token_sekarang.tipe {
                TokenType::TitikKoma => {
                    self.lanjut_token();
                    return None;
                }
                TokenType::Publik => {
                    is_publik = true;
                    self.lanjut_token();
                }
                TokenType::Pribadi => {
                    self.lanjut_token(); // lewat 'pribadi'
                }
                TokenType::Tugas => {
                    is_async = true;
                    self.lanjut_token();
                }
                TokenType::Uji => {
                    is_uji = true;
                    self.lanjut_token();
                }
                TokenType::Asing => {
                    is_asing = true;
                    self.lanjut_token();
                }
                _ => break,
            }
        }
        
        match self.token_sekarang.tipe {
            TokenType::Aman => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada 'aman'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada 'aman'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada 'aman'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada 'aman'".to_string()); }
                self.parse_pernyataan_aman()
            },
            TokenType::PantauMemori => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada 'pantau_memori'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada 'pantau_memori'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada 'pantau_memori'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada 'pantau_memori'".to_string()); }
                self.parse_pernyataan_pantau_memori()
            },
            TokenType::Ubah | TokenType::Konstanta => {
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada deklarasi peubah".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada deklarasi peubah".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada deklarasi peubah".to_string()); }
                self.parse_deklarasi(is_publik)
            },
            TokenType::Kembalikan => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada 'kembalikan'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada 'kembalikan'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada 'kembalikan'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada 'kembalikan'".to_string()); }
                self.parse_kembalikan()
            },
            TokenType::Jika | TokenType::Lainnya => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada pernyataan kondisi".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada pernyataan kondisi".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada pernyataan kondisi".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada pernyataan kondisi".to_string()); }
                self.parse_pernyataan_jika()
            },
            TokenType::Selama => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada pernyataan 'selama'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada pernyataan 'selama'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada pernyataan 'selama'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada pernyataan 'selama'".to_string()); }
                self.parse_pernyataan_selama()
            },
            TokenType::Putar => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada pernyataan 'putar'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada pernyataan 'putar'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada pernyataan 'putar'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada pernyataan 'putar'".to_string()); }
                self.parse_pernyataan_putar()
            },
            TokenType::Untuk => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada pernyataan 'untuk'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada pernyataan 'untuk'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada pernyataan 'untuk'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada pernyataan 'untuk'".to_string()); }
                self.parse_pernyataan_untuk_dalam()
            },
            TokenType::Fungsi => self.parse_pernyataan_fungsi(is_publik, is_async, is_uji, is_asing),
            TokenType::Modul => {
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada modul".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada modul".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada modul".to_string()); }
                self.parse_pernyataan_modul(is_publik)
            },
            TokenType::Gunakan => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada pernyataan 'gunakan'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada pernyataan 'gunakan'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada pernyataan 'gunakan'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada pernyataan 'gunakan'".to_string()); }
                self.parse_pernyataan_gunakan()
            },
            TokenType::Struktur => {
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada struktur".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada struktur".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada struktur".to_string()); }
                self.parse_pernyataan_struktur(is_publik)
            },
            TokenType::Enum => {
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada enum".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada enum".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada enum".to_string()); }
                self.parse_pernyataan_enum(is_publik)
            },
            TokenType::Tipe => {
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada alias tipe".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada alias tipe".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada alias tipe".to_string()); }
                self.parse_pernyataan_alias_tipe(is_publik)
            },
            TokenType::Sifat => {
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada sifat".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada sifat".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada sifat".to_string()); }
                self.parse_pernyataan_sifat(is_publik)
            },
            TokenType::Implementasi => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada 'implementasi'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada 'implementasi'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada 'implementasi'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada 'implementasi'".to_string()); }
                self.parse_pernyataan_implementasi()
            },
            TokenType::Henti => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada 'henti'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada 'henti'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada 'henti'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada 'henti'".to_string()); }
                let p = PernyataanHenti { token: self.token_sekarang.clone() };
                self.lanjut_token();
                Some(Box::new(p))
            },
            TokenType::Lanjut => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada 'lanjut'".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada 'lanjut'".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada 'lanjut'".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada 'lanjut'".to_string()); }
                let p = PernyataanLanjut { token: self.token_sekarang.clone() };
                self.lanjut_token();
                Some(Box::new(p))
            },
            _ => {
                if is_publik { self.pesan_error.push("Modifier 'publik' tidak diizinkan pada pernyataan ekspresi".to_string()); }
                if is_async { self.pesan_error.push("Modifier 'tugas' tidak diizinkan pada pernyataan ekspresi".to_string()); }
                if is_uji { self.pesan_error.push("Modifier 'uji' tidak diizinkan pada pernyataan ekspresi".to_string()); }
                if is_asing { self.pesan_error.push("Modifier 'asing' tidak diizinkan pada pernyataan ekspresi".to_string()); }
                self.parse_ekspresi_atau_penugasan()
            }
        }
    }

    fn resolve_import_path(&self, path_file: &str) -> PathBuf {
        let raw_path = Path::new(path_file);
        if raw_path.is_absolute() {
            return raw_path.to_path_buf();
        }

        let mut candidates = Vec::new();
        if let Some(base) = &self.base_dir {
            candidates.push(base.join(raw_path));
        }
        if let Ok(cwd) = std::env::current_dir() {
            candidates.push(cwd.join(raw_path));
        }

        candidates.into_iter().find(|p| p.exists()).unwrap_or_else(|| {
            if let Some(base) = &self.base_dir {
                base.join(raw_path)
            } else {
                raw_path.to_path_buf()
            }
        })
    }

    fn parse_impor(&mut self, pernyataan_pernyataan: &mut Vec<Box<dyn Pernyataan>>) {
        self.lanjut_token(); // Lewati token 'impor'
        
        let path_file = if let TokenType::Teks(path) = &self.token_sekarang.tipe {
            path.clone()
        } else {
            self.pesan_error.push(format!("Diharapkan string path file setelah 'impor' di baris {}", self.token_sekarang.baris));
            return;
        };
        self.lanjut_token(); // Lewati token string
        
        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        }

        let resolved_path = self.resolve_import_path(&path_file);
        let resolved_parent = resolved_path.parent().map(Path::to_path_buf);

        // Baca file target
        match std::fs::read_to_string(&resolved_path) {
            Ok(isi) => {
                let mut lexer_impor = Lexer::new(&isi);
                let mut parser_impor = Parser::new_with_base_dir(&mut lexer_impor, resolved_parent);
                let program_impor = parser_impor.parse_program();
                
                if !parser_impor.pesan_error.is_empty() {
                    for err in parser_impor.pesan_error {
                        self.pesan_error.push(format!("[Impor {}] {}", path_file, err));
                    }
                } else {
                    pernyataan_pernyataan.extend(program_impor.pernyataan_pernyataan);
                }
            }
            Err(e) => {
                self.pesan_error.push(format!("Gagal memuat impor '{}': {}", path_file, e));
            }
        }
    }

    // --- PARSING PERNYATAAN ---

    fn parse_deklarasi(&mut self, is_publik: bool) -> Option<Box<dyn Pernyataan>> {
        let token_awal = self.token_sekarang.clone();
        self.lanjut_token(); 
        
        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(nama_str) => Identitas {
                token: self.token_sekarang.clone(),
                nilai: nama_str.clone(),
            },
            _ => {
                self.pesan_error.push(format!("Diharapkan Identitas, tapi mendapat {:?}", self.token_sekarang.tipe));
                self.sinkronkan();
                return None;
            }
        };

        self.lanjut_token();
        
        let tipe_data = if self.token_sekarang.tipe == TokenType::TitikDua {
            self.lanjut_token();
            match self.parse_tipe_data() {
                Some(t) => t,
                None => return None,
            }
        } else {
            "bebas".to_string()
        };

        if !self.harapkan(&TokenType::SamaDengan, "Diharapkan tanda sama dengan '='") {
            self.sinkronkan();
            return None;
        }

        let nilai = match self.parse_ekspresi(Prioritas::Terendah) {
            Some(eks) => eks,
            None => {
                self.sinkronkan();
                return None;
            }
        };

        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        }

        Some(Box::new(PernyataanDeklarasi {
            token: token_awal,
            nama,
            tipe_data,
            nilai,
            is_publik,
        }))
    }

    fn parse_kembalikan(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token();

        let nilai = if self.token_sekarang.tipe == TokenType::TitikKoma {
            Box::new(EkspresiKosong)
        } else {
            match self.parse_ekspresi(Prioritas::Terendah) {
                Some(eks) => eks,
                None => {
                    self.sinkronkan();
                    return None;
                }
            }
        };

        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        }

        Some(Box::new(PernyataanKembalikan { token, nilai }))
    }

    fn parse_ekspresi_atau_penugasan(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token_awal = self.token_sekarang.clone();
        let lhs = match self.parse_ekspresi(Prioritas::Terendah) {
            Some(e) => e,
            None => {
                self.sinkronkan();
                return None;
            }
        };

        if self.is_assignment_op(&self.token_sekarang.tipe) {
            let token_op = self.token_sekarang.clone();
            let operator = match &token_op.tipe {
                TokenType::SamaDengan => "=",
                TokenType::TambahSama => "+=",
                TokenType::KurangSama => "-=",
                TokenType::KaliSama => "*=",
                TokenType::BagiSama => "/=",
                TokenType::SisaBagiSama => "%=",
                TokenType::PangkatSama => "^=",
                TokenType::GeserKiriSama => "<<=",
                TokenType::GeserKananSama => ">>=",
                _ => unreachable!(),
            }.to_string();
            
            self.lanjut_token(); // lewat operator penugasan

            let nilai = match self.parse_ekspresi(Prioritas::Terendah) {
                Some(eks) => eks,
                None => {
                    self.sinkronkan();
                    return None;
                }
            };

            if self.token_sekarang.tipe == TokenType::TitikKoma {
                self.lanjut_token();
            }

            return Some(Box::new(PernyataanPenugasan {
                token: token_op,
                nama: lhs,
                operator,
                nilai,
            }));
        }

        // Kalau bukan penugasan, berarti ekspresi murni
        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        }

        Some(Box::new(PernyataanEkspresi { token: token_awal, ekspresi: lhs }))
    }

    fn is_assignment_op(&self, tipe: &TokenType) -> bool {
        matches!(tipe,
            TokenType::SamaDengan | TokenType::TambahSama | TokenType::KurangSama | 
            TokenType::KaliSama | TokenType::BagiSama | TokenType::SisaBagiSama | 
            TokenType::PangkatSama | TokenType::GeserKiriSama | TokenType::GeserKananSama
        )
    }

    fn parse_blok_pernyataan(&mut self) -> Option<PernyataanBlok> {
        let token = self.token_sekarang.clone();
        if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{'") { return None; }
        
        let mut pernyataan_pernyataan = Vec::new();
        while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
            if let Some(p) = self.parse_pernyataan() {
                pernyataan_pernyataan.push(p);
            }
        }
        
        if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }
        
        Some(PernyataanBlok { token, pernyataan_pernyataan })
    }

    fn parse_pernyataan_jika(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token_awal = self.token_sekarang.clone();
        
        if token_awal.tipe == TokenType::Jikalau || token_awal.tipe == TokenType::Lainnya {
            self.pesan_error.push(format!("'{}' tidak bisa berdiri sendiri tanpa 'jika' sebelumnya di baris {}, kolom {}", token_awal.nilai_string(), token_awal.baris, token_awal.kolom));
            self.sinkronkan();
            return None;
        }
        
        self.lanjut_token(); // lewat 'jika'

        // Tanda kurung opsional: `jika kondisi { }` atau `jika (kondisi) { }`
        let pakai_kurung = self.token_sekarang.tipe == TokenType::KurungBuka;
        if pakai_kurung {
            self.lanjut_token(); // lewat '('
        }
        
        let kondisi = self.parse_ekspresi(Prioritas::Terendah)?;
        
        if pakai_kurung {
            if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')' setelah kondisi") { return None; }
        }
        
        // 'maka' opsional: `jika kondisi maka { }` atau `jika kondisi { }`
        if self.token_sekarang.tipe == TokenType::Maka {
            self.lanjut_token(); // lewat 'maka'
        }
        
        let konsekuensi = self.parse_blok_pernyataan()?;
        let mut alternatif = None;
        
        if self.token_sekarang.tipe == TokenType::Lainnya {
            if self.token_intip.tipe == TokenType::Jika {
                self.lanjut_token(); // lewat 'lainnya'
                // Sekarang token_sekarang adalah 'jika', parse secara rekursif
                if let Some(pernyataan_jika) = self.parse_pernyataan_jika() {
                    alternatif = Some(pernyataan_jika);
                }
            } else {
                self.lanjut_token(); // lewat 'lainnya'
                if let Some(blok_lainnya) = self.parse_blok_pernyataan() {
                    alternatif = Some(Box::new(blok_lainnya) as Box<dyn Pernyataan>);
                }
            }
        }

        Some(Box::new(PernyataanJika {
            token: token_awal,
            kondisi,
            konsekuensi,
            alternatif,
        }))
    }

    fn parse_pernyataan_putar(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'putar'
        
        let blok = self.parse_blok_pernyataan()?;
        
        Some(Box::new(PernyataanPutar { token, blok }))
    }

    fn parse_pernyataan_untuk_dalam(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'untuk'

        let variabel = match &self.token_sekarang.tipe {
            TokenType::Identitas(nama) => Identitas { token: self.token_sekarang.clone(), nilai: nama.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama variabel setelah 'untuk'".to_string());
                return None;
            }
        };
        self.lanjut_token();

        if !self.harapkan(&TokenType::Dalam, "Diharapkan 'dalam' setelah variabel loop") { return None; }

        let iterable = self.parse_ekspresi(Prioritas::Terendah)?;
        let blok = self.parse_blok_pernyataan()?;

        Some(Box::new(PernyataanUntukDalam { token, variabel, iterable, blok }))
    }

    fn parse_pernyataan_selama(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token();

        // Tanda kurung opsional: `selama kondisi { }` atau `selama (kondisi) { }`
        let pakai_kurung = self.token_sekarang.tipe == TokenType::KurungBuka;
        if pakai_kurung {
            self.lanjut_token(); // lewat '('
        }
        
        let kondisi = self.parse_ekspresi(Prioritas::Terendah)?;
        
        if pakai_kurung {
            if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')' setelah kondisi") { return None; }
        }
        
        let blok = self.parse_blok_pernyataan()?;
        
        Some(Box::new(PernyataanSelama { token, kondisi, blok }))
    }

    fn parse_pernyataan_fungsi(&mut self, is_publik: bool, is_async: bool, is_uji: bool, is_asing: bool) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'fungsi'
        
        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(nama_str) => Identitas { token: self.token_sekarang.clone(), nilai: nama_str.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama fungsi".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();
        
        if !self.harapkan(&TokenType::KurungBuka, "Diharapkan '('") { return None; }
        
        let parameter = self.parse_parameter_fungsi()?;
        let mut tipe_kembalian = "kosong".to_string(); 
        
        if self.token_sekarang.tipe == TokenType::Panah {
            self.lanjut_token();
            tipe_kembalian = self.parse_tipe_data()?;
        }
        
        let tubuh = if self.token_sekarang.tipe == TokenType::TitikKoma {
            let tok = self.token_sekarang.clone();
            self.lanjut_token(); // lewat ';'
            PernyataanBlok { token: tok, pernyataan_pernyataan: Vec::new() }
        } else {
            self.parse_blok_pernyataan()?
        };
        Some(Box::new(PernyataanFungsi { token, nama, parameter, tipe_kembalian, tubuh, is_publik, is_async, is_uji, is_asing }))
    }

    fn parse_pernyataan_modul(&mut self, is_publik: bool) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'modul'
        
        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(nama_str) => nama_str.clone(),
            _ => {
                self.pesan_error.push("Diharapkan nama modul".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();
        
        let blok = if self.token_sekarang.tipe == TokenType::KurungKurawalBuka {
            Some(self.parse_blok_pernyataan()?)
        } else if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
            
            // Baca dari file eksternal
            let path_file1 = format!("src/{}.tela", nama);
            let path_file2 = format!("src/{}/utama.tela", nama);
            
            let isi = std::fs::read_to_string(&path_file1).or_else(|_| std::fs::read_to_string(&path_file2));
            
            match isi {
                Ok(kode) => {
                    let mut lexer_mod = Lexer::new(&kode);
                    let mut parser_mod = Parser::new(&mut lexer_mod);
                    let prog = parser_mod.parse_program();
                    if !parser_mod.pesan_error.is_empty() {
                        for err in parser_mod.pesan_error {
                            self.pesan_error.push(format!("[Modul {}] {}", nama, err));
                        }
                        None
                    } else {
                        Some(PernyataanBlok {
                            token: token.clone(),
                            pernyataan_pernyataan: prog.pernyataan_pernyataan,
                        })
                    }
                },
                Err(e) => {
                    self.pesan_error.push(format!("Gagal memuat modul '{}': {}", nama, e));
                    None
                }
            }
        } else {
            self.pesan_error.push("Diharapkan '{' atau ';' setelah deklarasi modul".to_string());
            self.sinkronkan();
            return None;
        };
        
        Some(Box::new(PernyataanModul { token, nama, blok, is_publik }))
    }

    fn parse_pernyataan_gunakan(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'gunakan'
        
        let mut jalur = Vec::new();
        let mut semua = false;
        
        loop {
            match &self.token_sekarang.tipe {
                TokenType::Identitas(nama) => {
                    jalur.push(nama.clone());
                    self.lanjut_token();
                },
                TokenType::Kali => {
                    semua = true;
                    self.lanjut_token();
                    break;
                },
                _ => {
                    self.pesan_error.push(format!("Diharapkan identitas atau '*' di pernyataan gunakan, mendapat {:?}", self.token_sekarang.tipe));
                    self.sinkronkan();
                    return None;
                }
            }
            
            if self.token_sekarang.tipe == TokenType::TitikTitikDua {
                self.lanjut_token();
            } else {
                break;
            }
        }
        
        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        } else {
            self.pesan_error.push("Diharapkan ';' di akhir pernyataan gunakan".to_string());
            self.sinkronkan();
            return None;
        }
        
        Some(Box::new(PernyataanGunakan { token, jalur, semua }))
    }

    fn parse_pernyataan_struktur(&mut self, is_publik: bool) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token();

        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama struktur".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();

        if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{' pada struktur") { return None; }

        let mut properti = Vec::new();
        while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
            let prop_nama = match &self.token_sekarang.tipe {
                TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
                _ => {
                    self.pesan_error.push("Diharapkan nama properti".to_string());
                    self.sinkronkan();
                    return None;
                }
            };
            self.lanjut_token();

            if !self.harapkan(&TokenType::TitikDua, "Diharapkan ':' setelah nama properti") { return None; }
            let tipe = self.parse_tipe_data()?;
            
            properti.push((prop_nama, tipe));

            if self.token_sekarang.tipe == TokenType::Koma {
                self.lanjut_token();
            } else if self.token_sekarang.tipe != TokenType::KurungKurawalTutup {
                self.pesan_error.push("Diharapkan ',' atau '}' pada definisi struktur".to_string());
                self.sinkronkan();
                return None;
            }
        }

        if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }

        Some(Box::new(PernyataanStruktur { token, nama, properti, is_publik }))
    }

    fn parse_pernyataan_enum(&mut self, is_publik: bool) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token();

        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama enum".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();

        if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{' pada enum") { return None; }

        let mut varian = Vec::new();
        while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
            let var_nama = match &self.token_sekarang.tipe {
                TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
                _ => {
                    self.pesan_error.push("Diharapkan nama varian enum".to_string());
                    self.sinkronkan();
                    return None;
                }
            };
            self.lanjut_token();

            let mut tipe_data = None;
            if self.token_sekarang.tipe == TokenType::KurungBuka {
                self.lanjut_token();
                let mut data_vec = Vec::new();
                while self.token_sekarang.tipe != TokenType::KurungTutup && self.token_sekarang.tipe != TokenType::Eof {
                    if let Some(t) = self.parse_tipe_data() {
                        data_vec.push(t);
                    } else { return None; }
                    
                    if self.token_sekarang.tipe == TokenType::Koma {
                        self.lanjut_token();
                    } else if self.token_sekarang.tipe != TokenType::KurungTutup {
                        self.pesan_error.push("Diharapkan ',' atau ')' pada data enum".to_string());
                        self.sinkronkan();
                        return None;
                    }
                }
                if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')'") { return None; }
                tipe_data = Some(data_vec);
            }

            varian.push(VarianEnum { nama: var_nama, tipe_data });

            if self.token_sekarang.tipe == TokenType::Koma {
                self.lanjut_token();
            } else if self.token_sekarang.tipe != TokenType::KurungKurawalTutup {
                self.pesan_error.push("Diharapkan ',' atau '}' pada definisi enum".to_string());
                self.sinkronkan();
                return None;
            }
        }

        if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }

        Some(Box::new(PernyataanEnum { token, nama, varian, is_publik }))
    }

    fn parse_pernyataan_alias_tipe(&mut self, is_publik: bool) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token();

        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama alias tipe".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();

        if !self.harapkan(&TokenType::SamaDengan, "Diharapkan '=' pada deklarasi alias tipe") { return None; }

        let tipe_asli = if let Some(t) = self.parse_tipe_data() { t } else { return None; };

        if self.token_sekarang.tipe == TokenType::TitikKoma {
            self.lanjut_token();
        }

        Some(Box::new(PernyataanAliasTipe { token, nama, tipe_asli, is_publik }))
    }

    fn parse_pernyataan_sifat(&mut self, is_publik: bool) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'sifat'

        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama sifat (trait)".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();

        if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{' pada deklarasi sifat") { return None; }

        let mut metode = Vec::new();
        while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
            let mut is_pub = false;
            if self.token_sekarang.tipe == TokenType::Publik {
                is_pub = true;
                self.lanjut_token();
            }
            let mut is_async = false;
            if self.token_sekarang.tipe == TokenType::Tugas {
                is_async = true;
                self.lanjut_token();
            }
            if self.token_sekarang.tipe == TokenType::Fungsi {
                if let Some(f) = self.parse_pernyataan_fungsi(is_pub, is_async, false, false) {
                    if let Some(pf) = f.as_any().downcast_ref::<PernyataanFungsi>() {
                        metode.push(pf.clone());
                    }
                }
            } else {
                self.pesan_error.push("Diharapkan fungsi dalam deklarasi sifat".to_string());
                self.sinkronkan();
                return None;
            }
        }

        if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }

        Some(Box::new(PernyataanSifat { token, nama, metode, is_publik }))
    }

    fn parse_pernyataan_implementasi(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token();

        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama struktur atau sifat untuk implementasi".to_string());
                self.sinkronkan();
                return None;
            }
        };
        self.lanjut_token();

        // Cek `implementasi Sifat untuk Struktur { ... }`
        if self.token_sekarang.tipe == TokenType::Untuk {
            self.lanjut_token(); // lewat 'untuk'
            let target = match &self.token_sekarang.tipe {
                TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
                _ => {
                    self.pesan_error.push("Diharapkan nama struktur target setelah 'untuk'".to_string());
                    self.sinkronkan();
                    return None;
                }
            };
            self.lanjut_token();

            if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{' pada implementasi sifat") { return None; }

            let mut metode = Vec::new();
            while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
                let mut is_publik = false;
                if self.token_sekarang.tipe == TokenType::Publik {
                    is_publik = true;
                    self.lanjut_token();
                }
                let mut is_async = false;
                if self.token_sekarang.tipe == TokenType::Tugas {
                    is_async = true;
                    self.lanjut_token();
                }
                if self.token_sekarang.tipe == TokenType::Fungsi {
                    if let Some(f) = self.parse_pernyataan_fungsi(is_publik, is_async, false, false) {
                        if let Some(pf) = f.as_any().downcast_ref::<PernyataanFungsi>() {
                            metode.push(pf.clone());
                        }
                    }
                } else {
                    self.pesan_error.push("Diharapkan fungsi dalam implementasi".to_string());
                    self.sinkronkan();
                    return None;
                }
            }

            if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }

            return Some(Box::new(PernyataanImplementasiSifat { token, nama_sifat: nama, nama_target: target, metode }));
        }

        if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{' atau 'untuk' pada implementasi") { return None; }

        let mut metode = Vec::new();
        while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
            let mut is_publik = false;
            if self.token_sekarang.tipe == TokenType::Publik {
                is_publik = true;
                self.lanjut_token();
            }
            let mut is_async = false;
            if self.token_sekarang.tipe == TokenType::Tugas {
                is_async = true;
                self.lanjut_token();
            }
            if self.token_sekarang.tipe == TokenType::Fungsi {
                if let Some(f) = self.parse_pernyataan_fungsi(is_publik, is_async, false, false) {
                    metode.push(f);
                }
            } else {
                self.pesan_error.push("Diharapkan fungsi dalam implementasi".to_string());
                self.sinkronkan();
                return None;
            }
        }

        if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }

        Some(Box::new(PernyataanImplementasi { token, nama, metode }))
    }

    fn parse_parameter_fungsi(&mut self) -> Option<Vec<Parameter>> {
        let mut params = Vec::new();
        
        if self.token_sekarang.tipe == TokenType::KurungTutup {
            self.lanjut_token();
            return Some(params);
        }
        
        if let Some(param) = self.parse_satu_parameter() {
            params.push(param);
        } else { return None; }
        
        while self.token_sekarang.tipe == TokenType::Koma {
            self.lanjut_token();
            if let Some(param) = self.parse_satu_parameter() {
                params.push(param);
            } else { return None; }
        }
        
        if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')'") { return None; }
        
        Some(params)
    }

    fn parse_satu_parameter(&mut self) -> Option<Parameter> {
        let (nama, is_diri) = match &self.token_sekarang.tipe {
            TokenType::Identitas(nama_str) => (Identitas { token: self.token_sekarang.clone(), nilai: nama_str.clone() }, false),
            TokenType::DiriKecil => (Identitas { token: self.token_sekarang.clone(), nilai: "diri".to_string() }, true),
            _ => {
                self.pesan_error.push("Diharapkan nama parameter".to_string());
                return None;
            }
        };
        self.lanjut_token();
        
        if is_diri {
            if self.token_sekarang.tipe == TokenType::TitikDua {
                self.lanjut_token();
                let tipe_data = self.parse_tipe_data()?;
                return Some(Parameter { nama, tipe_data });
            } else {
                return Some(Parameter { nama, tipe_data: "Diri".to_string() });
            }
        }
        
        if !self.harapkan(&TokenType::TitikDua, "Diharapkan ':' setelah nama parameter") { return None; }
        
        let tipe_data = self.parse_tipe_data()?;
        Some(Parameter { nama, tipe_data })
    }

    fn parse_tipe_data(&mut self) -> Option<String> {
        if self.token_sekarang.tipe == TokenType::KurungSikuBuka {
            self.lanjut_token();
            let tipe_dasar = self.parse_tipe_data()?;
            if !self.harapkan(&TokenType::TitikKoma, "Diharapkan ';' pada tipe larik") {
                return None;
            }
            let ukuran = match &self.token_sekarang.tipe {
                TokenType::Bilangan(n) => *n,
                _ => {
                    self.pesan_error.push("Diharapkan ukuran larik (bilangan bulat)".to_string());
                    return None;
                }
            };
            self.lanjut_token(); // lewat ukuran
            if !self.harapkan(&TokenType::KurungSikuTutup, "Diharapkan ']' pada tipe larik") {
                return None;
            }
            return Some(format!("[{}; {}]", tipe_dasar, ukuran));
        }
        
        // --- Fase 6A: Tipe Referensi `&T` ---
        if self.token_sekarang.tipe == TokenType::BitDan {
            self.lanjut_token(); // lewat '&'
            // Cek apakah ini `&ubah T` (mutable reference type)
            if self.token_sekarang.tipe == TokenType::Ubah {
                self.lanjut_token(); // lewat 'ubah'
                let tipe_dalam = self.parse_tipe_data()?;
                return Some(format!("&ubah {}", tipe_dalam));
            }
            let tipe_dalam = self.parse_tipe_data()?;
            return Some(format!("&{}", tipe_dalam));
        }
        
        // --- Fase 6A: Tipe Kotak `kotak<T>` ---
        if self.token_sekarang.tipe == TokenType::Kotak {
            self.lanjut_token(); // lewat 'kotak'
            // kotak<T> - bentuk generik
            if self.token_sekarang.tipe == TokenType::LebihKecil {
                self.lanjut_token(); // lewat '<'
                let tipe_dalam = self.parse_tipe_data()?;
                if self.token_sekarang.tipe == TokenType::LebihBesar {
                    self.lanjut_token(); // lewat '>'
                }
                return Some(format!("kotak<{}>", tipe_dalam));
            }
            return Some("kotak".to_string());
        }

        // --- Larik Dinamis: Tipe Vektor `vektor<T>` ---
        if self.token_sekarang.tipe == TokenType::Vektor {
            self.lanjut_token(); // lewat 'vektor'
            if self.token_sekarang.tipe == TokenType::LebihKecil {
                self.lanjut_token(); // lewat '<'
                let tipe_dalam = self.parse_tipe_data()?;
                if self.token_sekarang.tipe == TokenType::LebihBesar {
                    self.lanjut_token(); // lewat '>'
                }
                return Some(format!("vektor<{}>", tipe_dalam));
            }
            return Some("vektor".to_string());
        }
        
        if self.token_sekarang.tipe == TokenType::KurungBuka {
            self.lanjut_token(); // lewat '('
            let mut tipe_elemen = Vec::new();
            if self.token_sekarang.tipe != TokenType::KurungTutup {
                if let Some(t) = self.parse_tipe_data() {
                    tipe_elemen.push(t);
                } else { return None; }
                while self.token_sekarang.tipe == TokenType::Koma {
                    self.lanjut_token();
                    if let Some(t) = self.parse_tipe_data() {
                        tipe_elemen.push(t);
                    } else { return None; }
                }
            }
            if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')' pada tipe tuple") {
                return None;
            }
            return Some(format!("({})", tipe_elemen.join(", ")));
        }

        let tipe_data = match &self.token_sekarang.tipe {
            TokenType::TipeBilangan => "bilangan".to_string(),
            TokenType::TipeDesimal => "desimal".to_string(),
            TokenType::TipeTeks => "teks".to_string(),
            TokenType::TipeLogika => "logika".to_string(),
            TokenType::TipeKosong => "kosong".to_string(),
            TokenType::TipeKarakter => "karakter".to_string(),
            TokenType::TipeDaftar => "daftar".to_string(),
            TokenType::TipeKamus => "kamus".to_string(),
            TokenType::Identitas(t) => t.clone(),
            _ => {
                self.pesan_error.push(format!("Diharapkan tipe data yang valid, mendapat {:?}", self.token_sekarang.tipe));
                return None;
            }
        };
        self.lanjut_token();
        Some(tipe_data)
    }

    // --- PARSING EKSPRESI ---

    fn parse_ekspresi(&mut self, prioritas: Prioritas) -> Option<Box<dyn Ekspresi>> {
        let mut kiri = self.parse_prefix()?;

        while self.token_sekarang.tipe != TokenType::TitikKoma 
              && self.token_sekarang.tipe != TokenType::Eof 
              && prioritas < prioritas_token(&self.token_sekarang.tipe) {
            
            let op_tipe = self.token_sekarang.tipe.clone();
            
            if op_tipe == TokenType::KurungBuka {
                kiri = self.parse_panggilan_fungsi(kiri)?;
            } else if op_tipe == TokenType::KurungSikuBuka {
                kiri = self.parse_indeks_larik(kiri)?;
            } else if self.is_infix_op(&op_tipe) {
                kiri = self.parse_infix(kiri)?;
            } else {
                return Some(kiri);
            }
        }
        
        Some(kiri)
    }

    fn is_infix_op(&self, tipe: &TokenType) -> bool {
        // PERHATIAN: Assignment operator tidak ada di sini lagi.
        matches!(tipe, 
            TokenType::Titik | TokenType::TitikTitikDua | TokenType::Tambah | TokenType::Kurang | TokenType::Kali | TokenType::Bagi | TokenType::SisaBagi | TokenType::Pangkat |
            TokenType::Setara | TokenType::TidakSetara | TokenType::LebihBesar | TokenType::LebihKecil | TokenType::LebihBesarSetara | TokenType::LebihKecilSetara |
            TokenType::LogikaDan | TokenType::LogikaAtau | TokenType::BitDan | TokenType::BitAtau | TokenType::BitXor | TokenType::GeserKiri | TokenType::GeserKanan |
            TokenType::Sebagai | TokenType::Rentang
        )
    }

    fn parse_prefix(&mut self) -> Option<Box<dyn Ekspresi>> {
        match self.token_sekarang.tipe.clone() {
            TokenType::Identitas(nama) => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                
                if self.token_sekarang.tipe == TokenType::KurungKurawalBuka && nama.chars().next().map_or(false, |c| c.is_uppercase()) {
                    self.lanjut_token(); // lewat '{'
                    let mut properti = Vec::new();
                    while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
                        let prop_nama = match &self.token_sekarang.tipe {
                            TokenType::Identitas(n) => Identitas { token: self.token_sekarang.clone(), nilai: n.clone() },
                            _ => {
                                self.pesan_error.push("Diharapkan nama properti".to_string());
                                self.sinkronkan();
                                return None;
                            }
                        };
                        self.lanjut_token();
                        if !self.harapkan(&TokenType::TitikDua, "Diharapkan ':' setelah nama properti inisiasi") { return None; }
                        let eks = self.parse_ekspresi(Prioritas::Terendah)?;
                        properti.push((prop_nama, eks));
                        if self.token_sekarang.tipe == TokenType::Koma {
                            self.lanjut_token();
                        } else if self.token_sekarang.tipe != TokenType::KurungKurawalTutup {
                            self.pesan_error.push("Diharapkan ',' atau '}' pada inisiasi struktur".to_string());
                            self.sinkronkan();
                            return None;
                        }
                    }
                    if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}'") { return None; }
                    Some(Box::new(EkspresiInisiasiStruktur { token: token.clone(), nama: Identitas { token, nilai: nama }, properti }))
                } else {
                    Some(Box::new(Identitas { token, nilai: nama }))
                }
            },
            TokenType::DiriKecil => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(Identitas { token, nilai: "diri".to_string() }))
            },
            TokenType::DiriBesar => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(Identitas { token, nilai: "Diri".to_string() }))
            },
            TokenType::Bilangan(val) => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(LiteralBilangan { token, nilai: val }))
            },
            TokenType::Desimal(val) => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(LiteralDesimal { token, nilai: val }))
            },
            TokenType::Teks(val) => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(LiteralTeks { token, nilai: val }))
            },
            TokenType::Karakter(val) => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(LiteralKarakter { token, nilai: val }))
            },
            TokenType::Benar => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(LiteralLogika { token, nilai: true }))
            },
            TokenType::Salah => {
                let token = self.token_sekarang.clone();
                self.lanjut_token();
                Some(Box::new(LiteralLogika { token, nilai: false }))
            },
            TokenType::KurungBuka => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat '('
                
                if self.token_sekarang.tipe == TokenType::KurungTutup {
                    self.lanjut_token(); // lewat ')'
                    return Some(Box::new(LiteralTuple { token, elemen: Vec::new() }));
                }
                
                let first = self.parse_ekspresi(Prioritas::Terendah)?;
                let mut elemen = vec![first];
                let mut has_comma = false;
                
                while self.token_sekarang.tipe == TokenType::Koma {
                    has_comma = true;
                    self.lanjut_token(); // lewat ','
                    if self.token_sekarang.tipe != TokenType::KurungTutup {
                        let next = self.parse_ekspresi(Prioritas::Terendah)?;
                        elemen.push(next);
                    }
                }
                
                if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')'") {
                    return None;
                }
                
                if elemen.len() == 1 && !has_comma {
                    Some(elemen.remove(0))
                } else {
                    Some(Box::new(LiteralTuple { token, elemen }))
                }
            },
            TokenType::KurungSikuBuka => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat '['
                let elemen = self.parse_daftar_ekspresi(TokenType::KurungSikuTutup)?;
                Some(Box::new(LiteralDaftar { token, elemen }))
            },
            TokenType::KurungKurawalBuka => {
                let token = self.token_sekarang.clone();
                // Check whether it's a Block Expression or a Dictionary Literal.
                // Dictionary must have string/number keys followed by colon.
                let mut _is_kamus = false;
                if let TokenType::Teks(_) = self.token_intip.tipe {
                    // Peek ahead to see if there's a colon. This isn't perfect without a bigger lookahead but works for now.
                    // Actually, if it's a block, we parse it as block.
                    // Let's assume for now { } is block expression if it contains statements, but Kamus if it contains key-values.
                    // A simple heuristic: if it's empty, or the first thing is an expression followed by `:`, it's kamus.
                    // Otherwise it's a block.
                }
                
                // For simplicity, we just parse it as Block Expression in this phase.
                // To keep backward compatibility, we could use dictionary syntax differently, but let's parse block.
                let blok = self.parse_blok_pernyataan()?;
                Some(Box::new(EkspresiBlok { token, blok }))
            },
            TokenType::Kurang | TokenType::Tidak | TokenType::BitTidak => {
                let token = self.token_sekarang.clone();
                let operator = match token.tipe {
                    TokenType::Kurang => "-",
                    TokenType::Tidak => "!",
                    TokenType::BitTidak => "~",
                    _ => "",
                }.to_string();
                self.lanjut_token();
                
                let kanan = self.parse_ekspresi(Prioritas::Prefix)?;
                Some(Box::new(EkspresiPrefix { token, operator, kanan }))
            },
            // --- Fase 6A/6B: Referensi `&x` atau `&ubah x` ---
            TokenType::BitDan => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat '&'
                // Cek apakah ini `&ubah x` (mutable reference)
                if self.token_sekarang.tipe == TokenType::Ubah {
                    self.lanjut_token(); // lewat 'ubah'
                    let nilai = self.parse_ekspresi(Prioritas::Prefix)?;
                    Some(Box::new(EkspresiReferensiUbah { token, nilai }))
                } else {
                    let nilai = self.parse_ekspresi(Prioritas::Prefix)?;
                    Some(Box::new(EkspresiReferensi { token, nilai }))
                }
            },
            // --- Fase 6A: Dereference `*x` ---
            TokenType::Kali => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat '*'
                let nilai = self.parse_ekspresi(Prioritas::Prefix)?;
                Some(Box::new(EkspresiDeref { token, nilai }))
            },
            // --- Fase 6A: Kotak `kotak(nilai)` ---
            TokenType::Kotak => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat 'kotak'
                if !self.harapkan(&TokenType::KurungBuka, "Diharapkan '(' setelah 'kotak'") {
                    return None;
                }
                let nilai = self.parse_ekspresi(Prioritas::Terendah)?;
                if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')' setelah isi kotak") {
                    return None;
                }
                Some(Box::new(EkspresiKotak { token, nilai }))
            },
            // --- Larik Dinamis: Vektor `vektor_baru<T>()` ---
            TokenType::VektorBaru => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat 'vektor_baru'
                if !self.harapkan(&TokenType::LebihKecil, "Diharapkan '<' setelah 'vektor_baru'") {
                    return None;
                }
                let tipe_elemen = self.parse_tipe_data()?;
                if !self.harapkan(&TokenType::LebihBesar, "Diharapkan '>' setelah tipe data vektor") {
                    return None;
                }
                if !self.harapkan(&TokenType::KurungBuka, "Diharapkan '(' setelah 'vektor_baru<T>'") {
                    return None;
                }
                if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')' setelah 'vektor_baru<T>('") {
                    return None;
                }
                Some(Box::new(EkspresiVektorBaru { token, tipe_elemen }))
            },
            // --- Fase 7: Cocokkan `cocokkan target { pattern => expr, ... }` ---
            TokenType::Cocokkan => {
                self.parse_ekspresi_cocokkan()
            },
            // --- Fase 7: Coba `coba expr` ---
            TokenType::Coba => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat 'coba'
                let ekspresi = self.parse_ekspresi(Prioritas::Prefix)?;
                Some(Box::new(EkspresiCoba { token, ekspresi }))
            },
            // --- Fase 10: Tunggu `tunggu expr` ---
            TokenType::Tunggu => {
                let token = self.token_sekarang.clone();
                self.lanjut_token(); // lewat 'tunggu'
                let ekspresi = self.parse_ekspresi(Prioritas::Prefix)?;
                Some(Box::new(EkspresiTunggu { token, ekspresi }))
            },
            _ => {
                self.pesan_error.push(format!("Tidak ada fungsi parse prefix untuk {:?} di baris {}, kolom {}", self.token_sekarang.tipe, self.token_sekarang.baris, self.token_sekarang.kolom));
                None
            }
        }
    }

    fn parse_infix(&mut self, kiri: Box<dyn Ekspresi>) -> Option<Box<dyn Ekspresi>> {
        let token = self.token_sekarang.clone();
        
        if token.tipe == TokenType::TitikTitikDua {
            self.lanjut_token(); // lewat '::'
            let kanan = self.token_sekarang.clone();
            // Terima identitas DAN kata kunci tipe data sebagai nama setelah '::'
            // (misal: Teks::kosong, Koleksi::kamus_baru, Konversi::teks_ke_bilangan)
            let nama_kanan = match &kanan.tipe {
                TokenType::Identitas(nama) => Some(nama.clone()),
                TokenType::TipeBilangan => Some("bilangan".to_string()),
                TokenType::TipeDesimal => Some("desimal".to_string()),
                TokenType::TipeTeks => Some("teks".to_string()),
                TokenType::TipeLogika => Some("logika".to_string()),
                TokenType::TipeKosong => Some("kosong".to_string()),
                TokenType::TipeKarakter => Some("karakter".to_string()),
                TokenType::TipeDaftar => Some("daftar".to_string()),
                TokenType::TipeKamus => Some("kamus".to_string()),
                _ => None,
            };
            
            if let Some(nama_kanan) = nama_kanan {
                self.lanjut_token();
                let mut bagian = Vec::new();
                
                // Kalau kiri adalah Identitas, mulai dengan namanya
                // Kalau kiri adalah EkspresiPath, gabungkan bagian-bagiannya
                if let Some(id) = kiri.as_any().downcast_ref::<Identitas>() {
                    bagian.push(id.nilai.clone());
                } else if let Some(path) = kiri.as_any().downcast_ref::<EkspresiPath>() {
                    bagian.extend(path.bagian.clone());
                } else {
                    self.pesan_error.push(format!("Kiri dari '::' harus berupa path atau identitas, bukan '{}'", kiri.nilai_string()));
                    return None;
                }
                
                bagian.push(nama_kanan);
                return Some(Box::new(EkspresiPath { token, bagian }));
            } else {
                self.pesan_error.push(format!("Diharapkan identitas setelah '::', mendapat {:?}", kanan.tipe));
                return None;
            }
        }
        if token.tipe == TokenType::Sebagai {
            self.lanjut_token(); // lewat 'sebagai'
            let tipe_tujuan = self.parse_tipe_data()?;
            return Some(Box::new(EkspresiKonversi { token, ekspresi: kiri, tipe_tujuan }));
        }

        if token.tipe == TokenType::Titik {
            self.lanjut_token(); // lewat '.'
            let properti = self.token_sekarang.clone();
            match properti.tipe {
                TokenType::Identitas(_) | TokenType::Bilangan(_) => {
                    self.lanjut_token();
                    return Some(Box::new(EkspresiAksesProperti { token, kiri, properti }));
                },
                _ => {
                    self.pesan_error.push(format!("Diharapkan nama properti atau indeks tuple setelah '.', tetapi mendapat {:?}", properti.tipe));
                    return None;
                }
            }
        }

        let operator = match &token.tipe {
            TokenType::Tambah => "+",
            TokenType::Kurang => "-",
            TokenType::Kali => "*",
            TokenType::Bagi => "/",
            TokenType::SisaBagi => "%",
            TokenType::Pangkat => "^",
            TokenType::Setara => "==",
            TokenType::TidakSetara => "!=",
            TokenType::LebihBesar => ">",
            TokenType::LebihKecil => "<",
            TokenType::LebihBesarSetara => ">=",
            TokenType::LebihKecilSetara => "<=",
            TokenType::LogikaDan => "&&",
            TokenType::LogikaAtau => "||",
            TokenType::BitDan => "&",
            TokenType::BitAtau => "|",
            TokenType::BitXor => "^",
            TokenType::GeserKiri => "<<",
            TokenType::GeserKanan => ">>",
            TokenType::Rentang => "..",
            _ => "",
        }.to_string();

        let mut prioritas = prioritas_token(&token.tipe);
        
        // Asosiatif kanan-ke-kiri khusus untuk pangkat
        if token.tipe == TokenType::Pangkat {
            prioritas = Prioritas::Kali; // Turun 1 level (hack kasar)
        }

        self.lanjut_token();
        
        let kanan = self.parse_ekspresi(prioritas)?;
        
        Some(Box::new(EkspresiInfix { token, kiri, operator, kanan }))
    }

    fn parse_panggilan_fungsi(&mut self, fungsi: Box<dyn Ekspresi>) -> Option<Box<dyn Ekspresi>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat '('
        
        let argumen = self.parse_daftar_ekspresi(TokenType::KurungTutup)?;
        Some(Box::new(EkspresiPanggil { token, fungsi, argumen }))
    }

    fn parse_indeks_larik(&mut self, kiri: Box<dyn Ekspresi>) -> Option<Box<dyn Ekspresi>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat '['
        
        let indeks = self.parse_ekspresi(Prioritas::Terendah)?;
        
        if !self.harapkan(&TokenType::KurungSikuTutup, "Diharapkan ']' setelah indeks") {
            return None;
        }
        
        Some(Box::new(EkspresiIndeks { token, kiri, indeks }))
    }

    fn parse_daftar_ekspresi(&mut self, penutup: TokenType) -> Option<Vec<Box<dyn Ekspresi>>> {
        let mut daftar = Vec::new();
        
        if self.cek_tipe_sekarang(&penutup) {
            self.lanjut_token();
            return Some(daftar);
        }
        
        if let Some(eks) = self.parse_ekspresi(Prioritas::Terendah) {
            daftar.push(eks);
        } else { return None; }
        
        while self.token_sekarang.tipe == TokenType::Koma {
            self.lanjut_token();
            if let Some(eks) = self.parse_ekspresi(Prioritas::Terendah) {
                daftar.push(eks);
            } else { return None; }
        }
        
        if !self.harapkan(&penutup, "Diharapkan tanda penutup") {
            return None;
        }
        
        Some(daftar)
    }

    fn parse_kamus_ekspresi(&mut self) -> Option<Vec<(Box<dyn Ekspresi>, Box<dyn Ekspresi>)>> {
        let mut pasangan = Vec::new();
        
        if self.cek_tipe_sekarang(&TokenType::KurungKurawalTutup) {
            self.lanjut_token();
            return Some(pasangan);
        }
        
        loop {
            let kunci = self.parse_ekspresi(Prioritas::Terendah)?;
            if !self.harapkan(&TokenType::TitikDua, "Diharapkan ':' setelah kunci kamus") {
                return None;
            }
            let nilai = self.parse_ekspresi(Prioritas::Terendah)?;
            pasangan.push((kunci, nilai));
            
            if self.token_sekarang.tipe == TokenType::KurungKurawalTutup {
                self.lanjut_token();
                break;
            }
            if !self.harapkan(&TokenType::Koma, "Diharapkan ',' atau '}' pada kamus") {
                return None;
            }
        }
        Some(pasangan)
    }

    // --- Fase 7: Pattern Matching Helper ---
    fn parse_ekspresi_cocokkan(&mut self) -> Option<Box<dyn Ekspresi>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'cocokkan'

        let target = self.parse_ekspresi(Prioritas::Terendah)?;

        if !self.harapkan(&TokenType::KurungKurawalBuka, "Diharapkan '{' setelah target 'cocokkan'") {
            return None;
        }

        let mut cabang = Vec::new();
        while self.token_sekarang.tipe != TokenType::KurungKurawalTutup && self.token_sekarang.tipe != TokenType::Eof {
            let pola = self.parse_pola()?;
            if !self.harapkan(&TokenType::PanahTebal, "Diharapkan '=>' setelah pola") {
                return None;
            }
            let ekspresi = self.parse_ekspresi(Prioritas::Terendah)?;
            cabang.push(CabangCocokkan { pola, ekspresi });

            if self.token_sekarang.tipe == TokenType::Koma {
                self.lanjut_token(); // lewat koma opsional
            }
        }

        if !self.harapkan(&TokenType::KurungKurawalTutup, "Diharapkan '}' penutup 'cocokkan'") {
            return None;
        }

        Some(Box::new(EkspresiCocokkan { token, target, cabang }))
    }

    fn parse_pola(&mut self) -> Option<Pola> {
        match &self.token_sekarang.tipe {
            TokenType::GarisBawah => {
                self.lanjut_token();
                Some(Pola::Wildcard)
            },
            TokenType::Bilangan(_) | TokenType::Desimal(_) | TokenType::Teks(_) | TokenType::Karakter(_) | TokenType::Benar | TokenType::Salah => {
                let expr = self.parse_ekspresi(Prioritas::Prefix)?;
                Some(Pola::Literal(expr))
            },
            TokenType::Identitas(nama_first) => {
                let mut nama_full = nama_first.clone();
                self.lanjut_token();

                // Cek `::` seperti `Bentuk::Lingkaran`
                if self.token_sekarang.tipe == TokenType::TitikTitikDua {
                    self.lanjut_token(); // lewat '::'
                    if let TokenType::Identitas(nama_sub) = &self.token_sekarang.tipe {
                        nama_full = format!("{}::{}", nama_full, nama_sub);
                        self.lanjut_token();
                    }
                }

                // Cek apakah varian membawa payload dalam kurung: `Sukses(x, y)` atau `Lingkaran(r)`
                if self.token_sekarang.tipe == TokenType::KurungBuka {
                    self.lanjut_token(); // lewat '('
                    let mut vars = Vec::new();
                    while self.token_sekarang.tipe != TokenType::KurungTutup && self.token_sekarang.tipe != TokenType::Eof {
                        if let TokenType::Identitas(v) = &self.token_sekarang.tipe {
                            vars.push(v.clone());
                            self.lanjut_token();
                        } else if self.token_sekarang.tipe == TokenType::GarisBawah {
                            vars.push("_".to_string());
                            self.lanjut_token();
                        } else {
                            self.pesan_error.push(format!("Diharapkan nama variabel pola di baris {}, kolom {}", self.token_sekarang.baris, self.token_sekarang.kolom));
                            return None;
                        }

                        if self.token_sekarang.tipe == TokenType::Koma {
                            self.lanjut_token();
                        }
                    }
                    if !self.harapkan(&TokenType::KurungTutup, "Diharapkan ')'") {
                        return None;
                    }
                    Some(Pola::Varian { nama: nama_full, variabel: vars })
                } else {
                    // Tanpa payload: varian enum tanpa argumen, atau variabel biasa
                    if nama_full.contains("::") || nama_full.chars().next().map_or(false, |c| c.is_uppercase()) {
                        Some(Pola::Varian { nama: nama_full, variabel: Vec::new() })
                    } else {
                        Some(Pola::Variabel(nama_full))
                    }
                }
            },
            _ => {
                self.pesan_error.push(format!("Pola tidak valid di baris {}, kolom {}", self.token_sekarang.baris, self.token_sekarang.kolom));
                None
            }
        }
    }
    
    fn parse_pernyataan_pantau_memori(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'pantau_memori'
        
        let nama = match &self.token_sekarang.tipe {
            TokenType::Identitas(nama_str) => Identitas { token: self.token_sekarang.clone(), nilai: nama_str.clone() },
            _ => {
                self.pesan_error.push("Diharapkan nama peubah setelah 'pantau_memori'".to_string());
                return None;
            }
        };
        self.lanjut_token();
        
        if !self.harapkan(&TokenType::TitikKoma, "Diharapkan ';' setelah pernyataan 'pantau_memori'") {
            return None;
        }
        Some(Box::new(PernyataanPantauMemori { token, nama }))
    }
    
    fn parse_pernyataan_aman(&mut self) -> Option<Box<dyn Pernyataan>> {
        let token = self.token_sekarang.clone();
        self.lanjut_token(); // lewat 'aman'
        
        let blok = self.parse_blok_pernyataan()?;
        Some(Box::new(PernyataanAman { token, blok }))
    }
}
