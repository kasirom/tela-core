use crate::ast::*;
use std::collections::HashMap;
use crate::token::TokenType;

pub struct LLVMGenerator {
    pub output: String,
    pub temporary_id_counter: i64,
    pub block_id_counter: i64,
    pub var_map: HashMap<String, String>,
    pub var_type_map: HashMap<String, String>,
    pub var_bahasa_type_map: HashMap<String, String>,
    pub string_literals: Vec<(String, String)>,
    pub functions_output: String,
    pub function_map: HashMap<String, (String, Vec<String>)>,
    pub async_function_map: HashMap<String, String>,
    pub current_function_return_type: String,
    pub loop_stack: Vec<(String, String)>, // (continue_label, break_label)
    pub current_module_path: Vec<String>,
    pub struct_types: HashMap<String, Vec<(String, String)>>,
    pub enum_map: HashMap<String, Vec<(String, Option<Vec<String>>)>>,
    pub alias_tipe: HashMap<String, String>,
    pub struct_header_output: String,
    pub import_map: HashMap<String, String>,
    pub is_test_mode: bool,
    pub test_functions: Vec<String>,
    pub dalam_blok_aman: bool,
}

impl LLVMGenerator {
    pub fn new() -> Self {
        Self {
            output: String::new(),
            temporary_id_counter: 1,
            block_id_counter: 1,
            var_map: HashMap::new(),
            var_type_map: HashMap::new(),
            var_bahasa_type_map: HashMap::new(),
            string_literals: Vec::new(),
            functions_output: String::new(),
            function_map: HashMap::new(),
            async_function_map: HashMap::new(),
            current_function_return_type: "i32".to_string(),
            loop_stack: Vec::new(),
            current_module_path: Vec::new(),
            struct_types: HashMap::new(),
            enum_map: HashMap::new(),
            alias_tipe: HashMap::new(),
            struct_header_output: String::new(),
            import_map: HashMap::new(),
            is_test_mode: false,
            test_functions: Vec::new(),
            dalam_blok_aman: false,
        }
    }

    fn new_temp(&mut self) -> String {
        let id = self.temporary_id_counter;
        self.temporary_id_counter += 1;
        format!("%{}", id)
    }

    fn new_block(&mut self) -> String {
        let id = self.block_id_counter;
        self.block_id_counter += 1;
        format!("lbl_{}", id)
    }

    fn has_terminator(output: &str) -> bool {
        let lines: Vec<&str> = output.trim_end().split('\n').collect();
        if let Some(last_line) = lines.last() {
            let trimmed = last_line.trim();
            trimmed.starts_with("ret ") || trimmed.starts_with("br ") || trimmed == "unreachable"
        } else {
            false
        }
    }

    pub fn llvm_tipe(&self, tipe_bahasa: &str) -> String {
        // Jika tipe sudah berupa tipe LLVM array "[N x T]"
        if tipe_bahasa.starts_with('[') && tipe_bahasa.contains(" x ") && tipe_bahasa.ends_with(']') {
            return tipe_bahasa.to_string();
        }
        // Tipe referensi `&T` → ptr
        if tipe_bahasa.starts_with('&') {
            return "ptr".to_string();
        }
        // Tipe kotak `kotak<T>` → ptr (heap)
        if tipe_bahasa.starts_with("kotak<") || tipe_bahasa == "kotak" {
            return "ptr".to_string();
        }
        // Tipe larik dinamis `vektor<T>` → ptr (heap)
        if tipe_bahasa.starts_with("vektor<") || tipe_bahasa == "vektor" {
            return "ptr".to_string();
        }
        // Tipe struct / tuple LLVM `{ ... }` → return as-is
        if tipe_bahasa.starts_with('{') {
            return tipe_bahasa.to_string();
        }
        if tipe_bahasa.starts_with('[') && tipe_bahasa.ends_with(']') {
            let parts: Vec<&str> = tipe_bahasa[1..tipe_bahasa.len()-1].split(';').collect();
            if parts.len() == 2 {
                let t_dasar = self.llvm_tipe(parts[0].trim());
                let ukuran = parts[1].trim();
                return format!("[{} x {}]", ukuran, t_dasar);
            }
        }
        if tipe_bahasa.starts_with('(') && tipe_bahasa.ends_with(')') {
            let inner = &tipe_bahasa[1..tipe_bahasa.len()-1];
            let mut element_types = Vec::new();
            
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
            
            for p in parts {
                element_types.push(self.llvm_tipe(&p));
            }
            return format!("{{ {} }}", element_types.join(", "));
        }
        
        match tipe_bahasa {
            "bilangan" | "i64" => "i64".to_string(),
            "desimal" | "double" => "double".to_string(),
            "logika" | "i1" => "i1".to_string(),
            "karakter" | "i8" => "i8".to_string(),
            "teks" | "ptr" => "ptr".to_string(),
            "kosong" | "void" => "void".to_string(),
            _ => {
                if tipe_bahasa.starts_with('%') {
                    return tipe_bahasa.to_string();
                }
                // Cek apakah tipe adalah nama struktur
                if self.struct_types.contains_key(tipe_bahasa) {
                    return format!("%{}", tipe_bahasa);
                }
                if self.enum_map.contains_key(tipe_bahasa) {
                    return "{ i32, ptr }".to_string(); // Simple Enum representation
                }
                if let Some(asli) = self.alias_tipe.get(tipe_bahasa).cloned() {
                    return self.llvm_tipe(&asli);
                }
                "ptr".to_string()
            }
        }
    }

    pub fn generate(&mut self, node: &dyn Node) {
        self.generate_node(node);
        
        let mut final_out = String::new();
        final_out.push_str("; --- TELA CORE LLVM IR ---\n");
        final_out.push_str("target datalayout = \"e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\"\n");
        final_out.push_str("target triple = \"x86_64-pc-windows-msvc\"\n\n");
        
        // Deklarasi fungsi bawaan OS (C Standard Library)
        final_out.push_str("declare i32 @printf(ptr, ...)\n");
        final_out.push_str("declare i32 @scanf(ptr, ...)\n");
        final_out.push_str("@.fmt.desimal = private unnamed_addr constant [6 x i8] c\"%.15g\\00\", align 1\n");
        final_out.push_str("@.fmt.input_desimal = private unnamed_addr constant [4 x i8] c\"%lf\\00\", align 1\n");
        final_out.push_str("@.fmt.input_bilangan = private unnamed_addr constant [5 x i8] c\"%lld\\00\", align 1\n");
        final_out.push_str("@.fmt.string_nl = private unnamed_addr constant [3 x i8] c\"%s\\00\", align 1\n\n");
        final_out.push_str("declare ptr @GetStdHandle(i32)\n");
        final_out.push_str("declare i32 @GetConsoleMode(ptr, ptr)\n");
        final_out.push_str("declare i32 @SetConsoleMode(ptr, i32)\n");
        final_out.push_str("declare i32 @SetConsoleOutputCP(i32)\n");
        final_out.push_str("declare i32 @getchar()\n");
        final_out.push_str("declare i32 @MessageBeep(i32)\n\n");
        
        // Deklarasi File I/O
        final_out.push_str("declare ptr @fopen(ptr, ptr)\n");
        final_out.push_str("declare i32 @fprintf(ptr, ptr, ...)\n");
        final_out.push_str("declare i32 @fclose(ptr)\n\n");
        
        // Deklarasi C Math
        final_out.push_str("declare double @sqrt(double)\n");
        final_out.push_str("declare double @pow(double, double)\n");
        final_out.push_str("declare double @sin(double)\n");
        final_out.push_str("declare double @cos(double)\n");
        final_out.push_str("declare double @tan(double)\n");
        final_out.push_str("declare double @log10(double)\n\n");

        // Deklarasi Waktu (Time) dan Memori
        final_out.push_str("declare i64 @time(ptr)\n");
        final_out.push_str("declare ptr @localtime(ptr)\n");
        final_out.push_str("declare i64 @strftime(ptr, i64, ptr, ptr)\n");
        final_out.push_str("declare ptr @malloc(i64)\n");
        final_out.push_str("declare ptr @realloc(ptr, i64)\n");
        final_out.push_str("declare void @free(ptr)\n");
        final_out.push_str("declare ptr @CreateThread(ptr, i64, ptr, ptr, i32, ptr)\n");
        final_out.push_str("declare i32 @WaitForSingleObject(ptr, i32)\n");
        final_out.push_str("declare i32 @CloseHandle(ptr)\n\n");
        
        final_out.push_str("@.fmt.string = private unnamed_addr constant [3 x i8] c\"%s\\00\", align 1\n");
        final_out.push_str("@.fmt.waktu = private unnamed_addr constant [18 x i8] c\"%Y-%m-%d %H:%M:%S\\00\", align 1\n");
        final_out.push_str("@.fmt.test.header = private unnamed_addr constant [32 x i8] c\"==============================\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.test.start = private unnamed_addr constant [27 x i8] c\"Menjalankan pengujian...\\0A\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.test.running = private unnamed_addr constant [12 x i8] c\"TES %s ... \\00\", align 1\n");
        final_out.push_str("@.fmt.test.ok = private unnamed_addr constant [4 x i8] c\"OK\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.test.gagal = private unnamed_addr constant [7 x i8] c\"GAGAL\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.test.summary = private unnamed_addr constant [50 x i8] c\"\\0AHasil Pengujian: %d lulus, %d gagal dari %d tes\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.pantau.header = private unnamed_addr constant [42 x i8] c\"========================================\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.pantau.title = private unnamed_addr constant [21 x i8] c\"[PANTAU MEMORI: %s]\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.pantau.addr = private unnamed_addr constant [23 x i8] c\"  Alamat Pointer : %p\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.pantau.type = private unnamed_addr constant [23 x i8] c\"  Tipe Data      : %s\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.pantau.size = private unnamed_addr constant [30 x i8] c\"  Ukuran Memori  : %lld byte\\0A\\00\", align 1\n");
        final_out.push_str("@.fmt.aman.divzero = private unnamed_addr constant [70 x i8] c\"  Peringatan (Aman): Pembagian dengan nol terdeteksi. Hasil diset 0.\\0A\\00\", align 1\n\n");
        
        // Deklarasikan semua global string literal
        for (name, val) in &self.string_literals {
            final_out.push_str(&format!("{} = private unnamed_addr constant {}, align 1\n", name, val));
        }
        
        final_out.push_str(&self.struct_header_output);
        final_out.push_str(&self.functions_output);
        final_out.push_str("\n");
        
        final_out.push_str("define i32 @main() {\n");
        final_out.push_str("entry:\n");
        
        final_out.push_str("  call i32 @SetConsoleOutputCP(i32 65001)\n");
        
        final_out.push_str("  %hOut = call ptr @GetStdHandle(i32 -11)\n");
        final_out.push_str("  %dwMode = alloca i32\n");
        final_out.push_str("  %mode_res = call i32 @GetConsoleMode(ptr %hOut, ptr %dwMode)\n");
        final_out.push_str("  %current_mode = load i32, ptr %dwMode\n");
        final_out.push_str("  %new_mode = or i32 %current_mode, 4\n");
        final_out.push_str("  %set_res = call i32 @SetConsoleMode(ptr %hOut, i32 %new_mode)\n\n");
        
        final_out.push_str("  %hIn = call ptr @GetStdHandle(i32 -10)\n");
        final_out.push_str("  %dwModeIn = alloca i32\n");
        final_out.push_str("  %mode_res_in = call i32 @GetConsoleMode(ptr %hIn, ptr %dwModeIn)\n");
        final_out.push_str("  %current_mode_in = load i32, ptr %dwModeIn\n");
        final_out.push_str("  %and_mode_in = and i32 %current_mode_in, -71\n");
        final_out.push_str("  %new_mode_in = or i32 %and_mode_in, 528\n");
        final_out.push_str("  %set_res_in = call i32 @SetConsoleMode(ptr %hIn, i32 %new_mode_in)\n");
        final_out.push_str(&self.output);
        
        if self.is_test_mode {
            final_out.push_str("  %lulus = alloca i32\n");
            final_out.push_str("  store i32 0, ptr %lulus\n");
            final_out.push_str("  %gagal = alloca i32\n");
            final_out.push_str("  store i32 0, ptr %gagal\n");
            
            final_out.push_str("  %t1 = call i32 (ptr, ...) @printf(ptr @.fmt.test.header)\n");
            final_out.push_str("  %t2 = call i32 (ptr, ...) @printf(ptr @.fmt.test.start)\n");
            
            for (idx, func_name) in self.test_functions.iter().enumerate() {
                let label_name = format!("@.str.test.{}", func_name);
                let (ret, _) = self.function_map.get(func_name).cloned().unwrap_or(("void".to_string(), vec![]));
                
                let test_name_len = func_name.len() + 1;
                final_out.push_str(&format!("  %ptr_name_{} = getelementptr [{} x i8], ptr {}, i64 0, i64 0\n", idx, test_name_len, label_name));
                final_out.push_str(&format!("  %t_run_{} = call i32 (ptr, ...) @printf(ptr @.fmt.test.running, ptr %ptr_name_{})\n", idx, idx));
                
                if ret == "i1" {
                    final_out.push_str(&format!("  %res_{} = call i1 @{}()\n", idx, func_name));
                    final_out.push_str(&format!("  br i1 %res_{}, label %test_ok_{}, label %test_fail_{}\n", idx, idx, idx));
                    
                    final_out.push_str(&format!("\ntest_ok_{}:\n", idx));
                    final_out.push_str(&format!("  %t_ok_p_{} = call i32 (ptr, ...) @printf(ptr @.fmt.test.ok)\n", idx));
                    final_out.push_str(&format!("  %l_val_{} = load i32, ptr %lulus\n", idx));
                    final_out.push_str(&format!("  %l_new_{} = add i32 %l_val_{}, 1\n", idx, idx));
                    final_out.push_str(&format!("  store i32 %l_new_{}, ptr %lulus\n", idx));
                    final_out.push_str(&format!("  br label %test_next_{}\n", idx));
                    
                    final_out.push_str(&format!("\ntest_fail_{}:\n", idx));
                    final_out.push_str(&format!("  %t_fail_p_{} = call i32 (ptr, ...) @printf(ptr @.fmt.test.gagal)\n", idx));
                    final_out.push_str(&format!("  %g_val_{} = load i32, ptr %gagal\n", idx));
                    final_out.push_str(&format!("  %g_new_{} = add i32 %g_val_{}, 1\n", idx, idx));
                    final_out.push_str(&format!("  store i32 %g_new_{}, ptr %gagal\n", idx));
                    final_out.push_str(&format!("  br label %test_next_{}\n", idx));
                    
                    final_out.push_str(&format!("\ntest_next_{}:\n", idx));
                } else {
                    if ret == "void" {
                        final_out.push_str(&format!("  call void @{}()\n", func_name));
                    } else {
                        final_out.push_str(&format!("  %unused_res_{} = call {} @{}()\n", idx, ret, func_name));
                    }
                    final_out.push_str(&format!("  %t_ok_p_{} = call i32 (ptr, ...) @printf(ptr @.fmt.test.ok)\n", idx));
                    final_out.push_str(&format!("  %l_val_{} = load i32, ptr %lulus\n", idx));
                    final_out.push_str(&format!("  %l_new_{} = add i32 %l_val_{}, 1\n", idx, idx));
                    final_out.push_str(&format!("  store i32 %l_new_{}, ptr %lulus\n", idx));
                }
            }
            
            final_out.push_str("  %l_total = load i32, ptr %lulus\n");
            final_out.push_str("  %g_total = load i32, ptr %gagal\n");
            final_out.push_str(&format!("  %t_sum = call i32 (ptr, ...) @printf(ptr @.fmt.test.summary, i32 %l_total, i32 %g_total, i32 {})\n", self.test_functions.len()));
            final_out.push_str("  %t_foot = call i32 (ptr, ...) @printf(ptr @.fmt.test.header)\n");
            
            final_out.push_str("  %has_failures = icmp ne i32 %g_total, 0\n");
            final_out.push_str("  %exit_code = select i1 %has_failures, i32 1, i32 0\n");
            final_out.push_str("  ret i32 %exit_code\n");
        } else {
            // Cek tipe kembalian fungsi utama()
            let utama_ret_type = self.function_map.get("utama")
                .map(|(ret, _)| ret.clone())
                .unwrap_or_else(|| "void".to_string());
            
            if utama_ret_type == "void" {
                final_out.push_str("  call void @utama()\n");
                final_out.push_str("  ret i32 0\n");
            } else {
                final_out.push_str(&format!("  %utama_res = call {} @utama()\n", utama_ret_type));
                if utama_ret_type == "i64" {
                    final_out.push_str("  %main_res = trunc i64 %utama_res to i32\n");
                    final_out.push_str("  ret i32 %main_res\n");
                } else {
                    final_out.push_str("  ret i32 0\n");
                }
            }
        }
        final_out.push_str("}\n\n");
        
        self.output = final_out;
    }
    
