In the previous unit, you defined the operation `IsbnOracle`, which takes as an argument the qubit register for our search space and ultimately applies a phase factor of -1 to the number state $|x \rangle$ which satisfies the condition $(9 + 6 \cdot x) \bmod 11$. 
To do so, you also defined the operation `ComputeIsbnCheck`, which is used inside `IsbnOracle` and performs the necessary arithmetic mapping to a second qubit register.
In addition, we wrote the function `GetIsbnCheckConstants` to determine the check condition constants $a$ and $b$ for $(b + a \cdot x) \bmod 11$ from any arbitrary ISBN with a single digit missing. 
We will continue below with our use of the generalized code, passing these constants to the oracle.

Recall that the general process of Grover's algorithm works by applying a certain number of "Grover iterations," each of which consists of:
1. applying the oracle,
2. reflecting about the uniform superposition of states.

The first step is precisely what we defined in the previous unit with `IsbnOracle`.

The second step---sometimes referred to as *reflection about the mean* or *diffusion*---is *not* as problem specific as the oracle.
Nonetheless, it can be somewhat optimized for our situation.
We implement it in the following.

## Reflection about uniform superposition

In the [previous module using Grover's](https://docs.microsoft.com/learn/modules/solve-graph-coloring-problems-grovers-search/), the uniform superposition was created over all the $2^n$ number states spanned by the $n$ qubits. 
In that case, the creation of the superposition is straightforwardly handled by applying the `H` operation to each individual qubit.

However, since we are only interested in the number states $0 - 9$, we have no use for the remaining states $10-15$ which our 4 qubits can represent.
Therefore, we will only utilize and reflect about the uniform superposition $\sum_{i=0}^9 |i \rangle$.

To prepare this state on qubit register `digitReg`, we define the operation `PrepareUnifromSuperpositionOverDigits` as

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

Each Grover iteration will consist of one application of `IsbnOracle` followed by `ReflectAboutUniform`.

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

## Wrap Grover's algorithm

Now to write Grover's algorithm we just need to wrap everything into a single operation `RunGroversSearch`:

```qsharp
operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
    // Prepare an equal superposition of all compatible states.
    PrepareUniformSuperpositionOverDigits(register);
    
    // Iterations of Grover's search
    for (_ in 1 .. iterations) {
        // Step 1: apply the oracle
        phaseOracle(register);
        // Step 2: reflect about the uniform superposition
        ReflectAboutUniform(register);
    }
}
```

This operation is general for any phase oracle, so you can to introduce as
argument the oracle you defined in the previous page.

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

Our function will take an array of integers corresponding to our ISBN---in our example, 0-306-$x$0615-2 with $x$ the missing digit returned by the algorithm---and returns `True` if the equation is satisfied, `False` if not.

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

### Obtain the full ISBN

Recall that the incomplete ISBNs will be provided as 10-integer arrays with the missing digit indicated by `-1`.
To create the reuslting ISBN array to check with `IsIsbnValid`, we also write the function `MakeResultIsbn` which replaces that `-1` with the `missingDigit` output by the algorithm:

```qsharp
    function MakeResultIsbn(missingDigit : Int, inputISBN : Int[]) : Int[] {
        mutable resultISBN = new Int[Length(inputISBN)];
        for (i in 0..Length(inputISBN) - 1) {
            if (inputISBN[i] < 0) {
                set resultISBN w/= i <- missingDigit;
            }
            else {
                set resultISBN w/= i <- inputISBN[i];
            }
        }
        return resultISBN;
    }
```

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
            using (digitReg = Qubit[4]) {
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
                until (IsIsbnValid(resultISBN));

                // print the results
                Message($"Missing digit: {missingDigit}");
                Message($"Full ISBN: {resultISBN}");
                if(attempts==1){
                    Message($"The missing digit was found in {attempts} attempt.");
                }
                else {
                    Message( $"The missing digit was found in {attempts} attempts.");
                }
            }
        }


        operation ComputeIsbnCheck(constants : (Int, Int), digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
            let (a, b) = constants; 
            ApplyXorInPlace(b, LittleEndian(targetReg));
            MultiplyAndAddByModularInteger(a, 11, LittleEndian(digitReg), LittleEndian(targetReg));
        }


        operation IsbnOracle(constants : (Int, Int), digitReg : Qubit[]) : Unit is Adj + Ctl {
            using ((targetReg, flagQubit) = (Qubit[Length(digitReg)], Qubit()) ) {
                within {
                    X(flagQubit);
                    H(flagQubit);
                    ComputeIsbnCheck(constants, digitReg, targetReg);
                } apply {  
                    ApplyControlledOnInt(0, X, targetReg, flagQubit);
                }
            }   
        }


        function GetIsbnCheckConstants(digits : Int[]) : (Int, Int) {
            EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
            mutable a = 0;
            mutable b = 0;
            for ((idx, digit) in Enumerated(digits)) {
                if (digit < 0) {
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
            for ((idx, digit) in Enumerated(digits)) {
                set acc += (10 - idx) * digit;
            }
            return acc % 11 == 0;
        }


        function MakeResultIsbn(missingDigit : Int, inputISBN : Int[]) : Int[] {
            mutable resultISBN = new Int[Length(inputISBN)];
            for (i in 0..Length(inputISBN) - 1) {
                if (inputISBN[i] < 0) {
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
            for (_ in 1 .. iterations) {
                phaseOracle(register);
                ReflectAboutUniform(register);
            }
        }

    }
```

## Find your missing digit

In the command line, enter `dotnet run` and your should see the following output:

```output
ISBN with missing digit: [0,3,0,6,-1,0,6,1,5,2]
Oracle validates: (9 + 6x) mod 11 = 0 

# wave function for qubits with ids (least to most significant): 0;1;2;3
∣ 0❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 1❭:   -0.012649 +  0.000000 i  ==     *                    [ 0.000160 ] ---     [  3.14159 rad ]
∣ 2❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 3❭:   -0.012649 +  0.000000 i  ==     *                    [ 0.000160 ] ---     [  3.14159 rad ]
∣ 4❭:    0.999280 +  0.000000 i  ==     ******************** [ 0.998560 ]     --- [  0.00000 rad ]
∣ 5❭:   -0.012649 +  0.000000 i  ==     *                    [ 0.000160 ] ---     [  3.14159 rad ]
∣ 6❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 7❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 8❭:   -0.012649 + -0.000000 i  ==     *                    [ 0.000160 ]     --- [ -3.14159 rad ]
∣ 9❭:   -0.012649 +  0.000000 i  ==     *                    [ 0.000160 ] ---     [  3.14159 rad ]
∣10❭:    0.000000 +  0.000000 i  ==     *                    [ 0.000000 ]      /  [  0.63970 rad ]
∣11❭:   -0.000000 +  0.000000 i  ==     *                    [ 0.000000 ] ---     [  2.94946 rad ]
∣12❭:   -0.000000 + -0.000000 i  ==     *                    [ 0.000000 ]     --- [ -3.14159 rad ]
∣13❭:    0.000000 + -0.000000 i  ==     *                    [ 0.000000 ]     --- [ -0.00000 rad ]
∣14❭:    0.000000 +  0.000000 i  ==     *                    [ 0.000000 ]     --- [  0.00000 rad ]
∣15❭:   -0.000000 + -0.000000 i  ==     *                    [ 0.000000 ]     --- [ -3.14159 rad ]
Missing digit: 4
Full ISBN: [0,3,0,6,4,0,6,1,5,2]
The missing digit was found in 1 attempt.
```

As expected, we see that the Grover iterations left only one basis state with a significant amplitude; precisely that one corresponding to our missing digit: $|4 \rangle$. Hence the returned measurement result is 4.

You've got the book you need!

## What's next?

In case other space farers may need this same code, it's valuable to document it properly.
In the next unit you will add your own API documentation to some of these operations. 
