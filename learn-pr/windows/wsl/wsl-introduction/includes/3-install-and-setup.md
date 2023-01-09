Windows Subsystem for Linux is included by default with Windows, but must be enabled before installing a Linux distribution. This unit will cover how you can enable WSL, install Linux distributions, and set up a Linux username and password.

> [!IMPORTANT]
> You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command.

## WSL install command

You can now install everything you need to run WSL by entering a single command, `wsl --install`, in an administrator PowerShell or Windows Command Prompt and then restarting your machine.

There are a few things to know about what this command accomplishes and the options that it provides.

You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command. [Check for updates](ms-settings:windowsupdate). If you're running an earlier build of Windows and can't update, see the docs linked at the end of this training on how to manually enable WSL and install a Linux distribution.

The `wsl --install` command performs the following actions:

- Enables WSL and Virtual Machine Platform components that are included by default with Windows.
- Downloads the WSL package from the Microsoft Store, enabling updates and security fixes to be pushed as they become available.
- Downloads and installs the latest Linux kernel, setting WSL 2 as the default architecture.
- Downloads and installs the Ubuntu distribution of Linux.

To use the install command:

1. Open PowerShell or Windows Command Prompt in administrator mode by right-clicking and selecting "Run as administrator".

2. Enter the command: `wsl --install`

3. You'll need to restart your machine following this installation process to begin using WSL.

## Install alternative Linux distributions

The `wsl --install` command installs the Ubuntu distribution of Linux by default. You can select a different Linux distribution from the list available in the Microsoft Store. You can also install additional Linux distributions after installing the default Ubuntu.

To see what distributions are currently available via the store, enter the command: `wsl --list --online`

To select an alternative to the default Ubuntu distribution, or to install additional distributions from the store, use the command: `wsl --install --distribution <Distribution Name>`

If a Linux distribution that you want to install isn't available via the Microsoft Store, you can still install it by importing using a `.tar` file or `.appx` file. You can also build your own custom distribution. You can find a link at the end of this training to documentation on how to import or build a custom Linux distribution. For beginners, we recommend starting with the default Ubuntu distribution, which will also make it easier to follow along with the training.

> [!NOTE]
> For advanced-level WSL users, there are some additional options that can be set using flags on the `wsl --install` command. For business or enterprise users, there are options for creating a custom WSL image for distribution in your company. There is also the option to install WSL from a CDN rather than the Microsoft Store package if, for example, access to the store is blocked. As well as the option to enable the older WSL 1 architecture if you have a specific scenario that requires it. The `wsl --install` command is also supported on Windows Server 2019 (version 1709) or later, with options not to automatically launch the distribution after install or to enable WSL components without installing any distribution at all. See the documentation linked at the end of the module.

## Set up your Linux username and password

Once you've used WSL to install a Linux distribution and restarted your machine, the distribution will open and you'll be asked to "Enter a new UNIX username", along with a password. There are a few things to note here:

- This username and password will be considered the Linux administrator, with the ability to run sudo (Super User Do) administrative commands.
- This user account is specific to each separate Linux distribution that you install and has no bearing on your Windows username. If you install more than one Linux distribution, each will have its own separate Linux user accounts and passwords. You'll have to configure a new username and password every time you add a distribution, reinstall, or reset.
- The username and password will accept almost anything as valid, but some characters may cause trouble in various contexts. Punctuation like underscores is generally okay, but periods, slashes, or colons, such as `/:.` may cause trouble and you should definitely not begin your username with the `-` hyphen/minus character. We generally recommend to strip out unusual punctuation. You should also note that while entering the password, nothing will appear on the screen (this is normal and called "blind typing").
- If you need to change or reset your password, or if you forget the password for a Linux distribution that you've installed, see the WSL documentation linked at the end of this module.

Once you've entered a username and password, you can confirm the Linux distribution you've installed and the version number using the command: `cat /etc/os-release`.

## Find and open your newly installed Linux distribution

You can now find the Linux distribution that you've installed using Windows search. It will be listed according to the distribution name--Ubuntu (for example).

Beginning October 2022 in Windows 11 (version 22H2), Windows Terminal is the default command line host. So when you open your Linux distribution, you'll see it open as a tab inside Windows Terminal. You can learn more about how to customize your Linux distribution's command line (BASH), including the default startup behavior, starting directory, tab title, appearance (text size, font, colors, etc), by visiting the Windows Terminal documentation. A link will be provided at the end of this training.

Whenever a new WSL Linux distribution is installed, a new instance will be created for it inside the Windows Terminal that can be customized to your preferences.

## Update and upgrade packages

We recommend you frequently update and upgrade the packages included with the Linux distribution once installed. Updating regularly will ensure you have the latest security updates. Windows doesn't automatically update or upgrade your Linux distribution(s). This is a task most Linux users prefer to control themselves. Each distribution has associated package managers to handle this. For Ubuntu or Debian, the package manager included is called "apt" (for Advanced Package Tool).

To update and upgrade packages for the default Ubuntu distribution using apt:

1. Open Ubuntu (you can find it in the Windows search menu once it's been installed).
2. Enter the command: `sudo apt update && upgrade`
3. Updating and upgrading packages requires elevated "sudo" (superuser do) permissions, so you'll also need to enter the password that you created for the Linux distribution.

It's best to run both commands. The `update` command updates the list of available packages and their versions, but doesn't install or upgrade any packages. The `upgrade` command installs newer versions of the packages you've installed. It is recommended to run update first (or at the same time as in the combined command above) so that your package manager is aware of available updates for the software you have installed.
