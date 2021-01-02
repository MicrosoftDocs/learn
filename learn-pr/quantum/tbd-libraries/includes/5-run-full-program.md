In the previous unit, you defined the operation `ApplyIsbnOracle`, which takes as an argument the qubit register for our search space, as well as an ancilla qubit in $\ket{-}$ to be used by the oracle to flag the correct states. 
This process is handled by the `ComputeIsbnCheck` operation run within `ApplyIsbnOracle`.

Recall that the general process of Grover's algorithm works by applying a certain number of "Grover iterations" which consist of
- applying the oracle, which reflects the state about the bad solutions, and
- reflecting about the uniform superposition of states.

The first step is handled by the `ReflectAboutCorrectDigit` operation which you also defined previously (simply allocating the ancilla $\ket{-}$ before passing it all on to `ApplyIsbnOracle`).
The second step is *not* as problem specific as the oracle, but can be somewhat optimized for our situation. We implement it in the following. 

## Reflection about uniform superposition

In the [previous module using Grover's](https://docs.microsoft.com/learn/modules/solve-graph-coloring-problems-grovers-search/), the uniform superposition was created over all the $2^n$ number states spanned by the $n$ qubits. 
However, since we are only interested in the number states $0 - 9$, we have no use for the remaining states $10-15$ which our 4 qubits can represent.
Therefore, we will only utilize and reflect about the uniform superposition $\sum_{i=0}^9 \ket{i}$.

To prepare this on a qubit register `digit`, we define the operation `PrepareUnifromSuperpositionOverDigits` as

```qsharp
    operation PrepareUniformSuperpositionOverDigits(digit : LittleEndian) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(10, ComplexPolar(1.0, 0.0)), digit);
    }
```

Next, the reflection about this state is handled by `ReflectAboutUniform`:

```qsharp
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
```

## Grover iterations

Each Grover iteration will consist of one application of `ReflectAboutCorrectDigit` followed by `ReflectAboutUniform`.

The ideal number of Grover iterations to perform is provided by the number of possible solutions and the total number of states.
In this case, we have a single possible solution, so we define the function `NIterations` which takes the total number of states as an argument:

```qsharp
    function NIterations(nItems : Int) : Int {
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }
```
Since we only consider the 10 possible digits as our search space, we will provide this an argument of 10.


## Run the full program

Before you can run the whole program, note that some of the operations we implement require the Numerics library. 
Go ahead and add that by entering in the command line
```dotnet
dotnet add package Microsoft.Quantum.Numerics
```

Next, you will need to have access to all the operations, so be sure to include the `open` statements:
```qsharp
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;
```

To perform the full search, define the operation `SearchForMissingDigit` as below. Be sure to include the `@EntryPoint()` attribute before it, which will let you run it from the command line.

```qsharp
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
```

The `DumpMachine` call will allow us to see the full four-qubit quantum state, and the return will be the measurement result--hopefully the digit you need!

### Full file

Your program file should look like the following:

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

    operation PrepareUniformSuperpositionOverDigits(digit : LittleEndian) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(10, ComplexPolar(1.0, 0.0)), digit);
    }

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


## Find your missing digit

In the command line, enter `dotnet run` and your should see the following output:

```output
# wave function for qubits with ids (least to most significant): 0;1;2;3
∣ 0❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 1❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 2❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 3❭:   -0.012649 +  0.000000 i  ==     *                    [ 0.000160 ] ---     [  3.14159 rad ]
∣ 4❭:    0.999280 +  0.000000 i  ==     ******************** [ 0.998560 ]     --- [  0.00000 rad ]
∣ 5❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 6❭:   -0.012649 +  0.000000 i  ==     *                    [ 0.000160 ] ---     [  3.14159 rad ]
∣ 7❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 8❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 9❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣10❭:   -0.000000 +  0.000000 i  ==     *                    [ 0.000000 ]  \      [  2.23582 rad ]
∣11❭:   -0.000000 +  0.000000 i  ==     *                    [ 0.000000 ] ---     [  3.13413 rad ]
∣12❭:   -0.000000 + -0.000000 i  ==     *                    [ 0.000000 ]     --- [ -3.14159 rad ]
∣13❭:    0.000000 +  0.000000 i  ==     *                    [ 0.000000 ]     --- [  0.00000 rad ]
∣14❭:    0.000000 +  0.000000 i  ==     *                    [ 0.000000 ]     --- [  0.00000 rad ]
∣15❭:   -0.000000 +  0.000000 i  ==     *                    [ 0.000000 ] ---     [  3.14159 rad ]
4
```

As expected, we see that the Grover iterations left only one basis state with a significant amplitude; precisely that one corresponding to our missing digit: $\ket{4}$.
Hence the returned measurement result is 4.

A quick double check: $6\cdot 4 = 24$, so $(9 + 6\cdot 4) = 33 = 0 \text{ mod } 11$, and indeed this is a valid ISBN. 

You've got the book you need!

## What's next?

In case other space farers may need this same code, it's valuable to document it properly.
In the next unit you will add your own API documentation to some of these operations. 