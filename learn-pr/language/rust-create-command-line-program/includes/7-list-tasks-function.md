The third and last action we need to define is the `list_tasks` function. All it needs to do is read
the journal file and print the list of tasks, if there are any:

```rust
pub fn list_tasks(journal_path: PathBuf) -> Result<()> {
    // Open the file.
    let file = OpenOptions::new().read(true).open(journal_path)?;
    // Parse the file and collect the tasks.
    let tasks = collect_tasks(&file)?;

    // Enumerate and display tasks, if any.
    if tasks.is_empty() {
        println!("Task list is empty!");
    } else {
        let mut order: u32 = 1;
        for task in tasks {
            println!("{}: {}", order, task);
            order += 1;
        }
    }

    Ok(())
}
```

This function is a bit more simple than its siblings because it doesn't need to write to the file. We reuse the `collect_tasks` helper function again, proving the usefulness of our refactor. We then check if the task vector is empty before we try to list its contents.

When we print the list, we use a simple counter that starts at `1` to enumerate the tasks. This number will be the same one that our users will pass to the `complete_task` action.

Note that this code won't compile because the `Task` struct doesn't yet implement the `Display` trait. As we've seen in other modules, the `Display` trait is used to show a struct representation to end users, which is exactly what we're doing here.

Implementing the `Display` trait for our types is easy. All we need to do is implement the `fmt` function, like this:

```rust
use std::fmt;

impl fmt::Display for Task {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let created_at = self.created_at.with_timezone(&Local).format("%F %H:%M");
        write!(f, "{:<50} [{}]", self.text, created_at)
    }
}
```

In the `Display::fmt` function, we convert the `DateTime<Utc>` timestamp into a `DateTime<Local>` struct, so users can see the date and time the task was created in local time.

You might be wondering why we didn't define the `created_at` field by using the `DateTime<Local>` type since the beginning. We didn't do that because the `chrono::serde::ts_seconds` module expects `DateTime` structs to be specialized over the `Utc` type.

We then write the `Task` representation to the `Formatter` value `f` by using the `write!` macro. We represent our `Task` type like this:

- `{:<50}`: a left-aligned string padded with 50 spaces.
- Followed by `[{}]`: the date and time the task was created, inside brackets.

## Summary

That concludes our journey into the `tasks.rs` module file. The last step we should take is to bind the user input captured by `cli::CommandLineArgs` with the three functions defined in this
module.

In the next section, we'll connect those ends in the `main.rs` file and finish our application.
