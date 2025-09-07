use std::fs::File;
use std::io::BufReader;
use serde_json::Value;
use std::collections::HashSet;

fn extract_strings(value: &Value, unique_strings: &mut HashSet<String>) {
    match value {
        Value::String(s) => {
            unique_strings.insert(s.clone());
        }
        Value::Array(arr) => {
            for item in arr {
                extract_strings(item, unique_strings);
            }
        }
        Value::Object(obj) => {
            for (_, v) in obj {
                extract_strings(v, unique_strings);
            }
        }
        _ => {} // Ignore other types (Number, Bool, Null)
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let file_path = "/data/data/com.termux.nix/files/home/recover/logs.json";
    let file = File::open(file_path)?;
    let reader = BufReader::new(file);

    let json_value: Value = serde_json::from_reader(reader)?;

    let mut unique_strings: HashSet<String> = HashSet::new();
    extract_strings(&json_value, &mut unique_strings);

    for s in unique_strings {
        println!("{}", s);
    }

    Ok(())
}