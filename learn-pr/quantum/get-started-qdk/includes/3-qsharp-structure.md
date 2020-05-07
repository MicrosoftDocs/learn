Quantum computing is based on quantum mechanics, which describes how objects at atomic and subatomic scale behave and interact with one another.

Although there are more formal methods for learning the mathematics and theory behind quantum computing, here we'll define a few basic terms and walk through the structure of a basic Q# program. You'll apply these concepts later as you build your quantum random number generator.

> [!TIP]
> You'll find resources to help you understand more of the theory behind quantum computing at the end of this module.

## What are qubits and superposition?

Qubits and superposition are fundamental to quantum computing.

A _qubit_ (quantum bit) is a basic unit of quantum information, analogous to a bit in classical computing.

While a bit, or binary digit, can have a value of either zero or one, a qubit can have a value that's either of these or a quantum _superposition_ of zero and one.

Think of superposition as a combination of both zero and one states, with some probability of being zero or one when measured. The act of measuring a qubit changes the qubit's state. In other words, when measured, a qubit goes from being in superposition to one of the classical states.

## What's in a Q# program?

Here's the Q# program that you ran in the previous part:

```qsharp
namespace HelloQuantum {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    @EntryPoint()
    operation HelloQ() : Unit {
        Message("Hello quantum world!");
    }
}
```

Let's explore how each piece fits within the overall program.

### Namespaces

Every Q# file typically starts with a namespace. Here's an example:

```qsharp
namespace HelloQuantum {
    // Your code goes here.
}
```

Namespaces help you organize related functionality. They also help you clarify the functionality you intend when you have more than one function or operation with the same name.

For example, say you define a quantum operation named `MyQuantumOperation`, which appears in two namespaces: `Math` and `Physics`. `MyQuantumOperation` might be implemented differently within each namespace.

`Math.MyQuantumOperation` refers to the version of `MyQuantumOperation` from the `Math` namespace. Similarly, `Physics.MyQuantumOperation` refers to the version of `MyQuantumOperation` from the `Physics` namespace.

### Libraries

Q# makes extensive use of libraries. A library is a package that contains functions and operations that you can use in quantum programs.

For example, the [Microsoft.Quantum.Chemistry](/qsharp/api/qsharp/microsoft.quantum.chemistry?azure-portal=true) library helps you perform quantum calculations that relate to chemistry. There are several standard libraries that include all sorts of basic operations.

To use a library in your program, you use the `open` directive. Here's an example that includes the `Canon` and `Intrinsic` libraries:

```qsharp
namespace HelloQuantum {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    // Your code goes here.
}
```

The `Microsoft.Quantum.Canon` library provides the most basic operations of Q#.

The `Microsoft.Quantum.Intrinsic` library provides common operations that you can perform on qubits. It also provides the `Message` function, which you used in the previous part of print a message to the console.

You can find a list of libraries used in Q# [here in the left dropdown menu](https://docs.microsoft.com/en-us/qsharp/api/qsharp/).

### Operations

Operations are the basic building blocks of a Q# program. A Q# operation is a quantum subroutine. That is, it's a callable routine that contains quantum operations that modify the state of the qubit register.

To define a Q# operation, you specify a name for the operation along with its inputs and its output. Here's a basic example:

```qsharp
@EntryPoint()
operation HelloQ() : Unit {
    Message("Hello quantum world!");
}
```

Here, `HelloQ` is the name of the operation. It takes zero arguments as its input and returns type `Unit`. The value of the `Unit` type is always `()`, which means that the operation returns no information.

Q# provides a number of built-in types you're already familiar with, including `Int`, `Double`, `Bool`, and `String`, along with types that are specific to quantum computing. Q# also provides types that define ranges, arrays, and tuples. You can even define your own custom types.

In this module, you'll work with the `Result` type. A `Result` represents the result of a qubit measurement and can have two possible values: `One` and `Zero`.

`EntryPoint` tells the Q# compiler that this is where to begin execution of the program. 

Q# libraries also provide operations that you can use in your programs. One operation you'll use later is the `H` operation. Think of the `H` operation as a way of putting a qubit into an even superposition. Once in superposition, a qubit has a 50% chance of being measured as zero or one.

### Allocating qubits

In Q#, to obtain a qubit you use the `using` keyword. You can allocate one or many qubits at a time.

Here's an example that allocates one qubit:

```qsharp
using (q = Qubit()) { // Allocate a qubit.
    // Do something with q here.
}
```

Every qubit you allocate with the `using` keyword starts in the zero state.

With these ideas in place, let's dive in and start building our random number generator. You'll start by defining an operation that produces a single random bit.
