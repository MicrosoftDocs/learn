    operation ComputeIsbnCheck(constants : (Int, Int), digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
        let (a, b) = constants;

        // Being freshly allocated, targetReg will be in |0⟩ when this operation is called.
        // We first intialize it to |b⟩:
        ApplyXorInPlace(b, LittleEndian(targetReg));

        // Apply the mapping |x⟩|b⟩ -> |x⟩ |(b + a*x) mod 11 ⟩ where |x⟩ is the state of digitReg
        MultiplyAndAddByModularInteger(a, 11, LittleEndian(digitReg), LittleEndian(targetReg));
    }


    operation IsbnOracle(constants : (Int, Int), digitReg : Qubit[]) : Unit is Adj + Ctl {
        // Allocate target register for oracle mapping, flag qubit for phase kickback
        using ((targetReg, flagQubit) = (Qubit[Length(digitReg)], Qubit()) ) {
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
    }