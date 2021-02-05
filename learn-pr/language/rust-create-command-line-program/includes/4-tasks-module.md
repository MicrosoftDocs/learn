The next module we create will be responsible for representing our tasks, persisting them on disk, and deserializing them from the disk.

We'll start by defining a simple struct to represent what a to-do item will look like in our
program:

```rust
use chrono::{DateTime, Utc};

[derive(Debug)]
pub struct Task {
    pub text: String,
    pub created_at: DateTime<Utc>,
}
```

Our struct has two fields:

- `text` stores the task description, like `"pay the bills"`.
- `created_at` stores the timestamp of the task's creation.

We won't add a `status` or `is_complete` field because we'll represent the to-do list as a vector of tasks (`Vec<Task>`). So when a task is complete, we can simply remove it from the vector.

You might have noticed that we're using a third-party crate, `chrono`. We've specified the `Utc` parameter for its `DateTime` struct. `chrono` is a good crate to use if you need to
handle date and time data in Rust. It provides an easy API for representing a moment in time.

Because we're using it, we need to declare it in the `Cargo.toml` file:

```toml
[dependencies]
structopt = "0.3"
chrono = "0.4" # Add chrono here.
```

The next step is to implement a method for instantiating new tasks. Tasks will always be timestamped with the current date and time:

```rust
impl Task {
    pub fn new(text: String) -> Task {
        let created_at: DateTime<Utc> = Utc::now();
        Task { text, created_at }
    }
}
```

This code defines the `Task::new` function. The function requires only the task description. It will capture the current timestamp by using the `Utc::now()` method.

It seems that our task struct is complete. Now let's tackle this module's next item:
*persistence*.

Because we'll represent our to-do list as a vector of tasks, we could easily use a JSON file to persist the data. To achieve that, the best course of action is to use another excellent crate from the Rust ecosystem: `serde_json`.

## Serialize and deserialize tasks by using `serde_json`

Before we continue, we should cover some recommended practices for encoding and decoding in Rust.

When we need to persist structs and enum instances, we need to think about *serialization*. When we need to get that data back into a program, we’re talking about *deserialization*.

According to [OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Deserialization_Cheat_Sheet.html?azure-portal=true):

- **Serialization** is the process of turning some object into a data format that can be restored later. People often serialize objects in order to save them to storage, or to send as part of communications.

- **Deserialization** is the reverse of that process, taking data structured from some format, and rebuilding it into an object. Today, the most popular data format for serializing data is JSON. Before that, it was XML.

In short mean that we can stash our data into a stream of bytes and retrieve it for later use, without any loss of information. We can then send those bytes over some connection or store them into a file in our storage device.

The Rust community recommends the `serde` crate for handling most (de)serialization of Rust data structures efficiently and generically, ours included. By standing in shoulders of giants, we can be even more productive and idiomatic.

To get started serializing our `Task` type, we will need two crates:

- `serde`, the base crate that will provide our types the ability to `derive` the `Serialize` and `Deserialize` traits, and
- `serde_json`, the crate that will implement those traits into our desired file specification
format, JSON.

As always, the first step to do is include the `serde_json` and `serde` in our `[dependencies]` section of our `Cargo.toml`. But this time we are going to use a different notation for specifying them, since we'll need to conditionally compile some of `serde`'s features. Your file should look like this by now:

```toml
[dependencies]
structopt = "0.3"
serde_json = "1.0"    # add `serde_json`

[dependencies.serde]  # add `serde` in its own section
version = "1.0"
features = ["derive"] # we will need the "derive" feature

[dependencies.chrono]
version = "0.4"
features = ["serde"]  # since we're here, we are also going to need
          # the "serde" feature for the `chrono` crate,
          # crate, so we can serialize our DateTime field.
          # declare it the same way as we did for the
          # `serde` crate.
```

Now we should be able to adapt our `Task` struct to use the new features from `serde`. Open the `tasks.rs` file and modify our struct so it looks like this:

```rust
use chrono::{serde::ts_seconds, DateTime, Local, Utc};
use serde::Deserialize;
use serde::Serialize;

#[derive(Debug, Deserialize, Serialize)]
pub struct Task {
    pub text: String,

    #[serde(with = "ts_seconds")]
    pub created_at: DateTime<Utc>,
}
```

Note the differences:

- We've added the `Deserialize` and `Serialize` to our list of traits to implement
- We've annotated our `created_at_field` passing the `ts_seconds` from `chrono` to the `serde(with = ...)` attribute, so `chrono` can tell serde how its type `Datetime` will implement the two new traits.

Great. Now that our `Task` type can perform both serialization and deserialization, we can move on and implement our file handling functions.

## Interact with the file system

Lets review the three kinds of actions our program must perform:

1. Add new tasks to a to-do list.
2. Remove completed tasks from that list.
3. Print all the current tasks in that list.

Our module interface should be as simple as that list, so we are going to expose three functions, one for each action:

```rust
use std::io::Result;
use std::path::PathBuf;

pub fn add_task(journal_path: PathBuf, task: Task) -> Result<()> { ... }

pub fn complete_task(journal_path: PathBuf, task_position: usize) -> Result<()> { ... }

pub fn list_tasks(journal_path: PathBuf) -> Result<()> { ... }
```

Take a look at each function's signature first. See that all of them require a `journal_path:
PathBuf` argument. That means all of them need a file path to work upon, the file where the tasks will be stored.

- `add_task` also requires a `Task` argument. That makes sense because that is the taskthal will be added to the list.
- `complete_task` requires a `task_position` argument to indicate which `Task` will be removed, meaning it is completed.
- `list_tasks` does not need any additional information, since it will only show to our user all tasks currently stored in the journal file in a pretty format.

They all have the same return type: `std::io::Result<()>`, which means that this is an I/O result, signaling that we're expecting a broad family of unwanted outcomes that might arise when dealing with data in the physical word. The `Ok` variant is just an empty tuple, `()`, which is the type commonly associated with "no data" at all; its only purpose is to signal that the function returned an `Ok` and no errors happened.

In the next units, we will walk through writing the contents of each function in detail.
