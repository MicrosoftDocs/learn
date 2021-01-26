Right now, if we try to read from a journal file that doesn't exist, our program will panic with the following output:

```output
    $ cargo run -- done 2

    thread 'main' panicked at 'Failed to perform action: Os { code: 2, kind: NotFound, message: "No such file or directory" }'
```

This error is rather verbose to present to our end users, so we should make it more presentable. We could write lots of code to handle that, but there is an excellent crate for displaying useful and pretty errors to end users, called `anyhow`.

The logic behind the `anyhow` crate is that it gives us its own error type, which has
pretty-printing properties and can easily be converted from another errors, such as
`std::io::Error`. It is really easy to add `anyhow` to our project, since all we have to do is place it as the return type of our `main` function.

But fist, declare it in your `Cargo.toml` file:

```toml
[dependencies]
anyhow = "1.0" # <--- add `anyhow` to our project dependencies
home = "0.5"
serde_json = "1.0"
structopt = "0.3"

[dependencies.chrono]
features = ["serde"]
version = "0.4"

[dependencies.serde]
features = ["derive"]
version = "1.0"
```

And update the `main` function signature so it returns the type `anyhow::Result<()>`:

```rust
use anyhow::anyhow;
use std::path::PathBuf;
use structopt::StructOpt;
mod cli;
mod tasks;

use cli::{Action::*, CommandLineArgs};
use tasks::Task;

fn find_default_journal_file() -> Option<PathBuf> {
    home::home_dir().map(|mut path| {
        path.push(".rust-journal.json");
        path
    })
}

fn main() -> anyhow::Result<()> {
    let CommandLineArgs {
        action,
        journal_file,
    } = CommandLineArgs::from_args();

    let journal_file = journal_file
        .or_else(find_default_journal_file)
        .ok_or(anyhow!("Failed to find journal file."))?;

    match action {
        Add { text } => tasks::add_task(journal_file, Task::new(text)),
        List => tasks::list_tasks(journal_file),
        Done { position } => tasks::complete_task(journal_file, position),
    }?;
    Ok(())
}
```

Since most error types can be converted to `anyhow::Error`, we can use the `?` syntax to remove all those `expect` calls from our code. Also note that we are using the `anyhow!` macro to produce an `anyhow::Error` on the fly with the provided error message.

Now every panic message caused by an IO error being returned from within our program will be
displayed to our users like this:

```output
    $ cargo run -- -j missing-journal done 2
    Error: No such file or directory (os error 2)
```

Which is quite an improvement for a few extra lines of code.
