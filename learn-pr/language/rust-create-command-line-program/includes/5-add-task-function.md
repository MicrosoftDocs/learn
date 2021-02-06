The `add_task` function has to append a new `Task` value to a possibly existing collection of tasks encoded in a JSON file.

So, before inserting a task into that collection, we must first read that file and assemble a vector of tasks from its contents.

The first version looks like this:

```rust

use std::fs::OpenOptions;
use std::io::{BufReader, Result, Seek, SeekFrom};
  // ...

pub fn add_task(journal_path: PathBuf, task: Task) -> Result<()> {
    // Open the file.
    let file = OpenOptions::new()
        .read(true)
        .write(true)
        .create(true)
        .open(journal_path)?;

    // Consume the file's contents as a vetcor of tasks.
    let mut tasks: Vec<Tasks> = match serde_json::from_reader(file) {
        Ok(tasks) => tasks,
        Err(e) if e.is_eof() => Vec::new(),
        Err(e) => Err(e)?,
    };

    // Rewind the file after reading from it.
    file.seek(SeekFrom::Start(0))?;

    // Write the modified task list back into the file.
    tasks.push(task);
    serde_json::to_writer(file, &tasks)?;

    Ok(())
}
```

Let's go over this function in four steps:

## Open the file

First, we open the file by using `OpenOptions`, which allows us to specify some modes for operating on the file, like `read`, `write`, and `create` (for when the file doesn't yet exist).

The question mark symbol (`?`) after that statement is used to propagate errors without writing too much boilerplate code. It's syntax sugar for early returning an error if that error matches with the return type of the function it's in. So both these snippets are equivalent:

```rust
fn function_1() -> Result(Success, Failure) {
    match operation_that_might_fail() {
        Ok(success) => success,
        Err(failure) => return Err(failure),
    }
}

fn function_2() -> Result(Success, Failure) {
    operation_that_might_fail()?
}
```

That pattern is used a lot in code that needs to perform multiple I/O operations, as we do in this program.

## Build a reader and consume its contents as a vector of tasks

The second step is to actually read the file. To read the file, `serde_json` asks for any type that implements the `Reader` trait. The `File` type implements that trait, so we just pass it as a parameter to the `serde_json.from_reader` function while declaring that we expect to receive a `Vec<Task>` from it.

Keep in mind that accessing the file system is an I/O action that can fail for various reasons, so we need to take into account how our program should behave (and possibly recover) in some specific cases. For example, `serde_json` will return an error when it reaches the end of a file without having found anything to parse. This event will always happen in an empty file, and we need to be able to recover from it.

To recover from specific kinds of errors, we use `guards` in our `match` expression to build an empty `Vec` when that specific error occurs, representing an empty to-do list.

Note that `serde_json::Error` can be easily converted to the `std::io::Error` type because [it
implements the `From` trait](https://docs.serde.rs/serde_json/error/struct.Error.html#impl-From%3CError%3E?azure-portal=true), making it possible for us to use the `?` operator to unpack or early return them.

## Rewind the file after reading from it

Because we have moved the cursor to the end of our file, we must rewind it before writing over it again. If we don't, we would begin writing at the cursor's last position, causing a malformed JSON file. The `Seek` trait and the `SeekFrom` enum from the `std::io` module are used to make that happen.

## Write the modified task list back into the file

Last but not least, we push the `Task` value received as a function parameter to the task list and use `serde_json` to write our task vector into our file. We then return the empty tuple value inside an `Ok` to inform that everything went according to our plans.
