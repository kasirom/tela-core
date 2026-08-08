use std::collections::HashMap;
use std::rc::Rc;
use std::cell::RefCell;
use crate::objek::Objek;

#[derive(Clone)]
pub struct Lingkungan {
    simpanan: HashMap<String, Objek>,
    luar: Option<Rc<RefCell<Lingkungan>>>,
}

impl Lingkungan {
    pub fn baru() -> Self {
        Lingkungan {
            simpanan: HashMap::new(),
            luar: None,
        }
    }

    pub fn tertutup(luar: Rc<RefCell<Lingkungan>>) -> Self {
        Lingkungan {
            simpanan: HashMap::new(),
            luar: Some(luar),
        }
    }

    pub fn ambil(&self, nama: &str) -> Option<Objek> {
        match self.simpanan.get(nama) {
            Some(obj) => Some(obj.clone()),
            None => {
                if let Some(luar) = &self.luar {
                    luar.borrow().ambil(nama)
                } else {
                    None
                }
            }
        }
    }

    pub fn simpan(&mut self, nama: String, nilai: Objek) {
        self.simpanan.insert(nama, nilai);
    }

    pub fn perbarui(&mut self, nama: &str, nilai: Objek) -> bool {
        if self.simpanan.contains_key(nama) {
            self.simpanan.insert(nama.to_string(), nilai);
            return true;
        }
        if let Some(luar) = &self.luar {
            luar.borrow_mut().perbarui(nama, nilai)
        } else {
            false
        }
    }
}
