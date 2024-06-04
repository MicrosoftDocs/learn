
The Q# quantum programming language has a well-defined structure. In this unit, you'll review the main components of a Q# program.

## Namespace

Every Q# file starts with a namespace. Here's an example:

```qsharp
namespace HelloQuantum {
    // Your code goes here.
}
```

The `namespace` keyword is used to define a namespace. Namespaces are used to organize Q# code into logical units. Their use becomes important when you use Q# libraries in your programs and when you write your own libraries.

## Libraries

Q# libraries contain functions and operations that you can use in quantum programs. When you call a function or operation from a library, you use the `open` directive and specify the library's namespace. For example:

```qsharp
namespace HelloQuantum {

    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation HelloQ() : Unit {
        Message("Hello quantum world!");
    }
}
```

In this example, the `open` directive tells the Q# compiler to look for the `Message` operation in the `Microsoft.Quantum.Intrinsic` namespace. 

## Entry points

`EntryPoint` tells the Q# compiler where to begin executing the program. Every Q# program must have at least one entry point followed by an operation.

## Allocating qubits

In Q#, to obtain a qubit, you use the `use` keyword. Every qubit you allocate with the `use` keyword starts in the |0〉 state.

You can allocate one or many qubits at a time. Here's an example that allocates one and five qubits:

```qsharp
use q1 = Qubit(); // Allocate one qubit
use q5 = Qubit[5]; // Allocate five qubits
```

## Quantum operations

Operations are the basic building blocks of a Q# program. A Q# operation is a quantum subroutine. That is, it's a callable routine that contains quantum operations that modify the state of the qubit register.

To define a Q# operation, you specify a name for the operation along with its inputs and its output. Here's a basic example:

```qsharp
@EntryPoint()
operation SayHelloQ() : Unit {
    Message("Hello quantum world!");
}
```

Here, `SayHelloQ` is the name of the operation. It takes zero arguments as its input and returns type `Unit`, which means that the operation returns no information.

Q# libraries also provide operations that you can use in your programs. One operation you'll use later is the `H` operation. Given a qubit in Z-basis, the `H` operation puts the qubit into an *even* superposition. After it's in superposition, the qubit has a 50% chance of being measured as zero or one.

## Types

Q# provides many built-in types you're already familiar with, including `Int`, `Double`, `Bool`, and `String`, along with types that are specific to quantum computing. Q# also provides types that define ranges, arrays, and tuples. You can even define your own custom types.

In this module, you'll work with the `Result` type. A `Result` represents the result of a qubit measurement and can have one of two possible values: `One` and `Zero`.

## Measuring qubits

In Q#, Pauli measurements are done by applying the `Measure` operation, which performs a joint measurement of one or more qubits in the specified Pauli bases. The `Measure` operation returns a `Result` type that is either `One` or `Zero`.

> [!NOTE]
> If the basis array and qubit array are different lengths, the `Measure` operation will fail.

To implement a measurement in the computational basis {|0〉 ,|1〉} you can also use the `M` operation, which performs a measurement of a single qubit in the Pauli Z basis. Therefore, the `M` operation is equivalent to applying `Measure([PauliZ], [qubit])`.

A simple example is the following program, which allocates one qubit in the |0〉 state, then applies a Hadamard operation `H` to it and measures the result in the `PauliZ` basis.

```qsharp
@EntryPoint()
operation MeasureOneQubit() : Result {
    // Allocate a qubit, by default it is in zero state      
    use q = Qubit();  
    // We apply a Hadamard operation H to the state
    // It now has a 50% chance of being measured 0 or 1  
    H(q);      
    // Now we measure the qubit in Z-basis.
    let result = M(q);

    // Reset the qubit so it can be safely released.
    Reset(qubit);
    return result;
}
```

> [!NOTE]
> The `Reset` operation is used to reset the qubit to the |0〉 state. In Q#, qubits must be in the |0〉 state by the time they are released.
