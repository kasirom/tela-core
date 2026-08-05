use crate::ast::*;
use crate::objek::Objek;
use crate::lingkungan::Lingkungan;
use std::rc::Rc;
use std::cell::RefCell;

pub struct Evaluator;

impl Evaluator {
    pub fn evaluasi(node: &dyn Node, lingkungan: &Rc<RefCell<Lingkungan>>) -> Objek {
        let any = node.as_any();

        // --- PROGRAM ---
        if let Some(prog) = any.downcast_ref::<Program>() {
            return Self::evaluasi_program(prog, lingkungan);
        }

        // --- STATEMENTS ---
        if let Some(p) = any.downcast_ref::<PernyataanEkspresi>() {
            return Self::evaluasi(p.ekspresi.as_ref(), lingkungan);
        }
        if let Some(p) = any.downcast_ref::<PernyataanDeklarasi>() {
            let nilai = Self::evaluasi(p.nilai.as_ref(), lingkungan);
            if Self::is_error(&nilai) { return nilai; }
            lingkungan.borrow_mut().simpan(p.nama.nilai.clone(), nilai);
            return Objek::Kosong;
        }
        if let Some(p) = any.downcast_ref::<PernyataanKembalikan>() {
            let nilai = Self::evaluasi(p.nilai.as_ref(), lingkungan);
            if Self::is_error(&nilai) { return nilai; }
            return Objek::Kembalikan(Box::new(nilai));
        }
        if let Some(p) = any.downcast_ref::<PernyataanPenugasan>() {
            let mut nilai = Self::evaluasi(p.nilai.as_ref(), lingkungan);
            if Self::is_error(&nilai) { return nilai; }
            
            if let Some(id) = p.nama.as_any().downcast_ref::<Identitas>() {
                if p.operator != "=" {
                    if let Some(nilai_lama) = lingkungan.borrow().ambil(&id.nilai) {
                        let op = &p.operator[..p.operator.len()-1];
                        nilai = Self::evaluasi_infix(op, nilai_lama, nilai);
                        if Self::is_error(&nilai) { return nilai; }
                    } else {
                        return Objek::Error(format!("Variabel '{}' belum dideklarasikan", id.nilai));
                    }
                }
                
                let berhasil = lingkungan.borrow_mut().perbarui(&id.nilai, nilai.clone());
                if !berhasil {
                    return Objek::Error(format!("Variabel '{}' belum dideklarasikan", id.nilai));
                }
                return nilai;
            } else {
                return Objek::Error("Evaluator tidak mendukung penugasan ke lvalue non-identitas".to_string());
            }
        }
        if let Some(p) = any.downcast_ref::<PernyataanBlok>() {
            let lingkungan_baru = Rc::new(RefCell::new(Lingkungan::tertutup(lingkungan.clone())));
            let mut hasil = Objek::Kosong;
            for pernyataan in &p.pernyataan_pernyataan {
                hasil = Self::evaluasi(pernyataan.as_ref(), &lingkungan_baru);
                if matches!(hasil, Objek::Kembalikan(_) | Objek::Error(_)) { return hasil; }
            }
            return hasil;
        }
        if let Some(p) = any.downcast_ref::<PernyataanFungsi>() {
            let nilai = Objek::Fungsi(
                p.parameter.clone(),
                p.tubuh.clone(),
                lingkungan.clone()
            );
            lingkungan.borrow_mut().simpan(p.nama.nilai.clone(), nilai);
            return Objek::Kosong;
        }
        if let Some(p) = any.downcast_ref::<PernyataanJika>() {
            let kondisi = Self::evaluasi(p.kondisi.as_ref(), lingkungan);
            if Self::is_error(&kondisi) { return kondisi; }
            
            let mut is_truthy = false;
            if let Objek::Logika(b) = kondisi { is_truthy = b; }
            
            if is_truthy {
                return Self::evaluasi(&p.konsekuensi, lingkungan);
            } else if let Some(alt) = &p.alternatif {
                return Self::evaluasi(alt.as_ref(), lingkungan);
            }
            return Objek::Kosong;
        }
        if let Some(p) = any.downcast_ref::<PernyataanSelama>() {
            let mut hasil = Objek::Kosong;
            loop {
                let kondisi = Self::evaluasi(p.kondisi.as_ref(), lingkungan);
                if Self::is_error(&kondisi) { return kondisi; }
                
                let mut is_truthy = false;
                if let Objek::Logika(b) = kondisi { is_truthy = b; }
                
                if !is_truthy { break; }
                
                let hasil_iter = Self::evaluasi(&p.blok, lingkungan);
                if Self::is_error(&hasil_iter) || matches!(hasil_iter, Objek::Kembalikan(_)) {
                    return hasil_iter;
                }
                hasil = hasil_iter;
            }
            return hasil;
        }
        if let Some(_) = any.downcast_ref::<PernyataanPantauMemori>() {
            return Objek::Kosong;
        }

        // --- EXPRESSIONS ---
        if let Some(e) = any.downcast_ref::<LiteralBilangan>() {
            return Objek::Bilangan(e.nilai);
        }
        if let Some(e) = any.downcast_ref::<LiteralDesimal>() {
            return Objek::Desimal(e.nilai);
        }
        if let Some(e) = any.downcast_ref::<LiteralKarakter>() {
            return Objek::Karakter(e.nilai);
        }
        if let Some(e) = any.downcast_ref::<LiteralTeks>() {
            return Objek::Teks(e.nilai.clone());
        }
        if let Some(e) = any.downcast_ref::<LiteralLogika>() {
            return Objek::Logika(e.nilai);
        }
        if let Some(e) = any.downcast_ref::<LiteralDaftar>() {
            let mut elemen = Vec::new();
            for eks in &e.elemen {
                let nilai = Self::evaluasi(eks.as_ref(), lingkungan);
                if Self::is_error(&nilai) { return nilai; }
                elemen.push(nilai);
            }
            return Objek::Daftar(elemen);
        }
        if let Some(e) = any.downcast_ref::<Identitas>() {
            if let Some(val) = lingkungan.borrow().ambil(&e.nilai) {
                return val;
            } else {
                return Objek::Error(format!("Variabel '{}' tidak ditemukan", e.nilai));
            }
        }
        if let Some(e) = any.downcast_ref::<EkspresiPrefix>() {
            let kanan = Self::evaluasi(e.kanan.as_ref(), lingkungan);
            if Self::is_error(&kanan) { return kanan; }
            return match (e.operator.as_str(), kanan) {
                ("-", Objek::Bilangan(v)) => Objek::Bilangan(-v),
                ("-", Objek::Desimal(v)) => Objek::Desimal(-v),
                ("!", Objek::Logika(v)) => Objek::Logika(!v),
                (op, val) => Objek::Error(format!("Operator awalan {} tidak berlaku untuk {}", op, val)),
            };
        }
        if let Some(e) = any.downcast_ref::<EkspresiInfix>() {
            let kiri = Self::evaluasi(e.kiri.as_ref(), lingkungan);
            if Self::is_error(&kiri) { return kiri; }
            let kanan = Self::evaluasi(e.kanan.as_ref(), lingkungan);
            if Self::is_error(&kanan) { return kanan; }
            return Self::evaluasi_infix(&e.operator, kiri, kanan);
        }
        if let Some(e) = any.downcast_ref::<EkspresiPanggil>() {
            let fungsi = Self::evaluasi(e.fungsi.as_ref(), lingkungan);
            if Self::is_error(&fungsi) { return fungsi; }
            
            let mut argumen_eval = Vec::new();
            for arg in &e.argumen {
                let nilai = Self::evaluasi(arg.as_ref(), lingkungan);
                if Self::is_error(&nilai) { return nilai; }
                argumen_eval.push(nilai);
            }
            
            return match fungsi {
                Objek::Fungsi(params, tubuh, lingkungan_luar) => {
                    let lingkungan_fungsi = Rc::new(RefCell::new(Lingkungan::tertutup(lingkungan_luar)));
                    for (param, nilai) in params.iter().zip(argumen_eval) {
                        lingkungan_fungsi.borrow_mut().simpan(param.nama.nilai.clone(), nilai);
                    }
                    let hasil = Self::evaluasi(&tubuh, &lingkungan_fungsi);
                    match hasil {
                        Objek::Kembalikan(nilai) => *nilai,
                        Objek::Error(_) => hasil,
                        _ => Objek::Kosong,
                    }
                }
                _ => Objek::Error("Bukan fungsi yang bisa dipanggil".to_string()),
            };
        }
        if let Some(e) = any.downcast_ref::<EkspresiTunggu>() {
            return Self::evaluasi(e.ekspresi.as_ref(), lingkungan);
        }

        Objek::Error(format!("Node AST tidak dikenali oleh Evaluator"))
    }

