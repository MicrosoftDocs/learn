namespace ExploringGroversSearchAlgorithm {
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;


    operation MarkColorEquality(c0 : Qubit[], c1 : Qubit[], target : Qubit) : Unit is Adj+Ctl {
        within {
            for ((q0, q1) in Zipped(c0, c1)) {
                CNOT(q0, q1);
            }
        } apply {
            (ControlledOnInt(0, X))(c1, target);
        }
    }


    operation MarkValidVertexColoring(
        edges : (Int, Int)[], 
        colorsRegister : Qubit[], 
        target : Qubit
    ) : Unit is Adj+Ctl {
        let nEdges = Length(edges);
        let colors = Chunks(2, colorsRegister);
        using (conflictQubits = Qubit[nEdges]) {
            within {
                for (((start, end), conflictQubit) in Zipped(edges, conflictQubits)) {
                    MarkColorEquality(colors[start], colors[end], conflictQubit);
                }
            } apply {
                (ControlledOnInt(0, X))(conflictQubits, target);
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
            within {
                ApplyToEachA(H, register);
                ApplyToEachA(X, register);
            } apply {
                Controlled Z(Most(register), Tail(register));
            }
        }
    }


    @EntryPoint()
    operation SolveGraphColoringProblem() : Unit {
        // Graph description: hardcoded from the example.
        let nVertices = 5;
        let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        // Define the oracle that implements this graph coloring.
        let markingOracle = MarkValidVertexColoring(edges, _, _);
        let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);

        // Define the parameters of the search.
        
        // Each color is described using 2 bits (or qubits).
        let nQubits = 2 * nVertices;

        // The search space is all bit strings of length nQubits.
        let searchSpaceSize = 2 ^ (nQubits);

        // The number of solutions is the number of permutations of 4 colors (over the first four vertices) = 4!
        // multiplied by 3 colors that vertex 4 can take in each case.
        let nSolutions = 72;

        // The number of iterations can be computed using a formula.
        let nIterations = Round(PI() / 4.0 * Sqrt(IntAsDouble(searchSpaceSize) / IntAsDouble(nSolutions)));

        mutable answer = new Bool[nQubits];
        using ((register, output) = (Qubit[nQubits], Qubit())) {
            mutable isCorrect = false;
            repeat {
                RunGroversSearch(register, phaseOracle, nIterations);
                let res = MultiM(register);
                // Check whether the result is correct.
                markingOracle(register, output);
                if (MResetZ(output) == One) {
                    set isCorrect = true;
                    set answer = ResultArrayAsBoolArray(res);
                }
                ResetAll(register);
            } until (isCorrect);
        }

        // Convert the answer to readable format (actual graph coloring).
        let colorBits = Chunks(2, answer);
        Message("The resulting graph coloring:");
        for (i in 0 .. nVertices - 1) {
            Message($"Vertex {i} - color {BoolArrayAsInt(colorBits[i])}");
        }
    }
}
