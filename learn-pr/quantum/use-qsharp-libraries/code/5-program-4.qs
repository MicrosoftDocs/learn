    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        // Prepare an equal superposition of all compatible states.
        PrepareUniformSuperpositionOverDigits(register);
        
        // Iterations of Grover's search
        for _ in 1 .. iterations {
            // Step 1: apply the oracle
            phaseOracle(register);
            // Step 2: reflect about the uniform superposition
            ReflectAboutUniform(register);
        }
    }