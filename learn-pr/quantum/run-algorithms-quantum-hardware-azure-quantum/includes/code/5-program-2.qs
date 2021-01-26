operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
    ApplyToEachCA(H, register);
    for (_ in 1 .. iterations) {
        phaseOracle(register);
        ReflectAboutUniform(register);
    }
}
