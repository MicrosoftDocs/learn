Windows Subsystem for Linux (WSL) must be enabled and a distribution of Linux must be installed before you can run Linux commands and access tools like Bash. This unit will cover how you can enable WSL, install Linux distributions, and set up a Linux username and password.

> [!IMPORTANT]
> You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command.

## WSL install command

You can now install everything you need to run WSL by entering a single command, `wsl --install`, in an administrator PowerShell or Windows Command Prompt and then restarting your machine.

There are a few things to know about what this command accomplishes and the options that it provides.

You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command. You can [check the version of Windows you are currently running and update to a new version](ms-settings:windowsupdate) if necessary. If you're running an older build of Windows and can't update, see the docs linked at the end of this training on how to manually enable WSL and install a Linux distribution.

:::image type="content" source="../media/wsl-install.png" alt-text="Screenshot of PowerShell with wsl install command entered.":::

The `wsl --install` command performs the following actions:

- Enables the Virtual Machine Platform Optional Component and installs the WSL core binaries.
- Downloads the WSL package (including the latest Linux kernel) from the Microsoft Store, enabling updates and security fixes to be pushed as they become available.
- Downloads and installs the Ubuntu distribution of Linux (unless you use one of the command options to elect a different distribution).

To use the install command:

1. Open PowerShell or Windows Command Prompt in administrator mode by right-clicking and selecting "Run as administrator".

2. Enter the command: `wsl --install`

3. You'll need to restart your machine following this installation process to begin using WSL.

## Install alternative Linux distributions

The `wsl --install` command installs the Ubuntu distribution of Linux by default. You can select a different Linux distribution from the list available in the Microsoft Store. You can also install additional Linux distributions after installing the default Ubuntu.

To see what distributions are currently available via the store, enter the command: `wsl --list --online`

:::image type="content" source="../media/wsl-list.png" alt-text="Screenshot of PowerShell with wsl list online command display of Linux distributions available in the Microsoft Store.":::

To select an alternative to the default Ubuntu distribution, or to install additional distributions from the store, use the command: `wsl --install --distribution <Distribution Name>`

If a Linux distribution that you want to install isn't available via the Microsoft Store, you can still install it by importing using a `.tar` file or `.appx` file. You can also build your own custom distribution. You can find a link at the end of this training to documentation on how to import or build a custom Linux distribution. For beginners, we recommend starting with the default Ubuntu distribution, which will also make it easier to follow along with the training.

> [!NOTE]
> For advanced-level WSL users, there are some additional options that can be set using flags on the `wsl --install` command. See the WSL documentation linked at the end of this training to learn more.
> - If access to the Microsoft Store is blocked, WSL can be installed from a CDN instead.
> - The `wsl --install` command is supported on Windows Server with options not to automatically launch the distribution after install or to enable WSL components without installing any distribution at all. *(Only on Windows 2019 version 1709 or newer).*
> - Linux distributions can be installed with WSL 1 architecture if you have a specific scenario that requires it.
> - Business or enterprise users, can create a custom WSL image for distribution in your company.

## Set up your Linux username and password

Once you've used WSL to install a Linux distribution and restarted your machine, the distribution will open and you'll be asked to "Enter a new UNIX username", along with a password.

:::image type="content" source="../media/wsl-username.png" alt-text="Screenshot of PowerShell with wsl installing the OpenSUSE distribution of Linux then asking for a username and password.":::

There are a few things to note here:

- The username and password created here will be considered the Linux administrator, with the ability to run sudo (Super User Do) administrative commands.
- Each user account is specific to each separate Linux distribution that you install and has no bearing on your Windows username. If you install more than one Linux distribution, each will have its own separate Linux user accounts and passwords. You'll have to configure a new username and password every time you add a distribution, reinstall, or reset.
- The username and password will accept almost anything as valid, but some characters may cause trouble in various contexts. Punctuation like underscores is generally okay, but periods, slashes, or colons, such as `/:.` may cause trouble and you should definitely not begin your username with the `-` hyphen/minus character. We generally recommend striping out unusual punctuation. You should also note that while entering the password, nothing will appear on the screen (this is normal and called "blind typing").
- If you need to change or reset your password, or if you forget the password for a Linux distribution that you've installed, see the WSL documentation linked at the end of this module.

Once you've entered a username and password, you can confirm the Linux distribution you've installed and the version number using the command: `cat /etc/os-release`.

## Find and open your newly installed Linux distribution

You can now find the Linux distribution that you've installed using Windows search. It will be listed according to the distribution name--Ubuntu (for example).

Beginning October 2022 in Windows 11 (version 22H2), Windows Terminal is the default command line host. So when you open your Linux distribution, you'll see it open as a tab inside Windows Terminal. You can learn more about how to customize your Linux distribution's command line (BASH), including the default startup behavior, starting directory, tab title, appearance (text size, font, colors, etc.), by visiting the Windows Terminal documentation. A link will be provided at the end of this training.

Whenever a new WSL Linux distribution is installed, a new instance will be created for it inside the Windows Terminal that can be customized to your preferences.

## Update and upgrade packages

We recommend you frequently update and upgrade the packages included with the Linux distribution once installed. Updating regularly will ensure you have the latest security updates. Windows doesn't automatically update or upgrade your Linux distribution(s). This is a task most Linux users prefer to control themselves. Each distribution has associated package managers to handle this. For Ubuntu or Debian, the package manager included is called "apt" (for Advanced Package Tool).

To update and upgrade packages for the default Ubuntu distribution using apt:

1. Open Ubuntu (you can find it in the Windows search menu once it's been installed).
2. Enter the command: `sudo apt update && upgrade`
3. Updating and upgrading packages requires elevated "sudo" (superuser do) permissions, so you'll also need to enter the password that you created for the Linux distribution.

It's best to run both commands. The `update` command updates the list of available packages and their versions, but doesn't install or upgrade any packages. The `upgrade` command installs newer versions of the packages you've installed. It is recommended to run update first (or at the same time as in the combined command above) so that your package manager is aware of available updates for the software you have installed.
