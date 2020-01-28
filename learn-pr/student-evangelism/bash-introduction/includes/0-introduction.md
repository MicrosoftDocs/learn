Imagine that you just started a new job as a system administrator (sysadmin) at Northwind, a high-frequency trading (HFT) firm that runs Windows on its clients and Linux on its servers. Computers are the lifeblood of the company an you need to learn more about how to manage Linux boxes. It's time to skill up.

A vital tool you must learn is Bash). The name stands for "**B**ourne **A**gain **SH**ell."

A shell is a program that commands the operating system to perform actions. You type commands into a console and execute them directly, or use scripts to execute batches of commands.  Shells such as PowerShell and Bash give system administrators the power and precision they need for fine-tuned control over the computers for which they are responsible.

While there are other Linux shells, including csh and zsh, Bash has become Linux's de facto standard. That's because Bash is compatible with Unix's first serious shell, the Bourne shell, also known as sh. Bash incorporates the best features of its predecessors. It also incorporates features of its own such as built-in commands and the ability to invoke external programs.

One reason for its success is its simplicity. Bash, like the rest of Linux, is based on the Unix design philosophy. As Peter Salus summarized in his book, A Quarter Century of Unix, three of the "big ideas" embodied in Unix are:

- Programs do one thing and do it well
- Programs work together
- Programs use text streams as the universal interface

The last part is key to understanding how Bash works. In Unix and Linux, everything is a file. That means you can use the same commands without worrying about whether the I/O stream—the input and output—comes from a keyboard, a disk file, a socket, a pipe, or another I/O abstraction.

Let's learn the basics of Bash, starting with the syntax and with commonly used commands such as `ls` and `cat`. But first, let's create a Linux VM in Azure so you have a place to practice your skills.

## Learning objectives

In this module, you will:

- Learn how to create a Linux VM in Azure
- Learn about the syntax of Bash commands
- Learn about important Bash commands, such as ls, cat, and ps
- Learn how to use I/O operators to redirect input and output
- Learn how to update a server's operating system
- Learn how to find and terminate rogue processes
- Learn how to use Bash to filter Azure CLI output
