use crate::token::{Token, TokenType};

pub struct Lexer {
    input: Vec<char>,
    posisi: usize,
    baca_posisi: usize,
    karakter_sekarang: char,
    baris: usize,
    kolom: usize,
}

impl Lexer {
    pub fn new(input: &str) -> Self {
        let mut lexer = Lexer {
            input: input.chars().collect(),
            posisi: 0,
            baca_posisi: 0,
            karakter_sekarang: '\0',
            baris: 1,
            kolom: 0,
        };
        lexer.baca_karakter();
        lexer
    }

    fn baca_karakter(&mut self) {
        if self.baca_posisi >= self.input.len() {
            self.karakter_sekarang = '\0';
        } else {
            self.karakter_sekarang = self.input[self.baca_posisi];
        }
        self.posisi = self.baca_posisi;
        self.baca_posisi += 1;
        self.kolom += 1;
    }

    fn intip_karakter(&self) -> char {
        if self.baca_posisi >= self.input.len() {
            '\0'
        } else {
            self.input[self.baca_posisi]
        }
    }

    pub fn token_selanjutnya(&mut self) -> Token {
        self.lewati_spasi();

        let baris_token = self.baris;
        let kolom_token = self.kolom;

        let tipe = match self.karakter_sekarang {
            '=' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::Setara
                } else if self.intip_karakter() == '>' {
                    self.baca_karakter();
                    TokenType::PanahTebal
                } else {
                    TokenType::SamaDengan
                }
            },
            '+' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::TambahSama
                } else if self.intip_karakter() == '+' {
                    self.baca_karakter();
                    TokenType::TambahSatu
                } else {
                    TokenType::Tambah
                }
            },
            '-' => {
                if self.intip_karakter() == '>' {
                    self.baca_karakter();
                    TokenType::Panah
                } else if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::KurangSama
                } else if self.intip_karakter() == '-' {
                    self.baca_karakter();
                    TokenType::KurangSatu
                } else {
                    TokenType::Kurang
                }
            },
            '*' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::KaliSama
                } else {
                    TokenType::Kali
                }
            },
            '/' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::BagiSama
                } else if self.intip_karakter() == '/' {
                    self.lewati_komentar();
                    return self.token_selanjutnya();
                } else if self.intip_karakter() == '*' {
                    self.baca_karakter(); // lewat *
                    self.lewati_komentar_blok();
                    return self.token_selanjutnya();
                } else {
                    TokenType::Bagi
                }
            },
            '%' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::SisaBagiSama
                } else {
                    TokenType::SisaBagi
                }
            },
            '^' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::PangkatSama
                } else {
                    TokenType::Pangkat
                }
            },
            '>' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::LebihBesarSetara
                } else if self.intip_karakter() == '>' {
                    self.baca_karakter();
                    if self.intip_karakter() == '=' {
                        self.baca_karakter();
                        TokenType::GeserKananSama
                    } else {
                        TokenType::GeserKanan
                    }
                } else {
                    TokenType::LebihBesar
                }
            },
            '<' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::LebihKecilSetara
                } else if self.intip_karakter() == '<' {
                    self.baca_karakter();
                    if self.intip_karakter() == '=' {
                        self.baca_karakter();
                        TokenType::GeserKiriSama
                    } else {
                        TokenType::GeserKiri
                    }
                } else {
                    TokenType::LebihKecil
                }
            },
            '!' => {
                if self.intip_karakter() == '=' {
                    self.baca_karakter();
                    TokenType::TidakSetara
                } else {
                    TokenType::Tidak
                }
            },
            '&' => {
                if self.intip_karakter() == '&' {
                    self.baca_karakter();
                    TokenType::LogikaDan
                } else {
                    TokenType::BitDan
                }
            },
            '|' => {
                if self.intip_karakter() == '|' {
                    self.baca_karakter();
                    TokenType::LogikaAtau
                } else {
                    TokenType::BitAtau
                }
            },
            '~' => TokenType::BitTidak,
            '.' => {
                if self.intip_karakter() == '.' {
                    self.baca_karakter();
                    TokenType::Rentang
                } else {
                    TokenType::Titik
                }
            },
            '(' => TokenType::KurungBuka,
            ')' => TokenType::KurungTutup,
            '[' => TokenType::KurungSikuBuka,
            ']' => TokenType::KurungSikuTutup,
            '{' => TokenType::KurungKurawalBuka,
            '}' => TokenType::KurungKurawalTutup,
            ':' => {
                if self.intip_karakter() == ':' {
                    self.baca_karakter();
                    TokenType::TitikTitikDua
                } else {
                    TokenType::TitikDua
                }
            },
            ';' => TokenType::TitikKoma,
            ',' => TokenType::Koma,
            '?' => TokenType::TandaTanya,
            '@' => TokenType::TandaAt,
            '\0' => TokenType::Eof,
            '\'' => {
                self.baca_karakter();
                let mut karakter = self.karakter_sekarang;
                
                if karakter == '\\' {
                    self.baca_karakter();
                    karakter = match self.karakter_sekarang {
                        'n' => '\n',
                        't' => '\t',
                        'r' => '\r',
                        '\\' => '\\',
                        '\'' => '\'',
                        _ => self.karakter_sekarang,
                    };
                }
                
                self.baca_karakter(); // pindah ke penutup '
                if self.karakter_sekarang == '\'' {
                    let token = Token::new(TokenType::Karakter(karakter), baris_token, kolom_token);
                    self.baca_karakter(); // lewati kutip penutup
                    return token;
                } else {
                    // Invalid char format
                    let token = Token::new(TokenType::Illegal(karakter), baris_token, kolom_token);
                    // tetap jalankan baca_karakter selanjutnya jika ada
                    return token;
                }
            },
            _ => {
                if se_huruf(self.karakter_sekarang) {
                    let identitas = self.baca_identitas();
                    let tipe_keyword = lookup_keyword(&identitas);
                    return Token::new(tipe_keyword, baris_token, kolom_token);
                } else if se_angka(self.karakter_sekarang) {
                    let (angka_str, is_desimal, is_hex) = self.baca_angka_lanjutan();
                    let token_type = self.parse_number(&angka_str, is_desimal, is_hex);
                    return Token::new(token_type, baris_token, kolom_token);
                } else if self.karakter_sekarang == '"' {
                    let teks = self.baca_teks();
                    let token = Token::new(TokenType::Teks(teks), baris_token, kolom_token);
                    self.baca_karakter(); // lewati kutip penutup
                    return token;
                } else {
                    TokenType::Illegal(self.karakter_sekarang)
                }
            }
        };

        let token = Token::new(tipe, baris_token, kolom_token);
        self.baca_karakter();
        token
    }

    fn baca_identitas(&mut self) -> String {
        let posisi_awal = self.posisi;
        while se_huruf(self.karakter_sekarang) || se_angka(self.karakter_sekarang) || self.karakter_sekarang == '_' {
            self.baca_karakter();
        }
        self.input[posisi_awal..self.posisi].iter().collect()
    }

    fn baca_angka_lanjutan(&mut self) -> (String, bool, bool) {
        let mut is_desimal = false;
        let mut is_hex_bin_oct = false;
        let posisi_awal = self.posisi;
        
        if self.karakter_sekarang == '0' {
            let next_ch = self.intip_karakter();
            if next_ch == 'x' || next_ch == 'X' || 
               next_ch == 'b' || next_ch == 'B' || 
               next_ch == 'o' || next_ch == 'O' {
                is_hex_bin_oct = true;
                self.baca_karakter(); // lewat 0
                self.baca_karakter(); // lewat penanda basis
            }
        } else if self.karakter_sekarang == '.' {
            is_desimal = true;
            self.baca_karakter();
        }

        while se_angka(self.karakter_sekarang) 
            || self.karakter_sekarang == '.' 
            || (is_hex_bin_oct && self.karakter_sekarang.is_ascii_hexdigit()) {
            
            if self.karakter_sekarang == '.' {
                if is_desimal {
                    break;
                }
                if self.intip_karakter() == '.' {
                    // Ini artinya operasi rentang '..', contoh: 123..456
                    break;
                }
                is_desimal = true;
            }
            self.baca_karakter();
        }
        (self.input[posisi_awal..self.posisi].iter().collect(), is_desimal, is_hex_bin_oct)
    }

    fn parse_number(&self, angka_str: &str, is_desimal: bool, is_hex_bin_oct: bool) -> TokenType {
        if is_hex_bin_oct {
            let mut basis = 10;
            let mut prefix_len = 0;
            if angka_str.starts_with("0x") || angka_str.starts_with("0X") { basis = 16; prefix_len = 2; }
            else if angka_str.starts_with("0b") || angka_str.starts_with("0B") { basis = 2; prefix_len = 2; }
            else if angka_str.starts_with("0o") || angka_str.starts_with("0O") { basis = 8; prefix_len = 2; }
            
            match i64::from_str_radix(&angka_str[prefix_len..], basis) {
                Ok(v) => TokenType::Bilangan(v),
                Err(_) => TokenType::Illegal('0'), // Invalid number format
            }
        } else if is_desimal {
            match angka_str.parse::<f64>() {
                Ok(v) => TokenType::Desimal(v),
                Err(_) => TokenType::Illegal('.'), // Invalid decimal format
            }
        } else {
            match angka_str.parse::<i64>() {
                Ok(v) => TokenType::Bilangan(v),
                Err(_) => TokenType::Illegal('0'),
            }
        }
    }

    fn baca_teks(&mut self) -> String {
        self.baca_karakter();
        let mut hasil = String::new();
        while self.karakter_sekarang != '"' && self.karakter_sekarang != '\0' {
            if self.karakter_sekarang == '\\' {
                self.baca_karakter();
                match self.karakter_sekarang {
                    '"' => hasil.push('"'),
                    'n' => hasil.push('\n'),
                    't' => hasil.push('\t'),
                    'r' => hasil.push('\r'),
                    'e' => hasil.push('\x1b'),
                    '\\' => hasil.push('\\'),
                    _ => hasil.push(self.karakter_sekarang),
                }
            } else {
                hasil.push(self.karakter_sekarang);
            }
            self.baca_karakter();
        }
        hasil
    }

    fn lewati_spasi(&mut self) {
        while self.karakter_sekarang == ' ' || self.karakter_sekarang == '\t' || self.karakter_sekarang == '\n' || self.karakter_sekarang == '\r' {
            if self.karakter_sekarang == '\n' {
                self.baris += 1;
                self.kolom = 0;
            }
            self.baca_karakter();
        }
    }

    fn lewati_komentar(&mut self) {
        while self.karakter_sekarang != '\n' && self.karakter_sekarang != '\0' {
            self.baca_karakter();
        }
    }

    fn lewati_komentar_blok(&mut self) {
        loop {
            self.baca_karakter();
            if self.karakter_sekarang == '*' && self.intip_karakter() == '/' {
                self.baca_karakter(); // Pindah ke '/'
                self.baca_karakter(); // Pindah ke karakter setelah '/'
                break;
            } else if self.karakter_sekarang == '\0' {
                break;
            } else if self.karakter_sekarang == '\n' {
                self.baris += 1;
                self.kolom = 0;
            }
        }
    }
}