    fn get_lvalue_ptr(&mut self, node: &dyn Node) -> (String, String, String) {
        let any = node.as_any();
        
        if let Some(id) = any.downcast_ref::<Identitas>() {
            let ptr = self.var_map.get(&id.nilai).cloned().unwrap_or_else(|| "".to_string());
            let llvm_t = self.var_type_map.get(&id.nilai).cloned().unwrap_or("i64".to_string());
            let bahasa_t = self.var_bahasa_type_map.get(&id.nilai).cloned().unwrap_or("bilangan".to_string());
            return (ptr, llvm_t, bahasa_t);
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiIndeks>() {
            let (base_ptr, base_llvm_type, base_bahasa_type) = self.get_lvalue_ptr(e.kiri.as_ref());
            let (idx_val, _) = self.generate_node(e.indeks.as_ref());
            
            if base_bahasa_type.starts_with("vektor<") {
                // Vector indexing - load actual pointer from base_ptr first
                let real_base = self.new_temp();
                self.output.push_str(&format!("  {} = load ptr, ptr {}\n", real_base, base_ptr));
                
                let data_ptr_addr = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 0\n", data_ptr_addr, real_base));
                let data_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = load ptr, ptr {}\n", data_ptr, data_ptr_addr));
                
                let inner_bahasa = &base_bahasa_type[7..base_bahasa_type.len()-1];
                let inner_llvm = self.llvm_tipe(inner_bahasa);
                
                let elem_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr {}, ptr {}, i64 {}\n", elem_ptr, inner_llvm, data_ptr, idx_val));
                
                return (elem_ptr, inner_llvm, inner_bahasa.to_string());
            } else {
                // Static array indexing
                let mut real_base = base_ptr.clone();
                let mut real_llvm_type = base_llvm_type.clone();
                if base_bahasa_type.starts_with('&') {
                    real_base = self.new_temp();
                    self.output.push_str(&format!("  {} = load ptr, ptr {}\n", real_base, base_ptr));
                    let clean_bahasa = if base_bahasa_type.starts_with("&ubah ") {
                        &base_bahasa_type[6..]
                    } else {
                        &base_bahasa_type[1..]
                    };
                    real_llvm_type = self.llvm_tipe(clean_bahasa);
                }
                
                let inner_llvm = if let Some(pos) = real_llvm_type.find(" x ") {
                    real_llvm_type[pos + 3..real_llvm_type.len() - 1].to_string()
                } else {
                    "i64".to_string()
                };
                
                let inner_bahasa = if base_bahasa_type.starts_with('[') && base_bahasa_type.ends_with(']') {
                    let parts: Vec<&str> = base_bahasa_type[1..base_bahasa_type.len()-1].split(';').collect();
                    parts[0].trim().to_string()
                } else if base_bahasa_type.contains('[') && base_bahasa_type.ends_with(']') {
                    let start = base_bahasa_type.find('[').unwrap();
                    let parts: Vec<&str> = base_bahasa_type[start+1..base_bahasa_type.len()-1].split(';').collect();
                    parts[0].trim().to_string()
                } else {
                    "bilangan".to_string()
                };
                
                let elem_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr {}, ptr {}, i32 0, i64 {}\n", elem_ptr, real_llvm_type, real_base, idx_val));
                return (elem_ptr, inner_llvm, inner_bahasa);
            }
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiAksesProperti>() {
            let (base_ptr, base_llvm_type, base_bahasa_type) = self.get_lvalue_ptr(e.kiri.as_ref());
            
            let mut struct_name = base_bahasa_type.clone();
            if struct_name.starts_with('&') {
                if struct_name.starts_with("&ubah ") {
                    struct_name = struct_name[6..].to_string();
                } else {
                    struct_name = struct_name[1..].to_string();
                }
            } else if struct_name.starts_with("kotak<") && struct_name.ends_with('>') {
                struct_name = struct_name[6..struct_name.len()-1].to_string();
            }
            
            if let Some(props) = self.struct_types.get(&struct_name).cloned() {
                let prop_nama = e.properti.nilai_string();
                let mut index = 0;
                let mut p_type = "".to_string();
                let mut p_bahasa = "".to_string();
                for (i, (n, t)) in props.iter().enumerate() {
                    if n == &prop_nama {
                        index = i;
                        p_type = self.llvm_tipe(t).to_string();
                        p_bahasa = t.clone();
                        break;
                    }
                }
                
                let mut real_base = base_ptr.clone();
                if base_bahasa_type.starts_with('&') || base_bahasa_type.starts_with("kotak<") {
                    real_base = self.new_temp();
                    self.output.push_str(&format!("  {} = load ptr, ptr {}\n", real_base, base_ptr));
                }
                
                let field_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr %{}, ptr {}, i32 0, i32 {}\n", field_ptr, struct_name, real_base, index));
                return (field_ptr, p_type, p_bahasa);
            }
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiDeref>() {
            let (ptr_val, _) = self.generate_node(e.nilai.as_ref());
            let inner_bahasa = if let Some(id) = e.nilai.as_any().downcast_ref::<Identitas>() {
                if let Some(bty) = self.var_bahasa_type_map.get(&id.nilai).cloned() {
                    if bty.starts_with('&') {
                        if bty.starts_with("&ubah ") {
                            bty[6..].to_string()
                        } else {
                            bty[1..].to_string()
                        }
                    } else if bty.starts_with("kotak<") && bty.ends_with('>') {
                        bty[6..bty.len()-1].to_string()
                    } else {
                        "bilangan".to_string()
                    }
                } else {
                    "bilangan".to_string()
                }
            } else {
                "bilangan".to_string()
            };
            let inner_llvm = self.llvm_tipe(&inner_bahasa);
            return (ptr_val, inner_llvm, inner_bahasa);
        }
        
        ("".to_string(), "".to_string(), "".to_string())
    }

    // Returns (Value, LLVM Type)
    pub fn generate_node(&mut self, node: &dyn Node) -> (String, String) {
        let any = node.as_any();

        if let Some(p) = any.downcast_ref::<Program>() {
            for stmt in &p.pernyataan_pernyataan {
                self.generate_node(stmt.as_ref());
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanBlok>() {
            for stmt in &p.pernyataan_pernyataan {
                self.generate_node(stmt.as_ref());
            }
            return ("".to_string(), "".to_string());
        }
        
        if let Some(p) = any.downcast_ref::<PernyataanDeklarasi>() {
            let (val, val_type) = self.generate_node(p.nilai.as_ref());
            let llvm_t = if p.tipe_data == "bebas" { self.llvm_tipe(&val_type) } else { self.llvm_tipe(&p.tipe_data) };
            let ptr_name = format!("%{}_{}", p.nama.nilai, self.temporary_id_counter);
            self.temporary_id_counter += 1;
            self.output.push_str(&format!("  {} = alloca {}\n", ptr_name, llvm_t));
            self.output.push_str(&format!("  store {} {}, ptr {}\n", llvm_t, val, ptr_name));
            self.var_map.insert(p.nama.nilai.clone(), ptr_name);
            self.var_type_map.insert(p.nama.nilai.clone(), llvm_t);
            self.var_bahasa_type_map.insert(p.nama.nilai.clone(), if p.tipe_data == "bebas" { val_type } else { p.tipe_data.clone() });
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanPenugasan>() {
            let (val, _val_type) = self.generate_node(p.nilai.as_ref());
            let (lval_ptr, lval_llvm_type, _) = self.get_lvalue_ptr(p.nama.as_ref());
            
            if !lval_ptr.is_empty() {
                if p.operator == "=" {
                    self.output.push_str(&format!("  store {} {}, ptr {}\n", lval_llvm_type, val, lval_ptr));
                } else {
                    // Compound assignment like +=, -=, etc.
                    let current_val = self.new_temp();
                    self.output.push_str(&format!("  {} = load {}, ptr {}\n", current_val, lval_llvm_type, lval_ptr));
                    
                    let op = &p.operator[..p.operator.len()-1];
                    let op_res = self.new_temp();
                    if lval_llvm_type == "double" {
                        match op {
                            "+" => self.output.push_str(&format!("  {} = fadd double {}, {}\n", op_res, current_val, val)),
                            "-" => self.output.push_str(&format!("  {} = fsub double {}, {}\n", op_res, current_val, val)),
                            "*" => self.output.push_str(&format!("  {} = fmul double {}, {}\n", op_res, current_val, val)),
                            "/" => self.output.push_str(&format!("  {} = fdiv double {}, {}\n", op_res, current_val, val)),
                            _ => {}
                        }
                    } else {
                        match op {
                            "+" => self.output.push_str(&format!("  {} = add i64 {}, {}\n", op_res, current_val, val)),
                            "-" => self.output.push_str(&format!("  {} = sub i64 {}, {}\n", op_res, current_val, val)),
                            "*" => self.output.push_str(&format!("  {} = mul i64 {}, {}\n", op_res, current_val, val)),
                            "/" => self.output.push_str(&format!("  {} = sdiv i64 {}, {}\n", op_res, current_val, val)),
                            "%" => self.output.push_str(&format!("  {} = srem i64 {}, {}\n", op_res, current_val, val)),
                            "<<" => self.output.push_str(&format!("  {} = shl i64 {}, {}\n", op_res, current_val, val)),
                            ">>" => self.output.push_str(&format!("  {} = ashr i64 {}, {}\n", op_res, current_val, val)),
                            _ => {}
                        }
                    }
                    self.output.push_str(&format!("  store {} {}, ptr {}\n", lval_llvm_type, op_res, lval_ptr));
                }
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanJika>() {
            let (kond_val, _) = self.generate_node(p.kondisi.as_ref());
            let lbl_true = self.new_block();
            let lbl_false = self.new_block();
            let lbl_akhir = self.new_block();

            self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", kond_val, lbl_true, lbl_false));
            
            self.output.push_str(&format!("\n{}:\n", lbl_true));
            self.generate_node(&p.konsekuensi);
            if !Self::has_terminator(&self.output) {
                self.output.push_str(&format!("  br label %{}\n", lbl_akhir));
            }
            
            self.output.push_str(&format!("\n{}:\n", lbl_false));
            if let Some(alt) = &p.alternatif {
                self.generate_node(alt.as_ref());
            }
            if !Self::has_terminator(&self.output) {
                self.output.push_str(&format!("  br label %{}\n", lbl_akhir));
            }
            
            self.output.push_str(&format!("\n{}:\n", lbl_akhir));
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanStruktur>() {
            let mut prop_types = Vec::new();
            let mut llvm_types = Vec::new();
            for (nama, tipe) in &p.properti {
                prop_types.push((nama.nilai.clone(), tipe.clone()));
                llvm_types.push(self.llvm_tipe(tipe).to_string());
            }
            
            self.struct_types.insert(p.nama.nilai.clone(), prop_types);
            
            // Generate global LLVM struct type
            let struct_def = format!("%{} = type {{ {} }}\n", p.nama.nilai, llvm_types.join(", "));
            self.struct_header_output.push_str(&struct_def);
            
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanEnum>() {
            let mut varian = Vec::new();
            for v in &p.varian {
                varian.push((v.nama.nilai.clone(), v.tipe_data.clone()));
            }
            self.enum_map.insert(p.nama.nilai.clone(), varian);
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanImplementasi>() {
            for stmt in &p.metode {
                if let Some(f) = stmt.as_any().downcast_ref::<PernyataanFungsi>() {
                    let mut f_clone = f.clone();
                    f_clone.nama.nilai = format!("{}::{}", p.nama.nilai, f.nama.nilai);
                    for param in &mut f_clone.parameter {
                        if param.tipe_data == "Diri" {
                            param.tipe_data = p.nama.nilai.clone();
                        }
                    }
                    if f_clone.tipe_kembalian == "Diri" {
                        f_clone.tipe_kembalian = p.nama.nilai.clone();
                    }
                    self.generate_node(&f_clone);
                }
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanSelama>() {
            let lbl_kondisi = self.new_block();
            let lbl_tubuh = self.new_block();
            let lbl_akhir = self.new_block();

            self.output.push_str(&format!("  br label %{}\n", lbl_kondisi));
            
            self.output.push_str(&format!("\n{}:\n", lbl_kondisi));
            let (kond_val, _) = self.generate_node(p.kondisi.as_ref());
            self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", kond_val, lbl_tubuh, lbl_akhir));
            
            self.output.push_str(&format!("\n{}:\n", lbl_tubuh));
            self.loop_stack.push((lbl_kondisi.clone(), lbl_akhir.clone()));
            self.generate_node(&p.blok);
            self.loop_stack.pop();
            
            if !Self::has_terminator(&self.output) {
                self.output.push_str(&format!("  br label %{}\n", lbl_kondisi));
            }
            
            self.output.push_str(&format!("\n{}:\n", lbl_akhir));
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanPutar>() {
            let lbl_tubuh = self.new_block();
            let lbl_akhir = self.new_block();

            self.output.push_str(&format!("  br label %{}\n", lbl_tubuh));
            self.output.push_str(&format!("\n{}:\n", lbl_tubuh));
            
            self.loop_stack.push((lbl_tubuh.clone(), lbl_akhir.clone()));
            self.generate_node(&p.blok);
            self.loop_stack.pop();
            
            if !Self::has_terminator(&self.output) {
                self.output.push_str(&format!("  br label %{}\n", lbl_tubuh));
            }
            self.output.push_str(&format!("\n{}:\n", lbl_akhir));
            return ("".to_string(), "".to_string());
        }
        
        if let Some(p) = any.downcast_ref::<PernyataanUntukDalam>() {
            // Evaluasi iterable (saat ini hanya mendukung rentang 'a..b')
            if let Some(infix) = p.iterable.as_any().downcast_ref::<EkspresiInfix>() {
                if infix.operator == ".." {
                    let (start_val, _start_type) = self.generate_node(infix.kiri.as_ref());
                    let (end_val, _end_type) = self.generate_node(infix.kanan.as_ref());
                    
                    let var_ptr = format!("%{}_{}", p.variabel.nilai, self.temporary_id_counter);
                    self.temporary_id_counter += 1;
                    
                    self.output.push_str(&format!("  {} = alloca i64\n", var_ptr));
                    self.output.push_str(&format!("  store i64 {}, ptr {}\n", start_val, var_ptr));
                    
                    self.var_map.insert(p.variabel.nilai.clone(), var_ptr.clone());
                    self.var_type_map.insert(p.variabel.nilai.clone(), "i64".to_string());
                    self.var_bahasa_type_map.insert(p.variabel.nilai.clone(), "bilangan".to_string());
                    
                    let lbl_kondisi = self.new_block();
                    let lbl_tubuh = self.new_block();
                    let lbl_akhir = self.new_block();
                    
                    self.output.push_str(&format!("  br label %{}\n", lbl_kondisi));
                    
                    self.output.push_str(&format!("\n{}:\n", lbl_kondisi));
                    let cur_val_ptr = format!("%tmp_{}", self.temporary_id_counter);
                    self.temporary_id_counter += 1;
                    self.output.push_str(&format!("  {} = load i64, ptr {}\n", cur_val_ptr, var_ptr));
                    
                    let kond_val = format!("%tmp_{}", self.temporary_id_counter);
                    self.temporary_id_counter += 1;
                    self.output.push_str(&format!("  {} = icmp slt i64 {}, {}\n", kond_val, cur_val_ptr, end_val));
                    self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", kond_val, lbl_tubuh, lbl_akhir));
                    
                    self.output.push_str(&format!("\n{}:\n", lbl_tubuh));
                    let lbl_update = self.new_block();
                    
                    self.loop_stack.push((lbl_update.clone(), lbl_akhir.clone()));
                    self.generate_node(&p.blok);
                    self.loop_stack.pop();
                    
                    if !Self::has_terminator(&self.output) {
                        self.output.push_str(&format!("  br label %{}\n", lbl_update));
                    }
                    
                    self.output.push_str(&format!("\n{}:\n", lbl_update));
                    let load_for_inc = format!("%tmp_{}", self.temporary_id_counter);
                    self.temporary_id_counter += 1;
                    self.output.push_str(&format!("  {} = load i64, ptr {}\n", load_for_inc, var_ptr));
                    
                    let inc_val = format!("%tmp_{}", self.temporary_id_counter);
                    self.temporary_id_counter += 1;
                    self.output.push_str(&format!("  {} = add i64 {}, 1\n", inc_val, load_for_inc));
                    self.output.push_str(&format!("  store i64 {}, ptr {}\n", inc_val, var_ptr));
                    self.output.push_str(&format!("  br label %{}\n", lbl_kondisi));
                    
                    self.output.push_str(&format!("\n{}:\n", lbl_akhir));
                } else {
                    // Fallback
                    self.generate_node(p.iterable.as_ref());
                }
            } else {
                self.generate_node(p.iterable.as_ref());
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(_) = any.downcast_ref::<PernyataanHenti>() {
            if let Some((_, break_lbl)) = self.loop_stack.last() {
                self.output.push_str(&format!("  br label %{}\n", break_lbl));
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(_) = any.downcast_ref::<PernyataanLanjut>() {
            if let Some((cont_lbl, _)) = self.loop_stack.last() {
                self.output.push_str(&format!("  br label %{}\n", cont_lbl));
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanAman>() {
            let old_aman = self.dalam_blok_aman;
            self.dalam_blok_aman = true;
            self.generate_node(&p.blok);
            self.dalam_blok_aman = old_aman;
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanPantauMemori>() {
            let var_nama = p.nama.nilai.clone();
            let ptr_val = self.var_map.get(&var_nama).cloned().unwrap_or("".to_string());
            let llvm_t = self.var_type_map.get(&var_nama).cloned().unwrap_or("i64".to_string());
            let bahasa_t = self.var_bahasa_type_map.get(&var_nama).cloned().unwrap_or("bilangan".to_string());
            
            if !ptr_val.is_empty() {
                let var_name_literal_label = format!("@.str.pantau.{}", var_nama);
                if !self.string_literals.iter().any(|(name, _)| name == &var_name_literal_label) {
                    let literal_val = format!("[{} x i8] c\"{}\\00\"", var_nama.len() + 1, var_nama);
                    self.string_literals.push((var_name_literal_label.clone(), literal_val));
                }
                
                let type_name_literal_label = format!("@.str.pantau.type.{}", var_nama);
                let display_type = format!("{} ({})", bahasa_t, llvm_t);
                if !self.string_literals.iter().any(|(name, _)| name == &type_name_literal_label) {
                    let literal_val = format!("[{} x i8] c\"{}\\00\"", display_type.len() + 1, display_type);
                    self.string_literals.push((type_name_literal_label.clone(), literal_val));
                }
                
                let size_bytes: i64 = match llvm_t.as_str() {
                    "i1" => 1,
                    "i8" => 1,
                    "i32" => 4,
                    "i64" => 8,
                    "double" => 8,
                    _ => 8,
                };
                
                let temp_print1 = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.pantau.header)\n", temp_print1));
                
                let name_len = var_nama.len() + 1;
                let temp_gep1 = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr [{} x i8], ptr {}, i64 0, i64 0\n", temp_gep1, name_len, var_name_literal_label));
                
                let temp_print2 = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.pantau.title, ptr {})\n", temp_print2, temp_gep1));
                
                let temp_print3 = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.pantau.addr, ptr {})\n", temp_print3, ptr_val));
                
                let type_len = display_type.len() + 1;
                let temp_gep2 = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr [{} x i8], ptr {}, i64 0, i64 0\n", temp_gep2, type_len, type_name_literal_label));
                
                let temp_print4 = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.pantau.type, ptr {})\n", temp_print4, temp_gep2));
                
                let temp_print5 = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.pantau.size, i64 {})\n", temp_print5, size_bytes));
                
                let temp_print6 = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.pantau.header)\n", temp_print6));
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanModul>() {
            self.current_module_path.push(p.nama.clone());
            if let Some(b) = &p.blok {
                self.generate_node(b);
            }
            self.current_module_path.pop();
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanGunakan>() {
            if p.semua {
                let mod_name = p.jalur.first().unwrap();
                if mod_name == "Sistem" {
                    self.import_map.insert("cetak_teks".to_string(), "Sistem_cetak_teks".to_string());
                    self.import_map.insert("cetak_desimal".to_string(), "Sistem_cetak_desimal".to_string());
                    self.import_map.insert("cetak_bilangan".to_string(), "Sistem_cetak_bilangan".to_string());
                    self.import_map.insert("baca_desimal".to_string(), "Sistem_baca_desimal".to_string());
                    self.import_map.insert("baca_bilangan".to_string(), "Sistem_baca_bilangan".to_string());
                    self.import_map.insert("baca_tombol".to_string(), "Sistem_baca_tombol".to_string());
                    self.import_map.insert("bunyi_bip".to_string(), "Sistem_bunyi_bip".to_string());
                } else if mod_name == "Berkas" {
                    self.import_map.insert("buka_file".to_string(), "Berkas_buka_file".to_string());
                    self.import_map.insert("tulis_teks".to_string(), "Berkas_tulis_teks".to_string());
                    self.import_map.insert("tulis_desimal".to_string(), "Berkas_tulis_desimal".to_string());
                    self.import_map.insert("tutup_file".to_string(), "Berkas_tutup_file".to_string());
                } else if mod_name == "Waktu" {
                    self.import_map.insert("waktu_sekarang".to_string(), "Waktu_waktu_sekarang".to_string());
                } else if mod_name == "Matematika" {
                    self.import_map.insert("akar".to_string(), "Matematika_akar".to_string());
                    self.import_map.insert("pangkat".to_string(), "Matematika_pangkat".to_string());
                    self.import_map.insert("sin".to_string(), "Matematika_sin".to_string());
                    self.import_map.insert("cos".to_string(), "Matematika_cos".to_string());
                    self.import_map.insert("tan".to_string(), "Matematika_tan".to_string());
                    self.import_map.insert("logaritma".to_string(), "Matematika_logaritma".to_string());
                } else {
                    let prefix = format!("{}_", p.jalur.join("_"));
                    let mut to_import = Vec::new();
                    for fname in self.function_map.keys() {
                        if fname.starts_with(&prefix) {
                            let short_name = fname.strip_prefix(&prefix).unwrap().to_string();
                            to_import.push((short_name, fname.clone()));
                        }
                    }
                    for (short, full) in to_import {
                        self.import_map.insert(short, full);
                    }
                }
            } else {
                let target_name = p.jalur.last().unwrap().clone();
                let full_name = p.jalur.join("_");
                self.import_map.insert(target_name, full_name);
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanEkspresi>() {
            return self.generate_node(p.ekspresi.as_ref());
        }

        if let Some(p) = any.downcast_ref::<PernyataanAliasTipe>() {
            self.alias_tipe.insert(p.nama.nilai.clone(), p.tipe_asli.clone());
            return ("".to_string(), "".to_string());
        }

        if let Some(e) = any.downcast_ref::<EkspresiBlok>() {
            let mut last_val = "".to_string();
            let mut last_type = "kosong".to_string();
            for stmt in &e.blok.pernyataan_pernyataan {
                let (val, ty) = self.generate_node(stmt.as_ref());
                last_val = val;
                last_type = ty;
            }
            if let Some(last) = e.blok.pernyataan_pernyataan.last() {
                if last.as_any().is::<PernyataanEkspresi>() {
                    return (last_val, last_type);
                }
            }
            return ("".to_string(), "kosong".to_string());
        }

        if let Some(e) = any.downcast_ref::<EkspresiKonversi>() {
            let (val, val_type) = self.generate_node(e.ekspresi.as_ref());
            let target_type = self.llvm_tipe(&e.tipe_tujuan);
            
            // Generate cast instruction if needed
            if val_type == "i64" && target_type == "double" {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", temp, val));
                return (temp, "double".to_string());
            } else if val_type == "double" && target_type == "i64" {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = fptosi double {} to i64\n", temp, val));
                return (temp, "i64".to_string());
            } else if val_type == "i1" && target_type == "i64" {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = zext i1 {} to i64\n", temp, val));
                return (temp, "i64".to_string());
            }
            // If types are the same or no primitive cast is supported directly, just return the value
            return (val, target_type);
        }

        if let Some(p) = any.downcast_ref::<PernyataanFungsi>() {
            let mut prefix = "".to_string();
            if !self.current_module_path.is_empty() {
                prefix = format!("{}_", self.current_module_path.join("_"));
            }
            
            let func_name = format!("{}{}", prefix, p.nama.nilai).replace("::", "_");
            
            let mut arg_types = Vec::new();
            let mut arg_names = Vec::new();
            
            for param in &p.parameter {
                arg_types.push(self.llvm_tipe(&param.tipe_data).to_string());
                arg_names.push(param.nama.nilai.clone());
            }
            
            let ret_type = if p.tipe_kembalian == "kosong" {
                "void".to_string()
            } else {
                self.llvm_tipe(&p.tipe_kembalian).to_string()
            };
            
            self.function_map.insert(func_name.clone(), (ret_type.clone(), arg_types.clone()));
            if p.is_async {
                self.async_function_map.insert(func_name.clone(), ret_type.clone());
            }
            if p.is_uji {
                self.test_functions.push(func_name.clone());
                let label_name = format!("@.str.test.{}", func_name);
                let val_str = format!("[{} x i8] c\"{}\\00\"", func_name.len() + 1, func_name);
                self.string_literals.push((label_name, val_str));
            }
            if p.is_asing {
                let mut arg_types_only = String::new();
                for i in 0..arg_types.len() {
                    arg_types_only.push_str(&arg_types[i]);
                    if i < arg_types.len() - 1 {
                        arg_types_only.push_str(", ");
                    }
                }
                self.functions_output.push_str(&format!("declare {} @{}({})\n\n", ret_type, func_name, arg_types_only));
                return ("".to_string(), "".to_string());
            }
            
            let mut arg_str = String::new();
            for i in 0..arg_types.len() {
                arg_str.push_str(&format!("{} %arg_{}", arg_types[i], arg_names[i]));
                if i < arg_types.len() - 1 {
                    arg_str.push_str(", ");
                }
            }
            
            let old_output = self.output.clone();
            self.output = String::new();
            
            let old_var_map = self.var_map.clone();
            let old_var_type_map = self.var_type_map.clone();
            let old_ret_type = self.current_function_return_type.clone();
            let old_temp_counter = self.temporary_id_counter;
            let old_block_counter = self.block_id_counter;
            
            self.var_map.clear();
            self.var_type_map.clear();
            self.var_bahasa_type_map.clear();
            self.current_function_return_type = ret_type.clone();
            self.temporary_id_counter = 1;
            self.block_id_counter = 1;
            
            self.output.push_str(&format!("define {} @{}({}) {{\nentry:\n", ret_type, func_name, arg_str));
            
            for i in 0..arg_types.len() {
                let ptr = format!("%{}", arg_names[i]);
                self.output.push_str(&format!("  {} = alloca {}\n", ptr, arg_types[i]));
                self.output.push_str(&format!("  store {} %arg_{}, ptr {}\n", arg_types[i], arg_names[i], ptr));
                self.var_map.insert(arg_names[i].clone(), ptr);
                self.var_type_map.insert(arg_names[i].clone(), arg_types[i].clone());
                self.var_bahasa_type_map.insert(arg_names[i].clone(), p.parameter[i].tipe_data.clone());
            }
            
            self.generate_node(&p.tubuh);
            
            if !Self::has_terminator(&self.output) {
                if ret_type == "void" {
                    self.output.push_str("  ret void\n");
                } else if ret_type == "i64" {
                    self.output.push_str("  ret i64 0\n");
                } else if ret_type == "double" {
                    self.output.push_str("  ret double 0.0\n");
                } else {
                    self.output.push_str("  ret void\n");
                }
            }
            
            self.output.push_str("}\n\n");
            self.functions_output.push_str(&self.output);
            
            if p.is_async {
                let mut wrapper_body = String::new();
                wrapper_body.push_str(&format!("define i32 @{}_async_wrapper(ptr %arg_struct_ptr) {{\nentry:\n", func_name));
                
                let mut call_args = Vec::new();
                for i in 0..arg_types.len() {
                    let arg_ptr = format!("%arg_{}", i);
                    let arg_val = format!("%val_{}", i);
                    let mut struct_layout = format!("{{ {}", ret_type);
                    for arg_t in &arg_types {
                        struct_layout.push_str(&format!(", {}", arg_t));
                     }
                     struct_layout.push_str(" }");
                     
                     wrapper_body.push_str(&format!("  {} = getelementptr {}, ptr %arg_struct_ptr, i32 0, i32 {}\n", arg_ptr, struct_layout, i + 1));
                     wrapper_body.push_str(&format!("  {} = load {}, ptr {}\n", arg_val, arg_types[i], arg_ptr));
                     call_args.push(format!("{} {}", arg_types[i], arg_val));
                }
                
                if ret_type == "void" {
                    wrapper_body.push_str(&format!("  call void @{}({})\n", func_name, call_args.join(", ")));
                } else {
                    let res_temp = "%res_temp";
                    wrapper_body.push_str(&format!("  {} = call {} @{}({})\n", res_temp, ret_type, func_name, call_args.join(", ")));
                    
                    let mut struct_layout = format!("{{ {}", ret_type);
                    for arg_t in &arg_types {
                        struct_layout.push_str(&format!(", {}", arg_t));
                    }
                    struct_layout.push_str(" }");
                    
                    let ret_ptr = "%ret_ptr";
                    wrapper_body.push_str(&format!("  {} = getelementptr {}, ptr %arg_struct_ptr, i32 0, i32 0\n", ret_ptr, struct_layout));
                    wrapper_body.push_str(&format!("  store {} {}, ptr {}\n", ret_type, res_temp, ret_ptr));
                }
                
                wrapper_body.push_str("  ret i32 0\n}\n\n");
                self.functions_output.push_str(&wrapper_body);
            }
            
            self.output = old_output;
            self.var_map = old_var_map;
            self.var_type_map = old_var_type_map;
            self.current_function_return_type = old_ret_type;
            self.temporary_id_counter = old_temp_counter;
            self.block_id_counter = old_block_counter;
            
            return ("".to_string(), "".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanImplementasiSifat>() {
            for f in &p.metode {
                let mut f_copy = f.clone();
                f_copy.nama.nilai = format!("{}_{}", p.nama_target.nilai, f.nama.nilai);
                let has_diri = f_copy.parameter.get(0).map_or(false, |param| param.nama.nilai == "diri");
                if !has_diri {
                    f_copy.parameter.insert(0, Parameter {
                        nama: Identitas { token: f_copy.token.clone(), nilai: "diri".to_string() },
                        tipe_data: p.nama_target.nilai.clone(),
                    });
                }
                self.generate_node(&f_copy);
            }
            return ("".to_string(), "kosong".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanImplementasi>() {
            for f in &p.metode {
                if let Some(pf) = f.as_any().downcast_ref::<PernyataanFungsi>() {
                    let mut f_copy = pf.clone();
                    f_copy.nama.nilai = format!("{}_{}", p.nama.nilai, pf.nama.nilai);
                    let has_diri = f_copy.parameter.get(0).map_or(false, |param| param.nama.nilai == "diri");
                    if !has_diri {
                        f_copy.parameter.insert(0, Parameter {
                            nama: Identitas { token: f_copy.token.clone(), nilai: "diri".to_string() },
                            tipe_data: p.nama.nilai.clone(),
                        });
                    }
                    self.generate_node(&f_copy);
                } else {
                    self.generate_node(f.as_ref());
                }
            }
            return ("".to_string(), "kosong".to_string());
        }

        if let Some(p) = any.downcast_ref::<PernyataanKembalikan>() {
            let (val, val_type) = self.generate_node(p.nilai.as_ref());
            let current_ret = self.current_function_return_type.clone();
            
            if current_ret == "void" || val_type == "kosong" {
                self.output.push_str("  ret void\n");
            } else if current_ret == "i32" && val_type == "i64" {
                let temp_i32 = self.new_temp();
                self.output.push_str(&format!("  {} = trunc i64 {} to i32\n", temp_i32, val));
                self.output.push_str(&format!("  ret i32 {}\n", temp_i32));
            } else if current_ret == "i32" && val_type == "i1" {
                let temp_i32 = self.new_temp();
                self.output.push_str(&format!("  {} = zext i1 {} to i32\n", temp_i32, val));
                self.output.push_str(&format!("  ret i32 {}\n", temp_i32));
            } else {
                let mut actual_val = val;
                if current_ret == "double" && val_type == "i64" {
                    let temp = self.new_temp();
                    self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", temp, actual_val));
                    actual_val = temp;
                }
                self.output.push_str(&format!("  ret {} {}\n", current_ret, actual_val));
            }
            return ("".to_string(), "".to_string());
        }

        if let Some(_) = any.downcast_ref::<EkspresiKosong>() {
            return ("".to_string(), "kosong".to_string());
        }

        if let Some(e) = any.downcast_ref::<LiteralBilangan>() {
            return (e.nilai.to_string(), "i64".to_string());
        }

        if let Some(e) = any.downcast_ref::<LiteralDesimal>() {
            let mut s = format!("{}", e.nilai);
            if !s.contains('.') && !s.contains('e') && !s.contains('E') {
                s.push_str(".0");
            }
            return (s, "double".to_string());
        }

        if let Some(e) = any.downcast_ref::<LiteralKarakter>() {
            return ((e.nilai as u32 as u8).to_string(), "i8".to_string());
        }
        
        if let Some(e) = any.downcast_ref::<LiteralLogika>() {
            let val = if e.nilai { "1" } else { "0" };
            return (val.to_string(), "i1".to_string());
        }



        if let Some(p) = any.downcast_ref::<LiteralTeks>() {
            let string_id = self.string_literals.len();
            let mut formatted = String::new();
            for c in p.nilai.chars() {
                if c == '\n' { formatted.push_str("\\0A"); }
                else if c == '\r' { formatted.push_str("\\0D"); }
                else if c == '\t' { formatted.push_str("\\09"); }
                else if c == '\\' { formatted.push_str("\\\\"); }
                else if c == '"' { formatted.push_str("\\22"); }
                else { formatted.push(c); }
            }
            formatted.push_str("\\00");
            let byte_len = p.nilai.as_bytes().len() + 1;
            
            let global_name = format!("@.str.{}", string_id);
            self.string_literals.push((global_name.clone(), format!("[{} x i8] c\"{}\"", byte_len, formatted)));
            return (global_name, "ptr".to_string());
        }
        
        if let Some(p) = any.downcast_ref::<LiteralDaftar>() {
            let mut element_vals = Vec::new();
            let mut base_type = String::new();
            for (i, el) in p.elemen.iter().enumerate() {
                let (val, ty) = self.generate_node(el.as_ref());
                if i == 0 { base_type = ty.clone(); }
                element_vals.push(format!("{} {}", ty, val));
            }
            let array_val = format!("[{}]", element_vals.join(", "));
            let array_type = format!("[{} x {}]", p.elemen.len(), base_type);
            return (array_val, array_type);
        }

        if let Some(e) = any.downcast_ref::<EkspresiIndeks>() {
            let (lval_ptr, lval_llvm_type, _) = self.get_lvalue_ptr(e);
            if !lval_ptr.is_empty() {
                let val_temp = self.new_temp();
                self.output.push_str(&format!("  {} = load {}, ptr {}\n", val_temp, lval_llvm_type, lval_ptr));
                return (val_temp, lval_llvm_type);
            }
            return ("0".to_string(), "i64".to_string());
        }

        if let Some(p) = any.downcast_ref::<LiteralTuple>() {
            let mut element_vals = Vec::new();
            let mut element_types = Vec::new();
            for el in &p.elemen {
                let (val, ty) = self.generate_node(el.as_ref());
                element_vals.push(val);
                element_types.push(ty);
            }
            let struct_type = format!("{{ {} }}", element_types.join(", "));
            
            let mut current_struct = "undef".to_string();
            for (i, (val, ty)) in element_vals.iter().zip(element_types.iter()).enumerate() {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {} {}, {} {}, {}\n", 
                    temp, struct_type, current_struct, ty, val, i));
                current_struct = temp;
            }
            return (current_struct, struct_type);
        }

        if let Some(p) = any.downcast_ref::<EkspresiAksesProperti>() {
            let (kiri_val, kiri_type) = self.generate_node(p.kiri.as_ref());
            if let TokenType::Bilangan(n) = &p.properti.tipe {
                let idx = *n;
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = extractvalue {} {}, {}\n", temp, kiri_type, kiri_val, idx));
                
                let inner = &kiri_type[2..kiri_type.len()-2];
                let mut parts = Vec::new();
                let mut depth = 0;
                let mut current = String::new();
                for c in inner.chars() {
                    if c == '(' || c == '[' || c == '{' { depth += 1; }
                    else if c == ')' || c == ']' || c == '}' { depth -= 1; }
                    
                    if c == ',' && depth == 0 {
                        parts.push(current.trim().to_string());
                        current.clear();
                    } else {
                        current.push(c);
                    }
                }
                if !current.trim().is_empty() { parts.push(current.trim().to_string()); }
                
                let extracted_type = parts[idx as usize].clone();
                return (temp, extracted_type);
            }
        }

        if let Some(e) = any.downcast_ref::<Identitas>() {
            let ptr = self.var_map.get(&e.nilai).cloned();
            let llvm_t = self.var_type_map.get(&e.nilai).cloned().unwrap_or("i64".to_string());
            if let Some(ptr_name) = ptr {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = load {}, ptr {}\n", temp, llvm_t, ptr_name));
                return (temp, llvm_t);
            }
            return ("0".to_string(), "i64".to_string());
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiPath>() {
            if e.bagian.len() == 2 {
                if let Some(varian_list) = self.enum_map.get(&e.bagian[0]) {
                    for (idx, (nama_var, _)) in varian_list.iter().enumerate() {
                        if nama_var == &e.bagian[1] {
                            // Struct Enum literal: { i32 tag, ptr null }
                            let val = format!("{{ i32 {}, ptr null }}", idx);
                            return (val, "{ i32, ptr }".to_string());
                        }
                    }
                }
            }
            return ("0".to_string(), "i64".to_string());
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiInfix>() {
            let (left, l_type) = self.generate_node(e.kiri.as_ref());
            let (right, r_type) = self.generate_node(e.kanan.as_ref());
            
            let (left, right, op_type) = match (l_type.as_str(), r_type.as_str()) {
                ("i64", "double") => {
                    let t = self.new_temp();
                    self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", t, left));
                    (t, right, "double")
                }
                ("double", "i64") => {
                    let t = self.new_temp();
                    self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", t, right));
                    (left, t, "double")
                }
                _ => (left, right, l_type.as_str()),
            };
            
            let mut temp = if e.operator.as_str() == "/" && self.dalam_blok_aman {
                "".to_string()
            } else {
                self.new_temp()
            };
            
            let mut ret_type = op_type.to_string();
            let is_f = op_type == "double";
            
            match e.operator.as_str() {
                "+" => self.output.push_str(&format!("  {} = {} {} {}, {}\n", temp, if is_f { "fadd" } else { "add" }, op_type, left, right)),
                "-" => self.output.push_str(&format!("  {} = {} {} {}, {}\n", temp, if is_f { "fsub" } else { "sub" }, op_type, left, right)),
                "*" => self.output.push_str(&format!("  {} = {} {} {}, {}\n", temp, if is_f { "fmul" } else { "mul" }, op_type, left, right)),
                "/" => {
                    if self.dalam_blok_aman {
                        let is_zero = self.new_temp();
                        if is_f {
                            self.output.push_str(&format!("  {} = fcmp oeq double {}, 0.0\n", is_zero, right));
                        } else {
                            self.output.push_str(&format!("  {} = icmp eq i64 {}, 0\n", is_zero, right));
                        }
                        
                        let res_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = alloca {}\n", res_ptr, op_type));
                        if is_f {
                            self.output.push_str(&format!("  store double 0.0, ptr {}\n", res_ptr));
                        } else {
                            self.output.push_str(&format!("  store i64 0, ptr {}\n", res_ptr));
                        }
                        
                        let lbl_not_zero = self.new_block();
                        let lbl_zero = self.new_block();
                        let lbl_merge = self.new_block();
                        
                        self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", is_zero, lbl_zero, lbl_not_zero));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_zero));
                        let temp_print = self.new_temp();
                        self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.aman.divzero)\n", temp_print));
                        self.output.push_str(&format!("  br label %{}\n", lbl_merge));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_not_zero));
                        let temp_div = self.new_temp();
                        self.output.push_str(&format!("  {} = {} {} {}, {}\n", temp_div, if is_f { "fdiv" } else { "sdiv" }, op_type, left, right));
                        self.output.push_str(&format!("  store {} {}, ptr {}\n", op_type, temp_div, res_ptr));
                        self.output.push_str(&format!("  br label %{}\n", lbl_merge));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_merge));
                        let final_temp = self.new_temp();
                        self.output.push_str(&format!("  {} = load {}, ptr {}\n", final_temp, op_type, res_ptr));
                        temp = final_temp;
                    } else {
                        self.output.push_str(&format!("  {} = {} {} {}, {}\n", temp, if is_f { "fdiv" } else { "sdiv" }, op_type, left, right));
                    }
                }
                "==" => {
                    self.output.push_str(&format!("  {} = {} {} {} {}, {}\n", temp, if is_f { "fcmp" } else { "icmp" }, if is_f { "oeq" } else { "eq" }, op_type, left, right));
                    ret_type = "i1".to_string();
                }
                "!=" => {
                    self.output.push_str(&format!("  {} = {} {} {} {}, {}\n", temp, if is_f { "fcmp" } else { "icmp" }, if is_f { "one" } else { "ne" }, op_type, left, right));
                    ret_type = "i1".to_string();
                }
                ">" => {
                    self.output.push_str(&format!("  {} = {} {} {} {}, {}\n", temp, if is_f { "fcmp" } else { "icmp" }, if is_f { "ogt" } else { "sgt" }, op_type, left, right));
                    ret_type = "i1".to_string();
                }
                "<" => {
                    self.output.push_str(&format!("  {} = {} {} {} {}, {}\n", temp, if is_f { "fcmp" } else { "icmp" }, if is_f { "olt" } else { "slt" }, op_type, left, right));
                    ret_type = "i1".to_string();
                }
                ">=" => {
                    self.output.push_str(&format!("  {} = {} {} {} {}, {}\n", temp, if is_f { "fcmp" } else { "icmp" }, if is_f { "oge" } else { "sge" }, op_type, left, right));
                    ret_type = "i1".to_string();
                }
                "<=" => {
                    self.output.push_str(&format!("  {} = {} {} {} {}, {}\n", temp, if is_f { "fcmp" } else { "icmp" }, if is_f { "ole" } else { "sle" }, op_type, left, right));
                    ret_type = "i1".to_string();
                }
                "&&" => {
                    self.output.push_str(&format!("  {} = and i1 {}, {}\n", temp, left, right));
                    ret_type = "i1".to_string();
                }
                "||" => {
                    self.output.push_str(&format!("  {} = or i1 {}, {}\n", temp, left, right));
                    ret_type = "i1".to_string();
                }
                _ => {}
            }
            return (temp, ret_type);
        }
        
        if let Some(e) = any.downcast_ref::<EkspresiInisiasiStruktur>() {
            let struct_name = e.nama.nilai_string();
            let ptr_name = self.new_temp();
            self.output.push_str(&format!("  {} = alloca %{}\n", ptr_name, struct_name));
            
            if let Some(props) = self.struct_types.get(&struct_name).cloned() {
                for (nama_prop, eks_prop) in &e.properti {
                    let mut index = 0;
                    for (i, (n, _)) in props.iter().enumerate() {
                        if n == &nama_prop.nilai_string() {
                            index = i;
                            break;
                        }
                    }
                    let (val, val_type) = self.generate_node(eks_prop.as_ref());
                    let field_ptr = self.new_temp();
                    self.output.push_str(&format!("  {} = getelementptr %{}, ptr {}, i32 0, i32 {}\n", field_ptr, struct_name, ptr_name, index));
                    self.output.push_str(&format!("  store {} {}, ptr {}\n", val_type, val, field_ptr));
                }
            }
            
            // Return struct by value (load it)
            let val_temp = self.new_temp();
            self.output.push_str(&format!("  {} = load %{}, ptr {}\n", val_temp, struct_name, ptr_name));
            return (val_temp, struct_name);
        }

        if let Some(e) = any.downcast_ref::<EkspresiAksesProperti>() {
            let (kiri_val, kiri_type) = self.generate_node(e.kiri.as_ref());
            let clean_type = if kiri_type.starts_with('%') { &kiri_type[1..] } else { &kiri_type };
            
            if let Some(props) = self.struct_types.get(clean_type).cloned() {
                let prop_nama = e.properti.nilai_string();
                let mut index = 0;
                let mut p_type = "".to_string();
                for (i, (n, t)) in props.iter().enumerate() {
                    if n == &prop_nama {
                        index = i;
                        p_type = self.llvm_tipe(t).to_string();
                        break;
                    }
                }
                
                // Since kiri_val is the struct value, we need to store it to alloca to use getelementptr
                let ptr_name = self.new_temp();
                self.output.push_str(&format!("  {} = alloca %{}\n", ptr_name, clean_type));
                self.output.push_str(&format!("  store %{} {}, ptr {}\n", clean_type, kiri_val, ptr_name));
                
                let field_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr %{}, ptr {}, i32 0, i32 {}\n", field_ptr, clean_type, ptr_name, index));
                
                let val_temp = self.new_temp();
                self.output.push_str(&format!("  {} = load {}, ptr {}\n", val_temp, p_type, field_ptr));
                return (val_temp, p_type);
            }
        }

        if let Some(e) = any.downcast_ref::<EkspresiPanggil>() {
            let mut raw_name = e.fungsi.nilai_string();
            if let Some(resolved) = self.import_map.get(&raw_name) {
                raw_name = resolved.clone();
            }
            let mut func_name = raw_name.replace("::", "_");

            // Vector method call resolution
            let mut is_vector_method = false;
            let mut vector_res = ("".to_string(), "".to_string());
            
            if let Some(prop_akses) = e.fungsi.as_any().downcast_ref::<EkspresiAksesProperti>() {
                let (_, _, bahasa_type) = self.get_lvalue_ptr(prop_akses.kiri.as_ref());
                if bahasa_type.starts_with("vektor<") {
                    is_vector_method = true;
                    let (diri_val, _) = self.generate_node(prop_akses.kiri.as_ref());
                    let method_name = prop_akses.properti.nilai_string();
                    
                    if method_name == "panjang" {
                        let len_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 1\n", len_ptr, diri_val));
                        let len_val = self.new_temp();
                        self.output.push_str(&format!("  {} = load i64, ptr {}\n", len_val, len_ptr));
                        vector_res = (len_val, "i64".to_string());
                    } else if method_name == "kapasitas" {
                        let cap_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 2\n", cap_ptr, diri_val));
                        let cap_val = self.new_temp();
                        self.output.push_str(&format!("  {} = load i64, ptr {}\n", cap_val, cap_ptr));
                        vector_res = (cap_val, "i64".to_string());
                    } else if method_name == "tambah" {
                        let len_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 1\n", len_ptr, diri_val));
                        let len_val = self.new_temp();
                        self.output.push_str(&format!("  {} = load i64, ptr {}\n", len_val, len_ptr));
                        
                        let cap_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 2\n", cap_ptr, diri_val));
                        let cap_val = self.new_temp();
                        self.output.push_str(&format!("  {} = load i64, ptr {}\n", cap_val, cap_ptr));
                        
                        let (val, val_type) = self.generate_node(e.argumen[0].as_ref());
                        let val_llvm_type = self.llvm_tipe(&val_type);
                        
                        let cond = self.new_temp();
                        self.output.push_str(&format!("  {} = icmp eq i64 {}, {}\n", cond, len_val, cap_val));
                        
                        let lbl_grow = self.new_block();
                        let lbl_add = self.new_block();
                        let lbl_merge = self.new_block();
                        
                        self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", cond, lbl_grow, lbl_add));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_grow));
                        let double_cap = self.new_temp();
                        self.output.push_str(&format!("  {} = mul i64 {}, 2\n", double_cap, cap_val));
                        let new_bytes = self.new_temp();
                        self.output.push_str(&format!("  {} = mul i64 {}, 8\n", new_bytes, double_cap));
                        
                        let data_ptr_addr_grow = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 0\n", data_ptr_addr_grow, diri_val));
                        let old_data_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = load ptr, ptr {}\n", old_data_ptr, data_ptr_addr_grow));
                        
                        let new_data_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = call ptr @realloc(ptr {}, i64 {})\n", new_data_ptr, old_data_ptr, new_bytes));
                        self.output.push_str(&format!("  store ptr {}, ptr {}\n", new_data_ptr, data_ptr_addr_grow));
                        self.output.push_str(&format!("  store i64 {}, ptr {}\n", double_cap, cap_ptr));
                        self.output.push_str(&format!("  br label %{}\n", lbl_add));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_add));
                        let data_ptr_addr_add = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 0\n", data_ptr_addr_add, diri_val));
                        let current_data_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = load ptr, ptr {}\n", current_data_ptr, data_ptr_addr_add));
                        
                        let elem_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = getelementptr {}, ptr {}, i64 {}\n", elem_ptr, val_llvm_type, current_data_ptr, len_val));
                        self.output.push_str(&format!("  store {} {}, ptr {}\n", val_llvm_type, val, elem_ptr));
                        
                        let incremented_len = self.new_temp();
                        self.output.push_str(&format!("  {} = add i64 {}, 1\n", incremented_len, len_val));
                        self.output.push_str(&format!("  store i64 {}, ptr {}\n", incremented_len, len_ptr));
                        self.output.push_str(&format!("  br label %{}\n", lbl_merge));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_merge));
                        vector_res = ("".to_string(), "void".to_string());
                    }
                }
            }
            
            if is_vector_method {
                return vector_res;
            }
            
            if func_name == "Sukses" || func_name == "Ada" {
                let data_ptr = if !e.argumen.is_empty() {
                    let (arg_val, arg_ty) = self.generate_node(e.argumen[0].as_ref());
                    let temp = self.new_temp();
                    self.output.push_str(&format!("  {} = alloca {}\n", temp, arg_ty));
                    self.output.push_str(&format!("  store {} {}, ptr {}\n", arg_ty, arg_val, temp));
                    temp
                } else {
                    "null".to_string()
                };
                
                let struct_temp = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {{ i32, ptr }} undef, i32 0, 0\n", struct_temp));
                let struct_temp2 = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {{ i32, ptr }} {}, ptr {}, 1\n", struct_temp2, struct_temp, data_ptr));
                return (struct_temp2, "{ i32, ptr }".to_string());
            }
            if func_name == "Gagal" || func_name == "Kosong" {
                let data_ptr = if !e.argumen.is_empty() {
                    let (arg_val, arg_ty) = self.generate_node(e.argumen[0].as_ref());
                    let temp = self.new_temp();
                    self.output.push_str(&format!("  {} = alloca {}\n", temp, arg_ty));
                    self.output.push_str(&format!("  store {} {}, ptr {}\n", arg_ty, arg_val, temp));
                    temp
                } else {
                    "null".to_string()
                };
                
                let struct_temp = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {{ i32, ptr }} undef, i32 1, 0\n", struct_temp));
                let struct_temp2 = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {{ i32, ptr }} {}, ptr {}, 1\n", struct_temp2, struct_temp, data_ptr));
                return (struct_temp2, "{ i32, ptr }".to_string());
            }
            
            let mut arg_vals = Vec::new();
            let mut arg_types_str = Vec::new();

            if let Some(prop_akses) = e.fungsi.as_any().downcast_ref::<EkspresiAksesProperti>() {
                let (diri_val, diri_type) = self.generate_node(prop_akses.kiri.as_ref());
                let clean_type = if diri_type.starts_with('%') { &diri_type[1..] } else { &diri_type };
                if self.struct_types.contains_key(clean_type) {
                    let method_name = prop_akses.properti.nilai_string();
                    func_name = format!("{}_{}", clean_type, method_name);
                    arg_vals.push(diri_val);
                    arg_types_str.push(format!("%{}", clean_type)); // 'diri' passed by value
                }
            }
            
            // Handle Enum instantiation with data
            if let Some(path) = e.fungsi.as_any().downcast_ref::<EkspresiPath>() {
                if path.bagian.len() == 2 {
                    if let Some(varian_list) = self.enum_map.get(&path.bagian[0]) {
                        for (idx, (nama_var, _)) in varian_list.iter().enumerate() {
                            if nama_var == &path.bagian[1] {
                                let data_ptr = if !e.argumen.is_empty() {
                                    let (arg_val, arg_ty) = self.generate_node(e.argumen[0].as_ref());
                                    let temp = self.new_temp();
                                    self.output.push_str(&format!("  {} = alloca {}\n", temp, arg_ty));
                                    self.output.push_str(&format!("  store {} {}, ptr {}\n", arg_ty, arg_val, temp));
                                    temp
                                } else {
                                    "null".to_string()
                                };
                                
                                let struct_temp = self.new_temp();
                                self.output.push_str(&format!("  {} = insertvalue {{ i32, ptr }} undef, i32 {}, 0\n", struct_temp, idx));
                                let struct_temp2 = self.new_temp();
                                self.output.push_str(&format!("  {} = insertvalue {{ i32, ptr }} {}, ptr {}, 1\n", struct_temp2, struct_temp, data_ptr));
                                return (struct_temp2, "{ i32, ptr }".to_string());
                            }
                        }
                    }
                }
            }
            
            for arg in &e.argumen {
                let (val, ty) = self.generate_node(arg.as_ref());
                arg_vals.push(val);
                arg_types_str.push(ty);
            }
            
            if func_name == "Sistem_cetak_teks" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.string_nl, ptr {})\n", temp_call, arg_vals[0]));
                return ("".to_string(), "kosong".to_string());
            } else if func_name == "Sistem_cetak_desimal" {
                let mut actual_val = arg_vals[0].clone();
                if arg_types_str[0] == "i64" {
                    let temp = self.new_temp();
                    self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", temp, actual_val));
                    actual_val = temp;
                }
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.desimal, double {})\n", temp_call, actual_val));
                return ("".to_string(), "kosong".to_string());
            } else if func_name == "Sistem_cetak_bilangan" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @printf(ptr @.fmt.input_bilangan, i64 {})\n", temp_call, arg_vals[0]));
                return ("".to_string(), "kosong".to_string());
            } else if func_name == "Sistem_baca_desimal" {
                let temp_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = alloca double\n", temp_ptr));
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @scanf(ptr @.fmt.input_desimal, ptr {})\n", temp_call, temp_ptr));
                let temp_val = self.new_temp();
                self.output.push_str(&format!("  {} = load double, ptr {}\n", temp_val, temp_ptr));
                return (temp_val, "double".to_string());
            } else if func_name == "Sistem_baca_bilangan" {
                let temp_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = alloca i64\n", temp_ptr));
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ...) @scanf(ptr @.fmt.input_bilangan, ptr {})\n", temp_call, temp_ptr));
                let temp_val = self.new_temp();
                self.output.push_str(&format!("  {} = load i64, ptr {}\n", temp_val, temp_ptr));
                return (temp_val, "i64".to_string());
            } else if func_name == "Sistem_baca_tombol" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 @getchar()\n", temp_call));
                let temp_ext = self.new_temp();
                self.output.push_str(&format!("  {} = sext i32 {} to i64\n", temp_ext, temp_call));
                return (temp_ext, "i64".to_string());
            } else if func_name == "Sistem_bunyi_bip" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 @MessageBeep(i32 0)\n", temp_call));
                return (temp_call, "i32".to_string());
            } else if func_name == "Berkas_buka_file" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call ptr @fopen(ptr {}, ptr {})\n", temp_call, arg_vals[0], arg_vals[1]));
                return (temp_call, "ptr".to_string());
            } else if func_name == "Berkas_tulis_teks" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ptr, ...) @fprintf(ptr {}, ptr @.fmt.string, ptr {})\n", temp_call, arg_vals[0], arg_vals[1]));
                let temp_ext = self.new_temp();
                self.output.push_str(&format!("  {} = sext i32 {} to i64\n", temp_ext, temp_call));
                return (temp_ext, "i64".to_string());
            } else if func_name == "Berkas_tulis_desimal" {
                let mut actual_val = arg_vals[1].clone();
                if arg_types_str[1] == "i64" {
                    let temp = self.new_temp();
                    self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", temp, actual_val));
                    actual_val = temp;
                }
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 (ptr, ptr, ...) @fprintf(ptr {}, ptr @.fmt.desimal, double {})\n", temp_call, arg_vals[0], actual_val));
                let temp_ext = self.new_temp();
                self.output.push_str(&format!("  {} = sext i32 {} to i64\n", temp_ext, temp_call));
                return (temp_ext, "i64".to_string());
            } else if func_name == "Berkas_tutup_file" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call i32 @fclose(ptr {})\n", temp_call, arg_vals[0]));
                let temp_ext = self.new_temp();
                self.output.push_str(&format!("  {} = sext i32 {} to i64\n", temp_ext, temp_call));
                return (temp_ext, "i64".to_string());
            } else if func_name == "Matematika_akar" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call double @sqrt(double {})\n", temp_call, arg_vals[0]));
                return (temp_call, "double".to_string());
            } else if func_name == "Matematika_pangkat" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call double @pow(double {}, double {})\n", temp_call, arg_vals[0], arg_vals[1]));
                return (temp_call, "double".to_string());
            } else if func_name == "Matematika_sin" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call double @sin(double {})\n", temp_call, arg_vals[0]));
                return (temp_call, "double".to_string());
            } else if func_name == "Matematika_cos" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call double @cos(double {})\n", temp_call, arg_vals[0]));
                return (temp_call, "double".to_string());
            } else if func_name == "Matematika_tan" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call double @tan(double {})\n", temp_call, arg_vals[0]));
                return (temp_call, "double".to_string());
            } else if func_name == "Matematika_logaritma" {
                let temp_call = self.new_temp();
                self.output.push_str(&format!("  {} = call double @log10(double {})\n", temp_call, arg_vals[0]));
                return (temp_call, "double".to_string());
            } else if func_name == "Waktu_waktu_sekarang" {
                let t_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = alloca i64\n", t_ptr));
                let t_val = self.new_temp();
                self.output.push_str(&format!("  {} = call i64 @time(ptr null)\n", t_val));
                self.output.push_str(&format!("  store i64 {}, ptr {}\n", t_val, t_ptr));
                let tm_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = call ptr @localtime(ptr {})\n", tm_ptr, t_ptr));
                
                let buf_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = call ptr @malloc(i64 20)\n", buf_ptr));
                
                let fmt_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = getelementptr [18 x i8], ptr @.fmt.waktu, i64 0, i64 0\n", fmt_ptr));
                
                let call_res = self.new_temp();
                self.output.push_str(&format!("  {} = call i64 @strftime(ptr {}, i64 20, ptr {}, ptr {})\n", call_res, buf_ptr, fmt_ptr, tm_ptr));
                
                return (buf_ptr, "ptr".to_string());
            }
            
            let (ret_type, expected_args) = self.function_map.get(&func_name).cloned().unwrap_or(("i32".to_string(), vec![]));
            
            if self.async_function_map.contains_key(&func_name) {
                let struct_size = 8 * (1 + arg_vals.len());
                let struct_ptr = self.new_temp();
                self.output.push_str(&format!("  {} = call ptr @malloc(i64 {})\n", struct_ptr, struct_size));
                
                let mut struct_layout = format!("{{ {}", ret_type);
                for arg_t in &expected_args {
                    struct_layout.push_str(&format!(", {}", arg_t));
                }
                struct_layout.push_str(" }");
                
                for i in 0..arg_vals.len() {
                    let expected_ty = if i < expected_args.len() { &expected_args[i] } else { &arg_types_str[i] };
                    let mut actual_val = arg_vals[i].clone();
                    if arg_types_str[i] == "i64" && expected_ty == "double" {
                        let temp = self.new_temp();
                        self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", temp, actual_val));
                        actual_val = temp;
                    }
                    
                    let member_ptr = self.new_temp();
                    self.output.push_str(&format!("  {} = getelementptr {}, ptr {}, i32 0, i32 {}\n", member_ptr, struct_layout, struct_ptr, i + 1));
                    self.output.push_str(&format!("  store {} {}, ptr {}\n", expected_ty, actual_val, member_ptr));
                }
                
                let thread_handle = self.new_temp();
                self.output.push_str(&format!("  {} = call ptr @CreateThread(ptr null, i64 0, ptr @{}_async_wrapper, ptr {}, i32 0, ptr null)\n", thread_handle, func_name, struct_ptr));
                
                let task_val = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {{ ptr, ptr }} undef, ptr {}, 0\n", task_val, thread_handle));
                let final_task_val = self.new_temp();
                self.output.push_str(&format!("  {} = insertvalue {{ ptr, ptr }} {}, ptr {}, 1\n", final_task_val, task_val, struct_ptr));
                
                return (final_task_val, "{ ptr, ptr }".to_string());
            }
            
            let mut call_args = String::new();
            for i in 0..arg_vals.len() {
                let expected_ty = if i < expected_args.len() { &expected_args[i] } else { &arg_types_str[i] };
                let mut actual_val = arg_vals[i].clone();
                if arg_types_str[i] == "i64" && expected_ty == "double" {
                    let temp = self.new_temp();
                    self.output.push_str(&format!("  {} = sitofp i64 {} to double\n", temp, actual_val));
                    actual_val = temp;
                }
                
                call_args.push_str(&format!("{} {}", expected_ty, actual_val));
                if i < arg_vals.len() - 1 {
                    call_args.push_str(", ");
                }
            }
            
            if ret_type == "void" {
                self.output.push_str(&format!("  call void @{}({})\n", func_name, call_args));
                return ("".to_string(), "kosong".to_string());
            } else {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = call {} @{}({})\n", temp, ret_type, func_name, call_args));
                return (temp, ret_type);
            }
        }

