On your own Linux computer, you can run Bash commands locally. If you have access to Linux servers, you can remote in to them and run Bash commands there. But nobody wants to experiment on a live production system, particularly on their first day at Northwind.

In this unit, you'll use Azure Cloud Shell on the right as your Linux terminal. Azure Cloud Shell is a shell you can access through the Azure portal or at <https://shell.azure.com>. You don't have to install anything on your PC or laptop to use it.

## Familiarize yourself with Cloud Shell

First, let's explore what's in Cloud Shell by using the Bash commands we've learned.

1. Use the `ls` command to list all files and subdirectories in the current directory:

    ```bash
    ls
    ```

1. You should see output that looks similar to this:

    ```output
    yourname@Azure:~$ ls
    clouddrive
    ```

    **clouddrive** is a subdirectory of your current directory. It's a mounted file share that persists if you're using Cloud Shell on your own account. Right now, you're using it on the Microsoft Learn sandbox.

1. But wait, what *is* the current directory? Let's use the `pwd` command to find out. `pwd` stands for "print working directory." It prints out the long-form path to what directory you're in now.

    ```bash
    pwd
    ```

1. You should see an output like this:

    ```output
    yourname@Azure:~$ pwd
    /home/yourname
    ```

    This output means that you're in a directory called **yourname** within a directory called **home**, at the root of the Linux file system.

1. There doesn't appear to be much in our current directory. Let's use a Bash *flag* to print all hidden files and directories to double check that's correct.

    ```bash
    ls -a
    ```

1. Whoa! That output showed us a lot more stuff in this directory than we initially thought.

    ```output
    yourname@Azure:~$ ls -a
    .  ..  .azure  .bash_history  .bash_logout  .bashrc  clouddrive  .profile  .tmux.conf  .viminfo
    ```

1. What were all of those files and subdirectories? Some are behind-the-scenes files to make Cloud Shell work. Let's discuss a few of the others.

    - `.` refers to your current directory, and `..` refers to your parent directory. Wherever you are, if you print all hidden files and directories, you'll see `.` and `..` printed.
    - `.bash_history` is a special Bash file where all commands that you enter into the shell are stored. Bash remembers your command history, which, as we'll see later, is useful.
    - `.bash_logout` is another special Bash file that is read and run every time a login shell exists. Linux superusers can modify it to customize your environment.
    - `.bashrc` is an important Bash configuration file that runs whenever you start a new shell. If you decide to open this file to look at it, be careful about making changes, because they can have unintended consequences.

## Recall your history and autocomplete commands

When you're entering complicated commands like this one, it's easy to make a mistake:

```bash
ls -a .azure/commands/202?*.log
```

Fortunately, Bash offers a couple pieces of functionality to help you.

### Recalling previous commands

1. Try entering this command that has a typo (`203?` instead of `202?`):

    ```bash
    ls -a .azure/commands/203?*.log
    ```

1. You should see this output letting you know that there weren't any files that matched that pattern:

    ```output
    ls: cannot access '.azure/commands/203?*.log': No such file or directory
    ```

1. Rather than entering the whole thing again to correct your mistake, you can recall previously entered commands by using the **Up arrow** and **Down arrow** keys. Try using the **Up arrow** key to bring back your incorrect command. Then use the **Left arrow key** to fix it by replacing the final `3` with a `2`. Select **Enter** again to submit the corrected command.

    Using the **Up arrow** key multiple times in a row will move you back multiple commands. Use the **Down arrow** key to move to later commands.

1. Now you should see something like the following output. It lets you know that your command worked correctly to list files that matched the given pattern.

    ```output
    .azure/commands/2020-01-29.21-56-35.login.103.log
    .azure/commands/2020-01-29.21-56-38.account_set.112.log
    ```

### Autocompletion

Let's say you want to read the contents of one of the files that you just found. You can use the `cat` (short for "catenate") command to print the contents of a file to the screen.

1. To use this command, you could use the full file name, such as:

    ```bash
    cat .azure/commands/2020-01-29.21-56-35.login.103.log
    ```

1. But that's a lot to type, and very error prone. Instead, you can use Bash's rudimentary autocompletion to do most of the work for you. Try typing:

    ```bash
    cat .a
    ```

    Then select the **Tab** key. What happens?

1. You should see the rest of the word "azure/" appear in your command:

    ```bash
    cat .azure/
    ```

    Keep typing the beginnings of words and using **Tab** to autocomplete. Keep in mind that if there's an ambiguity, Bash will not fill in anything. You can select **Tab** twice to have Bash print out all the files and directories in a given path that match the letters you've typed already.

1. Play around until you've gotten to a real **.log** file in the command directory. Then select **Enter** to use the `cat` command to print its contents to screen. It might look something like this:

    ```output
    CMD-LOG-LINE-BEGIN 103 | 2020-01-29 21:56:35,426 | INFO | az_command_data_logger | command args: login --identity
    CMD-LOG-LINE-BEGIN 103 | 2020-01-29 21:56:37,604 | INFO | az_command_data_logger | exit code: 0
    ```

    Keep in mind that if you've typed an incorrect letter already, Bash will not be able to correctly guess what letter you meant to type.

## Use `man`

We just used the `cat` command, but you don't know much about it yet. Practice `man` to bring up more information about the `cat` command.

1. Enter the following command to understand more about what `cat` is and how to use it:

    ```bash
    man cat
    ```

    Yes, you entered "man cat" into your shell. Bash commands can be both cryptic and amusing!

1. You should see an output like this:

    ```output
    CAT(1)                                       User Commands                                       CAT(1)

    NAME
           cat - concatenate files and print on the standard output

    SYNOPSIS
           cat [OPTION]... [FILE]...

    DESCRIPTION
           Concatenate FILE(s) to standard output.

           With no FILE, or when FILE is -, read standard input.

           -A, --show-all
                  equivalent to -vET

           -b, --number-nonblank
                  number nonempty output lines, overrides -n

           -e     equivalent to -vE

    ...
    ```

1. Use up and down arrows to scroll through the manual page, and enter `q` to exit.

## Change directories

Let's practice one more basic Bash command: `cd`.

While using the shell, you're always sitting inside a directory—just like a folder on your PC or Mac. To change folders, you use the `cd` (change directory) command.

It's simple, but let's get some practice.

1. First, enter this command to make sure you're in the right place:

    ```bash
    cd ~
    ```

   This command moved you back to your special **home** directory in the shell, if you weren't already there.

1. Double check by using the `pwd` command one more time:

    ```bash
    pwd
    ```

1. You should see an output like this:

    ```output
    /home/yourname
    ```

    `~` is another special character in Bash that refers to this home directory. You can use `~` to refer to the location **/home/yourname** no matter where you are in the shell.

1. Let's change to the directory that holds log files (where we were earlier):

    ```bash
    cd .azure/commands/
    ```

    You can either enter the full command yourself, or use **Tab** to autocomplete.

    Now you should see that the line where you enter commands looks different, showing you where you are in the shell:

    ```output
    yourname@Azure:~/.azure/commands$
    ```

1. Try using the special `..` syntax to move up one directory:

    ```bash
    cd ..
    ```

   Now you should be one level up in the directory structure, and your command line should look like this:

    ```output
    yourname@Azure:~/.azure$
    ```

Great work! You've taken your first steps to being a Bash expert. Let's keep learning.
