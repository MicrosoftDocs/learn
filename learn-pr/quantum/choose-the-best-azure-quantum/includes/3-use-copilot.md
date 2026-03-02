In this unit, you learn how to use Copilot on the Microsoft Quantum website to explore quantum computing and quantum programming. Copilot is an AI-powered tool that generates Q# code from your prompts and engages in conversations about quantum computing. You can also run your code and ask Copilot to explain quantum computing concepts.

To start exploring Copilot and coding in Microsoft Quantum, use one of the samples from the **Quantum Samples** dropdown in the [code tool](https://quantum.microsoft.com/en-us/tools/quantum-coding).

## Run a quantum program

To run a Q# code sample that generates a truly random number, follow these steps:

1. Go to the [Quantum coding](https://quantum.microsoft.com/tools/quantum-coding) section on the Microsoft Quantum website.
1. Select the **Quantum Samples** dropdown, and then choose **Random Bits**. The following code appears in the code window:

    ```qsharp
    /// # Summary
    /// Simple Quantum Random Number Generator sample
    ///
    /// # Description
    /// This program implements a quantum random number generator by setting qubits
    /// into superposition and then using the measurement results as random bits.
    /// This is equivalent to generating a random number in the range of 0..2ᴺ-1.
    operation Main() : Result[] {
        // Generate a 5-bit random number.
        GenerateNRandomBits(5)
    }
    
    /// # Summary
    /// Generates N random bits in the form of `Zero` or `One` results.
    operation GenerateNRandomBits(nBits : Int) : Result[] {
        // Array for the results
        mutable results = [];
        for _ in 1..nBits {
            // Append next random result to the array
            results += [GenerateRandomBit()];
        }
        results
    }
    
    /// # Summary
    /// Generates a random bit in the form of `Zero` or `One` result.
    operation GenerateRandomBit() : Result {
        // Allocate a qubit
        use q = Qubit();
        // Set the qubit into uniform superposition of |0〉 and |1〉
        H(q);
        // Now the qubit has 50% chance of being measured as `One`
        // and 50% chance of being measured as `Zero`.
        // Measure and reset the qubit. Return the result.
        MResetZ(q)
    }
    ```

1. In the simulator dropdown box, choose **In-Memory Simulator**.
1. Choose **Run**.

A histogram of your results displays in the **Result distribution of shots** area, and the random number for each shot displays in the **Result** field. Cycle through the **Shots** field to view each random number. To run the program again with a different number of shots, use the **Select number of shots** slider. Each shot corresponds to an individual run of the Q# program.

If you aren't sure what some of these terms mean or what the code is doing, then go ahead and ask Copilot to explain! For example, ask Copilot what a shot is, or what `MResetZ` does.

To run your program again with a different simulator:

1. Select the **In-Memory Simulator** dropdown, and then choose **Quantinuum's H-Series Emulator**.
1. Use the slider to choose the number of shots.
1. Choose **Run**.

The job status displays at the top of the code window. A histogram of the results displays below the code window.

## Ask Copilot

You can ask Copilot on Microsoft Quantum about anything related to quantum quantum computing. For example, give Copilot the following prompts and see what happens:

- "Explain the H operation"
- "Write Q# code that entangles two qubits"
- "Explain quantum interference"
- "What is the difference between a qubit and a classical bit?"
