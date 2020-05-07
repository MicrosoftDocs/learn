TODO: IDEA: Use the project code to drive discussion of quantum computing. Say how QC is a huge field and this is a basic way to get started.

In this part, you'll learn how _superposition_ can help you create a quantum random number generator.

You're likely already familiar with the concept of a random number generator (RNG). An RNG is a perfect introduction to quantum computing because it illustrates quantum behavior and requires only a few lines of code.

On classical computers, most random number generators don't produce truly random numbers, but rather _pseudorandom_ numbers. A pseudorandom number generator generates the same sequence of numbers based on some initial value, called a _seed_. To better approximate random values, this seed is often the current time from the CPU's clock.

TODO: First, let's define some terms, then... To help understand TODO, we'll look at the (TODO problem) in three ways: SP, SC, and the BS.

## What is a qubit?

TODO: A basic unit of quantum information, analogous to a bit in classical computing. For more information, see The Qubit.

## What is superposition?

The concept in quantum computing that a qubit is a linear combination of two states, $\ket{\0}$ and $\ket{\1}$, until it is measured. For more information, see What is quantum computing.

## What is Schrödinger's cat?

One of the most direct applications of quantum devices is the generation of
verified random numbers. We can perform measurements on quantum systems to
obtain pure random values.

![A conceptual image of Schrodinger's cat](../media/cat.png) 

In Schrödinger's cat thought experiment, if we open the box to check if the cat
is dead or alive, the quantum state of the cat randomly collapses into one of
the two classical states. Since the state of the cat can be encoded with a
single bit (0 -> Alive, 1 -> Dead), when we open the box we're generating a
random bit.

We can encode any random integer or float into a bit-string, depending on the
number of decimals and size of our number. Therefore, to generate pure random
numbers we just need to generate many pure random bits.

In real life, cats can't be put in a quantum superposition (and of course we
don't want to possibly kill many cats to generate a random number). However, the
basic elements of quantum computers, the qubits, can be driven to a quantum
superposition and measured like when we open the cat's box.

## What is the Bloch sphere?

(Was: Understand the Q# operation with the Bloch sphere)

Let's illustrate how to obtain a random bit with a qubit in a quantum computer
using the Bloch sphere.

In the Bloch sphere, the north pole represents the classical value **0** and the
south pole represents the classical value **1**. Any superposition can be
represented by a point on the sphere (represented by an arrow). The closer the
end of the arrow to a pole the higher the probability the qubit collapses into
the classical value assigned to that pole when measured. For example, the qubit
state represented by the red arrow below has a higher probability of giving the
value **0** if we measure it.

:::img src="../media/qrng-Bloch.png" width="175" alt="A qubit state with a high
probability of measuring zero":::

The steps to follow in a quantum program to obtain a random bit are the
following:

* First we start with a qubit initialized in the state **0** and apply `H` to
  create a superposition in which the probabilities for **0** and **1** are the
  same.

:::img src="../media/qrng-H.png" width="450" alt="Preparing a qubit in
superposition":::

* Then we measure the qubit and save the output:

:::img src="../media/qrng-meas.png" width="450" alt="Measuring a qubit and saving
the output":::

Since the outcome of the measurement is completely random, we have obtained a
random bit. We can call this operation several times to create integers. For
example, if we call the operation three times to obtain three random bits, we
can build random 3-bit numbers (that is, a random number between 0 and 7).

## What are quantum operations?

The basic unit of quantum execution in Q#. It is roughly equivalent to a function in C, C++ or Python, or a static method in C# or Java. For more information, see Operation and function types.

### What is the Hadamard operation?

The Hadamard operation (also referred to as the Hadamard gate or transform) acts on a single qubit and puts it in an even superposition of $\ket{0}$ or $\ket{1}$ if the qubit is initially in the $\ket{0}$ state. In Q#, this operation is applied by the pre-defined H operation.

---

In the next unit, we will put all these together into code.

---

TODO: Possibly use this to drive the discussion:

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
    open Microsoft.Quantum.Intrinsic;
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
    open Microsoft.Quantum.Intrinsic;
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

In the next unit you are going to explore how to create a complete random
number generator using the classical logic of Q#.
