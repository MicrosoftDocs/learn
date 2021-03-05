When modules get too large, we might consider moving their contents to a separate file to make the code easier to navigate.

Let's move the code from our previous example to its own file called `src/authentication.rs` and then change the crate root file.

*Filename: src/main.rs*
```rust
mod authentication;

fn main() {
    let mut user = authentication::User::new("jeremy", "super-secret");

    println!("The username is: {}", user.get_username());
    user.set_password("even-more-secret");p
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

When we place a semicolon after `mod authentication` instead of a code block, the compiler will load the contents of the module from another file with the same name as the module.

The module tree remains the same, and the code will work without any modification, even though the definitions live in different files. This technique lets you move modules to new files as they grow in size.