        // --- Fase 6A: Referensi `&x` (tidak-ubah) ---
        if let Some(e) = any.downcast_ref::<EkspresiReferensi>() {
            // &x: kembalikan pointer-nya langsung tanpa load
            if let Some(id) = e.nilai.as_any().downcast_ref::<Identitas>() {
                if let Some(ptr_name) = self.var_map.get(&id.nilai).cloned() {
                    return (ptr_name, "ptr".to_string());
                }
            }
            // Fallback: generate ekspresi biasa dan kembalikan pointer temporary
            let (val, ty) = self.generate_node(e.nilai.as_ref());
            let temp_ptr = self.new_temp();
            self.output.push_str(&format!("  {} = alloca {}\n", temp_ptr, ty));
            self.output.push_str(&format!("  store {} {}, ptr {}\n", ty, val, temp_ptr));
            return (temp_ptr, "ptr".to_string());
        }
        
        // --- Fase 6B: Referensi Mutable `&ubah x` ---
        if let Some(e) = any.downcast_ref::<EkspresiReferensiUbah>() {
            // &ubah x: kembalikan pointer yang sama (bisa ditulis melaluinya)
            if let Some(id) = e.nilai.as_any().downcast_ref::<Identitas>() {
                if let Some(ptr_name) = self.var_map.get(&id.nilai).cloned() {
                    return (ptr_name, "ptr".to_string());
                }
            }
            let (val, ty) = self.generate_node(e.nilai.as_ref());
            let temp_ptr = self.new_temp();
            self.output.push_str(&format!("  {} = alloca {}\n", temp_ptr, ty));
            self.output.push_str(&format!("  store {} {}, ptr {}\n", ty, val, temp_ptr));
            return (temp_ptr, "ptr".to_string());
        }
        
