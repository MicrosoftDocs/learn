namespace ExploringInterference {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation TestInterferenceB() : Unit {
        using (q = Qubit()) {
            X(q);
            H(q);
            DumpMachine();
            Reset(q);
        }
    }
}