use crate::ast::*;
use std::collections::HashMap;
use std::rc::Rc;
use std::cell::RefCell;
use crate::token::TokenType;

#[derive(Clone)]
pub struct LingkunganTipe {
    pub simpanan: HashMap<String, (String, bool)>, // (tipe, is_publik)
    pub fungsi: HashMap<String, (Vec<String>, String, bool)>, // (params, ret_type, is_publik)
    pub modul: HashMap<String, (Rc<RefCell<LingkunganTipe>>, bool)>, // (env, is_publik)
    pub struktur: HashMap<String, (Vec<(String, String)>, bool)>, // (properti, is_publik)
    pub enum_map: HashMap<String, (Vec<(String, Option<Vec<String>>)>, bool)>, // (varian, is_publik)
    pub alias_tipe: HashMap<String, (String, bool)>, // (tipe_asli, is_publik)
    pub sifat: HashMap<String, (Vec<(String, Vec<String>, String)>, bool)>, // (metode, is_publik)
    pub luar: Option<Rc<RefCell<LingkunganTipe>>>,
}

impl LingkunganTipe {
    pub fn baru() -> Self {
        let mut env = LingkunganTipe {
            simpanan: HashMap::new(),
            fungsi: HashMap::new(),
            modul: HashMap::new(),
            struktur: HashMap::new(),
            enum_map: HashMap::new(),
            alias_tipe: HashMap::new(),
            sifat: HashMap::new(),
            luar: None,
        };
        // --- Modul Sistem ---
        let env_sistem = Rc::new(RefCell::new(LingkunganTipe::kosong()));
        env_sistem.borrow_mut().simpan_fungsi("cetak_teks".to_string(), vec!["teks".to_string()], "kosong".to_string(), true);
        env_sistem.borrow_mut().simpan_fungsi("cetak_desimal".to_string(), vec!["desimal".to_string()], "kosong".to_string(), true);
        env_sistem.borrow_mut().simpan_fungsi("cetak_bilangan".to_string(), vec!["bilangan".to_string()], "kosong".to_string(), true);
        env_sistem.borrow_mut().simpan_fungsi("baca_desimal".to_string(), vec![], "desimal".to_string(), true);
        env_sistem.borrow_mut().simpan_fungsi("baca_bilangan".to_string(), vec![], "bilangan".to_string(), true);
        env_sistem.borrow_mut().simpan_fungsi("baca_tombol".to_string(), vec![], "bilangan".to_string(), true);
        env_sistem.borrow_mut().simpan_fungsi("bunyi_bip".to_string(), vec![], "bilangan".to_string(), true);
        env.simpan_modul("Sistem".to_string(), env_sistem, true);
        
        // --- Modul Berkas ---
        let env_berkas = Rc::new(RefCell::new(LingkunganTipe::kosong()));
        env_berkas.borrow_mut().simpan_fungsi("buka_file".to_string(), vec!["teks".to_string(), "teks".to_string()], "teks".to_string(), true);
        env_berkas.borrow_mut().simpan_fungsi("tulis_teks".to_string(), vec!["teks".to_string(), "teks".to_string()], "bilangan".to_string(), true);
        env_berkas.borrow_mut().simpan_fungsi("tulis_desimal".to_string(), vec!["teks".to_string(), "desimal".to_string()], "bilangan".to_string(), true);
        env_berkas.borrow_mut().simpan_fungsi("tutup_file".to_string(), vec!["teks".to_string()], "bilangan".to_string(), true);
        env.simpan_modul("Berkas".to_string(), env_berkas, true);
        
        // --- Modul Waktu ---
        let env_waktu = Rc::new(RefCell::new(LingkunganTipe::kosong()));
        env_waktu.borrow_mut().simpan_fungsi("waktu_sekarang".to_string(), vec![], "teks".to_string(), true);
        env.simpan_modul("Waktu".to_string(), env_waktu, true);
        
        // --- Modul Matematika ---
        let env_matematika = Rc::new(RefCell::new(LingkunganTipe::kosong()));
        env_matematika.borrow_mut().simpan_fungsi("akar".to_string(), vec!["desimal".to_string()], "desimal".to_string(), true);
        env_matematika.borrow_mut().simpan_fungsi("pangkat".to_string(), vec!["desimal".to_string(), "desimal".to_string()], "desimal".to_string(), true);
        env_matematika.borrow_mut().simpan_fungsi("sin".to_string(), vec!["desimal".to_string()], "desimal".to_string(), true);
        env_matematika.borrow_mut().simpan_fungsi("cos".to_string(), vec!["desimal".to_string()], "desimal".to_string(), true);
        env_matematika.borrow_mut().simpan_fungsi("tan".to_string(), vec!["desimal".to_string()], "desimal".to_string(), true);
        env_matematika.borrow_mut().simpan_fungsi("logaritma".to_string(), vec!["desimal".to_string()], "desimal".to_string(), true);
        env.simpan_modul("Matematika".to_string(), env_matematika, true);
        
        // --- Built-in Enums: Hasil & Mungkin (Fase 7) ---
        env.simpan_enum("Hasil".to_string(), vec![
            ("Sukses".to_string(), Some(vec!["bilangan".to_string()])),
            ("Gagal".to_string(), Some(vec!["teks".to_string()])),
        ], true);

        env.simpan_enum("Mungkin".to_string(), vec![
            ("Ada".to_string(), Some(vec!["bilangan".to_string()])),
            ("Kosong".to_string(), None),
        ], true);
        
        env
    }

    pub fn kosong() -> Self {
        LingkunganTipe {
            simpanan: HashMap::new(),
            fungsi: HashMap::new(),
            modul: HashMap::new(),
            struktur: HashMap::new(),
            enum_map: HashMap::new(),
            alias_tipe: HashMap::new(),
            sifat: HashMap::new(),
            luar: None,
        }
    }

    pub fn tertutup(luar: Rc<RefCell<LingkunganTipe>>) -> Self {
        LingkunganTipe {
            simpanan: HashMap::new(),
            fungsi: HashMap::new(),
            modul: HashMap::new(),
            struktur: HashMap::new(),
            enum_map: HashMap::new(),
            alias_tipe: HashMap::new(),
            sifat: HashMap::new(),
            luar: Some(luar),
        }
    }

    pub fn simpan_variabel(&mut self, nama: String, tipe: String, is_publik: bool) {
        self.simpanan.insert(nama, (tipe, is_publik));
    }

