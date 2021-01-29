The third and last action we need to define is the `list_tasks` function. All it needs to do is read
the journal file and print the list of tasks, if any.

```rust
pub fn list_tasks(journal_path: PathBuf) -> Result<()> {
    // Open the file
    let file = OpenOptions::new().read(true).open(journal_path)?;
    // Parse the file and collect our tasks
    let tasks = collect_tasks(&file)?;

    // Enumerate and display tasks, if any
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

This function is a bit more simple than its siblings since it doesn't need to write to the file. We reuse the `collect_tasks` helper function again, proving the point of our refactor. Then we check if the task vector is empty before attempting to list its contents.

When printing, we use a simple counter starting at `1` to enumerate our tasks. This will be the very same number that our users will pass to the `complete_task` action.

Note that this code won't compile as our `Task` struct does not implement the `Display` trait, yet. As we've seen in past modules, the `Display` trait is used to show a struct representation to end users, which is exactly what we are trying to do here.

Implementing the `Display` trait for our types is a rather simple job: all we need todo is implement the `fmt` function, like this:

```rust
use std::fmt;

impl fmt::Display for Task {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let created_at = self.created_at.with_timezone(&Local).format("%F %H:%M");
        write!(f, )"{:<50} [{}]", self.text, created_at)
    }
}
```

Inside the `Display::fmt` function we convert our `DateTime<Utc>` timestamp into a `DateTime<Local>` struct, so the user can see the date and time its task was created in its local timezone.

You might be wondering why we haven't defined our `created_at` field using the `DateTime<Local>` type since the beginning, and the reason is that the `chrono::serde::ts_seconds` module expects `DateTime` structs to be specialized over the `Utc` type.

Then, we write our `Task` representation to the `Formatter` value, `f` using the `write!` macro. We represent our `Task` type as:

- `{:<50}`: a left-aligned string padded with 50 spaces, followed by
- `[{}]`: the date and time it was created inside brackets.

## Summary

That concludes our journey into the `tasks.rs` module file. The last step we should take is to bind our user input captured by our `cli::CommandLineArgs` with our three functions defined in this
module.

In the next section, we'll connect those ends inside the `main.rs` file and finish our application.
