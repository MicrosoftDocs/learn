The recommended way to install Rust is to use `rustup`, the Rust toolchain installer.
Go to the website [rustup.rs](https://rustup.rs?azure-portal=true) to find the appropriate instructions for your operating system.

:::image type="content" source="../media/rustup.png" alt-text="Screenshot of the rust up installer website.":::

On Linux or macOS, copy the curl command by selecting the clipboard icon. Then open your computer's terminal or command prompt to paste the command, and follow the on-screen instructions. On Windows, follow the instructions in the installer.

> [!IMPORTANT]
> Rust requires the Microsoft C++ build tools for Visual Studio 2013 or later.
> The build tools must be installed before you can install Rust.
> If you need to install the build tools, see the steps in the [previous unit](../3-install-build-tools.yml).

Rust has a six-week, rapid release process, and supports a great number of platforms, so there are many builds of Rust available at any time. If you've installed `rustup` in the past, you can update to the latest stable version of Rust by running the command `rustup update`.


## Check the Rust installation

After you complete the Rust installation, you should have the `rustc` and `cargo` commands available.

> [!NOTE]
> The following commands work on all platforms.

Run the following command in your terminal or command prompt:

```console
rustc --version
```

You should see output like this example:

```output
rustc 1.50.0 (cb75ad5db 2021-02-10)
```

Then run the following command:

```console
cargo --version
```

You should see similar output:

```output
cargo 1.50.0 (f04e7fab7 2021-02-04)
```

Both output lines contain the following information on the latest stable versions of Rust and Cargo that are available:

- The release number
- The commit hash
- The commit date

This information appears in the following format:

`<executable-name> <three-part-release-number> (<9-character-hash-code> <4-digit-year>-<2-digit-month>-<2-digit-day>)`

If you see this type of output, both installations were successful. If you don't see this information, check your `PATH` environment variable. Make sure it includes a folder that contains the `rustc.exe` and `cargo.exe` executable files.

### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check answers**.
