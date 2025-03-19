
Before you start writing quantum programs, it's important to understand the structure and components of a Q# program.

In this unit, you'll review the main components of a Q# program.

## The `Main` operation

Every Q# program must contain at least one operation, which is usually the `Main` operation. The `Main` operation is the entry point of your program. By default, the Q# compiler starts executing a program from the `Main()` operation. Optionally, you can use the `@EntryPoint()` attribute to specify any operation in the program as the point of execution. 

For example, the following code defines an entry point operation, `MeasureOneQubit`:

```qsharp
@EntryPoint()
operation MeasureOneQubit() : Result {
    ...
}
```

However, you can also write that code without the `@EntryPoint()` attribute by renaming the `MeasureOneQubit()` operation to `Main()`:

```qsharp
// The Q# compiler automatically detects the Main() operation as the entry point. 
operation Main() : Result {
    ...
}
```

## Types

Q# provides many built-in types you might be already familiar with, including `Int`, `Double`, `Bool`, and `String`. Q# also provides types specific to quantum computing, such as `Qubit` and `Result`.

In this example, the `MeasureOneQubit` operation returns a `Result` type. A `Result` type is the result of measuring a qubit and can be either `One` or `Zero`.

```qsharp
operation MeasureOneQubit() : Result {
    ...
}
```

## Quantum libraries

The Q# libraries contain functions and operations that you can use in quantum programs. When you call a function or operation from a library, you use the `import` directive and specify the library's namespace. For example, to use the `Message` function from the `Microsoft.Quantum.Intrinsic` namespace in the Standard quantum library, you do the following:

```qsharp
// imports all functions and operations from Microsoft.Quantum.Intrinsic 
import Microsoft.Quantum.Intrinsic.*;
    Message("Hello quantum world!");


// imports just the `Message` function from Microsoft.Quantum.Intrinsic
import Microsoft.Quantum.Intrinsic.Message;
    Message("Hello quantum world!");
```

Namespaces in the Standard library can be imported using `Std` instead of `Microsoft.Quantum`. For example:

```qsharp
// imports all functions and operations from Microsoft.Quantum.Intrinsic == Std.Intrinsic
import Std.Intrinsic.*;
    Message("Hello quantum world!");
```

## Allocating qubits

In Q#, to allocate a qubit, you use the `use` keyword and the `Qubit` type. Every qubit you allocate with the `use` keyword starts in the $\ket{0}$ state.

You can allocate one or many qubits at a time. Here's an example that allocates one and five qubits:

```qsharp
use q1 = Qubit(); // Allocate one qubit
use q5 = Qubit[5]; // Allocate five qubits
```

## Measuring qubits

In Q#, the `Measure` operation performs a joint measurement of one or more qubits in the specified Pauli bases, which can be `PauliX`, `PauliY`, or `PauliZ`. The `Measure` operation returns a `Result` type that is either `One` or `Zero`.

To implement a measurement in the computational basis $\lbrace\ket{0},\ket{1}\rbrace$ you can also use the `M` operation, which performs a measurement in the Pauli Z-basis. Thus, the `M` operation is equivalent to applying `Measure([PauliZ], [qubit])`.

## Resetting qubits

In Q#, qubits must be in the $\ket{0}$ state by the time they are released. When you have finished using a qubit, you use the `Reset` operation to reset the qubit to the $\ket{0}$.

```qsharp
    // Reset the qubit so it can be safely released.
    Reset(qubit);
```

