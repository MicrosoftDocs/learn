PowerShell consists of two parts, a command-line shell and a scripting language. It started out as a framework you could use to automate administrative tasks in Windows but has grown to be cross-platform and used for a variety of tasks.

A command-line shell lacks a graphical interface where you would use a mouse to interact with graphical elements. Instead you are entering text commands in a computer console. The benefits from using the console are that it's often faster to interact with a console over a graphical interface. You can also run batches of commands, which makes it ideal for task automation and use in for example Continuous Integration pipelines. It can also be used to interact with cloud resources and more. Probably one of the biggest benefits of using commands and scripts are that they are something you can store in a text file and put in a source control system. The value of doing so is great as it gives you a repeatable set of commands and it's also auditable. For many systems out there, especially for government system it's important that everything a system does can be traced and evaluated, _audited_, whether it's changes to a database or changes done by a script.

## Features

PowerShell has features that it shares with traditional shells like:

- **Built-in help system**. Most shells have the idea of a help system in which you can learn more about a command, what it does and what parameters it supports and more. PowerShell has a powerful help system that not only allows you to learn more about commands but it also integrates with online help articles.

- **Pipeline**. The idea with a pipeline is to run many commands after one another and have the output of one command serve as the input for the next command in line. PowerShell has this concept implemented as well but differs as it operates on objects over text. More on that in upcoming units in this module.

- **Aliases**. Supporting aliases mean supporting the execution of commands by using an alternate name. PowerShell supports the use of common commands like for example `cls` (clearing screen) and `ls` (listing files). Thereby a new user can leverage the knowledge they already have instead of having to remember the PowerShell name for said commands.

PowerShell differentiates from a traditional command-line shell in a few ways, namely:

- **It operates on objects over text**. Using commands in a command-line shell means that you run scripts whose output and input may differ which leads you to spend time on formatting output and extracting the data you need. By using objects as input and output, it reduces the need to spend time on such tasks.
- **It has cmdlets**. Commands in PowerShell are called cmdlets. Unlike many other shell environments, cmdlets are built on a common runtime rather than separate executables. This provides a consistent experience in parameter parsing and pipeline behavior. Cmdlets typically take object input and return objects. The core cmdlets in PowerShell are built in .NET Core and are open source. You can extend PowerShell with additional cmdlets, scripts, and functions from the community and other sources or you could build your own in .NET Core or PowerShell.
- **Many types of commands**. Commands in PowerShell can be native executables, cmdlets, functions, scripts, or aliases. When you run a _command_, it's belongs to one of these types. It's common to use the word command and cmdlet interchangeably as a cmdlet is a type of command.

## Installation

In this module, you'll practice using PowerShell on your computer. PowerShell is available cross-platform, but if you're using a computer that's running Linux, MacOS, or an older version of Windows, you'll need to install it.

Instructions for installing PowerShell are different for each OS. Before you move on, take a few minutes to install PowerShell or verify your PowerShell installation.

### Windows

If you're running Windows 8 or later, a version of PowerShell, called **Windows PowerShell**, should already be installed. There are slight differences between this version of PowerShell and the most up-to-date PowerShell release, but it will work fine for learning.

You can launch Windows PowerShell from the Start menu.

### Other operating systems

If your computer runs something other than Windows 8 or later, you'll need to install PowerShell. You can find the specific installation instructions for your OS, [install PowerShell instructions](https://docs.microsoft.com/powershell/scripting/install/installing-powershell).

### PowerShell extension for Visual Studio Code

We recommend you use the [PowerShell extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell) to author your PowerShell scripts and to run your commands while completing this module. The advantages of using said extension is that it not only let's you run commands but also helps you with snippets, code completion, syntax highlighting and more. 

