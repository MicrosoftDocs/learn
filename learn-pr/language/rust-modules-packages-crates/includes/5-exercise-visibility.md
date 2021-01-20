Unless explicitly noted, every item in a module is private. Only the public items of a module can be accessed from outside the module scope.

The code below has a compiler error. Your assignment in this exercise is to make the code compile successfully without modifying the `main` function.

```rust
mod car_factory {
    fn build_car() {
        println!("Honk honk!");
    }
}

fn main() {
    car_factory::build_car();
}
```

Hint: The compiler error should point to the item that needs to be public.

You can also view this exercise at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=fe45044ec8efe9344f5ed81c7fa3ad06&azure-portal=true).

To find a solution for this exercise, check out this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=5298832fadbaad2afb8a09cfa0fcac3e&azure-portal=true).
