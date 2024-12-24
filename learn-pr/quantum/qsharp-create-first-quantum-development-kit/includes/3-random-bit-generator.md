In the previous unit, you learned about the basic building blocks of a Q# program. Now, you're ready to write your first quantum program: a quantum program to generate truly random numbers.

You build out your quantum random number generator in two phases. In this unit, you build out the first phase, which is to generate a single random bit.

## Create the Q# program

1. Open Visual Studio Code and select **File > New Text File** to create a new file.
1. Save the file as `Main.qs`. This file will contain the Q# code for your program.

## Define the `Main` operation

The `Main` operation is the entry point of your program.

```qsharp
operation Main(): Result{

    // Your code goes here

}
```

## Allocate a qubit

You start by allocating one qubit with the `use` keyword. In Q#, every qubit you allocate starts in the $\ket{0}$ state by default.

```qsharp
operation Main(): Result{

    // Allocate a qubit
    use q = Qubit();

}
```

## Put the qubit into superposition

The qubit is in the $\ket{0}$ state, which isn't very useful for generating random numbers. You need to put the qubit into superposition. To do this, you apply the **Hadamard operation**, `H`, to the qubit. The Hadamard operation changes the state of the qubit and puts it into an equal superposition of $\ket{0}$ and $\ket{1}$. 

$$ H \ket{0} = \frac{1}{\sqrt{2}} (\ket{0} + \ket{1}) $$

Because the qubit is in an equal superposition, when you measure it, you have a 50% chance of getting 0 and a 50% chance of getting 1.

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
}
```

## Measure the qubit

At this point the qubit `q` has 50% chance of being measured in the |0〉 state and 50% chance of being measured in the |1〉 state. Thus, if you measure the qubit, you'll get a random bit, either 0 or 1, with equal 50% probability. The value of this bit is truly random, there's no way of knowing in advance the result of the measurement.

To measure the qubit value, use the `M` operation and store the measurement value in the `result` variable.

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
}
```

## Reset the qubit

In Q#, every qubit must be in the $\ket{0}$ state by the time they are released. You use `Reset(q)` to reset the qubit to the zero state.

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
    Reset(q);
}
```

## Return the measurement result

Finally, you return the measurement result with the `return` keyword. This result is a random bit, either 0 or 1, with equal probability.

```qsharp
operation Main(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
    Reset(q);
    return result;
}
```

## Final program

Your `Main.qs` file should look like this. The program allocates a qubit, puts it into superposition, measures the qubit, resets the qubit, and returns the measurement result.

> [!NOTE]
> The `//` symbol represents optional comments to explain each step of the program.

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

## Run the program

To run your program on the built-in simulator, click **Run** above the `Main` operation or press **Ctrl+F5**. Your output appears in the debug console in the terminal.

The result is either `One` or `Zero`, which represents a truly random bit. You can run the program again to see a different result.

In the next unit, you'll implement the second phase of your quantum random number generator: combining multiple random bits to form a larger number.
