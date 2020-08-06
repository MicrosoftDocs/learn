namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;

    @EntryPoint()
    operation GenerateSpecificState(alpha : Double) : Result {
        using (q = Qubit()) {
            Rx(2.0 * ArcTan2(Sqrt(1.0-alpha), Sqrt(alpha)), q);
            S(q);
            Message("The qubit is in the desired state.");
            DumpMachine();
            Message("Your skewed random bit is:");
            return MResetZ(q);
        }
    }
}