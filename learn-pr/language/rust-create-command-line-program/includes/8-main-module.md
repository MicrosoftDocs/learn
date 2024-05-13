Now that our program can deal with user interaction (by using the `cli` module) and file handling
(by using the `tasks` module), we can try it out to see if everything works as expected.

We still need to polish some things, like using a default journal file and presenting friendly errors to users, but let's deal with those tasks later.

## Complete the main module and run the program

The next thing we should do is connect the `Actions` struct to the three public functions defined in the `tasks` module. Open the `main.rs` file and make it look like this:

```rust
use structopt::StructOpt;
mod cli;
mod tasks;

use cli::{Action::*, CommandLineArgs};
use tasks::Task;

fn main() {
    // Get the command-line arguments.
    let CommandLineArgs {
        action,
        journal_file,
    } = CommandLineArgs::from_args();

    // Unpack the journal file.
    let journal_file = journal_file.expect("Failed to find journal file");

    // Perform the action.
    match action {
        Add { task } => tasks::add_task(journal_file, Task::new(task)),
        List => tasks::list_tasks(journal_file),
        Done { position } => tasks::complete_task(journal_file, position),
    }
    .expect("Failed to perform action")
}

```

Our `main.rs` outline looks simple.

We start by *destructuring* our `CommandLineArgs` struct into its fields, so we can pass those
values independently to our task-handling functions.

Because `journal_file` is of type `Option<PathBuf>`, we need to extract the path to our journal file or emit a `panic`. We revisit this step later to make the program look for a default file. For now, this `.expect` instruction works fine.

Finally, we match each possible `Action` to its function, passing the required fields from the enum to the functions. We call `.expect` at the end of the `match` block because all functions return a `Result` type, which can fail. Again, we polish this functionality later to provide nice error messages to users if there's a failure.

Let's give it a try. Open your terminal and enter these commands:

```output
$ cargo run -- -j test-journal.json add "buy milk"

$ cargo run -- -j test-journal.json add "take the dog for a walk"

$ cargo run -- -j test-journal.json add "water the plants"

$ cargo run -- -j test-journal.json list
1: buy milk                                           [2021-01-08 16:39]
2: take the dog for a walk                            [2021-01-08 16:39]
3: water the plants                                   [2021-01-08 16:39]

$ cargo run -- -j test-journal.json done 2

$ cargo run -- -j test-journal.json list
1: buy milk                                           [2021-01-08 16:39]
2: water the plants                                   [2021-01-08 16:39]
```

It looks like the program is running well!

We started by calling `cargo run --` to ensure that all the arguments passed after `--` are sent to our program and not to `cargo` itself.

Then we added three tasks in a row by using the subcommand `add` followed by a task name string. The `list` subcommand then displayed our three tasks, in order, with their timestamps on the far right. We then called the `done 2` subcommand to mark the second task complete. When we called `list` again, that task was gone. Amazing, don't you think?

If we peek inside the `test-journal.json` file, we see the following content:

```js
[{"text":"buy milk","created_at":1610134741},{"text":"water the plants","created_at":1610134762}]
```

We see that each `Task` is represented as a JSON object, and that each file is one key. The task description is stored as a string, and the timestamp is persisted as the number of seconds since [epoch](https://en.wikipedia.org/wiki/Epoch_(computing)?azure-portal=true).

If we pretty-printed the JSON file, it would look like this:

```js
[
  {
    "text": "buy milk",
    "created_at": 1610134741
  },
  {
    "text": "water the plants",
    "created_at": 1610134762
  }
]
```

In the next two sections, we improve the usability of our program by configuring it to use a default journal file and presenting prettier error messages.
