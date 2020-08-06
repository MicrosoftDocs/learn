In this unit, we're going to explore how to create, manage, and inspect superpositions in Q#. We'll introduce a function from the Quantum Development Kit called `DumpMachine` that will allow us to observe the probability amplitudes of the simulated qubit registers.

## Create the project

Let's start by creating a Q# project like we did for the quantum random number generator.

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *QuantumRNG* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Include the Diagnostics namespace

The Diagnostics namespace `Microsoft.Quantum.Diagnostics` under the [Standard
library](https://docs.microsoft.com/quantum/user-guide/libraries/standard?azure-portal=true)
of the Quantum Development Kit contains functions and operations useful for
diagnostic purposes. For the moment, we're interested in the function
[`DumpMachine`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.diagnostics.dumpmachine?azure-portal=true).
This function dumps information about the current status of the target machine
into a file or some other location. If we omit the `location` in the argument,
it will print the output in the console. We'll use this information to track the
state of the qubit register.

> [!NOTE] 
> `DumpMachine` is only useful for simulations. In actual quantum
> hardware `DumpMachine` won't do anything at all since we can't access the
> state of the qubit register during the execution. Remember that measuring the
> state of a qubit may change its state. In simulated virtual quantum computers,
> we can use tools like `DumpMachine` and do *tricks* like these.

To add the library, we open `Microsoft.Quantum.Diagnostic` in the namespace:

 ```qsharp
     namespace ExploringSuperposition {
         open Microsoft.Quantum.Canon;
         open Microsoft.Quantum.Intrinsic;
         open Microsoft.Quantum.Diagnostics;
         
         ...
     }
 ```

## Learn to use `DumpMachine`

We can use the `GenerateRandomBit` operation we defined in the previous module to see
how `DumpMachine` works. We just need to add `DumpMachine()` on every step we want to
see the state of the register. In this case we'll call `DumpMachine()` three times:
at the beginning before

```
namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation GenerateRandomBit() : Result {
        using (q = Qubit()) {
            Message("Initialized qubit:");
            DumpMachine();
            Message(" ");
            H(q);
            Message("Qubit after applying H:");
            DumpMachine();
            Message(" ");
            let randomBit = M(q);
            Message("Qubit after the measurement:");
            DumpMachine();
            Message(" ");
            Reset(q);
            Message("Qubit after resetting:");
            DumpMachine();
            Message(" ");
            return randomBit;
        }
    }
}
```

Note that we split the operation `MResetZ` into two operations `M` and `Reset` since we want to observe the state after the measurement.

We run the code using the command `dotnet run` in the terminal. If we obtain the result `One`, we should see the following outcome:

```output 
Initialized qubit:
# wave function for qubits with ids (least to most significant): 0
|0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

Qubit after applying H:
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

Qubit after the measurement:
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|1⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]

Qubit after resetting:
# wave function for qubits with ids (least to most significant): 0
|0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

One
```

The `DumpMachine` function outputs a table with the information characterizing the state of the qubit register. Specifically, it gives the probability amplitude, the probability, and the phase in radians for each state. Let's comment on each step:

1. ```output
       Initialized qubit:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
       |1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
   ```

   Every qubit allocated with the `using` statement starts in the state $\ket{0}$, so `DumpMachine` outputs 
   the information corresponding to a single qubit register in the state
   $\ket{0}$.

1. ```output
       Qubit after applying H:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
       |1⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

   ```

   After applying `H` we prepare the qubit into the superposition state $\ket{\psi}=\frac1{\sqrt2} \ket{0} + \frac1{\sqrt2} \ket{1}$.

1. ```output
       Qubit after the measurement:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
       |1⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
   ```

   After measuring and storing the outcome `One`, the state of the registers
   collapses to $\ket{1}$ and is no longer in a superposition.

1. ```output
       Qubit after resetting:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
       |1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
   ```

   The operation `Reset` gives back the qubit to the state $\ket{0}$. Remember that for any Q# operation you
   always need to leave the qubits you use in the state $\ket{0}$ to be readily available for being used by other
   operations.

> [!TIP]
> Q# can also be run in Jupyter Notebooks. These notebooks provide a better
> visualization of the `DumpMachine` outputs. You can install them and try them
> out by following the official Quantum Development Kit documentation on [Q#
> Jupyter Notebooks](https://docs.microsoft.com/quantum/quickstarts/install-jupyter).

## Explore different superpositions

Now that we know how to inspect the state of a register, we can see operations that
modify the state of our qubits and put them into a superposition.

### Skewed random bit generator

Suppose that we want to create a random bit generator that is skewed. For example, 
it gives the outcome `Zero` with probability $\alpha$ and the outcome `One` with 
probability $1-\alpha$. A valid qubit state that will produce such random bit generator
is:

$$\ket{\psi}=\sqrt\alpha\ket{0}+\sqrt{1-\alpha}\ket{1}$$

This state can be obtained applying sequentially the operations [`Rx`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.Rx?azure-portal=true)($2\arctan \sqrt{\frac\alpha{1-\alpha}}$) and [`S`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.S?azure-portal=true)
to a qubit in the state $\ket{0}.$

> [!TIP]
> If you want to learn more about the math behind single qubit operations, 
> you can check the
> [Single qubit gates quantum katas](https://github.com/microsoft/QuantumKatas/tree/master/tutorials/SingleQubitGates?azure-portal=true).

The operation would be:

```qsharp
namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;

    @EntryPoint()
    operation GenerateSpecificState(alpha : Double) : Result {
        using (q = Qubit()) {
            Rx(2.0 * ArcTan2(Sqrt(1.0-alpha), Sqrt(alpha)), q);
            S(q);
            Message("The qubit is in the desired state.");
            DumpMachine();
            Message("Your skewed random bit is:");
            return MResetZ(q);
        }
    }
}
```

Let's try it out. If we choose $\alpha = \frac13$:

```outcome
dotnet run --alpha 0.333333
The qubit is in the desired state.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.577350 +  0.000000 i  ==     *******              [ 0.333333 ]     --- [  0.00000 rad ]
|1⟩:     0.816497 +  0.000000 i  ==     **************       [ 0.666667 ]     --- [  0.00000 rad ]
Your skewed random bit is:
One
```

We can see how  `DumpMachine` displays the wanted state after applying the operations
and displays the correct probabilities.

### Multi-qubit superposition

Now let's explore superpositions of a register of many qubits. For example, if we have a 
register with 3 qubits we have 8 different states:

$$\ket{000},\ket{001},\ket{010},\ket{011},\ket{100},\ket{101},\ket{110},\ket{111} $$

So an arbitrary 3-qubit state can be expressed as:

$$\ket{\psi}=a_0\ket{000}+a_1\ket{001}+a_3\ket{010}+a_4\ket{011}+a_5\ket{100}+a_6\ket{101}+a_7\ket{110}+a_7\ket{111}$$

where $a_i$ are complex numbers that satisfy $\sum|a_i|^2=1$.

For instance, we can put the qubits in a uniform superposition applying `H` to each qubit. We can use this uniform superposition to create a different version of the quantum random number generator that measures three qubits in superposition
instead of one qubit three times.

```qsharp
namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation GenerateRandomNumber() : Int {
        using (qubits = Qubit[3]){
            ApplyToEach(H, qubits);
            Message("The qubit register in a uniform superposition: ");
            DumpMachine();
            let result = ForEach(M, qubits);
            Message("Measuring the qubits collapses the superposition to a basis state.");
            DumpMachine();
            ResetAll(qubits);
            return BoolArrayAsInt(ResultArrayAsBoolArray(result));
        }
    }
}
```

In this code we introduced three concepts:

* Now `qubits` represents a `Qubit` array of dimension 3. You can learn more about arrays in Q# in the [QDK documentation](https://docs.microsoft.com/quantum/user-guide/language/types#array-types).
* We use the functions [`ApplyToEach`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.canon.applytoeach), [`ResetAll`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.resetall) and [`ForEach`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.arrays.foreach) to perform operations and measurements on multiple qubits with less code. Q# libraries offer many different functions alike that make writing quantum programs more efficient. 
* We use the functions [`BoolArrayAsInt`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.convert.boolarrayasint) and [`ResultArrayAsBoolArray`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.convert.resultarrayasboolarray) from the library `Microsoft.Quantum.Convert` to
transform the binary `Result` array returned by `ForEach(M, qubits)` into an integer number.

The output should be something like this:

```output
    The qubit register in a uniform superposition: 
    # wave function for qubits with ids (least to most significant): 0;1;2
    |0⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |1⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |2⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |3⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |4⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |5⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |6⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |7⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    Measuring the qubits collapses the superposition to a basis state.
    # wave function for qubits with ids (least to most significant): 0;1;2
    |0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |3⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
    |4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |5⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |7⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    Your random number is:
    3
```

We can see with `DumpMachine` how the act of measuring the three qubits
collapses the state of the register to one of the eight possible basis states. 

What would happen if instead of measuring the three qubits at once with
`ForEac(M, qubits)` we measure them sequentially? We can check it, we just need to
slightly modify the code:

```qsharp
namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    @EntryPoint()
    operation GenerateUniformState() : Int {
        using (qubits = Qubit[3]){
        ApplyToEach(H, qubits);
        Message("The qubit register in a uniform superposition: ");
        DumpMachine();
        mutable results = new Result[0];
        for (q in qubits) {
               Message(" ");
               set results += [M(q)];
               DumpMachine();
        }

        ResetAll(qubits);
        Message(" ");
        Message("Your random number is: ");
        return BoolArrayAsInt(ResultArrayAsBoolArray(results));
        }
    }
}
```

In this block, we have introduced the use of the loop `for`. Q# as a full stack programming language has classical flow control capabilities. You can learn more about the different Q# flow control statements in the [Quantum Development Kit documentation](https://docs.microsoft.com/quantum/user-guide/using-qsharp/control-flow).

The output of this code should be something like this:

```output
The qubit register in a uniform superposition: 
# wave function for qubits with ids (least to most significant): 0;1;2
|0⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|1⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|2⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|3⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|4⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|5⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|6⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
|7⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]

# wave function for qubits with ids (least to most significant): 0;1;2
|0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|1⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
|4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|5⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
|6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|7⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]

# wave function for qubits with ids (least to most significant): 0;1;2
|0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|1⟩:     0.707107 +  0.000000 i  ==     **********           [ 0.500000 ]     --- [  0.00000 rad ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|5⟩:     0.707107 +  0.000000 i  ==     **********           [ 0.500000 ]     --- [  0.00000 rad ]
|6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|7⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

# wave function for qubits with ids (least to most significant): 0;1;2
|0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|5⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
|6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|7⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

Your random number is:
5
```

We can see how each consecutive measurement alters the quantum state, and
therefore the probabilities of obtaining each outcome. Let's comment briefly on
each step:

1. **State preparation:** after applying `H` to each qubit of the register we obtain
  a uniform superposition.

    ```qsharp
    The qubit register in a uniform superposition: 
    # wave function for qubits with ids (least to most significant): 0;1;2
    |0⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |1⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |2⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |3⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |4⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |5⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |6⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    |7⟩:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ```

1. **First measurement:** in the first measurement, the result was `One`.
   Therefore, all the amplitudes of the states whose rightmost qubit is `Zero`
   get vanisheid, this is $\ket{0}=\ket{000}, \ket{2}=\ket{010}, \ket{4}=\ket{100}$
   and $\ket{6}=\ket{110}$. The rest of the amplitudes increase to fulfill the
   normalization condition.

    ```qsharp
    # wave function for qubits with ids (least to most significant): 0;1;2
    |0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |1⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    |2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |3⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    |4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |5⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    |6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |7⟩:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    ```

1. **Second measurement:** in the second measurement, the result was `Zero`, so
   all the amplitudes of the states whose second rightmost (middle) qubit is `One` get
   vanished, this is $\ket{3}=\ket{011}$, and $\ket{7}=\ket{111}$. The rest of the
   amplitudes increase to fulfill the normalization condition.

    ```qsharp
    # wave function for qubits with ids (least to most significant): 0;1;2
    |0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |1⟩:     0.707107 +  0.000000 i  ==     **********           [ 0.500000 ]     --- [  0.00000 rad ]
    |2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |3⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |5⟩:     0.707107 +  0.000000 i  ==     **********           [ 0.500000 ]     --- [  0.00000 rad ]
    |6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |7⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    ```

1. **Third measurement:** in the third measurement, the result was `One`, so
   all the amplitudes of the states whose leftmost qubit is `Zero` get
   vanished. The only compatible state is $\ket{5}=\ket{101}$, that get's an
   amplitude probability of $1$.

    ```qsharp
    # wave function for qubits with ids (least to most significant): 0;1;2
    |0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |3⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |4⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |5⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
    |6⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    |7⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    
    Your random number is:
    5
    ```

In the next unit, we're going to explore two important concepts of quantum
computing: interference and entanglement.
