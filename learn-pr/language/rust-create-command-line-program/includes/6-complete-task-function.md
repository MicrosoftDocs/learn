The `complete_task` function is responsible for trying to remove a task from the to-do list, which is stored in a file. The function needs to complete these actions: 
- Read the file. 
- Collect existing tasks, if there are any.
- Remove the task that's at the indicated position, if there is one.
- Write the updated vector of tasks back into the file.

A first implementation of the `complete_task` function could look like following the code. But we can already see signs of code duplication, so we'll need to do some refactoring.

```rust
use std::io::{Error, ErrorKind, Result, Seek, SeekFrom};  // Include the `Error` type.


pub fn complete_task(journal_path: PathBuf, task_position: usize) -> Result<()> {
    // Open the file.
    let file = OpenOptions::new()
        .read(true)
        .write(true)
        .open(journal_path)?;

    // Consume the file's contents as a vector of tasks.
    let tasks = match serde_json::from_reader(file) {
        Ok(tasks) => tasks,
        Err(e) if e.is_eof() => Vec::new(),
        Err(e) => Err(e)?,
    };

    // Remove the task.
    if task_position == 0 || task_position > tasks.len() {
        return Err(Error::new(ErrorKind::InvalidInput, "Invalid Task ID"));
    }
    tasks.remove(task_position - 1);

    // Rewind and truncate the file.
    file.seek(SeekFrom::Start(0))?;
    file.set_len(0)?;

    // Write the modified task list back into the file.
    serde_json::to_writer(file, &tasks)?;
    Ok(())
}
```

Before we start writing this function, we can see that the same code for reading the file that we used in the `add_task` function is required here. It will also be required again when we implement the `list_tasks` function. This need for duplication indicates that we should refactor our code and encapsulate that behavior in a dedicated function. We can then reuse the code in the logic for all of our three actions.

## Refactor `Task` collection

We can create a `collect_tasks` function that handles the file parsing:

```rust
fn collect_tasks(mut file: &File) -> Result<Vec<Task>> {
    file.seek(SeekFrom::Start(0))?; // Rewind the file before.
    let tasks = match serde_json::from_reader(file) {
        Ok(tasks) => tasks,
        Err(e) if e.is_eof() => Vec::new(),
        Err(e) => Err(e)?,
    };
    file.seek(SeekFrom::Start(0))?; // Rewind the file after.
    Ok(tasks)
}
```

The function receives a reference to a `File` and returns a `std::io::Result<Vec<Task>>`. That means it's expecting an `io::Error` to happen. As a bonus, it also rewinds the file, before reading its contents and before returning it back to the caller.

We can now refactor the `add_task` function to use the new function:

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

After this refactor, `add-task` looks much better and is easier to read!

## The final version of `complete_task`

We can now finally use the refactored code in the `complete_task` function:

```rust
pub fn complete_task(journal_path: PathBuf, task_position: usize) -> Result<()> {
    // Open the file.
    let file = OpenOptions::new()
        .read(true)
        .write(true)
        .open(journal_path)?;

    // Consume file's contents as a vector of tasks.
    let mut tasks = collect_tasks(&file)?;

    // Try to remove the task.
    if task_position == 0 || task_position > tasks.len() {
        return Err(Error::new(ErrorKind::InvalidInput, "Invalid Task ID"));
    }
    tasks.remove(task_position - 1);

    // Write the modified task list back into the file.
    file.set_len(0)?;
    serde_json::to_writer(file, &tasks)?;
    Ok(())
}
```

The first and second parts, and some of the fourth part, are doing the same thing we did in our `add_task` function, with a couple of exceptions:

- We're not creating the journal file. It doesn't exist.
- We're truncating the file before writing to it because we're performing a removal operation. So
the file will be smaller than the original. If we ignored this step, the rewound
cursor would stop behind the previously written bytes of the file, resulting in a malformed JSON
file. When we truncate the file by using the `file.set_len(0)` operation, we ensure that we're
writing the bytes in a blank page.

In the third section, we remove a task from the vector by pointing out its position. If the position isn't valid, we return early with a custom-made `io::Error` that explains the problem.
