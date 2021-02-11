namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation GenerateRandomNumber() : Int {
        using (qubits = Qubit[3]) {
            ApplyToEach(H, qubits);
            Message("The qubit register in a uniform superposition: ");
            DumpMachine();
            let result = ForEach(M, qubits);
            Message("Measuring the qubits collapses the superposition to a basis state.");
            DumpMachine();
            return BoolArrayAsInt(ResultArrayAsBoolArray(result));
        }
    }
}