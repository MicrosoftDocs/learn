


You're likely already familiar with the concept of a random number generator (RNG). Classical computers don't produce random numbers, but rather _pseudorandom_ numbers. A pseudorandom number generator generates a deterministic sequence of numbers based on some initial value, called a _seed_. To better approximate random values, this seed is often the current time from the CPU's clock.



You start by taking a qubit in a basis state, for example zero. The first step of the QRNG is to use an `H` operation to put the qubit into an equal superposition. The measurement of this state results in a zero or a one with 50% probability of each outcome. The value of this bit is truly random, there's no way of knowing what you will get after the measurement. But how can you use this behavior to generate larger random numbers?

Let's say you repeat the process four times, generating this sequence of binary digits:

$${0, 1, 1, 0}$$

If you concatenate, or combine, these bits into a bit string, you can form a larger number. In this example, the bit sequence ${0110}$ is equivalent to six in decimal.

$${0110_{\ binary} \equiv 6_{\ decimal}}$$

If you repeat this process many times, you can combine multiple bits to form any large number. Now you can provide your superior with that number as a secure password, since you can be sure that no space hacker could determine the results of the sequence of measurements.

You build out your quantum random number generator in two phases. In this unit, you build out the first phase, which is to generate a single random bit.

To do so, you:

> [!div class="checklist"]
> * Create a Q# file.
> * Add code that uses the `H` operation to put a qubit into superposition and then measure its value.
> * Run the program.

In the next section, you build out the second phase, which combines random bits to form a larger number.

> [!NOTE]
> Keep in mind that because you're using the simulator to run your Q# program, you still get pseudorandom results. 

## Create a Q# program

1. Open Visual Studio Code and select **File > New Text File** to create a new file.
1. Save the file as `RandomNumberGenerator.qs`. This file will contain the Q# code for your program.
1. Copy the following code in the `RandomNumberGenerator.qs` file.

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
> The Modern QDK includes a set of Q# samples that you can use to learn more about Q# and quantum computing. To view the samples, open a new Q# file and type `sample`, then select the sample you want to view from the list of options.

## Explore the Q# code

1. Hover over `H` operation to see a short summary of the definition.
1. Place your cursor in front of the `H` operation, right-click and select **Go to Definition**.  This opens a read-only view of the standard library code for the function.

## Run the program locally

1. To test run your program locally on the built-in simulator, select **Run Q# file** from the play icon drop-down in the top-right, or press **Ctrl+5**. Your output will appear in the debug console.
1. Run the program again to see a different result.

In the next unit, you'll implement the second phase of your quantum random number generator: combining multiple random bits to form a larger number.


