Sometimes you want to try a piece of Rust code, confirm a method in a Rust library, or quickly share some code with others. It's convenient to have a tool for these tasks, so you don't have to write a full program in a standalone development environment. The Rust language offers tools to support these tasks in the Rust playground.

The Rust playground is a website that acts an IDE for Rust development. You can write your code, and then compile and run your code in the same environment. In this exercise, we'll use some of the features of the playground.


## Access the Rust playground

The Rust playground is available on the internet at `https://play.rust-lang.org/`. Anyone can access the playground.
- Connect to the playground: https://play.rust-lang.org/.

## Write code

The playground is like an IDE for the Rust language that's available on the internet. You can write and build your code, test and debug your code, and run and save your code. The following screenshot shows the playground environment. At the far right on the toolbar, the **Configure** menu has options to set your preferences for the environment.

:::image type="content" source="../media/rust-playground-main.png" alt-text="Screenshot of the Rust playground that shows a basic program.":::

- Enter the following code into the playground editor:

   ```rust
   fn main(){println!(Welcome to Rust!);}
   ```

## Format your code

The playground features the **rustfmt** tool to format your Rust code to use official Rust styles. The tool adjusts your code to apply recommended indentation and spacing between elements and operators.

:::image type="content" source="../media/rust-playground-tools.png" alt-text="Screenshot of the Tools menu in the Rust playground.":::

- Select **Tools** > **Rustfmt** to format your code. The tool applies the standard Rust styles to your code and refreshes the display:

   :::image type="content" source="../media/rust-playground-rustfmt.png" alt-text="Screenshot of the reformatted code in the Rust playground.":::


## Use crates in your code

In the playground, you can access methods and functions in the Rust `std` standard library. The top 100 most-downloaded crates in the crates.io library are also available along with their dependencies. In the exercises for the Rust lessons, we'll use several Rust libraries and crates.

Our sample program uses the `println!` macro function to print some text. This functionality is available in a library that's loaded by default in the playground. Preloaded libraries mean you don't have to add extra code to use functionality from a library.


## Find mistakes in your code

Most developers appreciate the ability to run *lint* tests on their code to find errors and areas for improvement. The **Clippy** collection of lints is available in the playground. You can use the Clippy collection to help find mistakes in your code and see suggestions for how to improve your code.

1. Select **Tools** > **Clippy** to check for mistakes in the sample code. The tool runs the checks and displays the results under the editor.

   :::image type="content" source="../media/rust-playground-clippy.png" alt-text="Screenshot of the Clippy tool results in the Rust playground.":::

1. To fix the sample code, we need to add quote marks around the text, "Welcome to Rust!" In the editor, add the quote marks.

   :::image type="content" source="../media/rust-playground-add-quotes.png" alt-text="Screenshot of the fixed code in the Rust playground.":::


## Compile your code

In the playground, you can choose to compile your Rust code for *debugging* purposes or for full *release*. The faster option is to compile the code for debugging. If you choose to compile your code for full release, the process can take longer because the compiler applies more optimizing algorithms on the code.

:::image type="content" source="../media/rust-playground-debug.png" alt-text="Screenshot of the Debug menu in the Rust playground.":::


## Build and run your code

Now we'll compile and execute the sample program in the playground.

1. To choose how to build and run your code in the playground, open the **Run** dropdown menu at the top of the UI.

   :::image type="content" source="../media/rust-playground-run.png" alt-text="Screenshot of the Run menu in the Rust playground.":::

   The **Run** menu has several options for building and running your code. Here are a few you might use to complete the exercises in this lesson:
   - **Run**: Build and run your code, and show the output. The **Run** option is the same as using the `cargo run` command.
   - **Build**: Build your code, but don't run the code. The **Build** option is the same as using the `cargo build` command.
   - **Test**: Build your code, and run all the tests against the code. The **Test** option is the same as using the `cargo test` command.

1. Select **Run** to build and execute the sample program. Any output from the program is displayed under the editor:

   :::image type="content" source="../media/rust-playground-print.png" alt-text="Screenshot of the sample program output in the Rust playground.":::


## Share your code

Another useful feature of the playground is the ability to share any code that you write with other users.

- Select the **Share** feature on the toolbar to create a GitHub gist for your specific code in the playground.

   :::image type="content" source="../media/rust-playground-share.png" alt-text="Screenshot that shows how to use the Share feature in the Rust playground."::: 

   The feature also produces a *permalink* URL for the gist that you can share with others. You can also save the URL to access your code again later. The URL loads the gist for your specific code into the playground.


## Access your most recent code

As you write Rust programs in the playground, your code is saved automatically to the local storage for your browser. This feature makes it easy to recover your most recent work, especially if you happen to close your browser window.

> [!Note]
> The local storage for a browser is a singleton resource. If you have more than one browser window open to the Rust playground, and you're working on different code in each window, only your most recently saved code across all windows is persisted in the local storage. 


## Understand playground limitations

The Rust playground has some limitations that protect the site from being used in a malicious manner. The restrictions also help to ensure the site remains available for all users.

- **Network**: When you compile or run your code in the playground, a network connection isn't available.
- **Memory**: The playground limits the available memory to compile your code and run your built program.
- **Execution time**: The playground sets a maximum amount of time to compile your code and also to run your built program.
- **Disk**: The amount of available disk space to compile your code and run your built program is limited.


You can read more about the features of the Rust playground on the [Rust website](https://play.rust-lang.org/help?azure-portal=true).


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check answers**.
