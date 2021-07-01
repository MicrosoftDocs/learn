To enable Windows Subsystem for Linux (WSL) on your computer, you need to:

1. Open PowerShell as an admin. On the **Start** menu, type **PowerShell** to pull up the desktop app. Right-click **Windows PowerShell** and select **Run as administrator**.

2. After the **Administrator: Windows PowerShell** command window opens, copy and paste this script to enable the WSL feature:

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```

3. Restart your computer when prompted.

## Install a Linux distribution

There are several Linux distributions available to run on WSL. You can find and install your favorite in the Microsoft Store.

In general, you want to choose a distribution that offers the software packages you need, aligns with the production environment you're targeting, and uses tools and commands that you're familiar with. For example, Ubuntu uses the `apt` command to install software, while SUSE uses `zypper` and Fedora uses `dnf`. These package managers all perform the same basic tasks in slightly different ways and offer slightly different packages for install.

*We recommend installing [Ubuntu](https://www.microsoft.com/store/p/ubuntu/9nblggh4msv6) for this course.*

1. Open Microsoft Store. (You can find it on your **Start** menu.) Enter **Linux** in the **Search** box. You'll see a list of Linux distributions in the **Apps** section. 

   The following links will open the Microsoft Store page for each of these supported Linux distributions:

   - [Ubuntu](https://www.microsoft.com/store/p/ubuntu/9nblggh4msv6)
   - [openSUSE](https://www.microsoft.com/store/apps/9njvjts82tjx)
   - [SLES](https://www.microsoft.com/store/apps/9p32mwbh6cns)
   - [Kali Linux](https://www.microsoft.com/store/apps/9PKR34TNCV07)
   - [Debian GNU/Linux](https://www.microsoft.com/store/apps/9MSVKQC78PK6)

2. On the distribution's page, select **Get**. *(Ubuntu is a fairly large download, more than 200 MB, and might take some time to install.)*

For alternative installation methods or troubleshooting, see [Windows Subsystem for Linux Installation Guide for Windows 10](/windows/wsl/install-win10).

![View of Linux distributions in Microsoft Store.](../media/store.png)


3. After the Linux distribution has installed, open it. If you miss the prompt after the install, type the name of your distro in the **Start** menu - for example *ubuntu*. You'll be prompted to create an account name and password when you run a distribution for the first time. After this first time, when you start the distribution, you'll be signed in as this normal (non-admin) user by default.

    > [!Note]
    > You can choose any user name and password. They have no bearing on your Windows user name. After you create the user account, you won't be prompted for your password when using the distribution, unless you elevate a process by using the `sudo` command. Sudo stands for "SuperUser Do" and is used for any task requiring root admin privilege, like installing tools or frameworks.

## Update your distribution

We recommend updating your Linux distribution regularly. Most Linux distributions ship with an empty or minimal package catalog. An update will ensure it has the most recent packages. Windows doesn't automatically update or upgrade your Linux distributions. Linux users typically prefer to control this task themselves.

To update your Ubuntu distribution, use the APT package manager by pasting this command into the terminal: `sudo apt update && sudo apt upgrade`. (These commands will be explained further in Unit 4.)

To enable `sudo apt install <package name>`, run this command: `sudo apt-get update`.

## Build a custom Linux distribution
You can also create your own custom Linux distribution for submission to the Microsoft Store and/or sideloading. At the end of this course, you'll find a link to instructions, an open-source WSL custom distribution sample, and the distribution launcher repo.

> [!NOTE]
> **Curious about how WSL works?**
> You might be wondering how Linux can run natively on Windows 10 without a VM or a Docker shell. Behind the scenes, you're actually running user-mode Linux, but without the Linux kernel. The syscalls (system calls) that the unmodified Linux distributions use are brokered over to Windows. It's called a "PICO process," a smaller version of a normal host process that's run using a kernel-mode driver in Windows. The operating system dependencies are essentially decoupled from the underlying host OS, keeping everything lightweight and avoiding the overhead resource cost. You can see the process running in Windows Task Manager.

## Try it yourself
In the next section, we'll take a look at how to move between the Windows and Linux file systems, perform a few basic Linux commands, move between Linux distributions, and discuss some general tips and tricks for using WSL.