    operation ReflectAboutUniform(digitReg : Qubit[]) : Unit {
        within {
            // Transform the uniform superposition to all-zero.
            Adjoint PrepareUniformSuperpositionOverDigits(digitReg);
            // Transform the all-zero state to all-ones
            ApplyToEachCA(X, digitReg);
        } apply {
            // Reflects about that all-ones state, then let the within/apply
            // block transform the state back to the initial basis.
            Controlled Z(Most(digitReg), Tail(digitReg));
        }
    }