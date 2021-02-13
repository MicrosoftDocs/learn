    operation ComputeIsbnCheck(constants : (Int, Int), digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
        let (a, b) = constants;

        // Being freshly allocated, targetReg will be in |0⟩ when this operation is called.
        // We first intialize it to |b⟩:
        ApplyXorInPlace(b, LittleEndian(targetReg));

        // Apply the mapping |x⟩|b⟩ -> |x⟩ |(b + a*x) mod 11 ⟩ where |x⟩ is the state of digitReg
        MultiplyAndAddByModularInteger(a, 11, LittleEndian(digitReg), LittleEndian(targetReg));
    }