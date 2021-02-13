    operation IsbnOracle(digitReg : Qubit[], constants : (Int, Int)) : Unit is Adj + Ctl {
        // Allocate target register for oracle mapping, flag qubit for phase kickback
        use (targetReg, flagQubit) = (Qubit[Length(digitReg)], Qubit());
        within {
            // Initialize flag qubit to |-⟩ 
            X(flagQubit);
            H(flagQubit);
            // Map targetReg to |(b + a*x) mod 11 ⟩, where |x⟩ is the state of digitReg
            ComputeIsbnCheck(digitReg, targetReg, constants);
        } apply {
            // States where targetReg is in |0⟩ number state will be flagged with a -1
            // phase due to controlled X they apply to the flag qubit in the |-⟩ state.  
            ApplyControlledOnInt(0, X, targetReg, flagQubit);
        }
    }