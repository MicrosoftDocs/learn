Right now, if we try to read from a journal file that doesn't exist, our program panics with the following output:

```output
    $ cargo run -- done 2

    thread 'main' panicked at 'Failed to perform action: Os { code: 2, kind: NotFound, message: "No such file or directory" }'
```

This error is a little verbose for our users, so we should make it more presentable. We could write lots of code to handle that task, but there's an excellent crate for displaying useful and pretty errors to users called `anyhow`.

The logic behind the `anyhow` crate is that it provides its own error type. This type has
pretty-printing properties and can easily be converted from other errors, like
`std::io::Error`. It's easy to add `anyhow` to our project. All we have to do is place it as the return type of the `main` function.

First, declare it in the `Cargo.toml` file:

```toml
[dependencies]
anyhow = "1.0" # <--- Add `anyhow` to our project dependencies.
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

Now update the `main` function signature so it returns the type `anyhow::Result<()>`:

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
        Add { task } => tasks::add_task(journal_file, Task::new(task)),
        List => tasks::list_tasks(journal_file),
        Done { position } => tasks::complete_task(journal_file, position),
    }?;
    Ok(())
}
```

Because most error types can be converted to `anyhow::Error`, we can use `?` syntax to remove the `expect` calls from our code. Also, see how we're using the `anyhow!` macro to produce an `anyhow::Error` on the fly that contains the provided error message.

Now every panic message caused by an I/O error being returned from within our program is displayed to users like this:

```output
    $ cargo run -- -j missing-journal done 2
    Error: No such file or directory (os error 2)
```

Quite an improvement for a few extra lines of code.
