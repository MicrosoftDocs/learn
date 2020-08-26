In this unit, you're going to explore how to create, manage, and inspect superpositions in Q#. We introduce a function from the Quantum Development Kit called `DumpMachine` that enables us to observe the probability amplitudes of the simulated qubit registers.

## Create the project

Start by creating a Q# project like you did for the quantum random number generator in the [Create your first Q# program by using the Quantum Development Kit](https://docs.microsoft.com/learn/modules/qsharp-create-first-quantum-development-kit?azure-portal=true) module. To do so:

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *ExploringSuperposition* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Include the Diagnostics namespace

The Diagnostics namespace `Microsoft.Quantum.Diagnostics` under the [Standard
library](https://docs.microsoft.com/quantum/user-guide/libraries/standard?azure-portal=true)
of the Quantum Development Kit contains functions and operations that are useful for
diagnostic purposes.

For the moment, we're interested in the [DumpMachine](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.diagnostics.dumpmachine?azure-portal=true) function. This function dumps information about the current status of the target machine
into a file or some other location. If you omit the `location`, this function print the output in the console. We'll use this information to track the state of the qubit register.

> [!NOTE]
> `DumpMachine` is only useful for simulations. On quantum
> hardware, `DumpMachine` won't do anything since we can't access the
> state of the qubit register during execution. Remember that measuring the
> state of a qubit can change its state. In simulated virtual quantum computers,
> we can use tools like `DumpMachine` and to explore the state of the system.

To add the library, you use the `open` directive. Modify *Program.qs* like this:

:::code language="qsharp" source="code/3-program-0.qs" highlight="4":::

## Dump the state of the program

You can use the `GenerateRandomBit` operation that you defined in the in the [Create your first Q# program by using the Quantum Development Kit](https://docs.microsoft.com/learn/modules/qsharp-create-first-quantum-development-kit?azure-portal=true) module to see how `DumpMachine` works.

To do so, you simply call `DumpMachine` at every step that you want to see the state of the register.

1. Modify *Program.qs* like this and then save the file:

    :::code language="qsharp" source="code/3-program-1.qs":::

    Here, you call `DumpMachine()` four times:

    1. After the qubit is allocated.
    1. After placing the qubit in superposition.
    1. After measuring the qubit's state.
    1. After resetting the qubit.

    Note that you split the operation `MResetZ` into two operations: `M` and `Reset`. You do so because you want to observe the state after the measurement.

1. Open the integrated terminal. From the **Terminal** menu, select **New Terminal**.
1. From the terminal, run `dotnet run`:

    ```bash
    dotnet run
    ```

    At the end of the program, you get a result of `Zero` or `One`.

    If you obtain the result `One`, you see this output:

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

The `DumpMachine` function outputs a table with the information that describes the state of the qubit register. Specifically, it gives the probability amplitude, the probability, and the phase in radians for each state. Let's look at each step:

1. ```output
       Initialized qubit:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
       |1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
   ```

   Every qubit allocated with the `using` statement starts in the state $\ket{0}$, so `DumpMachine` outputs the information that corresponds to a single qubit register in the state $\ket{0}$.

1. ```output
       Qubit after applying H:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
       |1⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

   ```

   After applying `H`, we prepare the qubit into the superposition state $\ket{\psi}=\frac1{\sqrt2} \ket{0} + \frac1{\sqrt2} \ket{1}$.

1. ```output
       Qubit after the measurement:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
       |1⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
   ```

   After measuring and storing the outcome `One`, the state of the registers collapses to $\ket{1}$ and is no longer in superposition.

1. ```output
       Qubit after resetting:
       # wave function for qubits with ids (least to most significant): 0
       |0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
       |1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
   ```

   The operation `Reset` resets the qubit to the state $\ket{0}$. Remember that for any Q# operation you
   always need to leave the qubits you use in the state $\ket{0}$ so that it can be used by other operations.

> [!TIP]
> Q# can also be run in Jupyter Notebooks. These notebooks provide a better visualization of the `DumpMachine` outputs. You can install them and try them out by following the Quantum Development Kit documentation on [Q# Jupyter Notebooks](https://docs.microsoft.com/quantum/quickstarts/install-jupyter).

## Explore different superpositions

Now that you know how to inspect the state of a register, you can see operations that modify the state of your qubits and put them into a superposition.

The current random number generator produces either `Zero` or `One` with a 50% probability. Let's look at a second example that generates random numbers with a different probability.

### Skewed random bit generator

Suppose you want to create a random bit generator that is skewed. For example, you want the outcome `Zero` with probability $\alpha$ and the outcome `One` with probability $1-\alpha$. A valid qubit state that will produce such random bit generator is:

$$\ket{\psi}=\sqrt\alpha\ket{0}+\sqrt{1-\alpha}\ket{1}$$

This state can be obtained by sequentially applying the operations [Rx](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.Rx?azure-portal=true)($2\arctan \sqrt{\frac\alpha{1-\alpha}}$) and [S](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.S?azure-portal=true) to a qubit in the state $\ket{0}.$

> [!TIP]
> If you want to learn more about the math behind single qubit operations, check out the
> [Single qubit gates quantum kata](https://github.com/microsoft/QuantumKatas/tree/master/tutorials/SingleQubitGates?azure-portal=true).

1. Modify *Program.qs* like this and then save the file:

    :::code language="qsharp" source="code/3-program-2.qs":::

1. From the terminal, run `dotnet run`. This example chooses $\alpha = \frac13$:

    ```bash
    dotnet run --alpha 0.333333
    ```

    Here's an example that outputs `One`.

    ```output
    The qubit is in the desired state.
    # wave function for qubits with ids (least to most significant): 0
    |0⟩:     0.577350 +  0.000000 i  ==     *******              [ 0.333333 ]     --- [  0.00000 rad ]
    |1⟩:     0.816497 +  0.000000 i  ==     **************       [ 0.666667 ]     --- [  0.00000 rad ]
    Your skewed random bit is:
    One
    ```

    You can see how `DumpMachine` displays the expected state after applying the operations and displays the associated probabilities.

### Multi-qubit superposition

Now let's explore superpositions of a register of many qubits. For example, if you have a register with three qubits, then you have eight different basis states:

$$\ket{000},\ket{001},\ket{010},\ket{011},\ket{100},\ket{101},\ket{110},\ket{111} $$

Therefore, an arbitrary 3-qubit state can be expressed as:

$$\ket{\psi}=a_0\ket{000}+a_1\ket{001}+a_3\ket{010}+a_4\ket{011}+a_5\ket{100}+a_6\ket{101}+a_7\ket{110}+a_7\ket{111}$$

where $a_i$ are complex numbers that satisfy $\sum|a_i|^2=1$.

For instance, you can place qubits in a uniform superposition by applying `H` to each qubit. You can use this uniform superposition to create a different version of the quantum random number generator that generates 3-bit numbers by measuring three qubits in superposition
instead of one qubit three times.

1. Modify *Program.qs* like this and then save the file:

    :::code language="qsharp" source="code/3-program-3.qs":::

    Here, we introduce three concepts:

    * The `qubits` variable now represents a `Qubit` array with a length of three. You can learn more about arrays in Q# in the [QDK documentation](https://docs.microsoft.com/quantum/user-guide/language/types#array-types?azure-portal=true).
    * The [ApplyToEach](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.canon.applytoeach?azure-portal=true), [ResetAll](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.resetall) and [ForEach](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.arrays.foreach?azure-portal=true) functions perform operations and measurements on multiple qubits with less code. Q# libraries offer many different functions that make writing quantum programs more efficient.
    * The [BoolArrayAsInt](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.convert.boolarrayasint?azure-portal=true) and [ResultArrayAsBoolArray](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.convert.resultarrayasboolarray?azure-portal=true) fucntions from the `Microsoft.Quantum.Convert` library transform the binary `Result` array returned by `ForEach(M, qubits)` into an integer.

1. From the terminal, run `dotnet run`.

    ```bash
    dotnet run
    ```

    Here's example output that produces the number four:

    ```output
    The qubit register in a uniform superposition: 
    # wave function for qubits with ids (least to most significant): 0;1;2
    ∣0❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣1❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣2❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣3❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣4❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣5❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣6❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    ∣7❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    Measuring the qubits collapses the superposition to a basis state.
    # wave function for qubits with ids (least to most significant): 0;1;2
    ∣0❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    ∣1❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    ∣2❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    ∣3❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    ∣4❭:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
    ∣5❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    ∣6❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    ∣7❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]                   
    4
    ```

    You can see with `DumpMachine` how the act of measuring the three qubits collapses the state of the register to one of the eight possible basis states.

    What would happen if instead of measuring the three qubits at once with `ForEach(M, qubits)`, you measure them sequentially? To do so, you just need to modify the code slightly.

1. Modify *Program.qs* like this and then save the file:

    :::code language="qsharp" source="code/3-program-4.qs":::

    Here, you use a `for` loop to act on each qubit sequentially. Q# has classical flow control capabilities. You can learn more about the different Q# flow control statements in the [Quantum Development Kit documentation](https://docs.microsoft.com/quantum/user-guide/using-qsharp/control-flow?azure-portal=true).

    Your output resembles this:

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

You can see how each consecutive measurement alters the quantum state, and therefore the probabilities of obtaining each outcome.

Let's look briefly on each step:

1. **State preparation:** after applying `H` to each qubit of the register we obtain a uniform superposition.

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
    ```

1. **First measurement:** in the first measurement, the result was `One`. Therefore, all the amplitudes of the states whose rightmost qubit is `Zero` are no longer present, this is $\ket{0}=\ket{000}, \ket{2}=\ket{010}, \ket{4}=\ket{100}$ and $\ket{6}=\ket{110}$. The rest of the amplitudes increase to fulfill the normalization condition.

    ```output
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

1. **Third measurement:** in the third measurement, the result was `One`, so all the amplitudes of the states whose leftmost qubit is `Zero` get vanished. The only compatible state is $\ket{5}=\ket{101}$, that gets an amplitude probability of $1$.

    ```output
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

In the next part, you'll explore two important concepts of quantum computing: interference and entanglement.
