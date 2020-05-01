One of the cornerstones of the Quantum Development Kit is the quantum
programming language Q#. In this unit you are going to learn how to create a
quantum application in Q# with Visual Studio Code. This application consists of
a quantum random bit generator and it will be the base for our quantum random
number generator. The quantum random number generator uses a Hadamard gate to
put a qubit into superposition. The measurement results are random 0s or 1s.

## Create the Q# application

### Create a folder

First things first, anytime you create a quantum project it's recommendable to
create a folder to store the files. In our case we will create a new folder,
anywhere on your computer, called `MyQRNG`.

### Create a Q# project

Create a project with the Q# standalone console application template introduced
in [Unit 2](xref:learn.quantum.get-started-qdk.2-install-qdk). To do it:

        - Go to **View** -> **Command Palette**
        - Select **Q#: Create New Project**
        - Select **Standalone console application**
        - Navigate to the folder you want to store your quantum project. In our
        case we select the folder `MyQRNG` and type the name you want to use 
        for your Q# project. In our case: `Qrng`. This action will create the
        a file called `Qrng` with several files inside.
        - If you aren't already in the folder in VS Code, you can click on the
        **Open new project...** button in the VS Code pop-up, once the project has been created.
        

### Use the template to write your program

From the several files created in the `Qrng` folder we are interested in the one
called `Program.qs`. We can change the name to something more informative. In
our case let's rename the file to `my-random-bit.qs`. The Q# programming
language uses its own file format `*.qs`. This file is where the Q# code is
written to express the instructions for the quantum computer. Your
`my-random-bit.qs` file should look like something similar to this:
```qsharp
namespace Qrng {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    

    @EntryPoint()
    operation HelloQ() : Unit {
        Message("Hello quantum world!");
    }
}
```

There are several important things in this file so let's go by parts.

#### Set a namespace

In every Q# file we need a `namespace`. In the namespaces we can add quantum
operations that will be used by the compiler. In our case the template named
the namespace automatically `Qrng`.

```qsharp
namespace Qrng {

// ...
// stuff
// ...

}
```

#### Open the libraries

Q# is a modular programming language that makes extensive use of libraries. For
example, there's a Quantum Chemistry library to do quantum chemistry
calculations or a Quantum Numerics library to exploit quantum computing to
perform numerical calculations. There are several standard libraries that
include all sorts of basic operations. The template automatically opens
the `Microsoft.Quantum.Canon` and `Microsoft.Quantum.Intrinsic` libraries that
include the most basic operations of Q#.
```qsharp
namespace Qrng {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

// ...
// stuff
// ...

}
```

For our program `my-random-bit.qs` we just need and additional library,
`Microsoft.Quantum.Measurement` that contains the `MResetZ(q)` operation. To 
open it we just need to add it to the list with the `open` directive:
```qsharp
namespace Qrng {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

// ...
// stuff
// ...

}
```
#### Create the quantum operation

Operations are the basic building blocks of a Q# program. They are a set of instructions for the quantum computer to manipulate the qubit register in a specific way. To declare a Q# operation we need to specify a name for the operation and the
input and output format. In the template the operation is:
```qsharp
    operation HelloQ() : Unit {
        Message("Hello quantum world!");
    }
```
that just prints the message "Hello quantum world!". We can overwrite the
default operation with our operation. We will call the operation
`GenerateRandomBit`. It has no input and it outputs a `Result`. A `Result` in Q#
is a type that represents the result of a measurement and can have two possible
values: `One` and `Zero`. 

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;


    @EntryPoint()
    operation GenerateRandomBit() : Result {
    }
}
```
The line `@EntryPoint()` is just a pointer that the Q# compiler will use to know
where to start executing operations. Now that we have declared the operation we
can write its content:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;


    @EntryPoint()
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            H(q);               // Put the qubit to superposition. It now has a 50% chance of being measured 0 or 1.
            return MResetZ(q);  // Measure the qubit value.
        }
    }
}
```
Save the file (you can right click on the `my-random-bit.qs` file in the
explorer and click on "Save" in the contextual menu).

Let's comment here what each command is doing:

1. In Q#, to obtain a qubit we need to "ask" the computer for them with the
   block `using` in which we specify how many qubits we need and its name. In
   our case we just need one qubit. Every qubit we borrow with the command
   `using` starts by default in the `0` state.
2. We can put our qubit in a quantum superposition by applying the `H()`
   operation from the Intrinsic library. We only need to specify the target
   qubit inside the brackets.
3. After throwing our qubit in a quantum superposition we can measure the state.
   In Q#, at the end of every operation, we need to make sure that any used
   qubit is initialized back to the state `0`. We can do both operations with an
   `MResetZ` operation from the Intrinsic library. Alternatively, you can use an
   `M()`  operation followed by a `Reset()` operation from the Intrinsic
   library.
4. We return the result of our measurement, which is a random bit.

That's it! We have now a quantum program that takes a qubit, throws it into a
superposition, measures it and returns a random bit whose value depends on the
measurement result.

## Execute the Q# program

Ok, you have created a Q# quantum program, how do we execute it? The Q# program
allows us to communicate bidirectionally with the quantum computer by
manipulating the qubits and reading the measurements. 

The executable will run the operation or function marked with the
`@EntryPoint()` attribute on a simulator, resource estimator, depending on the
project configuration and command-line options.

In VS Code terminal, build the `my-random-bit.qs` the first time by typing the
below in the terminal: 
```
dotnet build
```
For subsequent runs, no need to build it again:
```
dotnet run --no-build
```
Pressing enter you should obtain the result of your measurement, either `Zero`
or `One` and therefore your quantum bit. 

In the next unit we are going to explore how we can create a complete random
number generator using the classical logic of Q#.