In the previous unit, you defined the operation `IsbnOracle`. That operation takes as an argument the qubit register for our search space. It ultimately applies a phase factor of -1 to the number state $|x \rangle$, which satisfies the condition $(9 + 6 \cdot x) \bmod 11$. 

You also defined the operation `ComputeIsbnCheck`, which is used inside `IsbnOracle` and performs the necessary arithmetic mapping to a second qubit register. In addition, you wrote the function `GetIsbnCheckConstants` to determine the check condition constants $a$ and $b$ for $(b + a \cdot x) \bmod 11$ from any arbitrary ISBN with a single digit missing.

We'll continue in this unit with our use of the generalized code, passing these constants to the oracle.

Recall that the general process of Grover's algorithm works by applying a certain number of "Grover iterations." Each iteration consists of:

1. Applying the oracle.
2. Reflecting about the uniform superposition of states.

The first step is precisely what we defined in the previous unit with `IsbnOracle`.

The second step is sometimes called *reflection about the mean* or *diffusion*. It's *not* as problem specific as the oracle. Nonetheless, we can somewhat optimize it for our situation by using the following series of steps.

## Step 1. Reflect about uniform superposition

In the [previous module that used Grover's algorithm](/training/modules/solve-graph-coloring-problems-grovers-search?azure-portal=true), the uniform superposition was created over all the $2^n$ number states spanned by the $n$ qubits. In that case, the creation of the superposition is straightforwardly handled by applying the `H` operation to each individual qubit.

Because we're interested in only the number states $0-9$ here, we have no use for the remaining states ($10-15$) that our four qubits can represent. Therefore, we'll only use and reflect about the uniform superposition $\sum_{i=0}^9 |i \rangle$.

To prepare this state on qubit register `digitReg`, we define the operation `PrepareUnifromSuperpositionOverDigits` as:

:::code language="qsharp" source="../code/5-program-1.qs":::

You can think of this operation as analogous to the previous module's use of `ApplyToEachA(H, register)` to prepare the uniform superposition over all possible number states. There, the operation is used both in preparing the initial superposition of the algorithm and in the operation that corresponds to reflection about that superposition. The same is true here.

`ReflectAboutUniform` then implements the full step:

:::code language="qsharp" source="../code/5-program-2.qs":::

## Step 2. Determine the number of Grover iterations

Each Grover iteration will consist of one application of `IsbnOracle` followed by `ReflectAboutUniform`.

The number of possible solutions and the total number of states provide the ideal number of Grover iterations to perform. In this case, we have a single possible solution, so we define the function `NIterations`. That function takes the total number of states as an argument:

:::code language="qsharp" source="../code/5-program-3.qs":::

Because we consider only the 10 possible digits as our search space, we'll provide this as an argument of 10.

## Step 3. Wrap Grover's algorithm

To run Grover's algorithm, we can wrap everything into the single operation `RunGroversSearch`:

:::code language="qsharp" source="../code/5-program-4.qs":::

This operation is general for any phase oracle, so you can introduce the oracle that you defined in the previous unit as an argument.

## Step 4. Check the result

Recall that in most situations, Grover's algorithm is probabilistic. Although it typically returns a correct answer with a very high probability, there's often a finite chance that the measurement results in an incorrect solution. This is because it merely amplifies the amplitude of the "good" states, so the "bad" states will often retain small amplitudes.

To account for this, we simply check whether the result is correct and then repeat the algorithm if the result is incorrect. In our scenario, we define the classical *function* `IsIsbnValid` to check whether the returned missing digit $x$ provides a valid ISBN.

To keep things a little more general, let's use the general form for the ISBN validity (introduced at the beginning of the previous unit):
$$
\left ( \sum_{i=0}^{9} (10-i) x_i \right ) \bmod 11 = 0
$$

Our function takes an array of integers that correspond to our ISBN. In our example, it's 0-306-$x$0615-2, with $x$ (the missing digit) returned by the algorithm. The function returns `True` if the equation is satisfied and `False` if not.

:::code language="qsharp" source="../code/5-program-5.qs":::

Our full program simply repeats Grover's algorithm until this condition is met, indicating that the returned digit correctly completes the ISBN.

### Obtain the full ISBN

Recall that the incomplete ISBNs are provided as 10-integer arrays with the missing digit indicated by `-1`. To create the resulting ISBN array to check with `IsIsbnValid`, we also write the function `MakeResultIsbn`. The function replaces that `-1` with the `missingDigit` output by the algorithm:

:::code language="qsharp" source="../code/5-program-6.qs":::

## Step 5. Run the full program

You need to have access to all the operations, so be sure to include the `open` statements as follows. (We include the corresponding operations that they provide in case you're curious.)

:::code language="qsharp" source="../code/5-program-7.qs":::

To perform the full search, define the operation `SearchForMissingDigit` as follows. Be sure to include the `@EntryPoint()` attribute before it, so you can run it from the command line.

Your program file should look like the following:

:::code language="qsharp" source="../code/5-program-8.qs":::

> [!NOTE]
> This code snippet does not currently run on any available Azure Quantum hardware targets, as the callable `MeasureInteger` requires a QPU with [full computation profile](/azure/quantum/quantum-computing-target-profiles#create-and-run-applications-for--profile-targets).
>
> Learn module code that does not feature such a notice is executable on current hardware targets.

## Find your missing digit

Enter `dotnet run` in the command line, and you should see the following output:

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

As expected, the Grover iterations left only one basis state with a significant amplitude. That basis state corresponds to our missing digit: $|4 \rangle$. The returned measurement result is 4.

You've got the book you need!

## What's next?

In case other spacefarers might need this same code, you should document it properly. In the next unit, you'll add your own API documentation to some of these operations.
