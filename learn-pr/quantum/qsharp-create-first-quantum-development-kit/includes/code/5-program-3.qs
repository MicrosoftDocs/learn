namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            // Put the qubit to superposition.
            H(q);
            // It now has a 50% chance of being measured 0 or 1.
            // Measure the qubit value.
            return MResetZ(q);
        }
    }

    @EntryPoint()
    operation GenerateRandomNumber() : Int {
        let max = 50;
        Message($"Sampling a random number between 0 and {max}: ");
        // Calculate `nBits`.
        let nBits = Floor(Log(IntAsDouble(max)) / LogOf2() + 1.);
    
        // Initiate a mutable variable to store the bit string.
        mutable bits = new Result[0]; 
        // Initiate a mutable variable to store the output.
        mutable output = 0; 
        repeat {
            // Restart the bit string to 0.
            set bits = new Result[0];
            // Loop to generate `nBits` random bits.
            for (bit in 1 .. nBits) { 
                // We call our operation to extract a random bit and append it to the bit string.
                set bits += [GenerateRandomBit()]; 
            }
            // Transform the bit string into a integer
            set output = ResultArrayAsInt(bits);
        }
        until (output <= max) // Condition to stop the loop.
        fixup {
            // Print this when the condition is not met.
            Message($"{output} > {max}, trying again.");
        }

        return output;
    }
}
