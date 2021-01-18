namespace GroversTutorial {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation FactorizeWithGrovers(number : Int) : Unit {
        
            // Define the oracle that for the factoring problem.
            let markingOracle = markingDivisor(number, _, _);
            let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);
            // Bit-size of the number to factorize.
            let size = BitSizeI(number);
            // Estimate of the number of solutions.
            let nSolutions = 4;
            // The number of iterations can be computed using the formula.
            let nIterations = Round(PI() / 4.0 * Sqrt(IntAsDouble(size) / IntAsDouble(nSolutions)));

            // Initialize the register to run the algorithm
            using ((register, output) = (Qubit[size], Qubit())){
                mutable isCorrect = false;
                mutable answer = 0;
                // Use a Repeat-Until-Succeed loop to iterate until the solution is valid.
                repeat {
                    RunGroversSearch(register, phaseOracle, nIterations);
                    let res = MultiM(register);
                    set answer = BoolArrayAsInt(ResultArrayAsBoolArray(res));
                    // Check that if the result is a solution with the oracle.
                    markingOracle(register, output);
                    if (MResetZ(output) == One and answer != 1 and answer != number) {
                        set isCorrect = true;
                    }
                    ResetAll(register);
                } until (isCorrect);

                // Print out the answer.
                Message($"The number {answer} is a factor of {number}.");
            }

    }

    operation markingDivisor (
        dividend : Int,
        divisorRegister : Qubit [],
        target : Qubit
    ) : Unit is Adj+Ctl {
        let size = BitSizeI(dividend);
        using ( (dividendQubits, resultQubits) = (Qubit[size], Qubit[size]) ){
            let xs = LittleEndian(dividendQubits);
            let ys = LittleEndian(divisorRegister);
            let result = LittleEndian(resultQubits);
            within{
                ApplyXorInPlace(dividend, xs);
                DivideI(xs, ys, result);
                ApplyToEachA(X, xs!);
            }
            apply{
                Controlled X(xs!, target);
            }
        }
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
        ApplyToEach(H, register);
        for (_ in 1 .. iterations) {
            phaseOracle(register);
            ReflectAboutUniform(register);
        }
    }

    operation ReflectAboutUniform(inputQubits : Qubit[]) : Unit {
        within {
            ApplyToEachA(H, inputQubits);
            ApplyToEachA(X, inputQubits);
        } apply {
            Controlled Z(Most(inputQubits), Tail(inputQubits));
        }
    }
    
}namespace GroversTutorial {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation FactorizeWithGrovers(nQubits : Int, idxMarked : Int) : Result[] {
            // Define the oracle that for the factoring problem.
            let markingOracle = markingNumber(idxMarked, _, _);
            let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);
            // Bit-size of the number to factorize.
            // Estimate of the number of solutions.
            let nSolutions = 1;
            // The number of iterations can be computed using the formula.
            let nIterations = Round(PI() / 4.0 * Sqrt(IntAsDouble(nQubits) / IntAsDouble(nSolutions)));

            // Initialize the register to run the algorithm
            using (qubits = Qubit[nQubits]){
                    RunGroversSearch(qubits, phaseOracle, nIterations);
                    return ForEach(MResetZ, qubits);
            }
    }

    @EntryPoint()
    operation SearchForMarkedInput(nQubits : Int, idxMarked : Int) : Result[] {
        using (qubits = Qubit[nQubits]) {
            // Initialize a uniform superposition over all possible inputs.
            PrepareUniform(qubits);
            // The search itself consists of repeatedly reflecting about the
            // marked state and our start state, which we can write out in Q#
            // as a for loop.
            for (idxIteration in 0..NIterations(nQubits) - 1) {
                ReflectAboutMarked(idxMarked, qubits);
                ReflectAboutUniform(qubits);
            }
            // Measure and return the answer.
            return ForEach(MResetZ, qubits);
        }
    }

    operation markingNumber (
        idxMarked : Int,
        inputQubits : Qubit [],
        target : Qubit
    ) : Unit is Adj+Ctl {
        (ControlledOnInt(idxMarked, X))(inputQubits, outputQubit);
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