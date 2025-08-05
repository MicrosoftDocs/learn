In the previous unit, you learned about the basic building blocks of a Q# program. Now, you're ready to write your first quantum program. In this unit, you write a quantum program that generates a truly random bit.

You'll build your quantum random number generator in two steps. This unit is the first step, which is to generate a single random bit. To generate a random bit, you allocate a qubit in the $\ket{0}$ state, put that qubit into a superposition state, and then measure the qubit to produce a random bit value of either 0 or 1.

## Create the Q# program file

1. Open Visual Studio Code and choose **File > New Text File** to create a new file.
1. Save the file as `Main.qs`. Write your Q# code for the random bit generator in this file.

## Define the `Main` operation

The `Main` operation is the entry point of your program. Copy the following code into your `Main.qs` file:

```qsharp
operation Main(): Result{

    // Your code goes here

}
```

## Allocate a qubit

To start, allocate one qubit with the `use` statement. In Q#, every qubit that you allocate with `use` starts in the $\ket{0}$ state by default. To allocate a single qubit, copy the following code into your program:

```qsharp
operation Main(): Result{

    // Allocate a qubit
    use q = Qubit();
}
```

## Put the qubit into a superposition state

At this point, you can't generate a random bit from the qubit because the qubit is in the $\ket{0}$ state. If you measure the state of this qubit, the measurement will return a bit value of 0 every time.

To generate a random bit from the qubit measurement, you first need to put the qubit into a superposition of the $\ket{0}$ state and the $\ket{1}$ state. To put the qubit into a superposition state, apply a Hadamard operation to the qubit. The Hadamard operation transforms the qubit from the $\ket{0}$ state to an equal superposition of the $\ket{0}$ and $\ket{1}$ states.

$$ H \ket{0} = \frac{1}{\sqrt{2}} (\ket{0} + \ket{1}) $$

To apply a Hadamard operation to your qubit in Q#, use the `H` operation:

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
}
```

> [!NOTE]
> When you apply a quantum operation to a qubit in Q#, the operation doesn't return a value. Instead, operations affect the state of the qubit.

## Measure the qubit

Because the qubit is now in an equal superposition state, when you measure the qubit you have a 50% chance that the measurement returns a 0 and a 50% chance that the measurement returns a 1.

To measure the qubit value in Q#, use the `M` operation and store the measurement value in the `result` variable:

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
}
```

## Reset the qubit

In Q#, a qubit must be in the $\ket{0}$ state before you can release the qubit. Use the `Reset` operation to reset the qubit to the $\ket{0}$ state.

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
    Reset(q);
}
```

## Return the measurement result

Finally, return the measurement result with the `return` statement. This result is a random bit, either 0 or 1, with equal probability. Copy the following code in your `Main.qs` file:

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
    Reset(q);
    return result;
}
```

## Run your random bit generator program

You created a Q# program called `Main.qs` that allocates a qubit, puts the qubit into an equal superposition state, measures the qubit, resets the qubit, and then returns the measurement result. Here's a recap of the Q# code that you wrote:

```qsharp
operation Main() : Result {
    // Allocate a qubit.
    use q = Qubit();

    // Set the qubit into superposition of 0 and 1 using the Hadamard 
    H(q);

    // Measure the qubit and store the result.
    let result = M(q);

    // Reset qubit to the |0〉 state.
    Reset(q);

    // Return the result of the measurement.
    return result;
}
```

> [!NOTE]
> The `//` symbol represents optional comments to explain each step of the program.

To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation, or press **Ctrl+F5**. Your output appears on the debug console in the terminal.

The result is either `Zero` or `One`, each with a 50% chance. The measurement value of this bit is truly random. Run the program multiple times to see for yourself how the result changes.

In the next unit, you combine multiple random bits to implement the second part of your quantum random number generator.
