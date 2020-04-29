One of the cornerstones of the Quantum Development Kit is the quantum
programming language Q#. In this unit you are going to learn how to create a
quantum application in Q# with Visual Studio Code. This application consists of
a quantum random bit generator and it will be the base for our quantum random
number generator. The quantum random number generator uses a Hadamard gate to put a qubit into superposition. The measurement results are random 0s or 1s.

## Create the Q# application

### 1. Create a folder

First things first, anytime you create a quantum project it's recommendable to
create a folder to store the files. In our case we will create a new folder, anywhere on your computer, called
`MyQRNG`.

### 2. Open the folder with Visual Studio Code

In VS Code, click on "File" -> "Open Folder" and select `MyQRNG`.

### 3. Create a Q# file

The Q# programming language uses its own file format `*.qs`. This file is
where the Q# code is written to express the instructions for the quantum
computer. Let's create a `*.qs` file to write the instructions. In our case we
will call it: `my-random-bit.qs`

Go to the Q# project template introduced in [Unit 2]() and use the `Program.qs` file , where you used a Q# file to output "Hello quantum world!". Rename it to `my-random-bit.qs`. You will be modifying the code 

### 4. Set a namespace

Now let's write in our `my-random-bit.qs` file the quantum program to generate a
random bit. 

First, we need a `namespace`. In the namespaces we can add
quantum operations that will be invoked from external programs. In our case we
will call this namespace `Qrng`. 

```qsharp
namespace Qrng {

}
```

### 5. Open the libraries

Q# is a modular programming language that makes extensive
use of libraries. For example, there's a Quantum Chemistry library to do quantum
chemistry calculations or a Quantum Numerics library to exploit quantum
computing to perform numerical calculations. There are several standard
libraries that include all sorts of basic operations. 

In the case of a quantum random number generator, we only need the following libraries that includes the most basic quantum operations. We can open the library using the `open` directive:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;

}
```

### 6. Write a Q# operation and save

To declare a Q# operation we need to specify a name for the operation and the input and output format. We will call
the operation `GenerateRandomBit`. It has no input and it outputs a `Result`. A
`Result` in Q# is a type that represents the result of a measurement and can
have two possible values: `One` and `Zero`. 

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;

    operation GenerateRandomBit() : Result {
    }
}
```

Now that we have declared the operation we can write its content:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            H(q);               // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            return MResetZ(q);  // Measure the qubit value.
        }
    }
}
```

Save the file.( You can right click on the `my-random-bit.qs` file in the explorer and click on 
"Save" in the contextual menu.)

Don't worry if you don't fully understand the content of the operation, we will
explain it in more detail in the next unit. But let's comment here what each
command is doing:

1. In Q#, to obtain a qubit we need to "ask" the computer for
   them with the block `using` in which we specify how many qubits we need and
   its name. In our case we just need one qubit. Every qubit we borrow with the
   command `using` starts by default in the `0` state.
2. We can put our qubit in a quantum superposition by applying the `H()` operation
   from the Intrinsic library. We only need to specify the target
   qubit inside the brackets.
3. After throwing our qubit in a quantum superposition we can measure the state. In Q#, at the end of every operation, we need to make sure that any used qubit
   is initialized back to the state `0`. We can do both operations with an `MResetZ` operation from the Intrinsic library.
    Alternatively, you can use an `M()`  operation followed by a `Reset()` operation from the Intrinsic library.
4. We return the result of our measurement, which is a random bit.

That's it! We have now a quantum program that takes a qubit, throws it into a
superposition, measures it and returns a random bit whose value depends on the
measurement result.

## Execute the Q# program

Ok, you have created a Q# quantum program, how do we execute it? The Q# program
allows us to communicate bidirectionally (what does this mean in this case?) with the quantum computer. However, we
don't want to use the quantum computer for everything, since for most things
classical computers work just fine. We want to call the quantum computer only
when we need it, for example to make some specific type of calculations, or
in this case, to extract pure randomness. 


This is why Q# works together with
classical code. This allows us to call the quantum 
operations from inside a classical program. In this tutorial we are going to 
build a quantum radom number generator with the Q# standalone executable.

The executable will run the operation or function marked with the `@EntryPoint()` attribute on a simulator, resource estimator, depending on the project configuration and command-line options.

```qsharp
namespace Qrng {

    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    

    operation GenerateRandomBit() : Result {
            using (q = Qubit())  {  // Allocate a qubit.
            H(q);               // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            return MResetZ(q);  // Measure the qubit value.
        }    
    }
     @EntryPoint()
    operation Main() : Int {
        let max = 10;
        Message($"Random number between 0 and {max}: ");  

        let nBits = Floor(Log(IntAsDouble(max))/LogOf2() + 1.);

        mutable bits = new Result[0];
        for(bit in 1 .. nBits) {
            set bits += [GenerateRandomBit()];
        }

        let output = ResultArrayAsInt(bits); 
        return output <= max ? output | Main();
    }
}
```

In VS Code terminal, Build the Program.qs the first time by typing the below in the terminal: 
```
dotnet build
```
For subsequent runs, no need to build it again:
```
dotnet run --no-build
```

Congratulations! Now you know how to combine Q# with a host program and ran a Q# program.
