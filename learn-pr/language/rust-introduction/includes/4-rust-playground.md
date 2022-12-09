Sometimes you just want to try a bit of Rust code or check syntax for a definition in a Rust library. You might also be looking for a way to quickly share some code with others. The Rust language offers support for these tasks in the Rust playground.

The playground is an IDE for Rust development that's available on the internet at `https://play.rust-lang.org/`. Anyone can access the playground. You can write your code, and then compile and run your code in the same environment. The following screenshot shows the playground environment. At the far right on the toolbar, the **CONFIG** menu has options to set your preferences for the environment.

:::image type="content" source="../media/rust-playground-main.png" alt-text="Screenshot of the Rust playground that shows a basic program.":::

In the playground, you can access methods and functions in the Rust `std` standard library. The top 100 most-downloaded crates in the `crates.io` library are also available along with their dependencies.


## Tools and features

The Rust playground has several built-in tools and development features:

- Format code: The **Rustfmt** tool formats code to follow official Rust styles. The tool adjusts the code and applies recommended indentation and spacing between elements and operators.
- Test code: The **Clippy** tool checks for mistakes in the code. The tool runs *lint* tests on code to find errors and areas for improvement.
- Save code: As you work in the Rust playground, your code is saved automatically to the local storage for your browser. This feature makes it easy to recover your most recent work, especially if you happen to close your browser window.
- Share code: The **Share** feature creates a shareable GitHub gist for the code in the playground. You can save this URL to access your code later. The URL loads the gist for your specific code into the playground.
   > [!Note]
   > The local storage for a browser is a singleton resource. If you have more than one browser window open to the Rust playground, and you're working on different code in each window, only your most recently saved code across all windows is persisted in the local storage. 


## Build options

There are several options for building and running code in the Rust playground:

- **Run**: Build and run your code, and show the output. The **Run** option is the same as using the `cargo run` command.
- **Build**: Build your code, but don't run the code. The **Build** option is the same as using the `cargo build` command.
- **Test**: Build your code, and run all the tests against the code. The **Test** option is the same as using the `cargo test` command.


## Protection limits

There are some limitations in the playground that protect the site from being used in a malicious manner. The restrictions help to ensure the site remains available for all users.

- **Network**: When you compile or run code in the playground, a network connection isn't available.
- **Memory**: The playground limits the available memory to compile code and run a built program.
- **Execution time**: The playground sets a maximum amount of time to compile code and run a built program.
- **Disk**: The amount of available disk space to compile code and run a built program is limited.

You can read more about the features of the Rust playground on the [Rust website](https://play.rust-lang.org/help?azure-portal=true).


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.
