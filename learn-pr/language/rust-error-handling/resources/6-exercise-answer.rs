use std::fs::File;
use std::io::{Error, Read};
use std::path::PathBuf;

fn read_file_contents(path: PathBuf) -> Result<String, Error> {
    let mut string = String::new();

    // Access a file at a specified path
    // ---------------------------------
    // - Pass variable to `file` variable on success, or
    // - Return from function early if there's an error    
    let mut file: File = match File::open(path) {
        // Corrected code: Pass variable to `file` variable on success
        Ok(file_handle) => file_handle,
        // Corrected code: Return from function early if there's an error
        Err(io_error) => return Err(io_error),
    };

    // Read file contents into `String` variable with `read_to_string`
    // ---------------------------------
    // Success path is already filled in
    // Return from the function early if it is an error
    match file.read_to_string(&mut string) {
        Ok(_) => (),
        // Corrected code: Return from function early if there's an error
        Err(io_error) => return Err(io_error),
    };

    // Corrected code: Return `string` variable as expected by function signature
    Ok(string)
}

fn main() {
    if read_file_contents(PathBuf::from("src/main.rs")).is_ok() {
        println!("The program found the main file.");
    }
    if read_file_contents(PathBuf::from("non-existent-file.txt")).is_err() {
        println!("The program reported an error for the file that doesn't exist.");
    }
}
