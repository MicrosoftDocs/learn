The Rust playground is a website that acts an IDE for Rust development. Anyone can access the playground. You can write your code, and then compile and run your code in the same environment. In this unit, we'll look at some of the features of the playground.

## Write code

The playground is like an IDE for the Rust language that's available on the internet. You can write and build your code, test and debug your code, and run and save your code. The following screenshot shows the playground environment. At the far right on the toolbar, the **Configure** menu has options to set your preferences for the environment.

:::image type="content" source="../media/rust-playground-main.png" alt-text="Screenshot of the Rust playground that shows code for a hello world program.":::


## Use crates in your code

In the playground, you can access methods and functions in the standard Rust libraries. The top 100 most-downloaded crates in the crates.io library are available along with their dependencies.


## Format your code

The playground features the **rustfmt** tool to format your Rust code to use official Rust styles. The tool adjusts your code to apply recommended indentation and spacing between elements and operators.

:::image type="content" source="../media/rust-playground-tools.png" alt-text="Screenshot of the Tools menu in the Rust playground.":::


## Find mistakes in your code

Most developers appreciate the ability to run *lint* tests on their code to find errors and areas for improvement. The **Clippy** collection of lints is available in the playground. You can use the Clippy collection to help find mistakes in your code and see suggestions for how to improve your code. The **Clippy** collection is available on the **Tools** menu.


## Compile your code

In the playground, you can choose to compile your Rust code for *Debugging* purposes or for full *Release*. The faster option is to compile the code for Debugging. If you choose to compile your code for full Release, the process can take longer because the compiler applies more optimizing algorithms on the code.

:::image type="content" source="../media/rust-playground-debug.png" alt-text="Screenshot of the Debug menu in the Rust playground.":::


## Build and run your code

To build and run your code in the playground, select **Run** at the top of the UI.

:::image type="content" source="../media/rust-playground-run.png" alt-text="Screenshot of the Run menu in the Rust playground.":::

The **Run** menu has several options for building and running your code. Here are a few you might use to complete the exercises in this lesson:
- **Run**: Build and run your code, and show the output. The **Run** option is the same as using the `cargo run` command.
- **Build**: Build your code, but don't run the code. The **Build** option is the same as using the `cargo build` command.
- **Test**: Build your code, and run all the tests against the code. The **Test** option is the same as using the `cargo test` command.


## Share your code

Another useful feature of the playground is the ability to share any code that you write with other users. You can select the **Share** feature on the toolbar to create a GitHub gist for your specific code in the playground. The feature also produces a *permalink* URL for the gist that you can share with others. You can also save the URL to access your code again later. The URL loads the gist for your specific code into the playground.

:::image type="content" source="../media/rust-playground-share.png" alt-text="Screenshot that shows how to use the Share feature in the Rust playground.":::


## Access your most recent code

As you write Rust programs in the playground, your code is saved automatically to the local storage for your browser. This feature makes it easy for you to recover your most recent work, especially if you happen to close your browser window.

> [!Note]
> The local storage for a browser is a singleton resource. If you have more than one browser window open to the Rust playground, only your most recently saved code is persisted in the local storage.


## Understand playground limitations

The Rust playground has some limitations that protect the site from being used in a malicious manner. The restrictions also help to ensure the site remains available for all users.

- **Network**: When you compile or run your code in the playground, a network connection isn't available.
- **Memory**: The playground limits how much memory the compiler can use to build your code, and also when you run your built program.
- **Execution time**: The playground sets a maximum amount of time to compile your code and also to run your built program.
- **Disk**: The amount of disk space that can be used to compile your code is limited, as well as when you run your built program.


You can read more about the features of the Rust playground on the [Rust website](https://play.rust-lang.org/help).


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check answers**.
