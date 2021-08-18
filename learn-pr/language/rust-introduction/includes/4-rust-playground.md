The Rust playground is convenient for testing small programs, trying new crates and libraries, and sharing code with others. In this exercise, we'll build a small program in the playground to become familiar with the environment.


## Write code in the playground

Let's start by writing some code for a basic program.

1. Connect to the Rust playground: https://play.rust-lang.org/.

1. Enter the following code in the playground editor:

   ```rust
   fn main(){println!(Welcome to Rust!);}
   ```

1. Select **Tools** > **Rustfmt** to format your code to follow official Rust styles:

   :::image type="content" source="../media/rust-playground-tools.png" alt-text="Screenshot of the Tools menu in the Rust playground.":::

   The tool adjusts your code and applies recommended indentation and spacing between elements and operators:

   :::image type="content" source="../media/rust-playground-rustfmt.png" alt-text="Screenshot of the reformatted code in the Rust playground.":::


## Fix mistakes in your code

The Rust playground lets you run *lint* tests on code to find errors and areas for improvement.

1. Select **Tools** > **Clippy** to lint your code against common mistakes. The tool runs the checks and displays the results under the editor:

   :::image type="content" source="../media/rust-playground-clippy.png" alt-text="Screenshot of the Clippy tool results in the Rust playground.":::

1. To fix the sample code, add quote marks around the text "Welcome to Rust!":

   :::image type="content" source="../media/rust-playground-add-quotes.png" alt-text="Screenshot of the fixed code in the Rust playground.":::


## Build and run your code

Now we'll compile and execute the program.

1. To choose how to build and run your code in the playground, open the **Run** dropdown menu at the top of the UI:

   :::image type="content" source="../media/rust-playground-run.png" alt-text="Screenshot of the Run menu in the Rust playground.":::

   The **Run** menu has several options for building and running your code, including:

   - **Run**: Build and run your code, and show the output. The **Run** option is the same as using the `cargo run` command.
   - **Build**: Build your code, but don't run the code. The **Build** option is the same as using the `cargo build` command.
   - **Test**: Build your code, and run all the tests against the code. The **Test** option is the same as using the `cargo test` command.

1. Select **Run** to build and execute the sample program. The program output is displayed under the editor:

   :::image type="content" source="../media/rust-playground-print.png" alt-text="Screenshot of the sample program output in the Rust playground.":::


## Save and share your code

As you write programs in the Rust playground, your code is saved automatically to the local storage for your browser. This feature makes it easy to recover your most recent work, especially if you happen to close your browser window.

1. Select the **Share** feature on the toolbar to create a GitHub gist for your specific code in the playground:

   :::image type="content" source="../media/rust-playground-share.png" alt-text="Screenshot that shows how to use the Share feature in the Rust playground.":::

1. Select the paper icon next to the text **Permalink to the playground** to get a shareable gist for your code. You can save this URL to access your code later. The URL loads the gist for your specific code into the playground.

   > [!Note]
   > The local storage for a browser is a singleton resource. If you have more than one browser window open to the Rust playground, and you're working on different code in each window, only your most recently saved code across all windows is persisted in the local storage. 
