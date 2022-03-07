It's common for some command-line applications to put their user-owned files, like dotfiles and config files, in their home directories. So we might want to place our default journal file there too.

Because home directories vary depending on the user's operating system, we'll rely on a third-party crate called `home` to determine the directory.

First, add it to the `Cargo.toml` file:

```toml
[dependencies]
home = "0.5" # <--- Add `home` to our project dependencies.
serde_json = "1.0"
structopt = "0.3"

[dependencies.chrono]
features = ["serde"]
version = "0.4"

[dependencies.serde]
features = ["derive"]
version = "1.0"
```

We can now update the `main.rs` file to use the `home::home_dir()` function. This function will look for the user's home directory and return it in an `Option<PathBuf>` type, just like the `journal_file` field from our `CommandLineArgs` type:

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

We created a new function called `find_default_journal_file`. It takes no input arguments and returns an `Option<PathBuf>`.

Inside that function, we try to build the full path to our default journal file. We build the path by taking an
`Option` type from the `home::home_dir` function output and calling its `map` method with an
anonymous function that pushes the string `".rusty-journal.json"` to the path. If the output of `home::home_dir` is `None`, no action is taken, because `map` will work only with a `Some` variant.

Then, in the `main` function, we *shadow* the `journal_file` variable to be updated with a call to `find_default_journal_file` only if its original value was `None`. The `.or_else` method does the opposite of the `map` method: it calls the function it holds only if the variant is `None`.

If the user hasn't provided a target journal file and `find_default_journal_file` can't find a
suitable file, we cause the program to panic because it's impossible for it to do anything
without a journal file.
