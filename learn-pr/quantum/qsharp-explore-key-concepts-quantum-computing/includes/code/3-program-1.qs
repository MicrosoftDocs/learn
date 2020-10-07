namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation GenerateRandomBit() : Result {
        using (q = Qubit()) {
            Message("Initialized qubit:");
            DumpMachine();
            Message(" ");
            H(q);
            Message("Qubit after applying H:");
            DumpMachine();
            Message(" ");
            let randomBit = M(q);
            Message("Qubit after the measurement:");
            DumpMachine();
            Message(" ");
            Reset(q);
            Message("Qubit after resetting:");
            DumpMachine();
            Message(" ");
            return randomBit;
        }
    }
}