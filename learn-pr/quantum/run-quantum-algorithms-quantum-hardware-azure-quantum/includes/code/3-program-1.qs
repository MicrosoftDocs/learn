namespace MyFirstJob {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;

    @EntryPoint()
    operation TestSuperposition() : Result {
        using (q = Qubit())  {
            H(q);
            return M(q);
        }
    }
}