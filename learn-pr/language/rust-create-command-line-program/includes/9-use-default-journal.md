It is common for some command-line applications to put their user-owned files *(such as dotfiles and config files)* in their home directory, so we might place our default journal file there too.

Since home directories will vary depending on the user's operating system, we will rely on a third-party crate called `home` to infer that directory for us.

Add it to our `Cargo.toml` file:

```toml
[dependencies]
home = "0.5" # <--- add `home` to our project dependencies
serde_json = "1.0"
structopt = "0.3"

[dependencies.chrono]
features = ["serde"]
version = "0.4"

[dependencies.serde]
features = ["derive"]
version = "1.0"
```

And now we can update our `main.rs` file to use its `home::home_dir()` function, that will look for the user's home directory and return it inside an `Option<PathBuf>` type, just like our `journal_file` field from our `CommandLineArgs` type.

```rust
// ...
use std::path::PathBuf;


fn find_default_journal_file() -> Option<PathBuf> {
    home::home_dir().map(|mut path| {
        path.push(".rusty-journal.json");
        path
    })
}

fn main() {

    let CommandLineArgs {
        action,
        journal_file,
    } = CommandLineArgs::from_args();

    let journal_file = journal_file
        .or_else(find_default_journal_file)
        .expect("Failed to find journal file.");

    // ...
}
```

We created a new function, called `find_default_journal_file` that takes no input arguments and will return an `Option<PathBuf>`.

Inside that function we try to build the full path to our default journal file, by taking an
`Option` type from the `home::home_dir` function output and calling its `map` method with an
anonymous function that pushes the string `".rusty-journal.json"` to the path. If the output of `home::home_dir` is `None`, no action is taken, since `map` will only work with a `Some` variant.

Later, inside our `main` function, we *shadow* our `journal_file` variable to only be updated with a call to `find_default_journal_file` if its original value was a `None`. The `.or_else` method does the opposite of the `map` method: it only calls the function it holds if the variant is a `None`.

If neither the user informed a target journal file nor `find_default_journal_file` could find a
suitable file, we will cause our program to panic, since it's impossible for it to do anything
without a journal file.
