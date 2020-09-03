namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    @EntryPoint()
    operation GenerateUniformState() : Int {
        using (qubits = Qubit[3]){
        ApplyToEach(H, qubits);
        Message("The qubit register in a uniform superposition: ");
        DumpMachine();
        mutable results = new Result[0];
        for (q in qubits) {
               Message(" ");
               set results += [M(q)];
               DumpMachine();
        }
        Message(" ");
        Message("Your random number is: ");
        return BoolArrayAsInt(ResultArrayAsBoolArray(results));
        }
    }
}