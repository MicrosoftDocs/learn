PowerShell consists of two parts: a command-line shell and a scripting language. It started out as a framework to automate administrative tasks in Windows. PowerShell has grown into a cross-platform tool that's used for many kinds of tasks.

A command-line shell lacks a graphical interface, where you use a mouse to interact with graphical elements. Instead, you type text commands into a computer console. Here are some of the benefits of using a console:

- Interacting with a console is often faster than using a graphical interface.
- In a console, you can run batches of commands, so it's ideal for task automation for continuous-integration pipelines.
- You can use a console to interact with cloud resources and other resources.
- You can store commands and scripts in a text file and use a source-control system. This capability is probably one of the biggest benefits, because your commands are repeatable and auditable. In many systems, especially government systems, everything must be traced and evaluated, or *audited*. Audits cover everything from database changes to changes done by a script.

## Features

PowerShell shares some features with traditional shells:

- **Built-in help system**: Most shells have some kind of help system, in which you can learn more about a command. For example, you can learn what the command does and what parameters it supports. The help system in PowerShell provides information about commands and also integrates with online help articles.
- **Pipeline**: Traditional shells use a pipeline to run many commands sequentially. The output of one command is the input for the next command. PowerShell implements this concept like traditional shells, but it differs because it operates on objects over text. You learn more about this feature later in this module.
- **Aliases**: Aliases are alternate names that can be used to run commands. PowerShell supports the use of common aliases such as `cls` (clear the screen) and `ls` (list the files). Therefore, new users can use their knowledge of other frameworks and don't necessarily have to remember the PowerShell name for familiar commands.

PowerShell differs from a traditional command-line shell in a few ways:

- **It operates on objects over text.** In a command-line shell, you have to run scripts whose output and input might differ, so you end up spending time formatting the output and extracting the data you need. By contrast, in PowerShell you use objects as input and output. That means you spend less time formatting and extracting.
- **It has cmdlets.** Commands in PowerShell are called cmdlets (pronounced *commandlets*). In PowerShell, cmdlets are built on a common runtime rather than separate executables as they are in many other shell environments. This characteristic provides a consistent experience in parameter parsing and pipeline behavior. Cmdlets typically take object input and return objects. The core cmdlets in PowerShell are built in .NET Core, and are open source. You can extend PowerShell by using more cmdlets, scripts, and functions from the community and other sources, or you can build your own cmdlets in .NET Core or PowerShell.
- **It has many types of commands.** Commands in PowerShell can be native executables, cmdlets, functions, scripts, or aliases. Every command you run belongs to one of these types. The words *command* and *cmdlet* are often used interchangeably, because a cmdlet is a type of command.

## Installation

In this module, you practice using PowerShell on your computer. PowerShell is available across platforms. However, if you use a computer that runs Linux, macOS, or an older version of Windows, you need to install it.

Instructions for installing PowerShell are different for each OS. Before you continue, take a few minutes to install PowerShell or to verify your PowerShell installation. The next unit in this module shows you how to verify your installation.

### Windows

If you're running Windows 8 or later, a version of PowerShell called *Windows PowerShell* should already be installed. This version differs slightly from the most up-to-date PowerShell release, but it works fine for learning purposes.

You can open Windows PowerShell from the Start menu.

### Other operating systems

If your computer runs something other than Windows 8 or later, you need to install PowerShell. To find the installation instructions for your OS, see [Install various versions of PowerShell](/powershell/scripting/install/installing-powershell?azure-portal=true).

### PowerShell extension for Visual Studio Code

We recommend that you use the [PowerShell extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell&azure-portal=true) to author your PowerShell scripts and to run the commands in this module. This extension lets you run commands, and also helps you with snippets, code completion, and syntax highlighting.