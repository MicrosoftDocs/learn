Quantum computing is based on quantum mechanics, which describes how objects at atomic and subatomic scale behave and interact with one another.

Although there are more formal methods for learning the mathematics and theory behind quantum computing, here we'll define a few basic terms and walk through the structure of a basic Q# program. You'll apply these concepts later as you build your quantum random number generator.

> [!TIP]
> As you explore quantum computing, you'll need to understand the concepts at the mathematical level. You'll find resources to help you understand more of the theory behind quantum computing at the end of this module. If you already have a background in quantum computing, here you'll learn how Q# applies the concepts.

## What are qubits and superposition?

Even if you're new to quantum computing, you may have heard the terms _qubit_ and _superposition_. These concepts are fundamental to quantum computing, but what do they mean?

A _qubit_ (quantum bit) is a basic unit of quantum information, analogous to a bit in classical computing.

While a bit (binary digit) can have a value of either zero or one, a qubit is in a state of _superposition_ of both the zero and one states, with some probability of being zero and some probability of being one when measured. The act of measuring a qubit changes the qubit's state. In other words, when measured, a qubit goes from being in superposition to one of the classical states.

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

Namespaces help you organize related functionality. Their use becomes important when you use Q# libraries in your programs and when you write your own libraries.

### Libraries

Q# makes extensive use of libraries. A library is a package that contains functions and operations that you can use in quantum programs.

For example, the [Microsoft.Quantum.Chemistry](/qsharp/api/qsharp/microsoft.quantum.chemistry?azure-portal=true) library helps you perform quantum calculations that relate to chemistry. There are several standard libraries that include all sorts of basic operations.

When you call a function or operation from a library, you specify the library's namespace. Here's an example that calls the `Message` function from the `Microsoft.Quantum.Intrinsic` library to print a message to the console:

```qsharp
namespace HelloQuantum {

    @EntryPoint()
    operation HelloQ() : Unit {
        Microsoft.Quantum.Intrinsic.Message("Hello quantum world!");
    }
}
```

More commonly, you use the `open` directive to make your code more succinct and easier to read.

This example does the same thing as the previous example, except this one uses the `open` directive to bring the `Microsoft.Quantum.Intrinsic` namespace into the program:

```qsharp
namespace HelloQuantum {

    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation HelloQ() : Unit {
        Message("Hello quantum world!");
    }
}
```

Here, you simply specify `Message` and the compiler understands which namespace it belongs to.

The Q# documentation provides complete reference documentation for each built-in library. For more information, see [Q# libraries](/quantum/user-guide/libraries/additional-libraries?tabs=tabid-csproj).

### Operations

Operations are the basic building blocks of a Q# program. A Q# operation is a quantum subroutine. That is, it's a callable routine that contains quantum operations that modify the state of the qubit register.

To define a Q# operation, you specify a name for the operation along with its inputs and its output. Here's a basic example:

```qsharp
operation HelloQ() : Unit {
    Message("Hello quantum world!");
}
```

Here, `HelloQ` is the name of the operation. It takes zero arguments as its input and returns type `Unit`, which means that the operation returns no information.

Q# libraries also provide operations that you can use in your programs. One operation you'll use later is the `H` operation. Think of the `H` operation as a way of putting a qubit into an *even* superposition. Once in superposition, a qubit has a 50% chance of being measured as zero or one.

### Types

Q# provides many built-in types you're already familiar with, including `Int`, `Double`, `Bool`, and `String`, along with types that are specific to quantum computing. Q# also provides types that define ranges, arrays, and tuples. You can even define your own custom types.

In this module, you'll work with the `Result` type. A `Result` represents the result of a qubit measurement and can have one of two possible values: `One` and `Zero`.

### Allocating qubits

In Q#, to obtain a qubit you use the `use` keyword. You can allocate one or many qubits at a time.

Here's an example that allocates one qubit:

```qsharp
// Allocate a qubit.
using (q = Qubit()) {
    // Do something with q here.
}
```

Every qubit you allocate with the `use` keyword starts in the zero state.

With these ideas in place, let's dive in and start building our random number generator. You'll start by defining an operation that produces a single random bit.
