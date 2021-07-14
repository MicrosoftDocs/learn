The recommended way to install Rust is to use `rustup`, the Rust toolchain installer.
Go to the website [rustup.rs](https://rustup.rs?azure-portal=true) to find the appropriate instructions for your operating system.

:::image type="content" source="../media/rustup.png" alt-text="Screenshot of the rust up installer website.":::

On Linux or macOS, copy the curl command by selecting the clipboard icon. Then open your computer's terminal or command prompt to paste the command, and follow the on-screen instructions. On Windows, follow the instructions in the installer.

> [!Note]
> Rust requires the Microsoft C++ build tools for Visual Studio 2013 or later. The build tools must be installed before you can install Rust. If you need to install the build tools, see the steps in the [Prerequisites](#prerequisites) section.

Rust has a six-week, rapid release process, and supports a great number of platforms, so there are many builds of Rust available at any time. If you've installed `rustup` in the past, you can update to the latest stable version of Rust by running the command `rustup update`.


## Prerequisites

Rust requires the Microsoft C++ build tools for Visual Studio 2013 or later. These build tools must be installed before you can install Rust.

If you don't have the build tools installed, follow these steps:

1. Go to the [Microsoft Visual Studio download page](https://visualstudio.microsoft.com/visual-cpp-build-tools/?azure-portal=true).

1. Select **Download Build Tools**.

1. After the download completes, run the installer file. The Visual Studio Installer window opens.

1. In the popup dialog, select **Yes**. In the next popup dialog, select **Continue**.

1. In the Installer window, under **Desktop & Mobile**, select the checkbox for the **C++ build tools** option on the left. 

1. In the Installation details pane on the right, make sure the following options are selected:

   :::image type="content" source="../media/install-visual-cpp-build-tools.png" alt-text="Screenshot that shows the options to install with the Visual C plus plus build tools." lightbox="../media/install-visual-cpp-build-tools-large.png":::

1. At the bottom right, select **Install**.

After the installation completes, you can continue with the Rust installation.


## Check the Rust installation

After you complete the Rust installation, you should have the `rustc` and `cargo` commands available.

> [!Note]
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
