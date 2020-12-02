The recommended way to install Rust is to use `rustup`, the Rust Toolchain Installer. Go to the website [rustup.rs](https://rustup.rs?azure-portal=true) to find the appropriate instructions for your operating system.

:::image type="content" source="../media/rustup.png" alt-text="Image of rustup installer website.":::

Copy the curl command by selecting the clipboard icon and then open up your computer's Terminal or Command Prompt to paste the command, then follow the onscreen instructions.

Rust has a **6-week rapid release process** and supports a great number of platforms, so there are many builds of Rust available at any time. So, if you've installed `rustup` in the past, you can update your installation by running the command `rustup update`.

After you've completed the installation, you should have the `rustc` and `cargo` commands available. Type the following commands in your Terminal or Command Prompt:

    $ rustc --version
    rustc 1.47.0 (18bf6b4f0 2020-10-07)

    $ cargo --version
    cargo 1.47.0 (f3c7e066a 2020-08-28)

You should see the version number, commit hash, and commit date for the latest stable version that has been released in the following format:

`rustc x.y.z (abcabcabc yyyy-mm-dd)`

If you see this information, you have installed Rust successfully! If you don't see this information and you're on Windows, check that Rust is in your `%PATH%` system variable.
