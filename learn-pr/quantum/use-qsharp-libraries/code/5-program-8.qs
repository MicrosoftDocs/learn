namespace ISBNGrover {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic; 
    open Microsoft.Quantum.Arrays; 
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;


    @EntryPoint()
    operation SearchForMissingDigit() : Unit {

        // define the incomplete ISBN, missing digit at -1
        let inputISBN = [0, 3, 0, 6, -1, 0, 6, 1, 5, 2];
        let constants = GetIsbnCheckConstants(inputISBN);
        let (a, b) = constants;

        Message($"ISBN with missing digit: {inputISBN}");
        Message($"Oracle validates: ({b} + {a}x) mod 11 = 0 \n");

        // get the number of Grover iterations required for 10 possible results and 1 solution
        let numIterations = NIterations(10);

        // Define the oracle
        let phaseOracle = IsbnOracle(constants, _);

        // Allocate 4-qubit register necessary to represent the possible values (digits 0-9)
        use digitReg = Qubit[4];
        mutable missingDigit = 0;
        mutable resultISBN = new Int[10];
        mutable attempts = 0;

        // Repeat the algorithm until the result forms a valid ISBN
        repeat{
            RunGroversSearch(digitReg, phaseOracle, numIterations);
            // print the resulting state of the system and then measure
            DumpMachine(); 
            set missingDigit = MeasureInteger(LittleEndian(digitReg));
            set resultISBN = MakeResultIsbn(missingDigit, inputISBN);
            // keep track of the number of attempts
            set attempts = attempts  + 1;
        } 
        until IsIsbnValid(resultISBN);

        // print the results
        Message($"Missing digit: {missingDigit}");
        Message($"Full ISBN: {resultISBN}");
        if attempts == 1 {
            Message($"The missing digit was found in {attempts} attempt.");
        }
        else {
            Message( $"The missing digit was found in {attempts} attempts.");
        }
    }


    operation ComputeIsbnCheck(constants : (Int, Int), digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
        let (a, b) = constants;
        ApplyXorInPlace(b, LittleEndian(targetReg));
        MultiplyAndAddByModularInteger(a, 11, LittleEndian(digitReg), LittleEndian(targetReg));
    }


    operation IsbnOracle(constants : (Int, Int), digitReg : Qubit[]) : Unit is Adj + Ctl {
        use (targetReg, flagQubit) = (Qubit[Length(digitReg)], Qubit());
        within {
            X(flagQubit);
            H(flagQubit);
            ComputeIsbnCheck(constants, digitReg, targetReg);
        } apply {
            ApplyControlledOnInt(0, X, targetReg, flagQubit);
        }
    }


    function GetIsbnCheckConstants(digits : Int[]) : (Int, Int) {
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
        mutable a = 0;
        mutable b = 0;
        for (idx, digit) in Enumerated(digits) {
            if digit < 0 {
                set a = 10 - idx;
            }
            else {
                set b += (10 - idx) * digit;
            } 
        }
        return (a, b % 11);
    }


    function NIterations(nItems : Int) : Int {
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }


    operation PrepareUniformSuperpositionOverDigits(digitReg : Qubit[]) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(10, ComplexPolar(1.0, 0.0)), LittleEndian(digitReg));
    }


    operation ReflectAboutUniform(digitReg : Qubit[]) : Unit {
        within {
            Adjoint PrepareUniformSuperpositionOverDigits(digitReg);
            ApplyToEachCA(X, digitReg);
        } apply {
            Controlled Z(Most(digitReg), Tail(digitReg));
        }
    }


    function IsIsbnValid(digits : Int[]) : Bool {
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
        mutable acc = 0;
        for (idx, digit) in Enumerated(digits) {
            set acc += (10 - idx) * digit;
        }
        return acc % 11 == 0;
    }


    function MakeResultIsbn(missingDigit : Int, inputISBN : Int[]) : Int[] {
        mutable resultISBN = new Int[Length(inputISBN)];
        for i in 0..Length(inputISBN) - 1 {
            if inputISBN[i] < 0 {
                set resultISBN w/= i <- missingDigit;
            }
            else {
                set resultISBN w/= i <- inputISBN[i];
            }
        }
        return resultISBN;
    }


    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        PrepareUniformSuperpositionOverDigits(register);
        for _ in 1 .. iterations {
            phaseOracle(register);
            ReflectAboutUniform(register);
        }
    }

}