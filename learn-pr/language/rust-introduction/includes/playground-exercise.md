The Rust playground is convenient for testing small programs, trying new crates and libraries, and sharing code with others. In this exercise, we'll build a small program in the playground to become familiar with the environment.


## Write code in the playground

Let's start by writing some code for a basic program.

1. Connect to the [Rust playground][RustPlay].

1. Enter the following code in the playground editor:

   ```rust
   fn main(){println!(Welcome to Rust!);}
   ```

1. Select **Tools** > **Rustfmt** to format the code:

   :::image type="content" source="../media/rust-playground-tools.png" alt-text="Screenshot of the Tools menu in the Rust playground.":::

   The tool adjusts the code to follow official Rust styles:

   :::image type="content" source="../media/rust-playground-rustfmt.png" alt-text="Screenshot of the reformatted code in the Rust playground.":::

1. Select **Tools** > **Clippy** to check for mistakes in the code. The results are displayed under the editor:

   :::image type="content" source="../media/rust-playground-clippy.png" alt-text="Screenshot of the Clippy tool results in the Rust playground.":::

1. To fix the sample code, add quote marks around the text "Welcome to Rust!":

   :::image type="content" source="../media/rust-playground-add-quotes.png" alt-text="Screenshot of the fixed code in the Rust playground.":::


## Build and run code in the playground

Now we'll compile the code and run the program.

1. To choose how to build and run the code in the playground, open the **Run** dropdown menu at the top of the UI:

   :::image type="content" source="../media/rust-playground-run.png" alt-text="Screenshot of the Run menu in the Rust playground.":::

1. Select **Run** to build and execute the sample program. The program output is displayed under the editor:

   :::image type="content" source="../media/rust-playground-print.png" alt-text="Screenshot of the sample program output in the Rust playground.":::


## Save and share code in the playground

As you work in the playground, the code is automatically saved to the browser storage. If you close the browser window, you can lose the code that you entered. To make the code always available, you can create a shareable URL.

1. Select the **Share** feature on the toolbar to create a GitHub gist for the code in the playground:

   :::image type="content" source="../media/rust-playground-share.png" alt-text="Screenshot that shows how to use the Share feature in the Rust playground.":::

1. Select the paper icon next to the text **Permalink to the playground** to get a shareable gist for the code.

Now you can save the URL to access the code later, or share the URL for others to see the code.


<!-- Links -->

[RustPlay]: https://play.rust-lang.org/?azure-portal=true
