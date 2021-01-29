Now's your chance to use what you've learned about using modules in functions and visibility.

The code below has a few compiler error. Your assignment in this exercise is to make the code compile successfully without modifying the `main` function.

```rust
mod text_processing {

    mod letters {
        fn count_letters(text: &str) -> usize {
            text.chars().filter(|ref c| c.is_alphabetic()).count()
        }
    }

    mod numbers {
        fn count_numbers(text: &str) -> usize {
           text.chars().filter(|ref c| c.is_numeric()).count()
        }
    }
}

fn count_letters_and_numbers(text: &str) -> (usize, usize) {
    let number_of_letters = ???;
    let number_of_numbers = ???;
    (number_of_letters, number_of_numbers)
}

fn main() {
    assert_eq!(count_letters_and_numbers("221B Baker Street"), (12, 3));
    assert_eq!(count_letters_and_numbers("711 Maple Street"), (11, 3));
    assert_eq!(count_letters_and_numbers("4 Privet Drive"), (11, 1));
}
```

You can also view this exercise at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=448be9f8ab548543ada9d3640b3d7d93&azure-portal=true).

To find a solution for this exercise, check out this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=7c0fa8c5f5aeac10ad0b674469b70a01&azure-portal=true).
