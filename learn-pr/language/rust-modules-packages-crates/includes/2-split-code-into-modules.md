Besides helping you to better organize your code, modules also provide privacy guarantees to your values, types, and methods.

Take a look at this example, in which we model a simplified authentication API:

```rust
mod authentication {
    pub struct User {
        username: String,
        password_hash: u64,
    }

    impl User {
        pub fn new(username: &str, password: &str) -> User {
            User {
                username: username.to_string(),
                password_hash: hash_password(password),
            }
    }
    fn hash_password(input: &str) -> u64 { /*...*/ }
}

fn main() {

    let user = authentication::User::new("jeremy", "super-secret");

    println!("The username is: {}", user.username);
    println!("The password is: {}", user.password_hash);

}
```

In the preceding code, we can see that the `authentication` module provides the `User` struct with the `User::new` method, since they're both public. *Notice the `pub` keyword.*

This code fails to compile because it tries to access the `username` and `password_hash` fields from the `User` struct, but they're private. Running the code results in the following error:

```output
    error[E0616]: field `username` of struct `User` is private
      --> src/main.rs:28:42
       |
    28 |     println!("The username is: {}", user.username);
       |                                          ^^^^^^^^ private field

    error[E0616]: field `password_hash` of struct `User` is private
      --> src/main.rs:29:42
       |
    29 |     println!("The password is: {}", user.password_hash);
       |                                          ^^^^^^^^^^^^^ private field

    error: aborting due to 2 previous errors
```

This error information is useful when we want to control which parts of our program can access each part of a given module. If we wanted to give read access to the `username` field and write access to the `password` field while keeping them private, we could use getter and setter methods:

```rust
mod authentication {

    // ...

    impl User {

    // ...

        pub fn get_username(&self) -> &String {
            &self.username
        }
    
        pub fn set_password(&mut self, new_password: &str) {
            self.password_hash = hash_password(new_password)
        }
    }
}
```

Now every read and write attempt will be controlled by the `authentication` module.

To view the code for this unit, visit this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=35b4e3ff0e72ee9d87abaa8313dd3b23&azure-portal=true).
