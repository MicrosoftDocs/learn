When the module contents become too large, code navigation becomes more challenging. Consider moving module contents to a separate file. 

Let's move the code from our previous example to its own file called `src/authentication.rs` and then change the crate root file.

*Filename: src/main.rs*
```rust
mod authentication;

fn main() {
    let mut user = authentication::User::new("jeremy", "super-secret");

    println!("The username is: {}", user.get_username());
    user.set_password("even-more-secret");
}
```

*Filename: src/authentication.rs*
```rust
pub struct User {
    username: String,
    password_hash: u64,
}

impl User {
    pub fn new(username: &str, password: &str) -> User {
        User {
            username: username.to_string(),
            password_hash: hash_password(&password.to_owned()),
        }
    }

    pub fn get_username(&self) -> &String {
        &self.username
    }

    pub fn set_password(&mut self, new_password: &str) {
        self.password_hash = hash_password(&new_password.to_owned())
    }
}

fn hash_password<T: Hash>(t: &T) -> u64 {/* ... */}
```

Place a semicolon after `mod authentication` instead of a code block. As files grow in size, this technique lets you move modules to new files automatically. The compiler loads the module contents from another file that's named the same as the module.

When the content loads, the module tree remains the same. The code will also work without requiring any changes, even though the definitions exist in different files. 
