namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            // Put the qubit to superposition.
            // It now has a 50% chance of being measured 0 or 1.
            H(q);
            // Measure the qubit value.
            return MResetZ(q);
        }
    }
}