Before we start coding, we should take some time to think about all the parts we should expect to implement for this application. It will be a command-line journal app to manage to-do items. We don't need to worry about fancy interfaces, but we'll need to handle and parse command-line arguments to interpret the actions our users will issue to it.

The program interface will handle these three simple actions:

1. Add new tasks to a to-do list.
2. Remove completed tasks from that list.
3. Print all the current tasks in that list.

The program will persist our to-do items in some kind of storage. A text file should be good enough to store such kind of data, so we can stick to a file format, such as JSON to encode our information. Hence, we will need to handle saving and retrieving our data from our storage.

Now that we've specified our application responsibilities, we can allocate each action into its own module. It would make sense to have modules for *command-line parsing* and *task persistence*, and then use the `main.rs` module to glue them together and handle all possible errors.

Since we'll manipulate to-do tasks, we should also have a `Task` struct for keeping track of each to-do item.

Having said that, let's create our project initial template. In your local development environment, create a new Cargo project using the `cargo new` command in your terminal. The project will be called **rusty-journal**.

```sh
$ cargo new rusty-journal
     Created binary (application) `rusty-journal` package
```

In the following units we'll add our new modules, types, and functions to our program.
