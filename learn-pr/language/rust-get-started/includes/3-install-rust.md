The recommended way to install Rust is to use `rustup`, the Rust toolchain installer. Go to the website [rustup.rs](https://rustup.rs?azure-portal=true) to find the appropriate instructions for your operating system.

:::image type="content" source="../media/rustup.png" alt-text="Screenshot of rustup installer website.":::

On Linux or macOS, copy the curl command by selecting the clipboard icon. Then open your computer's terminal or command prompt to paste the command, and follow the on-screen instructions. On Windows, follow the instructions in the installer.

Rust has a six-week, rapid release process, and supports a great number of platforms, so there are many builds of Rust available at any time. If you've installed `rustup` in the past, you can update to the latest stable version of Rust by running the command `rustup update`.

After you've completed the installation, you should have the `rustc` and `cargo` commands available. Type the following commands in your terminal or command prompt:

    $ rustc --version
    rustc 1.50.0 (cb75ad5db 2021-02-10)

    $ cargo --version
    cargo 1.50.0 (f04e7fab7 2021-02-04)

You should see the version number, commit hash, and commit date for the latest stable version that has been released. This information is in the following format:

`rustc x.y.z (abcabcabc yyyy-mm-dd)`

If you see this, you have installed Rust successfully! If you don't see this information and you're on Windows, check that Rust is in your `%PATH%` system variable.