        // --- Fase 6A: Dereference `*x` (baca dari pointer) ---
        if let Some(e) = any.downcast_ref::<EkspresiDeref>() {
            let (ptr_val, _ptr_ty) = self.generate_node(e.nilai.as_ref());
            // Deteksi tipe inner dari var_type_map jika ini adalah Identitas
            let inner_ty = if let Some(id) = e.nilai.as_any().downcast_ref::<Identitas>() {
                if let Some(vty) = self.var_type_map.get(&id.nilai).cloned() {
                    // Jika tipe variabel adalah ptr (dari referensi), baca inner-nya
                    if vty == "ptr" { "i64".to_string() } else { self.llvm_tipe(&vty) }
                } else { "i64".to_string() }
            } else { "i64".to_string() };
            let temp = self.new_temp();
            self.output.push_str(&format!("  {} = load {}, ptr {}\n", temp, inner_ty, ptr_val));
            return (temp, inner_ty);
        }
        
        // --- Fase 6A: Kotak (heap allocation) `kotak(nilai)` ---
        if let Some(e) = any.downcast_ref::<EkspresiKotak>() {
            let (val, ty) = self.generate_node(e.nilai.as_ref());
            let llvm_ty = self.llvm_tipe(&ty);
            let size = match ty.as_str() { "double" => 8, _ => 8 };
            let heap_ptr = self.new_temp();
            self.output.push_str(&format!("  {} = call ptr @malloc(i64 {})\n", heap_ptr, size));
            self.output.push_str(&format!("  store {} {}, ptr {}\n", llvm_ty, val, heap_ptr));
            return (heap_ptr, "ptr".to_string());
        }

