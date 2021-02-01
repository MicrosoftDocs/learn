namespace MyGroversJob {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation GroversTest(nQubits : Int, idxMarked : Int) : Result[] {
        // Define the oracle
        let markingOracle = markingNumber(idxMarked, _, _);
        let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);
        // Set the number of iterations of the algorithm
        let nIterations = NIterations(nQubits);

        // Initialize the register to run the algorithm
        using (qubits = Qubit[nQubits]){
                // Run the algorithm
                RunGroversSearch(qubits, phaseOracle, nIterations);
                // Obtain the results and reset the register
                return ForEach(MResetZ, qubits);
        }
    }

    function NIterations(nQubits : Int) : Int {
        let nItems = 1 <<< nQubits;
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }

    operation MarkingNumber (
        idxMarked : Int,
        inputQubits : Qubit [],
        target : Qubit
    ) : Unit is Adj+Ctl {
        (ControlledOnInt(idxMarked, X))(inputQubits, target);
    }

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

    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        ApplyToEachCA(H, register);
        for (_ in 1 .. iterations) {
            phaseOracle(register);
            ReflectAboutUniform(register);
        }
    }

    operation ReflectAboutUniform(inputQubits : Qubit[]) : Unit {
        within {
            ApplyToEachCA(H, inputQubits);
            ApplyToEachCA(X, inputQubits);
        } apply {
            Controlled Z(Most(inputQubits), Tail(inputQubits));
        }
    }
    
}