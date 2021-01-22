operation ReflectAboutUniform(inputQubits : Qubit[]) : Unit {
        within {
            ApplyToEachCA(H, inputQubits);
            ApplyToEachCA(X, inputQubits);
        } apply {
            Controlled Z(Most(inputQubits), Tail(inputQubits));
    }
}