        // --- Larik Dinamis: Vektor `vektor_baru<T>()` ---
        if let Some(e) = any.downcast_ref::<EkspresiVektorBaru>() {
            let vec_struct = self.new_temp();
            self.output.push_str(&format!("  {} = call ptr @malloc(i64 24)\n", vec_struct));
            
            let data_ptr = self.new_temp();
            self.output.push_str(&format!("  {} = call ptr @malloc(i64 32)\n", data_ptr)); // initial capacity 4, element size 8
            
            let data_ptr_addr = self.new_temp();
            self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 0\n", data_ptr_addr, vec_struct));
            self.output.push_str(&format!("  store ptr {}, ptr {}\n", data_ptr, data_ptr_addr));
            
            let len_ptr_addr = self.new_temp();
            self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 1\n", len_ptr_addr, vec_struct));
            self.output.push_str(&format!("  store i64 0, ptr {}\n", len_ptr_addr));
            
            let cap_ptr_addr = self.new_temp();
            self.output.push_str(&format!("  {} = getelementptr {{ ptr, i64, i64 }}, ptr {}, i32 0, i32 2\n", cap_ptr_addr, vec_struct));
            self.output.push_str(&format!("  store i64 4, ptr {}\n", cap_ptr_addr));
            
            return (vec_struct, "ptr".to_string());
        }