    pub fn ambil_variabel(&self, nama: &str) -> Option<(String, bool)> {
        if let Some(idx) = nama.find("::") {
            let mod_name = &nama[..idx];
            let rest = &nama[idx+2..];
            if let Some((modul, _)) = self.ambil_modul(mod_name) {
                return modul.borrow().ambil_variabel(rest);
            }
            // Fallback for names like Struct::method
        }
        
        if let Some(t) = self.simpanan.get(nama) {
            Some(t.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_variabel(nama)
        } else {
            None
        }
    }

    pub fn simpan_fungsi(&mut self, nama: String, param: Vec<String>, ret: String, is_publik: bool) {
        self.fungsi.insert(nama, (param, ret, is_publik));
    }

    pub fn ambil_fungsi(&self, nama: &str) -> Option<(Vec<String>, String, bool)> {
        if let Some(idx) = nama.find("::") {
            let mod_name = &nama[..idx];
            let rest = &nama[idx+2..];
            if let Some((modul, _)) = self.ambil_modul(mod_name) {
                return modul.borrow().ambil_fungsi(rest);
            }
            // Fallback for method names like Struct::method
        }

        if let Some(f) = self.fungsi.get(nama) {
            Some(f.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_fungsi(nama)
        } else {
            None
        }
    }

    pub fn simpan_modul(&mut self, nama: String, modul: Rc<RefCell<LingkunganTipe>>, is_publik: bool) {
        self.modul.insert(nama, (modul, is_publik));
    }

    pub fn ambil_modul(&self, nama: &str) -> Option<(Rc<RefCell<LingkunganTipe>>, bool)> {
        if let Some(idx) = nama.find("::") {
            let mod_name = &nama[..idx];
            let rest = &nama[idx+2..];
            if let Some((modul, _)) = self.ambil_modul(mod_name) {
                return modul.borrow().ambil_modul(rest);
            }
            return None;
        }

        if let Some(m) = self.modul.get(nama) {
            Some(m.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_modul(nama)
        } else {
            None
        }
    }

    pub fn simpan_alias_tipe(&mut self, nama: String, tipe_asli: String, is_publik: bool) {
        self.alias_tipe.insert(nama, (tipe_asli, is_publik));
    }

    pub fn ambil_alias_tipe(&self, nama: &str) -> Option<(String, bool)> {
        if let Some(t) = self.alias_tipe.get(nama) {
            Some(t.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_alias_tipe(nama)
        } else {
            None
        }
    }

    pub fn simpan_sifat(&mut self, nama: String, metode: Vec<(String, Vec<String>, String)>, is_publik: bool) {
        self.sifat.insert(nama, (metode, is_publik));
    }

    pub fn ambil_sifat(&self, nama: &str) -> Option<(Vec<(String, Vec<String>, String)>, bool)> {
        if let Some(s) = self.sifat.get(nama) {
            Some(s.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_sifat(nama)
        } else {
            None
        }
    }

    pub fn simpan_struktur(&mut self, nama: String, properti: Vec<(String, String)>, is_publik: bool) {
        self.struktur.insert(nama, (properti, is_publik));
    }

    pub fn ambil_struktur(&self, nama: &str) -> Option<(Vec<(String, String)>, bool)> {
        if let Some(idx) = nama.find("::") {
            let mod_name = &nama[..idx];
            let rest = &nama[idx+2..];
            if let Some((modul, _)) = self.ambil_modul(mod_name) {
                return modul.borrow().ambil_struktur(rest);
            }
            // Fallback
        }

        if let Some(s) = self.struktur.get(nama) {
            Some(s.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_struktur(nama)
        } else {
            None
        }
    }

    pub fn simpan_enum(&mut self, nama: String, varian: Vec<(String, Option<Vec<String>>)>, is_publik: bool) {
        self.enum_map.insert(nama, (varian, is_publik));
    }

    pub fn ambil_enum(&self, nama: &str) -> Option<(Vec<(String, Option<Vec<String>>)>, bool)> {
        if let Some(idx) = nama.find("::") {
            let mod_name = &nama[..idx];
            let rest = &nama[idx+2..];
            if let Some((modul, _)) = self.ambil_modul(mod_name) {
                return modul.borrow().ambil_enum(rest);
            }
            // Fallback
        }

        if let Some(e) = self.enum_map.get(nama) {
            Some(e.clone())
        } else if let Some(luar) = &self.luar {
            luar.borrow().ambil_enum(nama)
        } else {
            None
        }
    }
}

pub struct AnalyzerSemantik {
    pub pesan_error: Vec<String>,
    /// Borrow Checker: lacak pinjaman tidak-ubah per variabel (jumlahnya)
    pinjaman_tidak_ubah: std::collections::HashMap<String, u32>,
    /// Borrow Checker: lacak pinjaman ubah per variabel (true jika sedang dipinjam ubah)
    dipinjam_ubah: std::collections::HashSet<String>,
    pub dalam_perulangan: u32,
    pub dalam_tugas: u32,
    pub dalam_blok_aman: u32,
}

impl AnalyzerSemantik {
    pub fn new() -> Self {
        Self {
            pesan_error: Vec::new(),
            pinjaman_tidak_ubah: std::collections::HashMap::new(),
            dipinjam_ubah: std::collections::HashSet::new(),
            dalam_perulangan: 0,
            dalam_tugas: 0,
            dalam_blok_aman: 0,
        }
    }

    /// Meminjam variabel secara tidak-ubah (&x). Error jika sudah ada pinjaman ubah.
    pub fn pinjam_tidak_ubah(&mut self, nama_var: &str) -> bool {
        if self.dipinjam_ubah.contains(nama_var) {
            self.pesan_error.push(format!(
                "Pelanggaran Pinjaman: '{}' tidak bisa dipinjam secara tidak-ubah karena sudah dipinjam secara ubah",
                nama_var
            ));
            return false;
        }
        *self.pinjaman_tidak_ubah.entry(nama_var.to_string()).or_insert(0) += 1;
        true
    }

    /// Meminjam variabel secara ubah (&ubah x). Error jika sudah ada pinjaman apapun.
    pub fn pinjam_ubah(&mut self, nama_var: &str) -> bool {
        let ada_tidak_ubah = self.pinjaman_tidak_ubah.get(nama_var).map_or(false, |&c| c > 0);
        if ada_tidak_ubah {
            self.pesan_error.push(format!(
                "Pelanggaran Pinjaman: '{}' tidak bisa dipinjam secara ubah karena sudah dipinjam secara tidak-ubah",
                nama_var
            ));
            return false;
        }
        if self.dipinjam_ubah.contains(nama_var) {
            self.pesan_error.push(format!(
                "Pelanggaran Pinjaman: '{}' tidak bisa dipinjam lebih dari satu kali secara ubah",
                nama_var
            ));
            return false;
        }
        self.dipinjam_ubah.insert(nama_var.to_string());
        true
    }

    /// Lepas semua pinjaman untuk variabel (saat keluar scope)
    pub fn lepas_pinjaman(&mut self, nama_var: &str) {
        self.pinjaman_tidak_ubah.remove(nama_var);
        self.dipinjam_ubah.remove(nama_var);
    }

    pub fn error(&mut self, pesan: String) -> String {
        self.pesan_error.push(pesan);
        "error".to_string()
    }

    pub fn bisa_dikonversi(sumber: &str, target: &str, lingkungan: &Rc<RefCell<LingkunganTipe>>) -> bool {
        let mut sumber_asli = sumber.to_string();
        let mut target_asli = target.to_string();
        
        if let Some((asli, _)) = lingkungan.borrow().ambil_alias_tipe(sumber) {
            sumber_asli = asli;
        }
        if let Some((asli, _)) = lingkungan.borrow().ambil_alias_tipe(target) {
            target_asli = asli;
        }

        if sumber_asli == target_asli { return true; }
        if sumber_asli == "bilangan" && target_asli == "desimal" { return true; } // Implicit cast
        
        // Referensi: &T cocok dengan &T (termasuk &ubah T)
        let s_inner = if sumber_asli.starts_with("&ubah ") { Some(&sumber_asli["&ubah ".len()..]) }
                      else if sumber_asli.starts_with('&') { Some(&sumber_asli[1..]) }
                      else { None };
        let t_inner = if target_asli.starts_with("&ubah ") { Some(&target_asli["&ubah ".len()..]) }
                      else if target_asli.starts_with('&') { Some(&target_asli[1..]) }
                      else { None };
        if let (Some(si), Some(ti)) = (s_inner, t_inner) {
            // &T dan &ubah T saling cocok dari sisi inner type
            if si == ti || si == "bilangan" && ti == "desimal" { return true; }
        }
        
        // kotak<T> cocok dengan kotak<T>
        if sumber_asli.starts_with("kotak<") && target_asli.starts_with("kotak<") { return true; }
        
        // ptr cocok dengan &T dan kotak<T>
        if sumber_asli == "ptr" && (target_asli.starts_with('&') || target_asli.starts_with("kotak")) { return true; }
        if (sumber_asli.starts_with('&') || sumber_asli.starts_with("kotak")) && target_asli == "ptr" { return true; }

        // &teks cocok dengan teks (keduanya adalah pointer ke data teks di LLVM)
        if (sumber_asli == "&teks" && target_asli == "teks") || (sumber_asli == "teks" && target_asli == "&teks") { return true; }

        false
    }

    pub fn ada_kembalikan(pernyataan: &dyn Pernyataan) -> bool {
        let any = pernyataan.as_any();
        if any.is::<PernyataanKembalikan>() { return true; }
        if let Some(b) = any.downcast_ref::<PernyataanBlok>() {
            for stmt in &b.pernyataan_pernyataan {
                if Self::ada_kembalikan(stmt.as_ref()) { return true; }
            }
            return false;
        }
        if let Some(j) = any.downcast_ref::<PernyataanJika>() {
            let konsekuensi_ada = Self::ada_kembalikan(&j.konsekuensi);
            if let Some(alt) = &j.alternatif {
                return konsekuensi_ada && Self::ada_kembalikan(alt.as_ref());
            }
            return false;
        }
        false
    }

    pub fn cek_node(&mut self, node: &dyn Node, lingkungan: &Rc<RefCell<LingkunganTipe>>, tipe_kembalian_fungsi: Option<&str>) -> String {
        let any = node.as_any();

        // -- PROGRAM --
        if let Some(p) = any.downcast_ref::<Program>() {
            for stmt in &p.pernyataan_pernyataan {
                self.cek_node(stmt.as_ref(), lingkungan, tipe_kembalian_fungsi);
            }
            return "kosong".to_string();
        }

        // -- PERNYATAAN --
        if let Some(p) = any.downcast_ref::<PernyataanEkspresi>() {
            return self.cek_node(p.ekspresi.as_ref(), lingkungan, tipe_kembalian_fungsi);
        }

        if let Some(p) = any.downcast_ref::<PernyataanDeklarasi>() {
            let tipe_nilai = self.cek_node(p.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            let tipe_simpan = if p.tipe_data == "bebas" { tipe_nilai.clone() } else { p.tipe_data.clone() };
            if tipe_nilai != "error" && p.tipe_data != "bebas" && !Self::bisa_dikonversi(&tipe_nilai, &p.tipe_data, lingkungan) {
                self.error(format!("Tipe data tidak cocok pada '{}'. Dideklarasikan sebagai '{}' tapi diisi '{}'", p.nama.nilai, p.tipe_data, tipe_nilai));
            }
            lingkungan.borrow_mut().simpan_variabel(p.nama.nilai.clone(), tipe_simpan, p.is_publik);
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanAliasTipe>() {
            lingkungan.borrow_mut().simpan_alias_tipe(p.nama.nilai.clone(), p.tipe_asli.clone(), p.is_publik);
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanPenugasan>() {
            let tipe_lhs = self.cek_node(p.nama.as_ref(), lingkungan, tipe_kembalian_fungsi);
            let tipe_nilai = self.cek_node(p.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            
            // Cek apakah LHS adalah lvalue yang valid
            let mut is_lvalue = false;
            let lhs_any = p.nama.as_any();
            if lhs_any.is::<Identitas>() || lhs_any.is::<EkspresiIndeks>() || lhs_any.is::<EkspresiAksesProperti>() || lhs_any.is::<EkspresiDeref>() {
                is_lvalue = true;
            }
            
            if !is_lvalue {
                self.error(format!("Ekspresi '{}' bukan target penugasan (lvalue) yang valid", p.nama.nilai_string()));
            } else if tipe_lhs != "error" && tipe_nilai != "error" {
                if !Self::bisa_dikonversi(&tipe_nilai, &tipe_lhs, lingkungan) {
                    self.error(format!("Tidak dapat memasukkan tipe '{}' ke dalam target penugasan bertipe '{}'", tipe_nilai, tipe_lhs));
                }
            }
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanKembalikan>() {
            let tipe_nilai = self.cek_node(p.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if let Some(target) = tipe_kembalian_fungsi {
                if tipe_nilai != "error" && !Self::bisa_dikonversi(&tipe_nilai, target, lingkungan) {
                    self.error(format!("Fungsi mengharapkan kembalian bertipe '{}', tapi mengembalikan '{}'", target, tipe_nilai));
                }
            } else {
                self.error(format!("Pernyataan 'kembalikan' tidak boleh berada di luar fungsi"));
            }
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanBlok>() {
            let env_baru = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
            for stmt in &p.pernyataan_pernyataan {
                self.cek_node(stmt.as_ref(), &env_baru, tipe_kembalian_fungsi);
            }
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanFungsi>() {
            let mut param_types = Vec::new();
            for param in &p.parameter {
                param_types.push(param.tipe_data.clone());
            }
            let registered_ret = if p.is_async {
                format!("tugas<{}>", p.tipe_kembalian)
            } else {
                p.tipe_kembalian.clone()
            };
            lingkungan.borrow_mut().simpan_fungsi(p.nama.nilai.clone(), param_types.clone(), registered_ret, p.is_publik);
            
            let env_baru = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
            for param in &p.parameter {
                env_baru.borrow_mut().simpan_variabel(param.nama.nilai.clone(), param.tipe_data.clone(), false);
            }
            
            // Cek blok fungsi
            if !p.is_asing {
                if p.is_async {
                    self.dalam_tugas += 1;
                }
                self.cek_node(&p.tubuh, &env_baru, Some(&p.tipe_kembalian));
                if p.is_async {
                    self.dalam_tugas -= 1;
                }
            }
            
            // Cek eksistensi "kembalikan" (Sesuai aturan ketat semua jalur)
            if p.tipe_kembalian != "kosong" && !p.is_asing {
                if !Self::ada_kembalikan(&p.tubuh) {
                    self.error(format!("Fungsi '{}' menjanjikan kembalian '{}', tapi tidak ada jaminan pernyataan 'kembalikan' yang tereksekusi pada semua jalur cabangnya", p.nama.nilai, p.tipe_kembalian));
                }
            }
            
            return "kosong".to_string();
        }
        
        if let Some(p) = any.downcast_ref::<PernyataanJika>() {
            let tipe_kondisi = self.cek_node(p.kondisi.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if tipe_kondisi != "logika" && tipe_kondisi != "error" {
                self.error(format!("Kondisi 'jika' harus bertipe 'logika', tapi mendapat '{}'", tipe_kondisi));
            }
            self.cek_node(&p.konsekuensi, lingkungan, tipe_kembalian_fungsi);
            if let Some(alt) = &p.alternatif {
                self.cek_node(alt.as_ref(), lingkungan, tipe_kembalian_fungsi);
            }
            return "kosong".to_string();
        }
        
        if let Some(p) = any.downcast_ref::<PernyataanSelama>() {
            let tipe_kondisi = self.cek_node(p.kondisi.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if tipe_kondisi != "logika" && tipe_kondisi != "error" {
                self.error(format!("Kondisi 'selama' harus bertipe 'logika', tapi mendapat '{}'", tipe_kondisi));
            }
            self.dalam_perulangan += 1;
            self.cek_node(&p.blok, lingkungan, tipe_kembalian_fungsi);
            self.dalam_perulangan -= 1;
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanPutar>() {
            self.dalam_perulangan += 1;
            self.cek_node(&p.blok, lingkungan, tipe_kembalian_fungsi);
            self.dalam_perulangan -= 1;
            return "kosong".to_string();
        }
        
        if let Some(p) = any.downcast_ref::<PernyataanUntukDalam>() {
            let tipe_iterable = self.cek_node(p.iterable.as_ref(), lingkungan, tipe_kembalian_fungsi);
            // Untuk saat ini, asumsikan iterable mengembalikan elemen dari array atau range (bilangan)
            let tipe_item = if tipe_iterable.starts_with("daftar<") {
                tipe_iterable["daftar<".len()..tipe_iterable.len()-1].to_string()
            } else if tipe_iterable == "rentang" {
                "bilangan".to_string()
            } else {
                "bilangan".to_string() // default fallback
            };
            
            let env_baru = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
            env_baru.borrow_mut().simpan_variabel(p.variabel.nilai.clone(), tipe_item, false);
            
            self.dalam_perulangan += 1;
            self.cek_node(&p.blok, &env_baru, tipe_kembalian_fungsi);
            self.dalam_perulangan -= 1;
            return "kosong".to_string();
        }

        if let Some(_) = any.downcast_ref::<PernyataanHenti>() {
            if self.dalam_perulangan == 0 {
                self.error("Pernyataan 'henti' hanya bisa digunakan di dalam perulangan".to_string());
            }
            return "kosong".to_string();
        }

        if let Some(_) = any.downcast_ref::<PernyataanLanjut>() {
            if self.dalam_perulangan == 0 {
                self.error("Pernyataan 'lanjut' hanya bisa digunakan di dalam perulangan".to_string());
            }
            return "kosong".to_string();
        }
        
        if let Some(p) = any.downcast_ref::<PernyataanModul>() {
            let env_modul = Rc::new(RefCell::new(LingkunganTipe::baru()));
            if let Some(b) = &p.blok {
                for stmt in &b.pernyataan_pernyataan {
                    self.cek_node(stmt.as_ref(), &env_modul, tipe_kembalian_fungsi);
                }
            }
            lingkungan.borrow_mut().simpan_modul(p.nama.clone(), env_modul, p.is_publik);
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanGunakan>() {
            let j = p.jalur.join("::");
            if p.semua {
                // If it's `gunakan A::*;`
                let path_str = p.jalur.join("::");
                let mut env_to_import = None;
                if let Some((mod_env, _)) = lingkungan.borrow().ambil_modul(&path_str) {
                    env_to_import = Some(mod_env.clone());
                }
                
                if let Some(target_env) = env_to_import {
                    // Copy all public functions, variables, structures from target_env to lingkungan
                    let target_borrow = target_env.borrow();
                    
                    let mut funcs_to_copy = Vec::new();
                    for (name, (params, ret, is_pub)) in &target_borrow.fungsi {
                        if *is_pub {
                            funcs_to_copy.push((name.clone(), params.clone(), ret.clone()));
                        }
                    }
                    
                    let mut vars_to_copy = Vec::new();
                    for (name, (tipe, is_pub)) in &target_borrow.simpanan {
                        if *is_pub {
                            vars_to_copy.push((name.clone(), tipe.clone()));
                        }
                    }
                    
                    let mut structs_to_copy = Vec::new();
                    for (name, (props, is_pub)) in &target_borrow.struktur {
                        if *is_pub {
                            structs_to_copy.push((name.clone(), props.clone()));
                        }
                    }
                    
                    drop(target_borrow);
                    
                    let mut current = lingkungan.borrow_mut();
                    for (name, params, ret) in funcs_to_copy {
                        current.simpan_fungsi(name, params, ret, false);
                    }
                    for (name, tipe) in vars_to_copy {
                        current.simpan_variabel(name, tipe, false);
                    }
                    for (name, props) in structs_to_copy {
                        current.simpan_struktur(name, props, false);
                    }
                } else {
                    self.error(format!("Modul '{}' tidak ditemukan", path_str));
                }
            } else {
                // Verify the path exists and import
                let mut valid = false;
                let mut found_func = None;
                {
                    if let Some((param, ret, is_pub)) = lingkungan.borrow().ambil_fungsi(&j) {
                        found_func = Some((param, ret, is_pub));
                    }
                }
                
                if let Some((param, ret, is_pub)) = found_func {
                    if !is_pub {
                        self.error(format!("Fungsi '{}' bersifat pribadi dan tidak dapat digunakan dari luar", j));
                    }
                    let target_name = p.jalur.last().unwrap().clone();
                    lingkungan.borrow_mut().simpan_fungsi(target_name, param, ret, false);
                    valid = true;
                } else {
                    let mut found_var = None;
                    {
                        if let Some((tipe, is_pub)) = lingkungan.borrow().ambil_variabel(&j) {
                            found_var = Some((tipe, is_pub));
                        }
                    }
                    if let Some((tipe, is_pub)) = found_var {
                        if !is_pub {
                            self.error(format!("Variabel '{}' bersifat pribadi dan tidak dapat digunakan dari luar", j));
                        }
                        let target_name = p.jalur.last().unwrap().clone();
                        lingkungan.borrow_mut().simpan_variabel(target_name, tipe, false);
                        valid = true;
                    } else {
                        let mut found_struct = None;
                        {
                            if let Some((props, is_pub)) = lingkungan.borrow().ambil_struktur(&j) {
                                found_struct = Some((props, is_pub));
                            }
                        }
                        if let Some((props, is_pub)) = found_struct {
                            if !is_pub {
                                self.error(format!("Struktur '{}' bersifat pribadi dan tidak dapat digunakan dari luar", j));
                            }
                            let target_name = p.jalur.last().unwrap().clone();
                            lingkungan.borrow_mut().simpan_struktur(target_name, props, false);
                            valid = true;
                        }
                    }
                }
                
                if !valid {
                    self.error(format!("'{}' tidak ditemukan atau bukan item yang bisa diimpor", j));
                }
            }
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanStruktur>() {
            let mut props = Vec::new();
            for (nama, tipe) in &p.properti {
                props.push((nama.nilai.clone(), tipe.clone()));
            }
            lingkungan.borrow_mut().simpan_struktur(p.nama.nilai.clone(), props, p.is_publik);
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanEnum>() {
            let mut varian = Vec::new();
            for v in &p.varian {
                varian.push((v.nama.nilai.clone(), v.tipe_data.clone()));
            }
            lingkungan.borrow_mut().simpan_enum(p.nama.nilai.clone(), varian, p.is_publik);
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanImplementasi>() {
            let _env_baru = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
            for stmt in &p.metode {
                if let Some(f) = stmt.as_any().downcast_ref::<PernyataanFungsi>() {
                    let mut param_types = Vec::new();
                    let has_diri = f.parameter.get(0).map_or(false, |param| param.nama.nilai == "diri");
                    if !has_diri {
                        param_types.push(p.nama.nilai.clone());
                    }
                    for param in &f.parameter {
                        let t = if param.tipe_data == "Diri" {
                            p.nama.nilai.clone()
                        } else {
                            param.tipe_data.clone()
                        };
                        param_types.push(t);
                    }
                    let nama_method = format!("{}::{}", p.nama.nilai, f.nama.nilai);
                    let mut ret_type = f.tipe_kembalian.clone();
                    if ret_type == "Diri" {
                        ret_type = p.nama.nilai.clone();
                    }
                    let registered_ret = if f.is_async {
                        format!("tugas<{}>", ret_type)
                    } else {
                        ret_type.clone()
                    };
                    lingkungan.borrow_mut().simpan_fungsi(nama_method, param_types.clone(), registered_ret, f.is_publik);
                    
                    let env_fungsi = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
                    if !has_diri {
                        env_fungsi.borrow_mut().simpan_variabel("diri".to_string(), p.nama.nilai.clone(), false);
                    }
                    for (i, param) in f.parameter.iter().enumerate() {
                        let idx = if has_diri { i } else { i + 1 };
                        env_fungsi.borrow_mut().simpan_variabel(param.nama.nilai.clone(), param_types[idx].clone(), false);
                    }
                    if f.is_async {
                        self.dalam_tugas += 1;
                    }
                    self.cek_node(&f.tubuh, &env_fungsi, Some(&ret_type));
                    if f.is_async {
                        self.dalam_tugas -= 1;
                    }
                }
            }
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanSifat>() {
            let mut methods = Vec::new();
            for f in &p.metode {
                let mut param_types = Vec::new();
                let has_diri = f.parameter.get(0).map_or(false, |param| param.nama.nilai == "diri");
                if !has_diri {
                    param_types.push(p.nama.nilai.clone());
                }
                for param in &f.parameter {
                    let t = if param.tipe_data == "Diri" {
                        p.nama.nilai.clone()
                    } else {
                        param.tipe_data.clone()
                    };
                    param_types.push(t);
                }
                let mut ret_type = f.tipe_kembalian.clone();
                if ret_type == "Diri" {
                    ret_type = p.nama.nilai.clone();
                }
                methods.push((f.nama.nilai.clone(), param_types, ret_type));
            }
            lingkungan.borrow_mut().simpan_sifat(p.nama.nilai.clone(), methods, p.is_publik);
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanImplementasiSifat>() {
            let sifat_nama = p.nama_sifat.nilai.clone();
            let target_nama = p.nama_target.nilai.clone();

            let sifat_info = lingkungan.borrow().ambil_sifat(&sifat_nama);
            if sifat_info.is_none() {
                self.error(format!("Sifat (trait) '{}' tidak ditemukan", sifat_nama));
                return "kosong".to_string();
            }
            let (req_methods, _) = sifat_info.unwrap();

            if lingkungan.borrow().ambil_struktur(&target_nama).is_none() {
                self.error(format!("Struktur target '{}' untuk implementasi sifat '{}' tidak ditemukan", target_nama, sifat_nama));
                return "kosong".to_string();
            }

            let mut impl_methods_map = std::collections::HashMap::new();

            for f in &p.metode {
                let mut param_types = Vec::new();
                let has_diri = f.parameter.get(0).map_or(false, |param| param.nama.nilai == "diri");
                if !has_diri {
                    param_types.push(target_nama.clone());
                }
                for param in &f.parameter {
                    let t = if param.tipe_data == "Diri" {
                        target_nama.clone()
                    } else {
                        param.tipe_data.clone()
                    };
                    param_types.push(t);
                }
                let mut ret_type = f.tipe_kembalian.clone();
                if ret_type == "Diri" {
                    ret_type = target_nama.clone();
                }

                impl_methods_map.insert(f.nama.nilai.clone(), (param_types.clone(), ret_type.clone()));

                let nama_method = format!("{}::{}", target_nama, f.nama.nilai);
                lingkungan.borrow_mut().simpan_fungsi(nama_method, param_types.clone(), ret_type.clone(), f.is_publik);

                let env_fungsi = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
                if !has_diri {
                    env_fungsi.borrow_mut().simpan_variabel("diri".to_string(), target_nama.clone(), false);
                }
                for (i, param) in f.parameter.iter().enumerate() {
                    let idx = if has_diri { i } else { i + 1 };
                    env_fungsi.borrow_mut().simpan_variabel(param.nama.nilai.clone(), param_types[idx].clone(), false);
                }
                self.cek_node(&f.tubuh, &env_fungsi, Some(&ret_type));
            }

            for (req_name, req_params, _req_ret) in &req_methods {
                if let Some((given_params, _given_ret)) = impl_methods_map.get(req_name) {
                    if given_params.len() != req_params.len() {
                        self.error(format!("Metode '{}' pada implementasi sifat '{}' untuk '{}' mengharapkan {} parameter, mendapat {}", req_name, sifat_nama, target_nama, req_params.len(), given_params.len()));
                    }
                } else {
                    self.error(format!("Implementasi sifat '{}' untuk '{}' kurang metode wajib '{}'", sifat_nama, target_nama, req_name));
                }
            }

            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanAman>() {
            self.dalam_blok_aman += 1;
            self.cek_node(&p.blok, lingkungan, tipe_kembalian_fungsi);
            self.dalam_blok_aman -= 1;
            return "kosong".to_string();
        }

        if let Some(p) = any.downcast_ref::<PernyataanPantauMemori>() {
            let var_nama = p.nama.nilai.clone();
            if lingkungan.borrow().ambil_variabel(&var_nama).is_none() {
                self.error(format!("Variabel '{}' yang ingin dipantau tidak ditemukan dalam lingkup saat ini", var_nama));
            }
            return "kosong".to_string();
        }

        if any.is::<PernyataanHenti>() || any.is::<PernyataanLanjut>() {
            return "kosong".to_string();
        }

        // -- EKSPRESI --
        if any.is::<EkspresiKosong>() { return "kosong".to_string(); }
        
        if let Some(e) = any.downcast_ref::<EkspresiBlok>() {
            let env_baru = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));
            let mut tipe_terakhir = "kosong".to_string();
            for stmt in &e.blok.pernyataan_pernyataan {
                tipe_terakhir = self.cek_node(stmt.as_ref(), &env_baru, tipe_kembalian_fungsi);
            }
            // In Rust, a block returns the type of its last expression if it lacks a semicolon.
            // But here all expressions in block statements are evaluated.
            // If the last statement is a PernyataanEkspresi, we return its type.
            if let Some(last) = e.blok.pernyataan_pernyataan.last() {
                if last.as_any().is::<PernyataanEkspresi>() {
                    return tipe_terakhir;
                }
            }
            return "kosong".to_string();
        }

        if let Some(e) = any.downcast_ref::<EkspresiKonversi>() {
            let tipe_asal = self.cek_node(e.ekspresi.as_ref(), lingkungan, tipe_kembalian_fungsi);
            let tipe_tujuan = e.tipe_tujuan.clone();
            if !Self::bisa_dikonversi(&tipe_asal, &tipe_tujuan, lingkungan) {
                // In casting, we might allow more things like "bilangan" to "desimal" and vice versa.
                // But for now, we just trust the cast or do strict checking.
                // In Tela Core, `sebagai` forces a cast, so we return the target type anyway, unless completely invalid.
                if tipe_asal == "error" { return "error".to_string(); }
            }
            return tipe_tujuan;
        }

        if any.is::<LiteralBilangan>() { return "bilangan".to_string(); }
        if any.is::<LiteralDesimal>() { return "desimal".to_string(); }
        if any.is::<LiteralTeks>() { return "teks".to_string(); }
        if any.is::<LiteralLogika>() { return "logika".to_string(); }
        if any.is::<LiteralKarakter>() { return "karakter".to_string(); }
        if let Some(e) = any.downcast_ref::<LiteralDaftar>() { 
            if e.elemen.is_empty() { return "[kosong; 0]".to_string(); }
            let mut tipe_dasar = String::new();
            for (i, el) in e.elemen.iter().enumerate() {
                let t = self.cek_node(el.as_ref(), lingkungan, tipe_kembalian_fungsi);
                if i == 0 { tipe_dasar = t; }
                else if tipe_dasar != t { return self.error("Elemen larik harus memiliki tipe yang seragam".to_string()); }
            }
            return format!("[{}; {}]", tipe_dasar, e.elemen.len());
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiIndeks>() {
            let tipe_kiri = self.cek_node(e.kiri.as_ref(), lingkungan, tipe_kembalian_fungsi);
            let tipe_indeks = self.cek_node(e.indeks.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if tipe_indeks != "bilangan" && tipe_indeks != "error" {
                return self.error(format!("Indeks larik harus berupa 'bilangan', bukan '{}'", tipe_indeks));
            }
            if tipe_kiri.starts_with('[') && tipe_kiri.ends_with(']') {
                let parts: Vec<&str> = tipe_kiri[1..tipe_kiri.len()-1].split(';').collect();
                if parts.len() == 2 {
                    return parts[0].trim().to_string();
                }
            }
            if tipe_kiri.starts_with("vektor<") && tipe_kiri.ends_with('>') {
                return tipe_kiri[7..tipe_kiri.len()-1].to_string();
            }
            if tipe_kiri != "error" {
                return self.error(format!("Tipe '{}' tidak bisa diindeks, hanya larik/vektor yang didukung", tipe_kiri));
            }
            return "error".to_string();
        }
        if let Some(e) = any.downcast_ref::<LiteralTuple>() {
            let mut element_types = Vec::new();
            for el in &e.elemen {
                element_types.push(self.cek_node(el.as_ref(), lingkungan, tipe_kembalian_fungsi));
            }
            return format!("({})", element_types.join(", "));
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiInisiasiStruktur>() {
            let nama_struct = e.nama.nilai_string();
            if let Some((props, _)) = lingkungan.borrow().ambil_struktur(&nama_struct) {
                for (nama_prop, eks_prop) in &e.properti {
                    let tipe_eks = self.cek_node(eks_prop.as_ref(), lingkungan, tipe_kembalian_fungsi);
                    let mut ketemu = false;
                    for (n, t) in &props {
                        if n == &nama_prop.nilai_string() {
                            ketemu = true;
                            if tipe_eks != "error" && !Self::bisa_dikonversi(&tipe_eks, t, lingkungan) {
                                self.error(format!("Properti '{}' pada struktur '{}' mengharapkan tipe '{}', tapi mendapat '{}'", n, nama_struct, t, tipe_eks));
                            }
                            break;
                        }
                    }
                    if !ketemu {
                        self.error(format!("Struktur '{}' tidak memiliki properti '{}'", nama_struct, nama_prop.nilai_string()));
                    }
                }
                return nama_struct;
            } else {
                return self.error(format!("Struktur '{}' tidak ditemukan", nama_struct));
            }
        }

        if let Some(e) = any.downcast_ref::<EkspresiAksesProperti>() {
            let tipe_kiri = self.cek_node(e.kiri.as_ref(), lingkungan, tipe_kembalian_fungsi);
            
            if let Some((props, _)) = lingkungan.borrow().ambil_struktur(&tipe_kiri) {
                let prop_nama = e.properti.nilai_string();
                for (n, t) in props {
                    if n == prop_nama {
                        return t;
                    }
                }
                // Bisa juga method, tapi akses method murni tanpa panggil () belum didukung first-class function pointer
                return self.error(format!("Struktur '{}' tidak memiliki properti '{}'", tipe_kiri, prop_nama));
            }

            if tipe_kiri.starts_with('(') && tipe_kiri.ends_with(')') {
                let inner = &tipe_kiri[1..tipe_kiri.len()-1];
                let mut parts = Vec::new();
                let mut depth = 0;
                let mut current = String::new();
                for c in inner.chars() {
                    if c == '(' || c == '[' { depth += 1; }
                    else if c == ')' || c == ']' { depth -= 1; }
                    
                    if c == ',' && depth == 0 {
                        parts.push(current.trim().to_string());
                        current.clear();
                    } else {
                        current.push(c);
                    }
                }
                if !current.trim().is_empty() { parts.push(current.trim().to_string()); }
                
                if let TokenType::Bilangan(n) = &e.properti.tipe {
                    let idx = *n as usize;
                    if idx < parts.len() {
                        return parts[idx].clone();
                    } else {
                        return self.error(format!("Indeks {} di luar batas tuple dengan panjang {}", idx, parts.len()));
                    }
                } else {
                    return self.error(format!("Akses elemen tuple harus menggunakan bilangan bulat, bukan '{:?}'", e.properti.tipe));
                }
            } else if tipe_kiri != "error" {
                return self.error(format!("Tipe '{}' bukan tuple/struktur, tidak bisa diakses menggunakan operator titik", tipe_kiri));
            }
            return "error".to_string();
        }

        if any.is::<LiteralKamus>() { return "kamus".to_string(); }
        
        if let Some(e) = any.downcast_ref::<Identitas>() {
            if let Some((t, _)) = lingkungan.borrow().ambil_variabel(&e.nilai) {
                return t;
            } else {
                return self.error(format!("Variabel '{}' belum dideklarasikan", e.nilai));
            }
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiPath>() {
            if e.bagian.len() == 2 {
                if let Some((varian, _)) = lingkungan.borrow().ambil_enum(&e.bagian[0]) {
                    for (nama_var, tipe_data) in &varian {
                        if nama_var == &e.bagian[1] {
                            if tipe_data.is_some() {
                                return self.error(format!("Varian enum '{}::{}' membutuhkan argumen", e.bagian[0], e.bagian[1]));
                            }
                            return e.bagian[0].clone();
                        }
                    }
                    return self.error(format!("Varian '{}' tidak ditemukan di dalam enum '{}'", e.bagian[1], e.bagian[0]));
                }
            }
            return e.bagian.join("::");
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiPrefix>() {
            let tipe_kanan = self.cek_node(e.kanan.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if tipe_kanan == "error" { return "error".to_string(); }
            
            match e.operator.as_str() {
                "-" => {
                    if tipe_kanan == "bilangan" || tipe_kanan == "desimal" {
                        return tipe_kanan;
                    }
                    return self.error(format!("Tanda minus tidak berlaku untuk tipe '{}'", tipe_kanan));
                }
                "!" => {
                    if tipe_kanan == "logika" {
                        return "logika".to_string();
                    }
                    return self.error(format!("Operator '!' hanya untuk tipe 'logika'"));
                }
                "~" => {
                    if tipe_kanan == "bilangan" {
                        return "bilangan".to_string();
                    }
                    return self.error(format!("Operator bitwise tidak berlaku untuk tipe '{}'", tipe_kanan));
                }
                op => return self.error(format!("Operator awalan '{}' tidak dikenali", op))
            }
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiInfix>() {
            let tipe_kiri = self.cek_node(e.kiri.as_ref(), lingkungan, tipe_kembalian_fungsi);
            let tipe_kanan = self.cek_node(e.kanan.as_ref(), lingkungan, tipe_kembalian_fungsi);
            
            if tipe_kiri == "error" || tipe_kanan == "error" { return "error".to_string(); }
            
            match e.operator.as_str() {
                "+" | "-" | "*" | "/" | "^" | "%" => {
                    if tipe_kiri == "bilangan" && tipe_kanan == "bilangan" {
                        return "bilangan".to_string();
                    } else if (tipe_kiri == "bilangan" || tipe_kiri == "desimal") && (tipe_kanan == "bilangan" || tipe_kanan == "desimal") {
                        return "desimal".to_string();
                    } else if tipe_kiri == "teks" && tipe_kanan == "teks" && e.operator == "+" {
                        return "teks".to_string();
                    }
                    return self.error(format!("Operator matematika '{}' tidak didukung antara '{}' dan '{}'", e.operator, tipe_kiri, tipe_kanan));
                },
                "==" | "!=" | ">" | "<" | ">=" | "<=" => {
                    if tipe_kiri == tipe_kanan {
                        return "logika".to_string();
                    }
                    if (tipe_kiri == "bilangan" || tipe_kiri == "desimal") && (tipe_kanan == "bilangan" || tipe_kanan == "desimal") {
                        return "logika".to_string();
                    }
                    return self.error(format!("Operator perbandingan '{}' tidak bisa membandingkan '{}' dan '{}'", e.operator, tipe_kiri, tipe_kanan));
                },
                "&&" | "||" => {
                    if tipe_kiri == "logika" && tipe_kanan == "logika" {
                        return "logika".to_string();
                    }
                    return self.error(format!("Operator logika '{}' hanya untuk tipe logika", e.operator));
                },
                ".." => {
                    if tipe_kiri == "bilangan" && tipe_kanan == "bilangan" {
                        return "rentang".to_string();
                    }
                    return self.error(format!("Operator rentang '..' hanya untuk tipe bilangan"));
                },
                _ => return self.error(format!("Operator '{}' tidak dikenali semantik", e.operator)),
            }
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiPanggil>() {
            let mut arg_types = Vec::new();
            let mut nama_fungsi = e.fungsi.nilai_string();
            
            // Direct enum variant call resolution (e.g. Sukses(777), Gagal("err"))
            if let Some(id) = e.fungsi.as_any().downcast_ref::<Identitas>() {
                if id.nilai == "Sukses" || id.nilai == "Gagal" {
                    return "Hasil".to_string();
                }
                if id.nilai == "Ada" || id.nilai == "Kosong" {
                    return "Mungkin".to_string();
                }
            }
            
            // Vektor method call resolution
            let mut is_vektor_method = false;
            let mut vektor_ret_type = String::new();
            if let Some(prop_akses) = e.fungsi.as_any().downcast_ref::<EkspresiAksesProperti>() {
                let tipe_kiri = self.cek_node(prop_akses.kiri.as_ref(), lingkungan, tipe_kembalian_fungsi);
                if tipe_kiri.starts_with("vektor<") && tipe_kiri.ends_with('>') {
                    let tipe_elemen = tipe_kiri[7..tipe_kiri.len()-1].to_string();
                    let method_name = prop_akses.properti.nilai_string();
                    is_vektor_method = true;
                    
                    if method_name == "tambah" {
                        if e.argumen.len() != 1 {
                            self.error(format!("Metode 'tambah' pada vektor mengharapkan 1 argumen, tapi diberi {}", e.argumen.len()));
                        } else {
                            let arg_type = self.cek_node(e.argumen[0].as_ref(), lingkungan, tipe_kembalian_fungsi);
                            if arg_type != "error" && !Self::bisa_dikonversi(&arg_type, &tipe_elemen, lingkungan) {
                                self.error(format!("Argumen untuk 'tambah' pada '{}' harus bertipe '{}', bukan '{}'", tipe_kiri, tipe_elemen, arg_type));
                            }
                        }
                        vektor_ret_type = "kosong".to_string();
                    } else if method_name == "panjang" {
                        if e.argumen.len() != 0 {
                            self.error(format!("Metode 'panjang' pada vektor tidak menerima argumen, tapi diberi {}", e.argumen.len()));
                        }
                        vektor_ret_type = "bilangan".to_string();
                    } else if method_name == "kapasitas" {
                        if e.argumen.len() != 0 {
                            self.error(format!("Metode 'kapasitas' pada vektor tidak menerima argumen, tapi diberi {}", e.argumen.len()));
                        }
                        vektor_ret_type = "bilangan".to_string();
                    } else {
                        self.error(format!("Metode '{}' tidak dikenal pada tipe '{}'", method_name, tipe_kiri));
                        vektor_ret_type = "error".to_string();
                    }
                }
            }
            
            if is_vektor_method {
                return vektor_ret_type;
            }
            
            // Method call resolution
            if let Some(prop_akses) = e.fungsi.as_any().downcast_ref::<EkspresiAksesProperti>() {
                let tipe_kiri = self.cek_node(prop_akses.kiri.as_ref(), lingkungan, tipe_kembalian_fungsi);
                if lingkungan.borrow().ambil_struktur(&tipe_kiri).is_some() {
                    let method_name = prop_akses.properti.nilai_string();
                    nama_fungsi = format!("{}::{}", tipe_kiri, method_name);
                    arg_types.push(tipe_kiri); // 'diri' tersembunyi
                }
            }
            
            for arg in &e.argumen {
                arg_types.push(self.cek_node(arg.as_ref(), lingkungan, tipe_kembalian_fungsi));
            }
            
            // Enum variant call resolution
            if let Some(path) = e.fungsi.as_any().downcast_ref::<EkspresiPath>() {
                if path.bagian.len() == 2 {
                    if let Some((varian, _)) = lingkungan.borrow().ambil_enum(&path.bagian[0]) {
                        for (nama_var, tipe_data_opt) in &varian {
                            if nama_var == &path.bagian[1] {
                                if let Some(tipe_data) = tipe_data_opt {
                                    if arg_types.len() != tipe_data.len() {
                                        return self.error(format!("Varian enum '{}::{}' mengharapkan {} argumen, tapi diberi {}", path.bagian[0], path.bagian[1], tipe_data.len(), arg_types.len()));
                                    }
                                    for i in 0..tipe_data.len() {
                                        let tipe_arg = &arg_types[i];
                                        if tipe_arg != "error" && !Self::bisa_dikonversi(tipe_arg, &tipe_data[i], lingkungan) {
                                            self.error(format!("Argumen ke-{} pada varian enum '{}::{}' seharusnya bertipe '{}', tapi mendapat '{}'", i+1, path.bagian[0], path.bagian[1], tipe_data[i], tipe_arg));
                                        }
                                    }
                                } else {
                                    return self.error(format!("Varian enum '{}::{}' tidak menerima argumen", path.bagian[0], path.bagian[1]));
                                }
                                return path.bagian[0].clone();
                            }
                        }
                    }
                }
            }
            
            if let Some((params, ret, _)) = lingkungan.borrow().ambil_fungsi(&nama_fungsi) {
                if arg_types.len() != params.len() {
                    return self.error(format!("Fungsi '{}' mengharapkan {} argumen, tapi diberi {}", nama_fungsi, params.len(), arg_types.len()));
                }
                for i in 0..params.len() {
                    let tipe_arg = &arg_types[i];
                    if tipe_arg != "error" && !Self::bisa_dikonversi(tipe_arg, &params[i], lingkungan) {
                        self.error(format!("Argumen ke-{} pada fungsi '{}' seharusnya bertipe '{}', tapi mendapat '{}'", i+1, nama_fungsi, params[i], tipe_arg));
                    }
                }
                return ret;
            } else {
                return self.error(format!("Fungsi '{}' tidak ditemukan", nama_fungsi));
            }
        }

        // --- Fase 6A + 6B: Referensi (&x) dengan Borrow Checker ---
        if let Some(e) = any.downcast_ref::<EkspresiReferensi>() {
            let tipe_nilai = self.cek_node(e.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            // Jalankan borrow checker: lacak pinjaman tidak-ubah
            if let Some(id) = e.nilai.as_any().downcast_ref::<Identitas>() {
                self.pinjam_tidak_ubah(&id.nilai);
            }
            return format!("&{}", tipe_nilai);
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiDeref>() {
            let tipe_nilai = self.cek_node(e.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            // Deref dari &ubah T menghasilkan T
            if tipe_nilai.starts_with("&ubah ") {
                return tipe_nilai["&ubah ".len()..].to_string();
            }
            // Deref dari &T menghasilkan T
            if tipe_nilai.starts_with('&') {
                return tipe_nilai[1..].to_string();
            }
            // Deref dari kotak<T> menghasilkan T
            if tipe_nilai.starts_with("kotak<") && tipe_nilai.ends_with('>') {
                return tipe_nilai[6..tipe_nilai.len()-1].to_string();
            }
            return tipe_nilai;
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiKotak>() {
            let tipe_nilai = self.cek_node(e.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            return format!("kotak<{}>", tipe_nilai);
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiVektorBaru>() {
            return format!("vektor<{}>", e.tipe_elemen);
        }
        
        // --- Fase 6B: Referensi Ubah (&ubah x) dengan Borrow Checker ---
        if let Some(e) = any.downcast_ref::<EkspresiReferensiUbah>() {
            let tipe_nilai = self.cek_node(e.nilai.as_ref(), lingkungan, tipe_kembalian_fungsi);
            // Jalankan borrow checker: lacak pinjaman ubah
            if let Some(id) = e.nilai.as_any().downcast_ref::<Identitas>() {
                self.pinjam_ubah(&id.nilai);
            }
            return format!("&ubah {}", tipe_nilai);
        }

        // --- Fase 7: Ekspresi Cocokkan (Pattern Matching) ---
        if let Some(e) = any.downcast_ref::<EkspresiCocokkan>() {
            let tipe_target = self.cek_node(e.target.as_ref(), lingkungan, tipe_kembalian_fungsi);
            let mut tipe_hasil = "".to_string();

            for (i, cb) in e.cabang.iter().enumerate() {
                // Buat lingkungan tertutup untuk binding variabel di pola
                let env_cabang = Rc::new(RefCell::new(LingkunganTipe::tertutup(lingkungan.clone())));

                match &cb.pola {
                    Pola::Varian { nama, variabel } => {
                        let (enum_nama_target, var_nama_target) = if nama.contains("::") {
                            let parts: Vec<&str> = nama.split("::").collect();
                            (parts[0].to_string(), parts[1].to_string())
                        } else if tipe_target != "error" && !tipe_target.is_empty() {
                            (tipe_target.clone(), nama.clone())
                        } else {
                            ("Hasil".to_string(), nama.clone())
                        };

                        if let Some((varian_list, _)) = lingkungan.borrow().ambil_enum(&enum_nama_target) {
                            for (v_name, payload_opt) in varian_list {
                                if v_name == var_nama_target {
                                    if let Some(payload_types) = payload_opt {
                                        for (k, v_bound) in variabel.iter().enumerate() {
                                            if v_bound != "_" {
                                                let t = payload_types.get(k).cloned().unwrap_or_else(|| "bilangan".to_string());
                                                env_cabang.borrow_mut().simpan_variabel(v_bound.clone(), t, false);
                                            }
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                    },
                    Pola::Variabel(v) => {
                        if v != "_" {
                            env_cabang.borrow_mut().simpan_variabel(v.clone(), tipe_target.clone(), false);
                        }
                    },
                    Pola::Literal(lit) => {
                        self.cek_node(lit.as_ref(), &env_cabang, tipe_kembalian_fungsi);
                    },
                    Pola::Wildcard => {},
                }

                let t_branch = self.cek_node(cb.ekspresi.as_ref(), &env_cabang, tipe_kembalian_fungsi);
                if i == 0 {
                    tipe_hasil = t_branch;
                } else if tipe_hasil != "error" && t_branch != "error" {
                    if !Self::bisa_dikonversi(&t_branch, &tipe_hasil, lingkungan) {
                        self.error(format!("Tipe cabang ke-{} pada 'cocokkan' ({}) tidak sama dengan cabang pertama ({})", i+1, t_branch, tipe_hasil));
                    }
                }
            }
            return if tipe_hasil.is_empty() { "kosong".to_string() } else { tipe_hasil };
        }

        // --- Fase 7: Ekspresi Coba (coba expr) ---
        if let Some(e) = any.downcast_ref::<EkspresiCoba>() {
            let tipe_eks = self.cek_node(e.ekspresi.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if tipe_eks.starts_with("Hasil<") || tipe_eks == "Hasil" {
                return "bilangan".to_string();
            }
            return tipe_eks;
        }
        
        // --- Fase 10: Ekspresi Tunggu (tunggu expr) ---
        if let Some(e) = any.downcast_ref::<EkspresiTunggu>() {
            if self.dalam_tugas == 0 {
                self.error("Kata kunci 'tunggu' hanya dapat digunakan di dalam fungsi/metode asinkron ('tugas fungsi')".to_string());
            }
            let tipe_eks = self.cek_node(e.ekspresi.as_ref(), lingkungan, tipe_kembalian_fungsi);
            if tipe_eks.starts_with("tugas<") && tipe_eks.ends_with('>') {
                let inner = &tipe_eks[6..tipe_eks.len()-1];
                return inner.to_string();
            } else if tipe_eks != "error" {
                self.error(format!("Kata kunci 'tunggu' mengharapkan ekspresi asinkron bertipe 'tugas<T>', mendapat '{}'", tipe_eks));
            }
            return "error".to_string();
        }

        self.error(format!("Node AST tidak didukung secara semantik"))
    }
}

