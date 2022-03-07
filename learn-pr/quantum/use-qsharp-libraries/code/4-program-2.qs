    operation ComputeIsbnCheck(digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
        // Being freshly allocated, targetReg will be in |0⟩ when this operation is called.
        // We first intialize it to |9⟩:
        ApplyXorInPlace(9, LittleEndian(targetReg));

        // Apply the mapping |x⟩|9⟩ -> |x⟩ |(9 + 6*x) mod 11 ⟩ where |x⟩ is the state of digitReg
        MultiplyAndAddByModularInteger(6, 11, LittleEndian(digitReg), LittleEndian(targetReg));
    }