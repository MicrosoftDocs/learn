The `cli` module will handle user input, which users will enter via a command-line
interface (hence the name). To add the module to our project, we need to create a file named `src/cli.rs` at
the project root and add the following line to the `main.rs` file:

```rust
mod cli;
```

The new module doesn't contain any code. Let's change that.

## Handle command-line parameters by using `structopt`

You could parse and handle command-line arguments by using Rust's standard library. But it would
require a tremendous amount of code and effort to do that reasonably well. We'll use a third-party crate called [`structopt`](https://crates.io/crates/structopt) that will make this task as easy as defining a simple struct.

By running the command `cargo search structopt`, you can check whether it's available and determine the most
recent version:

```sh
$ cargo search structopt
structopt = "0.3.21"                  # Parse command-line argument by defining a struct.
...
```

Let's add it as a dependency for our project by adding the following entry to the `[dependencies]`
section of the `Cargo.toml` file:

```toml
[dependencies]
structopt = "0.3"
```

From now on, we can refer to it directly from any part of our code.

## Create the `CommandLineArgs` struct

Next, we need to create a struct to represent all the possible actions our program
can perform. In the previous unit, we defined those actions:

- *Add* a task.
- *Remove* a task.
- *Print* the task list.

If you thoughtfully read the [`structopt` README page](https://github.com/TeXitoi/structopt?azure-portal=true), you might decide that the best way to express those alternating options is to use an `enum` to hold all three actions.

Before we use `structopt`, let's look at the types that will represent our command-line arguments:

```rust
use std::path::PathBuf;

pub enum Action {
    Add { task: String },
    Done { position: usize },
    List,
}

pub struct CommandLineArgs {
    pub action: Action,
    pub journal_file: Option<PathBuf>,
}
```

The `Action` enum has one variant for each kind of action we'll need in our program:

- `Action::Add` holds a `String` that describes the task being added, like `"buy milk"` or `"take the dog
  on a walk"`.
- `Action::Done` holds the number of a task that we'll mark as done. For example, a `2` will cross out the
  second task in the numbered to-do list.
- `Action::List` will print the task list in the terminal.

Next, our `CommandLineArgs` struct holds the `Action` enum as a wrapper. It also holds an optional
argument (note the `Option` type) named `journal_file`. This argument is for when a user wants to point to a journal
file that isn't the default one.

Wrapping the `action` and the `journal_file` types together allows us to apply the `journal_file`
optional argument to all nested subcommands declared in the `Action` enum.

## Derive `StructOpt`

Those types won't be of any use until we annotate them by using the `structopt` attributes. The final
source code will look like this:

```rust
use std::path::PathBuf;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
pub enum Action {
    /// Write tasks to the journal file.
    Add {
        /// The task description text.
        #[structopt()]
        text: String,
    },
    /// Remove an entry from the journal file by position.
    Done {
        #[structopt()]
        position: usize,
    },
    /// List all tasks in the journal file.
    List,
}

#[derive(Debug, StructOpt)]
#[structopt(
    name = "Rusty Journal",
    about = "A command line to-do app written in Rust"
)]
pub struct CommandLineArgs {
    #[structopt(subcommand)]
    pub action: Action,

    /// Use a different journal file.
    #[structopt(parse(from_os_str), short, long)]
    pub journal_file: Option<PathBuf>,
}
```

In the final version of the `cli.rs` file, we used `#[derive(StructOpt)]` and several
`#[structopt]` attributes to instruct Rust to generate a command-line argument parser by using our
`CommandLineArgs` struct. The documentation strings (`///`) are used to provide
descriptions for each aspect of the command-line interface.

## Run the CLI program

It's time to take the program for a test drive. But first, modify the `main.rs` source file to look like
this:

```rust
mod cli;
use structopt::StructOpt;

fn main() {
    cli::CommandLineArgs::from_args();
}
```

When you use the `cargo run` command, you'll be greeted by the Help message that `structopt`
generated from our `CommandLineArgs` struct. Impressive, isn't it?

```output
    $ cargo run
        Finished dev [unoptimized + debuginfo] target(s) in 0.04s
         Running `target/debug/rusty-journal`

    Rust Journal 0.1.0
    A command line to-do app written in Rust

    USAGE:
        rusty-journal [OPTIONS] <SUBCOMMAND>

    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information

    OPTIONS:
        -j, --journal-file <journal-file>    Use a different journal file

    SUBCOMMANDS:
        add     Write tasks to the journal file
        done    Remove an entry from the journal file by position
        help    Prints this message or the help of the given subcommand(s)
        list    List all tasks in the journal file
```

The program even produces errors when subcommands are called with the wrong arguments. Give it a try!

## Use the parsed results

The point of using `structopt` as the argument parser is that every valid invocation of the
command-line interface will produce a `CommandLineArgs` value. We can use these values in the program to
invoke the specific behavior that the user wants.

Take a look at how some different uses of the app result in different values for the struct.
First, modify the `main.rs` file to print the result of `from_args()`. Then try to call the
program with different arguments.

```rust
mod cli;
use structopt::StructOpt;

fn main() {
    println!("{:#?}", cli::CommandLineArgs::from_args());
}
```

Notice how each different invocation instantiates a different value for the struct.

```rust
// $ cargo run -- add "buy milk"
CommandLineArgs {
    action: Add {
        text: "buy milk",
    },
    journal_file: None,
}

// $ cargo run -- done 4
CommandLineArgs {
    action: Done {
        position: 4,
    },
    journal_file: None,
}

// $ cargo run -- -j groceries.txt list
CommandLineArgs {
    action: List,
    journal_file: Some(
        "groceries.txt",
    ),
}
```

We can now use those values in the `main.rs` file to guide program execution.

Next, let's look at the `tasks` module file.
