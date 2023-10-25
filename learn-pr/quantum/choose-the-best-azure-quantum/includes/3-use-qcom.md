
To start exploring the Copilot in Azure Quantum, you can copy and paste a simple Q# program into the code window.

1. Navigate to the [Copilot in Azure Quantum](https://quantum.microsoft.com/en-us/experience/quantum-coding) using any Microsoft (MSA) account.
1. Copy and paste the following code into the code window. This program generates a random integer between 0 and 50.

    ```qsharp
    namespace Qrng {
        open Microsoft.Quantum.Canon;
        open Microsoft.Quantum.Intrinsic;
        open Microsoft.Quantum.Measurement;
        open Microsoft.Quantum.Math;
        open Microsoft.Quantum.Convert;
    
        operation SampleQuantumRandomNumberGenerator() : Result {
            // Allocate a qubit.
            use q = Qubit();
            // Put the qubit to superposition.
            H(q);
            // It now has a 50% chance of being measured 0 or 1.
            // Measure the qubit value.
            return MResetZ(q);
        }
        operation SampleRandomNumberInRange(max : Int) : Int {
            mutable output = 0; 
            repeat {
                mutable bits = []; 
                for idxBit in 1..BitSizeI(max) {
                    set bits += [SampleQuantumRandomNumberGenerator()]; 
                }
                set output = ResultArrayAsInt(bits);
            } until (output <= max);
            return output;
        }
        @EntryPoint()
        operation SampleRandomNumber() : Int {
            let max = 50;
            Message($"Sampling a random number between 0 and {max}: ");
            return SampleRandomNumberInRange(max);
        }
    }
    ```

1. Click **Run**. The results are displayed in the **Results** field, and a histogram of the results is displayed below the code window. 
1. You can move the slider for **Select number of shots** to specify how many times the program is run.
1. The **Shots** field displays the result for each shot.
1. Click **Explain code** to prompt the Copilot in Azure Quantum to generate an analysis of the code sample.


You can prompt the Copilot in Azure Quantum for almost anything quantum related. For example ask the Copilot the following questions and see what happens:

- "Explain the MResetZ operation"
- "Write Q# code that entangles two qubits"
- "Explain quantum interference"
- "What is the difference between a qubit and a classical bit?"