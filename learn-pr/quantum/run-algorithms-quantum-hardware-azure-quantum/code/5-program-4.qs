operation ApplyMarkingOracleAsPhaseOracle(
    markingOracle : ((Qubit[], Qubit) => Unit is Adj), 
    register : Qubit[]
) : Unit is Adj {
    using (target = Qubit()) {
        within {
            X(target);
            H(target);
        } apply {
            markingOracle(register, target);
        }
    }
}