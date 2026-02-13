
Before you write your own quantum programs, it's important to understand the structure and components of the Q# programming language.

In this unit, you learn about the basic components of a Q# program.

## The `Main` operation

Every Q# program must contain at least one operation. The Q# compiler begins to run a program from the entry point operation, which is the `Main` operation by default. For example, the following Q# program contains an operation called `Main` that creates a qubit and returns a measurement of the qubit's state:

```qsharp
// This operation is the entry point to your program because it's name is Main
operation Main() : Result {
    use q = Qubit();
    return M(q);
}
```

Your Q# code can't run without an entrypoint operation. If you want to use an operation other than `Main` as your entry point, then use the `@EntryPoint()` attribute. For example, the following code gives the preceding operation a more descriptive name, `MeasureOneQubit`, and defines that operation as the entry point to your Q# program:

```qsharp
// The @EntryPoint() attribute tells the compiler to start running your code from this operation
@EntryPoint()
operation MeasureOneQubit() : Result {
    use q = Qubit();
    return M(q);
}
```

## Types

Q# provides many built-in data types that you might already be familiar with, such as `Int`, `Double`, `Bool`, and `String`. Q# also provides types that are specific to quantum computing, such as `Qubit` and `Result`.

For example, the `MeasureOneQubit` operation returns a `Result` type value. The `Result` type represents the state of a qubit when the qubit is measured, and can have a value of either `Zero` or `One`.

## Quantum libraries

Q# comes with several libraries that contain functions and operations to help you write quantum programs. To call a function or operation from a library, use the `import` keyword and specify the library's namespace. For example, to use the `Message` function from the `Std.Intrinsic` namespace in the standard quantum library, use the following code:

```qsharp
// import all functions and operations from Std.Intrinsic 
import Std.Intrinsic.*;

operation Main() : Unit {
    // call the Message function from Std.Intrinsic
    Message("Hello quantum world!");
}
```

The asterisk means that you import all of the functions from the `Std.Intrinsic` namespace. Alternatively, you can import only the `Message` function:

```qsharp
// import only the Message function from Std.Intrinsic 
import Std.Intrinsic.Message;

operation Main() : Unit {
    // call the Message function from Std.Intrinsic
    Message("Hello quantum world!");
}
```

> [!NOTE]
> In Q#, the `Unit` type means that the function or operation doesn't return a value. For more information about types in Q#, see [Type System](https://learn.microsoft.com/azure/quantum/user-guide/language/typesystem/).

To explore the Q# standard library, see the [API reference](https://learn.microsoft.com/qsharp/api/qsharp-lang/).

## Qubit allocation

To allocate a qubit in Q#, use the `use` keyword and the `Qubit` type. Qubits that you allocate with the `use` keyword always start in the $\ket{0}$ state.

You can allocate a single qubit, or multiple qubits in a qubit array. Here's an example that allocates a single qubit in the variable `q1` and an array of five qubits in `q5`:

```qsharp
use q1 = Qubit();  // Allocate one qubit
use q5 = Qubit[5]; // Allocate five qubits
```

## Qubit measurement

In Q#, the `Measure` operation performs a joint measurement of one or more qubits in the specified Pauli bases, which can be `PauliX`, `PauliY`, or `PauliZ`. The `Measure` operation returns a `Result` type that has a value of either `Zero` or `One`.

To perform a measurement in the computational basis $\lbrace\ket{0},\ket{1}\rbrace$, you can also use the `M` operation. The `M` operation is equivalent to the `Measure` operation in the Pauli-Z basis, so `M([qubit])` behaves exactly the same as `Measure([PauliZ], [qubit])`. However, the `M` operation accepts only single qubits as input, not qubit arrays.

## Reset qubits

In Q#, qubits must be in the $\ket{0}$ state to release them. When you finish using a qubit, call the `Reset` operation to reset the qubit to the $\ket{0}$ state. For example, the following code allocates a qubit, measures the qubit's state, and then resets the qubit:

```qsharp
operation Main() : Result {
    use q = Qubit();
    let result = M(q);

    // Reset the qubit so that you can release it
    Reset(q);

    return result;
    }
```
