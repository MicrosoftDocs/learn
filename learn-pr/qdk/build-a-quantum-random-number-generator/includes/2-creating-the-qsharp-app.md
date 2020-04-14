One of the cornerstones of the Quantum Development Kit is the quantum
programming language Q#. In this unit you are going to learn how to create
a quantum application in Q# with Visual Studio Code. This application consists
on a quantum random bit generator and it will be the base for our quantum 
random number generator.

## Step 1: Create a folder

First things first, anytime you create a quantum project it's recommendable to
create a folder to store the files. In our case we will call this folder
`MyQRNG`.

## Step 2: Open the folder with Visual Studio Code

To do so, in Windows you can do right click on the folder and select "Open with
Code". Alternatively you can use the following command in the terminal:

 ```bash
 code MyQRNG
 ```

## Step 3: Create a Q# file

The Q# programming language uses its own file format `*.qs`. In this files it is
where the Q# code is written to express the instructions for the quantum
computer. Let's create a `*.qs` file to write the instructions. 
In our case we will call it: `my-random-bit.qs`

To do it you can do right click in the VS Code file explorer and select
"New File" or click in the interactive "New File" icon. Alternatively, you can
invoke the VS Code command palette by pressing `Ctrl`+`Shift`+`P`, type "new
file" and press `Enter`. 

## Step 4: Set a namespace

Now let's write in our `my-random-bit.qs` file the quantum program to 
generate a random bit. First, we need to create a `namespace`. In the namespaces
we can add quantum operations that will be invoked from external programs.
In our case we will call this namespace `Qrng`. 

```qsharp
namespace Qrng {

}
```

## Step 5: Open the libraries

The next thing that we need to do after creating the namespace is to open
all the libraries we need. Q# is a modular programming language that makes
extensive use of libraries. For example, there's a Quantum Chemistry library to
do quantum chemistry calculations or
a Quantum Numerics library to exploit quantum computing to perform numerical
calculations. There are several standard libraries that include all sort of
basic operations. In this case we only need the Intrinsic library that includes
the most basic quantum operations. We can open the library using the `open`
directive:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
}
```

## Step 6: Write a Q# operation

Now we can start to write the operation. To declare a Q# operation we need to
specify a name for the operation and the input and output format. We
will call the operation `GenerateRandomBit`. It has no input and it outputs a
`Result`. A `Result` in Q# is a type that represents the result of a measurement
and can have two possible values: `One` and `Zero`. 

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    operation GenerateRandomBit() : Result {
    }
}
```

Now that we have declared the operation we can write its content:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  { // Allocate a qubit.
            H(q);             // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            let r = M(q);     // Measure the qubit value.
            Reset(q);         // Reset the qubit to the zero state.
            return r;
        }
    }
}
```

Don't worry if you don't fully understand the content of the operation, we will
explain it in more detail in the next unit. But let's comment here what each
command is doing:
1. In Q#, to obtain qubits that we can use we need to "ask" the computer for
   them with the block `using`. In it which we specify how many qubits we need and
   their name. In our case we just need one qubit. Every qubit we borrow with the
   command `using` starts by defect in the `0` state.
2. We can put our qubit in a quantum superposition by applying the `H` operation
   from the Intrinsic library. To apply it we only need to specify the
   target qubit inside the brackets.
3. After throwing our qubit in a quantum superposition we can measure the state
   using the `M` operation from the Intrinsic library. We store the state in the 
   variable `r`.
4. In Q#, at the end of every operation we need to make sure that any qubit used
   is left in the same way we found it: in the state `0`. To do it we can
   use the `Reset(q)` operation from the Intrinsic library.
5. We return the result of our measurement, this is, a random bit.
