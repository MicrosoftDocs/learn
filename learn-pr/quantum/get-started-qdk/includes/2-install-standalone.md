# Install the Microsoft Quantum Development Kit (QDK)

In this unit, you will prepare your development environment to begin writing quantum programs with Microsoft's Quantum Development Kit.
The QDK consists of:

- the Q# programming language
- a set of libraries that abstract complex functionality in Q#
- APIs for Python and .NET languages (C#, F#, and VB.NET) for running quantum programs written in Q#
- tools to facilitate your development

Q# programs can be executed standalone in command line or paired with a host program written in a .NET language (typically C#) or Python.
The latter allows us to call quantum operations from inside a classical program.

The QDK is available for multiple development environments, but in this module we will use the Q# standalone executable within Visual Studio Code, as it is available for all operating systems.

Visual Studio Code (VS Code) offers a rich environment for developing Q# programs on Windows, Linux and Mac.
The Quantum Development Kit VS Code extension includes support for Q# syntax highlighting, code completion, and Q# code snippets.

## Prerequisites 

The first thing you'll need to get going is the latest version of the [.NET Core SDK 3.1](https://dotnet.microsoft.com/download). 
Open a command prompt and run the following:

```bash
dotnet --version
```

Verify the output is `3.1.100` or higher.
If not, install the [latest version](https://dotnet.microsoft.com/download) and check again.

Lastly, if you don't have it yet, [install VS Code](https://code.visualstudio.com/download).

## Install the QDK extension for VS Code

Open VS Code. 
To install the QDK extension, you either follow the link [here](https://marketplace.visualstudio.com/items?itemName=quantum.quantum-devkit-vscode) or simply find the *Extensions* tab, and search for "Quantum Development Kit".
Click the install button.

If this isn't the first time you've installed the QDK, please make sure to update it to the latest version but running this is the command line:

```bash
dotnet new -i Microsoft.Quantum.ProjectTemplates 0.11.2004.2825
```

## Verify the installation with your first quantum program!

### Create the Q# program

Install the Quantum project templates:

    - Go to **View** -> **Command Palette**
    - Select **Q#: Install project templates**

You now have the Quantum Development Kit installed and ready to use in your own applications and libraries.

 - Create a new project:

        - Go to **View** -> **Command Palette**
        - Select **Q#: Create New Project**
        - Select **Standalone console application**
        - Navigate to the location on the file system where you would like to create the application
        - Click on the **Open new project...** button in the VS Code pop-up, once the project has been created
        
    - Inspect the project

        You should see that a file called `Program.qs` created, which is a Q# program that defines a simple operation to print a message to the console.You can ignore the other files for now as they are for use with host programs.

### Run the program

        - Go to **Terminal** -> **New Terminal**
		- Enter `dotnet run`
        - You should see the following text in the output window `Hello quantum world!`


> [!NOTE]
> * Workspaces with multiple root folders are not currently supported by the Visual Studio Code extension. If you have multiple projects within one VS Code workspace, all projects need to be contained within the same root folder.

Congratulations, you just set up the QDK environment and ran your first Q# program! 
However, there hasn't been any quantum algorithm involved. The operation is simply giving an output message. 

In the next unit, you will learn more about constructing a quantum program. We will make a quantum random number generator as a demonstration.
