PowerShell consists of two parts, a command-line shell and a scripting language. It started out as a framework you could use to automate administrative tasks in Windows but has grown to be cross-platform and used for a variety of tasks.

A command-line shell lacks a graphical interface where you would use a mouse to interact with graphical elements. Instead you are entering text commands in a computer console. The benefits from using the console are that it's often faster to interact with a console over a graphical interface. You can also run batches of commands, which makes it ideal for task automation and use in for example Continuous Integration pipelines. It can also be used to interact with cloud resources and more. Probably one of the biggest benefits of using commands and scripts are that they are something you can store in a text file and put in a version control system. The value in doing so is great as it tells you exactly what commands you've run against a system instead of having to remember what graphical elements you've interacted with, in what order, using a graphical interface.

## Features

PowerShell differentiates from a traditional command-line shell in a few ways, namely:

- **It operates on objects over text**. Using commands in a command-line shell means that you run scripts whose output and input may differ which leads you to spend time on formatting output and extracting the data you need. By using objects as input and output, it reduces the need to spend time on such tasks.
- **It has cmdlets**. PowerShell has the idea of traditional scripts but it also has another concepts of cmdlets, modules that operate on objects as inputs and that return objects in turn. These cmdlets is something you can build yourself using .NET Core, even if PowerShell comes with numerous cmdlets at install.

PowerShell also has features that it shares with traditional shells like:

- **Aliases**. Supporting aliases mean supporting the execution of commands by using an alternate name. PowerShell supports the use of common commands like `cls` (clearing screen) and `ls` (listing files). Thereby a new user can leverage the knowledge they already have instead of having to remember the PowerShell name for said commands.
- **Built-in help system**. Most shells have the idea of a help system in which you can learn more about a command, what it does and what parameters it supports and more. PowerShell has a powerful help system that not only allows you to learn more about commands but it also integrates with online help articles.
- **Pipeline**. The idea with a pipeline is to run many commands after one another and have the output of one command serve as the input for the next command in line. PowerShell has this concept implemented as well but differs as it operates on objects over text. More on that in upcoming units in this module.

## Installation

In this module, you'll practice using PowerShell on your computer. PowerShell is available cross-platform, but if you're using a computer that's running Linux, MacOS, or an older version of Windows, you'll need to install it.

Instructions for installing PowerShell are different for each OS. Before you move on, take a few minutes to install PowerShell or verify your PowerShell installation.

### Windows

If you're running Windows 8 or later, a version of PowerShell, called **Windows PowerShell**, should already be installed. There are slight differences between this version of PowerShell and the most up-to-date PowerShell release, but it will work fine for learning. 

You can launch Windows PowerShell from the Start menu.

<insert image if you want>

### Other operating systems

If your computer runs something other than Windows 8 or later, you'll need to install PowerShell. You can find the specific installation instructions for your OS, [on ther PowerShell documentation site](https://docs.microsoft.com/powershell/scripting/install/installing-powershell).


### PowerShell extension for Visual Studio Code

We recommend you use the [PowerShell extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell) to author your PowerShell scripts and to run your commands while completing this module. The advantages of using said extension is that it not only let's you run commands but also helps you with snippets, code completion, syntax highlighting and more. 

## Execution policy

There's a concept called execution policy. It governs whether you have the right to run a script or not. It does not stop you from running a command interactively. Scripts are seen as insecure. The recommendation is therefore to ensure that any scripts you run is signed by a trusted publisher.

There are cmdlets created to help you manage your execution policy, so that you can both query the current state as well as changing it to your looking, namely:

- **Get-ExecutionPolicy**. Depending on what operating system you are on it will return with different values. The values you can get from running this command is:

   - **Unrestricted**. This value is not recommended as it allows you to run scripts, whether it's created by a trusted publisher or not.
   - **Restricted**. Getting this as a response means you cannot execute scripts at all.
   - **RemoteSigned**. This response means you can run scripts if it's signed by a trusted publisher. Therefore setting this as your execution is a recommended thing to do.

- **Set-ExecutionPolicy**. This command changes the execution policy. To run it, you need to specify it with the flag **-ExecutionPolicy**

   > [!NOTE]
   > This command is not supported on all platforms. If it is supported, consider running it to ensure you don't run malicious scripts.
