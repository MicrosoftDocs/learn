In the previous unit, you defined the operation `isbnOracle`, which takes as an argument the qubit register for our search space and ultimately applies a phase factor of -1 to the number state $\ket{x}$ which satisfies the condition $(9 + 6 \cdot x) \bmod 11$. 
To do so, you also defined the operation `ComputeIsbnCheck`, which is used inside `isbnOracle` and performs the necessary arithmetic mapping to a second qubit register.

Recall that the general process of Grover's algorithm works by applying a certain number of "Grover iterations," each of which consists of:
1. applying the oracle,
2. reflecting about the uniform superposition of states.

The first step is precisely what we defined in the previous unit with `isbnOracle`.

The second step---sometimes referred to as *reflection about the mean* or *diffusion*---is *not* as problem specific as the oracle.
Nonetheless, it can be somewhat optimized for our situation. 
We implement it in the following. 

## Reflection about uniform superposition

In the [previous module using Grover's](https://docs.microsoft.com/learn/modules/solve-graph-coloring-problems-grovers-search/), the uniform superposition was created over all the $2^n$ number states spanned by the $n$ qubits. 
In that case, the creation of the superposition is straightforwardly handled by applying the `H` operation to each individual qubit.

However, since we are only interested in the number states $0 - 9$, we have no use for the remaining states $10-15$ which our 4 qubits can represent.
Therefore, we will only utilize and reflect about the uniform superposition $\sum_{i=0}^9 \ket{i}$.

To prepare this on qubit register `digitReg`, we define the operation `PrepareUnifromSuperpositionOverDigits` as

```qsharp
    operation PrepareUniformSuperpositionOverDigits(digitReg : Qubit[]) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(10, ComplexPolar(1.0, 0.0)), LittleEndian(digitReg));
    }
```

You can think of this as analagous to the previous module's use of `ApplyToEachA(H, register)` to do prepare the uniform superposition over all possible number states.
There, the operation used both in preparing the initial superposition of the algorithm and in the operation corresponding to reflection about that superposition---the same is true here.

The full step is then implemented by `ReflectAboutUniform`:

```qsharp
    operation ReflectAboutUniform(digitReg : Qubit[]) : Unit {
        within {
            // Transform the uniform superposition to all-zero.
            Adjoint PrepareUniformSuperpositionOverDigits(digitReg);
            // Transform the all-zero state to all-ones
            ApplyToEachCA(X, digitReg);
        } apply {
            // Reflects about that all-ones state, then let
            // the within/apply block transform us back.
            Controlled Z(Most(digitReg), Tail(digitReg));
        }
    }
```

## Grover iterations

Each Grover iteration will consist of one application of `isbnOracle` followed by `ReflectAboutUniform`.

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

## Checking result

Recall that in most situations Grover's algorithm is probabilistic.
Although it typically returns a correct answer with a very high probability, there is often a finite chance that the measurement results in an incorrect solution. 
This is because it merely amplifies the amplitude of the "good" states, and therefore the "bad" states will often still retain small amplitudes.
To account for this, we simply check whether the result is correct and then repeat the algorithm if not.

In our scenario, we define the classical *function* `IsIsbnValid` to check whether the returned missing digit $x$ provides a valid ISBN. 
To keep things a little more general, let's use the general form for the ISBN validity (introduced at the beginning of the previous unit):
$$
\left ( \sum_{i=0}^{9} (10-i) x_i \right ) \bmod 11 = 0
$$

Our function will take an array of integers corresponding to our ISBN---in our case, 0-306-$x$0615-2 with $x$ the missing digit returned by the algorithm---and returns `True` if the equation is satisfied, `False` if not.

```qsharp
    function IsIsbnValid(digits : Int[]) : Bool {
        // ensure array is 10 digits
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
        
        mutable acc = 0;
        for ((idx, digit) in Enumerated(digits)) {
            set acc = (acc + (10 - idx) * digit) % 11;
        }
        return acc == 0;
    }
```

Thus our full program will simply repeat Grover's algorithm until this condition is met, indicating the returned digit correctly completes the ISBN. 

## Run the full program

Next, you will need to have access to all the operations, so be sure to include the `open` statements (we include the corresponding operations they provide in case you were curious): 

```qsharp
    open Microsoft.Quantum.Canon; // ApplyControlledOnInt, ApplyToEachCA
    open Microsoft.Quantum.Intrinsic; // X, H, Z
    open Microsoft.Quantum.Arithmetic; 
    // ApplyXorInPlace, MultiplyAndAddByModularInteger, LittleEndian, MeasureInteger
    open Microsoft.Quantum.Arrays; // ConstantArray, Most, Tail, Enumerated
    open Microsoft.Quantum.Convert; // IntAsDouble
    open Microsoft.Quantum.Math; // ArcSin, Sqrt, Round, PI, ComplexPolar
    open Microsoft.Quantum.Preparation; // PrepareArbitraryStateCP
    open Microsoft.Quantum.Diagnostics; // EqualityFactI, DumpMachine
```

To perform the full search, define the operation `SearchForMissingDigit` as below. Be sure to include the `@EntryPoint()` attribute before it, which will let you run it from the command line.

```qsharp
    @EntryPoint()
    operation SearchForMissingDigit() : Int {
        
        // get the number of Grover iterations required for 10 possible results and 1 solution
        let numIterations = NIterations(10);

        // Allocate 4-qubit register necessary to represent the possible values (digits 0-9)
        using (digitReg = Qubit[4]) {
            mutable missingDigit = 0;

            // Repeat the algorithm until the result forms a valid ISBN
            repeat{

                // Initialize a uniform superposition over all possible digit states
                PrepareUniformSuperpositionOverDigits(digitReg);

                // The Grover iterations
                for (idxIteration in 1..numIterations) {
                    // Apply the oracle
                    isbnOracle(digitReg);

                    // Reflect about the uniform superposition
                    ReflectAboutUniform(digitReg);
                }

                // Print the resulting state of the system and then measure
                DumpMachine(); 
                set missingDigit = MeasureInteger(LittleEndian(digitReg));
            } 
            until (IsIsbnValid([0, 3, 0, 6, missingDigit, 0, 6, 1, 5, 2]));

            return missingDigit;
        }
    }
```

The `DumpMachine` call will allow us to see the full four-qubit quantum state, and the return will be your missing digit!

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


    operation ComputeIsbnCheck(digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
        // Being freshly allocated, targetReg will be in |0⟩ when this operation is called.
        // We first intialize it to |9⟩:
        ApplyXorInPlace(9, LittleEndian(targetReg));

        // Apply the mapping |x⟩|9⟩ -> |x⟩ |(9 + 6x) mod 11 ⟩ where |x⟩ is the state of digitReg
        MultiplyAndAddByModularInteger(6, 11, LittleEndian(digitReg), LittleEndian(targetReg));
    }


    operation isbnOracle(digitReg : Qubit[]) : Unit is Adj + Ctl {
        // Allocate target register for oracle mapping, flag qubit for phase kickback
        using ((targetReg, flagQubit) = (Qubit[Length(digitReg)], Qubit()) ) {
            within {
                // Initialize flag qubit to |-⟩ 
                X(flagQubit);
                H(flagQubit);
                // Map targetReg to |(9 + 6x) mod 11 ⟩, where |x⟩ is the state of digitReg
                ComputeIsbnCheck(digitReg, targetReg);
            } apply {
                // States where targetReg is in |0⟩ number state will be flagged with a -1
                // phase due to controlled X they apply to the flag qubit in the |-⟩ state.  
                ApplyControlledOnInt(0, X, targetReg, flagQubit);
            }
        }
    }


    operation PrepareUniformSuperpositionOverDigits(digitReg : Qubit[]) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(10, ComplexPolar(1.0, 0.0)), LittleEndian(digitReg));
    }


    operation ReflectAboutUniform(digitReg : Qubit[]) : Unit {
        within {
            // Transform the uniform superposition to all-zero.
            Adjoint PrepareUniformSuperpositionOverDigits(digitReg);
            // Transform the all-zero state to all-ones
            ApplyToEachCA(X, digitReg);
        } apply {
            // Reflects about that all-ones state, then let
            // the within/apply block transform us back.
            Controlled Z(Most(digitReg), Tail(digitReg));
        }
    }


    function NIterations(nItems : Int) : Int {
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }


    function IsIsbnValid(digits : Int[]) : Bool {
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
        
        mutable acc = 0;
        for ((idx, digit) in Enumerated(digits)) {
            set acc = (acc + (10 - idx) * digit) % 11;
        }
        return acc == 0;
    }


    @EntryPoint()
    operation SearchForMissingDigit() : Int {
        
        // get the number of Grover iterations required for 10 possible results and 1 solution
        let numIterations = NIterations(10);

        // Allocate 4-qubit register necessary to represent the possible values (digits 0-9)
        using (digitReg = Qubit[4]) {
            mutable missingDigit = 0;

            // Repeat the algorithm until the result forms a valid ISBN
            repeat{

                // Initialize a uniform superposition over all possible digit states
                PrepareUniformSuperpositionOverDigits(digitReg);

                // The Grover iterations
                for (idxIteration in 1..numIterations) {
                    // Apply the oracle
                    isbnOracle(digitReg);

                    // Reflect about the uniform superposition
                    ReflectAboutUniform(digitReg);
                }

                // Print the resulting state of the system and then measure
                DumpMachine(); 
                set missingDigit = MeasureInteger(LittleEndian(digitReg));
            } 
            until (IsIsbnValid([0, 3, 0, 6, missingDigit, 0, 6, 1, 5, 2]));

            return missingDigit;
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