        // --- Fase 10: Ekspresi Tunggu (tunggu expr) ---
        if let Some(e) = any.downcast_ref::<EkspresiTunggu>() {
            let (task_val, _) = self.generate_node(e.ekspresi.as_ref());
            
            let mut awaited_llvm_type = "i64".to_string();
            
            // Case 1: Awaiting a variable
            if let Some(id) = e.ekspresi.as_any().downcast_ref::<Identitas>() {
                if let Some(bty) = self.var_bahasa_type_map.get(&id.nilai).cloned() {
                    if bty.starts_with("tugas<") && bty.ends_with('>') {
                        let inner = &bty[6..bty.len()-1];
                        awaited_llvm_type = self.llvm_tipe(inner).to_string();
                    }
                }
            }
            // Case 2: Awaiting a direct function call
            else if let Some(call) = e.ekspresi.as_any().downcast_ref::<EkspresiPanggil>() {
                let mut raw_name = call.fungsi.nilai_string();
                if let Some(resolved) = self.import_map.get(&raw_name) {
                    raw_name = resolved.clone();
                }
                let func_name = raw_name.replace("::", "_");
                if let Some(lty) = self.async_function_map.get(&func_name).cloned() {
                    awaited_llvm_type = lty;
                }
            }
            
            let thread_handle = self.new_temp();
            self.output.push_str(&format!("  {} = extractvalue {{ ptr, ptr }} {}, 0\n", thread_handle, task_val));
            let struct_ptr = self.new_temp();
            self.output.push_str(&format!("  {} = extractvalue {{ ptr, ptr }} {}, 1\n", struct_ptr, task_val));
            
            let wait_res = self.new_temp();
            self.output.push_str(&format!("  {} = call i32 @WaitForSingleObject(ptr {}, i32 -1)\n", wait_res, thread_handle));
            
            let ret_val = self.new_temp();
            if awaited_llvm_type != "void" {
                self.output.push_str(&format!("  {} = load {}, ptr {}\n", ret_val, awaited_llvm_type, struct_ptr));
            }
            
            let close_res = self.new_temp();
            self.output.push_str(&format!("  {} = call i32 @CloseHandle(ptr {})\n", close_res, thread_handle));
            self.output.push_str(&format!("  call void @free(ptr {})\n", struct_ptr));
            
            if awaited_llvm_type == "void" {
                return ("".to_string(), "void".to_string());
            } else {
                return (ret_val, awaited_llvm_type);
            }
        }