    fn is_error(obj: &Objek) -> bool {
        matches!(obj, Objek::Error(_))
    }

    fn evaluasi_program(program: &Program, lingkungan: &Rc<RefCell<Lingkungan>>) -> Objek {
        let mut hasil = Objek::Kosong;
        for p in &program.pernyataan_pernyataan {
            hasil = Self::evaluasi(p.as_ref(), lingkungan);
            match hasil {
                Objek::Kembalikan(nilai) => return *nilai,
                Objek::Error(_) => return hasil,
                _ => {}
            }
        }
        hasil
    }

    fn evaluasi_infix(operator: &str, kiri: Objek, kanan: Objek) -> Objek {
        match (kiri, kanan) {
            (Objek::Bilangan(k), Objek::Bilangan(ka)) => {
                match operator {
                    "+" => Objek::Bilangan(k + ka),
                    "-" => Objek::Bilangan(k - ka),
                    "*" => Objek::Bilangan(k * ka),
                    "/" => {
                        if ka == 0 { Objek::Error("Pembagian dengan nol".to_string()) }
                        else { Objek::Bilangan(k / ka) }
                    },
                    "==" => Objek::Logika(k == ka),
                    "!=" => Objek::Logika(k != ka),
                    ">" => Objek::Logika(k > ka),
                    "<" => Objek::Logika(k < ka),
                    ">=" => Objek::Logika(k >= ka),
                    "<=" => Objek::Logika(k <= ka),
                    _ => Objek::Error(format!("Operator {} tidak didukung untuk bilangan", operator)),
                }
            },
            (Objek::Teks(k), Objek::Teks(ka)) => {
                match operator {
                    "+" => Objek::Teks(format!("{}{}", k, ka)),
                    "==" => Objek::Logika(k == ka),
                    "!=" => Objek::Logika(k != ka),
                    _ => Objek::Error(format!("Operator {} tidak didukung untuk teks", operator)),
                }
            },
            (k, ka) => {
                // Let's handle f64 here manually to avoid Rust binding issue
                let left_val = match k {
                    Objek::Bilangan(n) => Some(n as f64),
                    Objek::Desimal(d) => Some(d),
                    _ => None,
                };
                let right_val = match ka {
                    Objek::Bilangan(n) => Some(n as f64),
                    Objek::Desimal(d) => Some(d),
                    _ => None,
                };
                
                if let (Some(l), Some(r)) = (left_val, right_val) {
                    match operator {
                        "+" => Objek::Desimal(l + r),
                        "-" => Objek::Desimal(l - r),
                        "*" => Objek::Desimal(l * r),
                        "/" => if r == 0.0 { Objek::Error("Pembagian dengan nol".into()) } else { Objek::Desimal(l / r) },
                        "==" => Objek::Logika((l - r).abs() < f64::EPSILON),
                        "!=" => Objek::Logika((l - r).abs() >= f64::EPSILON),
                        ">" => Objek::Logika(l > r),
                        "<" => Objek::Logika(l < r),
                        ">=" => Objek::Logika(l >= r),
                        "<=" => Objek::Logika(l <= r),
                        _ => Objek::Error(format!("Operator {} tidak didukung", operator)),
                    }
                } else {
                    Objek::Error(format!("Tidak bisa melakukan {} antara {} dan {}", operator, k, ka))
                }
            }
        }
    }
}
