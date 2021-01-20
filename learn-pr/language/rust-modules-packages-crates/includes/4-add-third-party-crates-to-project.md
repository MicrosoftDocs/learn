In this module, we'll learn how to add third party crates to your project. Rust standard library doesn't have a module for **regular expressions**, so lets add the `regex` crate that is available in the [Crates.io](https://crates.io/) website, which is the Rust community's central package registry that serves as a location to discover and download packages.

Whenever we want to add dependent crates to our project, we can rely on Cargo to do all the heavy-lifting for us. To depend on a library hosted on crates.io, add it to your `Cargo.toml` file:

```toml
[dependencies]
regex = "1.4.2"
```

If your `Cargo.toml` doesn't already have a `[dependencies]` section, add that, then list the crate name and version that you would like to use.

The next step is to run the command `cargo build`, and Cargo will fetch the new dependency and all of its dependencies, compile them all:

```output
    $ cargo build
        Updating crates.io index
      Downloaded regex v1.4.2
      Downloaded thread_local v1.0.1
      Downloaded regex-syntax v0.6.21
      Downloaded lazy_static v1.4.0
      Downloaded aho-corasick v0.7.15
      Downloaded memchr v2.3.4
      Downloaded 6 crates (689.7 KB) in 4.58s
       Compiling memchr v2.3.4
       Compiling lazy_static v1.4.0
       Compiling regex-syntax v0.6.21
       Compiling thread_local v1.0.1
       Compiling aho-corasick v0.7.15
       Compiling regex v1.4.2
       Compiling my-project v0.1.0 (/home/user/code/my-project)
        Finished dev [unoptimized + debuginfo] target(s) in 35.13s
```

We can now use the `regex` library in our `main.rs`:

```rust
use regex::Regex;

fn main() {
    let re = Regex::new(r"^\d{4}-\d{2}-\d{2}$").unwrap();
    println!("Did our date match? {}", re.is_match("2014-01-01"));
}
```

Running it will show:

```
    $ cargo run
       Running `target/hello_world`
    Did our date match? true
```

You can also use third party crates in the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=bc8a88c8013941d1d58c9e3b3bdafb42&azure-portal=true).
