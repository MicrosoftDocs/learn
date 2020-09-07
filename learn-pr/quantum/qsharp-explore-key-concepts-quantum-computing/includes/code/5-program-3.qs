namespace ExploringInterference {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation TestInterferenceC() : Unit {
        using (q = Qubit()) {
            Y(q);
            H(q);
            DumpMachine();
            Reset(q);
        }
    }
}