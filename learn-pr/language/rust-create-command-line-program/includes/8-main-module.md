Now that our program can deal with user interaction (using the `cli` module) and file handling
(using the `tasks` module) we can try it out to see if everything is working as expected.

We still need to polish some aspects, like using a default journal file and presenting friendly errors to our end users, but let's deal with those topics later.

## Complete the main module and run the program

The next thing we should do is connect our `Actions` struct to our three public functions defined in the `tasks` module. Open your `main.rs` file and make it look like this:

```rust
use structopt::StructOpt;
mod cli;
mod tasks;

use cli::{Action::*, CommandLineArgs};
use tasks::Task;

fn main() {
    // Get the command line arguments
    let CommandLineArgs {
        action,
        journal_file,
    } = CommandLineArgs::from_args();

    // Unpack the journal file
    let journal_file = journal_file.expect("Failed to find journal file");

    // Perform the action
    match action {
        Add { text } => tasks::add_task(journal_file, Task::new(text)),
        List => tasks::list_tasks(journal_file),
        Done { position } => tasks::complete_task(journal_file, position),
    }
    .expect("Failed to perform action")
}

```

Our `main.rs` outline looks really simple.

We start by *destructuring* our `CommandLineArgs` struct into its fields, so we can pass those
values independently to our task-handling functions.

Since `journal_file` is of type `Option<PathBuf>`, we need to extract the path to our journal file or emit a `panic`. We'll revisit this step later to make our program look for a default file, but this `.expect` instruction will work just fine for this experiment.

Finally, we match each possible `Action` to its function, passing the required fields from our enum to our functions. We call `.expect` at the end of our `match` block because all functions return a `Result` type, which can fail. Again, this will be polished to provide nice error messages to our users in case of failure.

Let's give it a try. Open your terminal and type the following commands:

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

It looks like our program is running well!

We started by calling `cargo run --` to ensure that all the arguments passed after `--` will be sent to our program and not to `cargo` itself.

Then we added three tasks in a row using the subcommand `add` followed by a string with the task name. The `list` subcommand then showed us all our three tasks in order with their timestamps on the far right. Then we called the `done 2` subcommand to mark the second task complete, and, when we called `list` again that task was gone. Pretty amazing, don't you think?

If we peek inside the `test-journal.json` file we would see the following content:

```js
[{"text":"buy milk","created_at":1610134741},{"text":"water the plants","created_at":1610134762}]
```

We can see that each `Task` is represented as a JSON Object, with each filed being one key. The task description is stored as a string and the timestamp is persisted as a number of seconds since [epoch](https://en.wikipedia.org/wiki/Epoch_(computing)).

If we pretty-printed that JSON file, it would look like this:

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

In the next two sections we will work on improving the usability of our program, by making it use a default journal file and presenting prettier error messages.
