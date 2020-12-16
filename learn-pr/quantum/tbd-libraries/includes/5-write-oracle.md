> [!NOTE]
> Overview of page: puts the whole file together and runs
> To-do: rename files to align with all this

## Reflections

## Grover iterations





### Setup

First things first, create a new Q# project. 

Some of the operations we will implement require the Numerics library, so go ahead and add that by entering in the command line
```dotnet
dotnet add package Microsoft.Quantum.Numerics
```

## Full file

The full file looks like
```qsharp
namespace ISBNGrover {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;

    /// # Remarks
    /// Implements the map by preparing a register, scratch, in the state |9>, applying the map to it, 
    /// and then transferring its contents to targetReg via the CNOTs before releasing it.
    operation ComputeIsbnCheck(missingDigitReg : LittleEndian, targetReg : LittleEndian) : Unit is Adj + Ctl {
        using (rawScratch = Qubit[Length(missingDigitReg!)]) {
            let scratchReg = LittleEndian(rawScratch);
            
            within {
                ApplyXorInPlace(9, scratchReg);
                MultiplyAndAddByModularInteger(6, 11, missingDigitReg, scratchReg);
            } apply {
                ApplyToEachCA(CNOT, Zipped(scratchReg!, targetReg!));
            }
            
        }
    }

    operation ApplyIsbnOracle(missingDigitReg : LittleEndian, flagQubit : Qubit) : Unit is Adj + Ctl {
        // Allocate an additional register for the check digit.
        using (rawTarget = Qubit[Length(missingDigitReg!)]) {
            let targetReg = LittleEndian(rawTarget);
            
            within {
                ComputeIsbnCheck(missingDigitReg, targetReg);
            } apply {
                // The flag qubit will be already initialized in |-> when this is applied.
                // Thus those states where targetReg is in |0> number state (the good solutions)
                // will be flagged with a -1 phase due to the controlled X they apply to the |-> state.  
                ApplyControlledOnInt(0, X, targetReg!, flagQubit);
            }
        }
    }


    operation ReflectAboutCorrectDigit(missingDigitReg : LittleEndian) : Unit is Adj + Ctl {
        using (flagQubit = Qubit()) {
            within {
                // put flagQubit in |->
                X(flagQubit);
                H(flagQubit);
            } apply {
                // uses phase kickback to flag the good solutions with a -1 phase
                ApplyIsbnOracle(missingDigitReg, flagQubit);
            }
        }
    }

    function NIterations(nItems : Int) : Int {
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }

    /// # Remarks
    /// Creates a uniform superposition in the 10-digit subspace, as opposed to all 16 digits 
    /// possible with the 4 qubit register
    operation PrepareUniformSuperpositionOverDigits(digit : LittleEndian) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(10, ComplexPolar(1.0, 0.0)), digit);
    }

    /// # Remarks
    /// Note we only do the reflection about the 10-digit subspace 
    /// created by PrepareUniformSuperpositionOverDigits
    operation ReflectAboutUniform(digit : LittleEndian) : Unit {
        within {
            // Transform the uniform superposition to all-zero.
            Adjoint PrepareUniformSuperpositionOverDigits(digit);
            // Transform the all-zero state to all-ones
            ApplyToEachCA(X, digit!);
        } apply {
            // Now that we've transformed the uniform superposition to the
            // all-ones state, reflect about the all-ones state, then let
            // the within/apply block transform us back.
            Controlled Z(Most(digit!), Tail(digit!));
        }
    }

    @EntryPoint()
    operation SearchForMissingDigit() : Int {
        using (raw = Qubit[4]) {
            let digit = LittleEndian(raw);

            // Initialize a uniform superposition over all possible inputs.
            PrepareUniformSuperpositionOverDigits(digit);

            // The search itself consists of repeatedly reflecting about the
            // marked state and our start state, which we can write out in Q#
            // as a for loop.
            for (idxIteration in 0..NIterations(10) - 1) {
                ReflectAboutCorrectDigit(digit);
                ReflectAboutUniform(digit);
            }

            // Measure and return the answer.
            DumpMachine();
            return MeasureInteger(digit);
        }
    }
}
```

## What's the missing digit?

Run it
