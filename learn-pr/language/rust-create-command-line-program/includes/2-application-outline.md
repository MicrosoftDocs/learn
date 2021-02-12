Before we start coding, we should take some time to think about all the parts we should expect to implement for this application. It will be a command-line journal app to manage to-do items. We don't need to worry about fancy interfaces. But we'll need to handle and parse command-line arguments to interpret the actions our users will issue to the command line.

The program interface will handle these three simple actions:

- Add new tasks to a to-do list.
- Remove completed tasks from that list.
- Print all the current tasks in the list.

The program will persist our to-do items in some kind of storage. A text file should be good enough to store this kind of data, so we can stick to a file format like JSON to encode our information. We'll need to handle saving data to storage and retrieving it from storage.

Now that we've specified our application's use cases, we can allocate each action into its own module. It would make sense to have modules for command-line parsing and task persistence and then use the `main.rs` module to link them together and handle all possible errors.

Because we'll manipulate to-do tasks, we should also have a `Task` struct to keep track of each to-do item.

Having said that, let's create our initial project template. In your local development environment, create a new Cargo project by using the `cargo new` command in your terminal. Call the project `rusty-journal`.

```sh
$ cargo new rusty-journal
     Created binary (application) `rusty-journal` package
```

In the following units, we'll add new modules, types, and functions to our program.
