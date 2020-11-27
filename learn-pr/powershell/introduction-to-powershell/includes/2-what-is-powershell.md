PowerShell consists of two parts, a command-line shell and a scripting language. It started out as a framework to automate administrative tasks in Windows. It has grown into a cross-platform tool that's used for many kinds of tasks.

A command-line shell lacks a graphical interface where you would use a mouse to interact with graphical elements. Instead, you type text commands into a computer console. Here are some of the benefits of using a console:

- Interacting with a console is often faster than using a graphical interface. 
- In a console, you can run batches of commands, which makes it ideal for task automation for continuous-integration pipelines. 
- You can use a console to interact with cloud resources and other resources. 
- You can store commands and scripts in a text file and use a source-control system. This benefit is probably one of the biggest because your commands are repeatable and auditable. Many systems, especially government systems, everything must be traced and evaluated, or _audited_. Audits cover everything from database changes to changes done by a script.

## Features

PowerShell shares some features with traditional shells:

- **Built-in help system**: Most shells have some kind of help system in which you can learn more about a command. For example, you can learn what the command does and what parameters it supports. The help system in PowerShell not only provides information about commands but also integrates with online help articles.

- **Pipeline**: In traditional shells, a pipeline is used to run many commands sequentially. The output of one command is the input for the next command. PowerShell implements this concept like traditional shells do, but it differs because it operates on objects over text. You'll learn more about this feature later in this module.

- **Aliases**: Aliases are alternate names that can be used to run commands. PowerShell supports the use of common aliases such as `cls` (clear the screen) and `ls` (list files). So new users can use their knowledge of other frameworks and don't necessarily have to remember the PowerShell name for familiar commands.

PowerShell differs from a traditional command-line shell in a few ways:

- **It operates on objects over text**: In a command-line shell, using commands means that you run scripts whose output and input might differ. So you spend time on formatting output and extracting the data you need. Using objects as input and output reduces the need to spend time on such tasks.
- **It has cmdlets**: Commands in PowerShell are called cmdlets. Unlike many other shell environments, cmdlets are built on a common runtime rather than separate executables. This provides a consistent experience in parameter parsing and pipeline behavior. Cmdlets typically take object input and return objects. The core cmdlets in PowerShell are built in .NET Core and are open source. You can extend PowerShell with additional cmdlets, scripts, and functions from the community and other sources or you could build your own in .NET Core or PowerShell.
- **It has many types of commands**: Commands in PowerShell can be native executables, cmdlets, functions, scripts, or aliases. When you run a _command_, it's belongs to one of these types. It's common to use the word command and cmdlet interchangeably as a cmdlet is a type of command.

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

