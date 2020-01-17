Imagine that you just started a new job as a system administrator (sysadmin) at Northwind, a high-frequency trading (HFT) firm that runs Windows on its clients and Linux on its servers. Computers are the lifeblood of the company. You know Windows like the back of your hand, but in your new position, you need to manage Linux boxes, as well. It's time to skill up.

A vital tool you must learn is [Bash](https://wikipedia.org/wiki/Bash_(Unix_shell)). The name stands for "Bourne Again SHell." 

A shell is a program that commands the operating system to perform actions. You type commands into a console and execute them directly, or use scripts to execute batches of commands.  Shells such as [PowerShell](https://docs.microsoft.com/powershell/scripting/overview?view=powershell-6) and Bash give system administrators the power and precision they need for fine-tuned control over the computers for which they are responsible. 

While there are other Linux shells, including [csh](https://wikipedia.org/wiki/C_shell), [Korn shell](https://wikipedia.org/wiki/KornShell), and [zsh](https://wikipedia.org/wiki/Z_shell), Bash has become Linux's de facto standard. That's because Bash is compatible with Unix's first serious shell, the Bourne shell, also known as [sh](https://wikipedia.org/wiki/Bourne_shell). Bash incorporates the best features of its predecessors. It also incorporates features of its own such as built-in commands and the ability to invoke external programs.

One reason for its success is its simplicity. Bash, like the rest of Linux, is based on the Unix design philosophy. As Peter Salus summarized in his book, [A Quarter Century of Unix](https://www.amazon.com/Quarter-Century-UNIX-Peter-Salus/dp/0201547775/ref=sr_1_1), three of the "big ideas" embodied in Unix are:
- Programs do one thing and do it well
- Programs work together
- Programs use text streams as the universal interface

The last part is key to understanding how Bash works. In Unix and Linux, everything is a file. That means you can use the same commands without worrying about whether the I/O stream—the input and output—comes from a keyboard, a disk file, a socket, a pipe, or another I/O abstraction.

As [PowerShell](https://docs.microsoft.com/powershell/scripting/overview?view=powershell-6) is to Windows Server, so Bash is to Linux. Let's learn the basics of Bash, starting with the syntax and with commonly used commands such as `ls` and `cat`. But first, let's create a Linux VM in Azure so you have a place to practice your skills.

## Learning objectives

In this module, you will:

- Learn how to create a Linux VM in Azure
- Learn about the syntax of Bash commands
- Learn about important Bash commands, such as ls, cat, and ps
- Learn how to use I/O operators to redirect input and output
- Learn how to update a server's operating system
- Learn how to find and terminate rogue processes
- Learn how to use Bash to filter Azure CLI output

## Prerequisites

None