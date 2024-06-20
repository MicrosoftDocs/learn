
You build out your quantum random number generator in two phases. In this unit, you build out the first phase, which is to generate a single random bit.

## Define a random bit generator

You start by allocating qubit. When you allocate a qubit, it's in the $\ket{0}$ state, which isn't very useful for generating random numbers. You need to put the qubit into superposition. You can do this by applying the Hadamard gate, `H`, to the qubit. The Hadamard gate puts the qubit into an equal superposition of $\ket{0}$ and $\ket{1}$. 

When you measure the qubit, you'll get a random bit, either 0 or 1, with equal 50% probability. The value of this bit is truly random, there's no way of knowing what you get after the measurement.

## Create the Q# program

1. Open Visual Studio Code and select **File > New Text File** to create a new file.
1. Save the file as `RandomNumberGenerator.qs`. This file will contain the Q# code for your program.
1. Copy the following code into the `RandomNumberGenerator.qs` file.

    ```qsharp
    namespace QuantumRandomNumberGenerator {
    
        @EntryPoint()
        operation GenerateRandomBit() : Result {
            // Allocate a qubit.
            use q = Qubit();
    
            // Set the qubit into superposition of 0 and 1 using the Hadamard 
            H(q);
    
            // At this point the qubit `q` has 50% chance of being measured in the
            // |0〉 state and 50% chance of being measured in the |1〉 state.
            // Measure the qubit value using the `M` operation, and store the
            // measurement value in the `result` variable.
            let result = M(q);
    
            // Reset qubit to the |0〉 state.
            // Qubits must be in the |0〉 state by the time they are released.
            Reset(q);
    
            // Return the result of the measurement.
            return result;
        }
    }
    ```

Let's take a moment to review the new code.

- First, you allocate one qubit with the `Qubit()` operation and the `use` keyword.
- Then, the Hadamard operation puts the qubit into superposition, `H(q)`.
- Then, you measure the qubit to get a random bit, `M(q)`.
- Finally, `Reset(q)` resets the qubit to the zero state. Qubits must be in the $\ket{0}$ state by the time they are released.

## Run the program locally

To run your program locally on the built-in simulator, **Run** from the list of commands below `@EntryPoint()`, or press **Ctrl+F5**. Your output appears in the debug console in the terminal.

The result is truly random. You can run the program again to see a different result.

> [!TIP]
> The  QDK includes a set of built-in Q# samples that you can use to learn more about Q# and quantum computing. To view the samples, open a new Q# file and type `sample`, then select the sample you want to view from the list of options. You can find the Q# code in this unit under "Random Bit sample".

In the next unit, you'll implement the second phase of your quantum random number generator: combining multiple random bits to form a larger number.