fn se_huruf(ch: char) -> bool {
    ch.is_alphabetic() || ch == '_'
}

fn se_angka(ch: char) -> bool {
    ch.is_numeric()
}

fn lookup_keyword(identitas: &str) -> TokenType {
    match identitas {
        "ubah" => TokenType::Ubah,
        "konstanta" => TokenType::Konstanta,
        "fungsi" => TokenType::Fungsi,
        "kembalikan" => TokenType::Kembalikan,
        "jika" => TokenType::Jika,
        "jikalau" => TokenType::Jikalau,
        "maka" => TokenType::Maka,
        "lainnya" => TokenType::Lainnya,
        "selama" => TokenType::Selama,
        "putar" => TokenType::Putar,
        "untuk" => TokenType::Untuk,
        "dalam" => TokenType::Dalam,
        "henti" => TokenType::Henti,
        "lanjut" => TokenType::Lanjut,
        "impor" => TokenType::Impor,
        "dari" => TokenType::Dari,
        "eksternal" => TokenType::Eksternal,
        "ekspor" => TokenType::Ekspor,
        "paket" => TokenType::Paket,
        "kelas" => TokenType::Kelas,
        "antarmuka" => TokenType::Antarmuka,
        "pilihan" => TokenType::Pilihan,
        "coba" => TokenType::Coba,
        "tangkap" => TokenType::Tangkap,
        "lempar" => TokenType::Lempar,
        "baru" => TokenType::Baru,
        "ini" => TokenType::Ini,
        "warisan" => TokenType::Warisan,
        "publik" => TokenType::Publik,
        "pribadi" => TokenType::Pribadi,
        "terlindungi" => TokenType::Terlindungi,
        "statis" => TokenType::Statis,
        "bilangan" => TokenType::TipeBilangan,
        "desimal" => TokenType::TipeDesimal,
        "teks" => TokenType::TipeTeks,
        "logika" => TokenType::TipeLogika,
        "kosong" => TokenType::TipeKosong,
        "karakter" => TokenType::TipeKarakter,
        "daftar" => TokenType::TipeDaftar,
        "kamus" => TokenType::TipeKamus,
        "benar" => TokenType::Benar,
        "salah" => TokenType::Salah,
        "modul" => TokenType::Modul,
        "gunakan" => TokenType::Gunakan,
        "struktur" => TokenType::Struktur,
        "enum" => TokenType::Enum,
        "implementasi" => TokenType::Implementasi,
        "diri" => TokenType::DiriKecil,
        "Diri" => TokenType::DiriBesar,
        "tipe" => TokenType::Tipe,
        "sebagai" => TokenType::Sebagai,
        "pantau_memori" => TokenType::PantauMemori,
        "kotak" => TokenType::Kotak,
        "cocokkan" => TokenType::Cocokkan,
        "sifat" => TokenType::Sifat,
        "tugas" => TokenType::Tugas,
        "tunggu" => TokenType::Tunggu,
        "bahaya" => TokenType::Bahaya,
        "panik" => TokenType::Panik,
        "vektor" => TokenType::Vektor,
        "vektor_baru" => TokenType::VektorBaru,
        "potongan" => TokenType::Potongan,
        "ref_bersama" => TokenType::RefBersama,
        "uji" => TokenType::Uji,
        "asing" => TokenType::Asing,
        "pakai" => TokenType::Pakai,
        "bentuk" => TokenType::Bentuk,
        "aman" => TokenType::Aman,
        "_" => TokenType::GarisBawah,
        "dan" => TokenType::Dan,
        "atau" => TokenType::Atau,
        _ => TokenType::Identitas(identitas.to_string()),
    }
}