        // --- Fase 7: Pattern Matching `cocokkan target { pattern => expr, ... }` ---
        if let Some(e) = any.downcast_ref::<EkspresiCocokkan>() {
            let (target_val, target_ty) = self.generate_node(e.target.as_ref());
            let res_ptr = self.new_temp();
            let mut final_ty = "i64".to_string();
            
            // Alloca temporary untuk menyimpan hasil ekspresi cocokkan
            self.output.push_str(&format!("  {} = alloca i64\n", res_ptr));

            let lbl_akhir = self.new_block();

            // Jika target adalah enum ({ i32, ptr })
            let is_enum = target_ty.contains("{ i32, ptr }") || target_ty.starts_with('{');
            let disc_val = if is_enum {
                let temp = self.new_temp();
                self.output.push_str(&format!("  {} = extractvalue {} {}, 0\n", temp, target_ty, target_val));
                temp
            } else {
                target_val.clone()
            };

            for cb in &e.cabang {
                let lbl_cabang = self.new_block();
                let lbl_selanjutnya = self.new_block();

                match &cb.pola {
                    Pola::Wildcard | Pola::Variabel(_) => {
                        self.output.push_str(&format!("  br label %{}\n", lbl_cabang));
                        self.output.push_str(&format!("\n{}:\n", lbl_cabang));

                        if let Pola::Variabel(v) = &cb.pola {
                            if v != "_" {
                                let v_ptr = self.new_temp();
                                self.output.push_str(&format!("  {} = alloca {}\n", v_ptr, target_ty));
                                self.output.push_str(&format!("  store {} {}, ptr {}\n", target_ty, target_val, v_ptr));
                                self.var_map.insert(v.clone(), v_ptr);
                                self.var_type_map.insert(v.clone(), target_ty.clone());
                                self.var_bahasa_type_map.insert(v.clone(), if target_ty == "ptr" { "teks".to_string() } else { "bilangan".to_string() });
                            }
                        }

                        let (b_val, b_ty) = self.generate_node(cb.ekspresi.as_ref());
                        if !b_ty.is_empty() && b_ty != "kosong" { final_ty = self.llvm_tipe(&b_ty); }
                        if !b_val.is_empty() {
                            self.output.push_str(&format!("  store {} {}, ptr {}\n", final_ty, b_val, res_ptr));
                        }
                        self.output.push_str(&format!("  br label %{}\n", lbl_akhir));
                        self.output.push_str(&format!("\n{}:\n", lbl_selanjutnya));
                    },
                    Pola::Literal(lit) => {
                        let (lit_val, _) = self.generate_node(lit.as_ref());
                        let cond = self.new_temp();
                        self.output.push_str(&format!("  {} = icmp eq i64 {}, {}\n", cond, disc_val, lit_val));
                        self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", cond, lbl_cabang, lbl_selanjutnya));
                        
                        self.output.push_str(&format!("\n{}:\n", lbl_cabang));
                        let (b_val, b_ty) = self.generate_node(cb.ekspresi.as_ref());
                        if !b_ty.is_empty() && b_ty != "kosong" { final_ty = self.llvm_tipe(&b_ty); }
                        if !b_val.is_empty() {
                            self.output.push_str(&format!("  store {} {}, ptr {}\n", final_ty, b_val, res_ptr));
                        }
                        self.output.push_str(&format!("  br label %{}\n", lbl_akhir));
                        self.output.push_str(&format!("\n{}:\n", lbl_selanjutnya));
                    },
                    Pola::Varian { nama, variabel } => {
                        let target_idx = if nama.contains("Gagal") || nama.contains("Kosong") { 1 } else { 0 };
                        let cond = self.new_temp();
                        self.output.push_str(&format!("  {} = icmp eq i32 {}, {}\n", cond, disc_val, target_idx));
                        self.output.push_str(&format!("  br i1 {}, label %{}, label %{}\n", cond, lbl_cabang, lbl_selanjutnya));

                        self.output.push_str(&format!("\n{}:\n", lbl_cabang));
                        let payload_ptr = self.new_temp();
                        self.output.push_str(&format!("  {} = extractvalue {} {}, 1\n", payload_ptr, target_ty, target_val));
                        
                        for v in variabel {
                            if v != "_" {
                                let v_ptr = self.new_temp();
                                let v_ty = if v == "err" || v == "msg" || v == "s" || v == "teks" { "ptr" } else { "i64" };
                                self.output.push_str(&format!("  {} = alloca {}\n", v_ptr, v_ty));
                                
                                let loaded_val = self.new_temp();
                                self.output.push_str(&format!("  {} = load {}, ptr {}\n", loaded_val, v_ty, payload_ptr));
                                self.output.push_str(&format!("  store {} {}, ptr {}\n", v_ty, loaded_val, v_ptr));
                                
                                self.var_map.insert(v.clone(), v_ptr);
                                self.var_type_map.insert(v.clone(), v_ty.to_string());
                                self.var_bahasa_type_map.insert(v.clone(), if v_ty == "ptr" { "teks".to_string() } else { "bilangan".to_string() });
                            }
                        }

                        let (b_val, b_ty) = self.generate_node(cb.ekspresi.as_ref());
                        if !b_ty.is_empty() && b_ty != "kosong" { final_ty = self.llvm_tipe(&b_ty); }
                        if !b_val.is_empty() {
                            self.output.push_str(&format!("  store {} {}, ptr {}\n", final_ty, b_val, res_ptr));
                        }
                        self.output.push_str(&format!("  br label %{}\n", lbl_akhir));
                        self.output.push_str(&format!("\n{}:\n", lbl_selanjutnya));
                    }
                }
            }

            self.output.push_str(&format!("  br label %{}\n", lbl_akhir));
            self.output.push_str(&format!("\n{}:\n", lbl_akhir));
            let res_val = self.new_temp();
            self.output.push_str(&format!("  {} = load {}, ptr {}\n", res_val, final_ty, res_ptr));
            return (res_val, final_ty);
        }

        // --- Fase 7: Ekspresi Coba (coba expr) ---
        if let Some(e) = any.downcast_ref::<EkspresiCoba>() {
            let (val, ty) = self.generate_node(e.ekspresi.as_ref());
            return (val, ty);
        }

        ("0".to_string(), "i64".to_string())
    }
}
