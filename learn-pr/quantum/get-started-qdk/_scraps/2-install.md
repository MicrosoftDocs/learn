# Install the Microsoft Quantum Development Kit (QDK)

In this unit, you will prepare your development environment to begin writing quantum programs with Microsoft's Quantum Development Kit.
The QDK consists of:

- the Q# programming language
- a set of libraries that abstract complex functionality in Q#
- APIs for Python and .NET languages (C#, F#, and VB.NET) for running quantum programs written in Q#
- tools to facilitate your development

Q# programs are often paired with a host program written in a .NET language (typically C#) or Python.
This allows us to call quantum operations from inside a classical program.

The QDK is available for multiple development environments, but in this module we will simply pair Q# and Python within Visual Studio Code, as it is available for all operating systems.

Visual Studio Code (VS Code) offers a rich environment for developing Q# programs on Windows, Linux and Mac.
The Quantum Development Kit VS Code extension includes support for Q# syntax highlighting, code completion, and Q# code snippets.

## Prerequisites 

The first thing you'll need to get going is [Python](https://www.python.org/downloads/) of course, specifically version *3.6 or later*.
In addition, you will need the [PIP](https://pip.pypa.io/en/stable/installing) Python package manager, but this tends to come with every Python install anyway. 

Next, check that you have the latest version of the [.NET Core SDK 3.1](https://dotnet.microsoft.com/download). 
Open a command prompt and run the following:

```bash
dotnet --version
```

Verify the output is `3.1.100` or higher.
If not, install the [latest version](https://dotnet.microsoft.com/download) and check again.

Lastly, if you don't have it yet, [install VS Code](https://code.visualstudio.com/download).

## Setup your system to pair Q# and Python

1. Install the `qsharp` package, a Python package that enables interoperability between Q# and Python.
In a command prompt, run

    ```bash
    pip install qsharp
    ```

1. Next, we need `iqsharp`, a kernel used by Python that provides the core functionality for compiling and executing Q# operations. 

    ```bash
    dotnet tool install -g Microsoft.Quantum.IQSharp
    dotnet iqsharp install
    ```


## Install the QDK extension for VS Code

Open VS Code. 
To install the QDK extension, you either follow the link [here](https://marketplace.visualstudio.com/items?itemName=quantum.quantum-devkit-vscode) or simply find the *Extensions* tab, and search for "Quantum Development Kit".
Click the install button.

## Verify the installation with your first quantum program!

### Create the Q# file and the host program

Within VS Code, create a file called `Operation.qs`, and add the following code to it:

```qsharp
namespace HelloWorld {
    open Microsoft.Quantum.Intrinsic;

    operation SayHello() : Result {

        using (q = Qubit()) {
            let result = M(q);
            Reset(q);
            return result;
        }
        
    }
}
```

Next, in the same VS Code workspace, create a Python program called `hello_world.py` to call the Q# `SayHello()` operation:

```python
import qsharp

from HelloWorld import SayHello

result = SayHello.simulate()

print("Hello world! Your qubit was measured in state: " + str(result))
```

Take a moment to explore these files and think about how they might work---from what's happening in each step, to how the files interact.
In particular, note that the Python host file calls the quantum operation defined in the Q# file.
Don't worry if the components of the Q# file look a little foreign, we dive into these details throughout the rest of the module!

### Run the program

Open the integrated terminal in VS Code, and run this command:

```bash
python hello_world.py
```

You should see the following output:

```bash
Hello world! Your qubit was measured in state: 0
```

Congratulations, you just ran your first quantum program! 
Specifically, you used the host program to instruct the target machine (a simulator in this case) to execute the quantum operation `SayHello`, which consisted of allocating a qubit, measuring it, and returning the result.
The result of a quantum measurement is classical data, so of course we can do with it whatever we'd like.
Here, we simply returned it to the classical host program, and printed it as output.

In the next unit, you will learn more about this behavior, and Q# files in general.


### Continue to the next unit
Insert words here
