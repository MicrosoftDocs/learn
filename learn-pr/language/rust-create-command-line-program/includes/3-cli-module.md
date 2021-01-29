The `cli` module will be responsible for handling user input, which will be via a command-line
interface *(hence the name)*. To add it to our project, we must create a file named `src/cli.rs` inside
our project root and add the following line to our `main.rs` file:

```rust
mod cli;
```

Our new module currently doesn't contain any code, but let's change that.

## Handle command-line parameters with `structopt`

Parsing and handling command-line arguments can be done using Rust's standard library, but it would
require a tremendous amount of code and effort to do it reasonably well, so we'll resort to a third-party crate called [`structopt`](https://crates.io/crates/structopt) that will make this chore easy as defining a simple struct.

By running the command `cargo search structopt`, we can find if it is available and which is its most
recent version:

```sh
$ cargo search structopt
structopt = "0.3.21"                  # Parse command line argument by defining a struct.
...
```

Let's use it as a dependency to our project by adding the following entry to the `[dependencies]`
section of our `Cargo.toml` file:

```toml
[dependencies]
structopt = "0.3"
```

From now on, we can refer to it directly from any part of our code.

## Create the `CommandLineArgs` struct

The next step we must take is to create a struct to represent all the possible actions our program
can perform. In previous sections, we've defined that those actions should be:

- **add** a task
- **remove** a task
- **print** the task list

After thoughtfully reading the [`structopt` README page](https://github.com/TeXitoi/structopt?azure-portal=true), we can tell that the best way to express those alternating options is to use an `enum` to hold all those three actions.

Before we actually use `structopt`, let us first look at our types that will represent our command-line arguments:

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

- `Action::Add` holds a `String` describing the task being added, like `"buy milk"` or `"take the dog
  on a walk"`.
- `Action::Done` holds the number of the task we will mark as done, so a `2` will cross out the
  second task in our numbered to-do list.
- `Action::List` will be used to print the task list in the terminal.

Next, our `CommandLineArgs` struct will hold our `Action` enum as a wrapper, along with an optional
argument *(mind the `Option` type)* named `journal_file`, for when the user wants to point a journal
file other than the default.

Wrapping the `action` and the `journal_file` types together allows us to apply the `journal_file`
optional argument to all nested subcommands declared in the `Action` enum.

## Derive StructOpt

But those types won't be of any use until we annotate them the `structopt` attributes. The final
source code will be like this:

```rust
use std::path::PathBuf;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
pub enum Action {
    /// Write tasks to the journal file
    Add {
        /// The task description text
        #[structopt()]
        text: String,
    },
    /// Remove an entry from the journal file by position
    Done {
        #[structopt()]
        position: usize,
    },
    /// List all tasks in the journal file
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

    /// Use a different journal file
    #[structopt(parse(from_os_str), short, long)]
    pub journal_file: Option<PathBuf>,
}
```

In the final version of our `cli.rs` file, we'd used the `#[derive(StructOpt)]` and the several
`#[structopt]` attributes to tell Rust to generate a command-line argument parser using our
`CommandLineArgs` struct. The documentation strings (`///`) will also be used to provide helpful
descriptions for each aspect of our command-line interface.

## Try out our CLI

It's about time to take our program for a test drive. But first, modify the `main.rs` source file to look like
this:

```rust
mod cli;
use structopt::StructOpt;

fn main() {
    cli::CommandLineArgs::from_args();
}
```

When you hit the `cargo run` command you will be greeted by the help message that `structopt`
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

It even produces errors when subcommands are called with the wrong arguments. Give it a try!

## Use the parsed results

The whole point of using `structopt` as our argument parser is that every valid invocation of our
command-line interface will produce a `CommandLineArgs` value that we can use within our program to
invoke the specific behavior our user wants.

Take a quick look at how some different usages of our app result in different values for our struct.
First, modify our `main.rs` file to print the result of the `from_args()` and then try to call our
program with different arguments.

```rust
mod cli;
use structopt::StructOpt;

fn main() {
    println!("{:#?}", cli::CommandLineArgs::from_args());
}
```

Note how each different invocation instantiates a different value for our struct.

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

We can now use those values in our `main.rs` file to guide our program execution.

Now let's take a look at our `tasks` module file.
