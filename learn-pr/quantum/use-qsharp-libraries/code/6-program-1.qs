    /// # Summary
    /// Given an input four-qubit register, flags the "good" states with a phase factor of -1. 
    /// Those are the states |x⟩ such that (b + a*x) mod 11 = 0.
    ///
    /// # Description
    /// Allocates 1) a "flag" qubit puts it in the state |-⟩ to be used for phase kickback,  
    /// and 2) a qubit register of the same size as the input. 
    /// Both are deallocated at the end of the call. 
    /// The latter serves as the target for the arithmetic mapping 
    /// |x⟩|0⟩ -> |x⟩ |(b + a*x) mod 11 ⟩ handled in `ComputeIsbnCheck`. Then, the target register
    /// being in number state |0⟩ controls an X operation on the flag qubit, providing the phase 
    /// factor to the proper states.
    ///
    /// # Input
    /// ## constants
    /// The tuple (a, b) of the values which result from the ISBN and which digit is missing. 
    /// ## digitReg
    /// The input four-qubit register which will be operated on.
    /// These imply the ISBN check equation 0 = b + a*x mod 11.
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