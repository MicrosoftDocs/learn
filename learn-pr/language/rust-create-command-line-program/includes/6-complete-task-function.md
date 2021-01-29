The `complete_task` function is responsible to try to remove a task from our to-do list stored in a file. This means that we have to read the file, collect existing tasks *(if any)*, remove the task at the informed position *(if there is any)* and write the updated vector of tasks back into the file.

A first implementation of the `complete_task` function could look like the code below, but we can already see signs of code duplication that will require a little refactoring effort from our part:

```rust
use std::io::{Error, ErrorKind, Result, Seek, SeekFrom};  // include the `Error` type


pub fn complete_task(journal_path: PathBuf, task_position: usize) -> Result<()> {
    // Open the file
    let file = OpenOptions::new()
        .read(true)
        .write(true)
        .open(journal_path)?;

    // Consume file's ocntents as a vector of tasks
    let tasks = match serde_json::from_reader(file) {
        Ok(tasks) => tasks,
        Err(e) if e.is_eof() => Vec::new(),
        Err(e) => Err(e)?,
    };

    // Remove the task
    if task_position == 0 || task_position > tasks.len() {
        return Err(Error::new(ErrorKind::InvalidInput, "Invalid Task ID"));
    }
    tasks.remove(task_position - 1);

    // Rewind and truncate the file
    file.seek(SeekFrom::Start(0))?;
    file.set_len(0)?;

    // Write the modified task list back into the file
    serde_json::to_writer(file, &tasks)?;
    Ok(())
}
```

Before we start writing this function, we can see that the same code for reading the file that we have used in the `add_task` function is also required here, and will be required again when we implement the `list_tasks` function. This is a good indicator for us to refactor our code and encapsulate that behavior in a dedicated function and reuse it in all of our three actions logic.

## Refactor `Task` collection

We can create a `collect_tasks` function that handles the file parsing for us:

```rust
fn collect_tasks(mut file: &File) -> Result<Vec<Task>> {
    file.seek(SeekFrom::Start(0))?; // rewind the file before
    let tasks = match serde_json::from_reader(file) {
        Ok(tasks) => tasks,
        Err(e) if e.is_eof() => Vec::new(),
        Err(e) => Err(e)?,
    };
    file.seek(SeekFrom::Start(0))?; // rewind the file after
    Ok(tasks)
}
```

It receives a reference to a `File` and returns a `std::io::Result<Vec<Task>>`, meaning that it is expecting an `io::Error` to happen. As a bonus, it also rewinds the file for us, before reading its contents and before returning it back to the caller.

We can now refactor our `add_task` function to use it:

```rust
pub fn add_task(journal_path: PathBuf, task: Task) -> Result<()> {
    let file = OpenOptions::new()
        .read(true)
        .write(true)
        .create(true)
        .open(journal_path)?;
    let mut tasks = collect_tasks(&file)?;
    tasks.push(task);
    serde_json::to_writer(file, &tasks)?;
    Ok(())
}
```

After this refactor, the function looks much better and easier to read!

## See `complete_task` in its final version

New we can finally use the refactored code it inside our `complete_task` function.

```rust
pub fn complete_task(journal_path: PathBuf, task_position: usize) -> Result<()> {
    // Open the file
    let file = OpenOptions::new()
        .read(true)
        .write(true)
        .open(journal_path)?;

    // Consume file's ocntents as a vector of tasks
    let mut tasks = collect_tasks(&file)?;

    // Try to remove the task
    if task_position == 0 || task_position > tasks.len() {
        return Err(Error::new(ErrorKind::InvalidInput, "Invalid Task ID"));
    }
    tasks.remove(task_position - 1);

    // Write the modified task list back into the file
    file.set_len(0)?;
    serde_json::to_writer(file, &tasks)?;
    Ok(())
}
```

The first, second and some of the fourth parts are doing the same as in our `add_task` function, with a couple exceptions:

- We are not creating the journal file it does not exist.
- We are truncating our file before writing because we are performing a *removal* operation,
meaning that the file will be smaller than the original. If we ignored this step our rewound
cursor would stop behind the previous written bytes of the file, resulting in a malformed JSON
file. When we *truncate* the file using the `file.set_len(0)` operation, we ensure that we are
writing our bytes in a "blank page."

In the third section, we will remove a task from our vector by pointing out its position. If the position is invalid, we return early with a custom-made `io::Error`, informing that.
