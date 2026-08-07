use crate::ast::{Parameter, PernyataanBlok};
use crate::lingkungan::Lingkungan;
use std::rc::Rc;
use std::cell::RefCell;
use std::fmt;

#[derive(Clone)]
pub enum Objek {
    Bilangan(i64),
    Desimal(f64),
    Teks(String),
    Karakter(char),
    Logika(bool),
    Daftar(Vec<Objek>),
    Kamus(Vec<(Objek, Objek)>),
    Kosong,
    Kembalikan(Box<Objek>),
    Error(String),
    Fungsi(Vec<Parameter>, PernyataanBlok, Rc<RefCell<Lingkungan>>),
}

impl fmt::Display for Objek {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Objek::Bilangan(v) => write!(f, "{}", v),
            Objek::Desimal(v) => write!(f, "{}", v),
            Objek::Teks(v) => write!(f, "\"{}\"", v),
            Objek::Logika(v) => write!(f, "{}", if *v { "benar" } else { "salah" }),
            Objek::Karakter(v) => write!(f, "'{}'", v),
            Objek::Daftar(elemen) => {
                let s: Vec<String> = elemen.iter().map(|e| format!("{}", e)).collect();
                write!(f, "[{}]", s.join(", "))
            },
            Objek::Kamus(pasangan) => {
                let s: Vec<String> = pasangan.iter().map(|(k, v)| format!("{}: {}", k, v)).collect();
                write!(f, "{{{}}}", s.join(", "))
            },
            Objek::Kosong => write!(f, "kosong"),
            Objek::Kembalikan(v) => write!(f, "kembalikan {}", v),
            Objek::Error(v) => write!(f, "error: {}", v),
            Objek::Fungsi(params, _, _) => {
                let p: Vec<String> = params.iter().map(|p| p.nama.nilai.clone()).collect();
                write!(f, "fungsi({})", p.join(", "))
            }
        }
    }
}
