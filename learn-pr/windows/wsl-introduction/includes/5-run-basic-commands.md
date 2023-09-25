We've already looked at a few basic WSL administrative commands, including `wsl --install` and `wsl --list --online`, as well as a few basic Linux commands, including `mkdir` to make a directory and `sudo apt install <x>` to install software, but let's explore a few more and try accomplishing some common tasks.

## Try some basic WSL commands

The WSL commands in this training are listed in a format supported by PowerShell or Windows Command Prompt (CMD). To run these commands from a Bash / Linux distribution command line, you must replace `wsl` with `wsl.exe`. This is because WSL is managed from the Windows file system as an executable file... but Windows executable files can *also* be run from Linux as long as you include the file extension.

Open a PowerShell command line and let's try a few basic WSL management tasks using the WSL admin commands:

1. Check what version of WSL you have installed, using: `wsl --version`. You'll see a version listed for:
    - WSL
    - the Linux Kernel used by WSL
    - the version for WSLg, which runs Linux GUI apps
    - the version for MSRDC, which represents the Microsoft Remote Desktop Client supporting WSL
    - the versions of Direct3D and DXCore, used for graphics rendering
    - the version of Windows that you're running

2. Use the command: `wsl --update` to ensure that we have the most recent WSL updates.

3. List the Linux distributions you currently have installed by entering: `wsl --list --verbose`.

4. Check which distributions are available via the Microsoft Store, use `wsl --list --online` and try installing a new distribution, entering: `wsl --install <Distribution Name>`. Confirm that the distribution installed using the `wsl --list` command again.

5. Try changing the default Linux distribution from Ubuntu (or whatever you first installed if not the default) to the distribution that you just installed by using the command: `wsl --set-default <Distribution Name>`. You can change it back using the same command.

6. Open your Bash command line (from the Linux distribution set as your default) to the home directory of your WSL file system by entering the command: `wsl ~` from inside PowerShell. You'll see that you remain within the same PowerShell command line window, but your prompt will change to Bash, looking something like: `<user>@<CPU-name>:~$`. Enter the command `pwd` to confirm that the directory path is now something like `/home/<username>`. Enter the command: `explorer.exe .` to open the directory in Windows File Explorer (be sure to include the period, which indicates to open the current directory path). Once open, you can confirm that the file path looks something like: `\\wsl.localhost\Ubuntu\home\<username>`.

:::image type="content" source="../media/wsl-home-command.png" alt-text="Screen capture of PowerShell terminal with wsl ~ command entered showing path.":::

7. Exit out of the Bash command line back to PowerShell using: `exit`. Use the command `pwd` again to see the path you're on now, it should be something like `C:\Users\<username>\...`. So you can see that you have switched between the Windows file system (C:\ drive) and the Linux file system (`\\wsl.localhost\<distro name>` network drive). Next let's try opening the current Windows file system directory in Bash by using the command: `wsl` without the `~` (which indicates to open Bash in the Linux home directory). You'll see that the directory path is now something like `/mnt/c/Users/<username>/...` because Bash is pointing to your Windows file system path on the mounted C-drive. The C-drive directory is mounted because you're now viewing it from inside the Linux file system. More about working between the Windows file system and Linux file system in WSL is covered in a separate training linked in the summary at the end of this module.

For a full list of commands, run `wsl --help`.

## Basic Bash and PowerShell commands

Bash is the default command line interface (CLI) for Linux. A deep-dive introduction to Bash is linked in the summary at the end of this module. PowerShell is the default command line for Windows (replacing the previous Windows Command Prompt). Both are hosted by the Windows Terminal, which can be customized to suit your preferences.

While the Bash CLI is different from the PowerShell CLI (and the older Windows Command Prompt), the differences between command lines are minimal. With WSL, most commands will work the same in both. For example, historically the command to list files in a directory was `ls` in a Bash/Linux environment and `dir` in a PowerShell/Windows environment, but with WSL, you can use either interchangeably. The utility tools available to install and use differ between Bash and PowerShell, but once installed, even these tools can be used interchangeably between the command lines. Both Bash and PowerShell are useful for authoring scripts to automate tasks, but Bash is designed to work better for automating Linux operating system tasks and PowerShell will be better for Windows operating system tasks.

Let's try a few basic Bash commands (that will work in both Bash and PowerShell). Open an Ubuntu command line (or your preferred Linux distribution) and enter these commands:

1. `pwd`: Print working directory will display the path of the current directory selected in the command line.
2. `ls` or `dir`: List the contents of the current directory. Some commands include "flags" that can modify an operation. For example, enter `ls -l` to list more details about the contents of the directory, such as it's size, owner, and last modified date. Enter `ls -a` to include ALL contents of a directory, including any hidden files. Bash will include hidden `.bash_history`, `.bash_logout`, `.bashrc` and `.profile` files that can be useful for Bash administrative tasks and customization.
3. `cd`: The change directory command must be accompanied by a bit of information indicating what you want to change the directory to. You can specify a directory name, such as `cd project-folder`, move up a directory level using `cd ..`, or change to your home directory using `cd ~`.
4. `mkdir`: Make a new directory by using this command plus the name of the new directory. For example, `mkdir new-folder`.
5. `cp`: Copy a file or directory. For example, `cp file.txt` or `cp folder-1`. Creating a copy named the same as an existing file will silently replace that file, so it's recommended to use the `-i` interactive flag, which will warn you before deleting/replacing an existing file. For example, `cp -i file.txt`.
6. `rm`: Remove a file or directory. For example, `rm file.txt`. To remove a directory in Bash, you must add the `-r` flag. For example, `rm -r folder-1`. Like the `cp` command, it's recommended to use the `-i` flag to provide prompts confirming what you intend to delete/remove. The `-f` flag forces removal, suppressing any prompts. It's generally recommended to avoid using the `-f` flag unless you're confident in what you're doing.
7. `clear`: Clear the terminal screen.

:::image type="content" source="../media/wsl-bash-commands.png" alt-text="Screen capture of Ubuntu terminal showing basic Bash commands.":::

There are a few shortcuts that work in both PowerShell and Bash as well, such as using the up-arrow to recall the most recent commands that were entered.

Now let's try a few basic Bash commands that will not work in PowerShell.

1. `sudo`: The "Super User Do" command in Bash enables you to temporarily elevate your current command line user account to have root privileges / administrator permissions. Sudo is often required for tasks such as installing new software and will require you to enter your Linux password. Sudo doesn't have an equivalent in PowerShell, rather you would need to open a separate PowerShell command line instance in Administrator mode by right-clicking and choosing "Run as administrator".
2. `touch`: The touch command creates an empty file. For example, `touch file.txt`. The equivalent in PowerShell is `New-Item file.txt` or `ni file.txt`.
3. `cat`: The concatenate command can read the contents of a file or multiple files. For example, `cat file.txt file2.txt` to show the contents of file and file2. Add the `-n` flag to include line numbers. Some commands, like `cat` behave slightly different in Bash and PowerShell. In Bash, the command `cat > file.txt` will create a new file and allow you to enter text in that file until you Ctrl+d to escape and close the file. In PowerShell, the `cat` command is not the traditional form and `cat > file.txt` won't work, however, `cat > newfile file.txt` will create a new.

We've covered a few basic commands here that can be incorporated into your workflow, in addition to a few of the similarities and differences between command lines. There are often multiple ways to run the same command, with Bash and PowerShell command lines each having their own preferred ways to go about using commands and scripts. With WSL, you can intermix Bash and PowerShell commands, and it's recommended to become familiar with both as distinct ways of automating tasks.
