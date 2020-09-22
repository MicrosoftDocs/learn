namespace ExploringGroversSearchAlgorithm {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        // Prepare an equal superposition of all basis states
        ApplyToEach(H, register);
        
        // Iterations of Grover's search
        for (_ in 1 .. iterations) {
            // Step 1: apply the oracle
            phaseOracle(register);
            // Step 2: reflection around the mean
            within {
                ApplyToEachA(H, register);
                ApplyToEachA(X, register);
            } apply {
                Controlled Z(Most(register), Tail(register));
            }
        }
    }
}