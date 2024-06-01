
Classical computers don't produce random numbers, but rather _pseudorandom_ numbers. A pseudorandom number generator generates a deterministic sequence of numbers based on some initial value (called a _seed_). To better approximate random values, this seed is often the current time from the CPU's clock.

Quantum computers, on the other hand, can generate truly random numbers. This is because the measurement of a qubit in superposition is a probabilistic process. The result of the measurement is random, and there's no way to predict the outcome. This is the basic principle of quantum random number generators.

## Define the QRNG problem

You start by taking a qubit in a basis state, such as zero. The first step of the QRNG is to use an `H` operation to put the qubit into an equal superposition. The measurement of this state results in a zero or a one with 50% probability of each outcome. The value of this bit is truly random, there's no way of knowing what you will get after the measurement. But how can you use this behavior to generate larger random numbers?

Let's say you repeat the process four times, generating this sequence of binary digits:

$${0, 1, 1, 0}$$

If you concatenate, or combine, these bits into a bit string, you can form a larger number. In this example, the bit sequence ${0110}$ is equivalent to six in decimal.

$${0110_{\ binary} \equiv 6_{\ decimal}}$$

If you repeat this process many times, you can combine multiple bits to form any large number.

You build out your quantum random number generator in two phases. In this unit, you build out the first phase, which is to generate a single random bit.

To do so, you:

1. Allocate a qubit.
1. Apply the `H` operation to put a qubit into superposition.
1. Measure the qubit to get a random bit.
1. Reset the qubit to the zero state.

## Create a Q# program

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

> [!TIP]
> The  QDK includes a set of built-in Q# samples that you can use to learn more about Q# and quantum computing. To view the samples, open a new Q# file and type `sample`, then select the sample you want to view from the list of options. You can find the Q# code in this unit under "Random Bit sample".

## Explore the Q# code

1. Hover over the `H` operation to see a short summary of the definition.
1. Place your cursor in front of the `H` operation, right-click and select **Go to Definition**. This opens a read-only view of the standard library code for the function.

## Run the program locally

1. Open a new terminal by selecting **Terminal > New Terminal**. 
1. To test run your program locally on the built-in simulator, click on **Run** from the list of commands below `@EntryPoint()`, or press **Ctrl+F5**. Your output will appear in the debug console.
1. Run the program again to see a different result.

In the next unit, you'll implement the second phase of your quantum random number generator: combining multiple random bits to form a larger number.
