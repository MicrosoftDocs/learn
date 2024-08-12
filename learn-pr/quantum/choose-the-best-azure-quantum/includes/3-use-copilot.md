
To start exploring Copilot and coding in Azure Quantum, use one of the samples from the **Quantum Samples** dropdown.

## Run a quantum program

1. Navigate to the [Code in Azure Quantum](https://quantum.microsoft.com/en-us/experience/quantum-coding).
1. Select **Quantum Samples**, and then select **Random Number Generator**. The following code is copied to the code window.

    ```qsharp
    /// # Sample
    /// Quantum Random Number Generator
    ///
    /// # Description
    /// This program implements a quantum ranndom number generator by setting qubits
    /// in superposition and then using the measurement results as random bits.
    namespace Sample {
        open Microsoft.Quantum.Measurement;
        open Microsoft.Quantum.Intrinsic;
    
        @EntryPoint()
        operation Main() : Result[] {
            // Generate 5-bit random number.
            let nBits = 5;
            return GenerateNRandomBits(nBits);
        }
    
        /// # Summary
        /// Generates N random bits.
        operation GenerateNRandomBits(nBits : Int) : Result[] {
            // Allocate N qubits.
            use register = Qubit[nBits];
    
            // Set the qubits into superposition of 0 and 1 using the Hadamard
            // operation `H`.
            for qubit in register {
                H(qubit);
            }
    
            // At this point each has 50% chance of being measured in the |0〉 state
            // and 50% chance of being measured in the |1〉 state.
            // Measure each qubit and reset them all so they can be safely
            // deallocated.
            let results = MeasureEachZ(register);
            ResetAll(register);
            return results;
        }
    }
    ```

1. Select **In-Memory Simulator**.
1. Select **Run**.

    - The results are displayed in the **Results** field, and a histogram of the results is displayed below the code window. 
    - You can move the slider for **Select number of shots** to specify how many times the program is run.
    - The **Shots** field displays the result for each shot. 

To run your program again using a different simulator:

1. Select the **In-Memory Simulator** dropdown and select **Quantinuum H-Series Emulator**.
1. Select the number of shots (currently limited to 20) and select **Run**.

    - The job status is displayed at the top of the code window.
    - A histogram of the results is displayed below the code window. Results for each shot aren't currently available with the Quantinuum H-Series Emulator.

## Ask Copilot

You can prompt Copilot in Azure Quantum for almost anything quantum related. For example, ask Copilot the following questions and see what happens:

- "Explain the MResetZ operation"
- "Write Q# code that entangles two qubits"
- "Explain quantum interference"
- "What is the difference between a qubit and a classical bit?"


