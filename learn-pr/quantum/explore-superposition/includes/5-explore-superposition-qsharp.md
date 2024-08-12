
In this unit, you'll learn to explore quantum superposition and probabilities in Q# by using the `DumpMachine` function. 

The `DumpMachine` function dumps information about the current status of the target machine at the point where it's called.


> [!NOTE]
> The `DumpMachine` function is useful only for simulations. On quantum
> hardware, `DumpMachine` does nothing because we can't access the
> state of the qubit register during execution. Remember that measuring the
> state of a qubit can change its state. On simulated virtual quantum computers,
> we can use tools like `DumpMachine` to explore the state of the system.

## Create a new Q# file

1. Open Visual Studio Code.
1. In Visual Studio Code, select **File > New Text File** and save the file as **Superposition.qs**.
1. Select **View -> Command Palette** and type **Q#: Set the Azure Quantum QIR target profile**. Press **Enter**.
1. Select **Q#: Unrestricted**.

### Get started

Let's start with a simple program that generates a random bit using a qubit in superposition. We'll use the `DumpMachine` function to see the state of the qubit at different points in the program.

1. Add the following code to the **Superposition.qs** file:

    ```qsharp
    namespace ExploringSuperposition {
        open Microsoft.Quantum.Diagnostics;
        
        @EntryPoint()
        operation GenerateRandomBit() : Result {
            use q = Qubit();
            Message("Initialized qubit:");
            DumpMachine(); // First dump
            Message(" ");
            H(q);
            Message("Qubit after applying H:");
            DumpMachine(); // Second dump
            Message(" ");
            let randomBit = M(q);
            Message("Qubit after the measurement:");
            DumpMachine(); // Third dump
            Message(" ");
            Reset(q);
            Message("Qubit after resetting:");
            DumpMachine(); // Fourth dump
            Message(" ");
            return randomBit;
        }
    }
    ```

    Here, you call `DumpMachine` four times:

    - After the qubit is allocated.
    - After you place the qubit in superposition.
    - After you measure the qubit's state.
    - After you reset the qubit.

    You split the operation `MResetZ` into two operations: `M` and `Reset`. You do so because you want to inspect the state after the measurement.

1. To run your program locally on the built-in simulator, click on **Run** from the list of commands below `@EntryPoint()`, or press **Ctrl+F5**. Your output will appear in the debug console.
1. The `DumpMachine` function creates a table of information that describes the state of the qubit register. Specifically, it gives the probability amplitude, the probability, and the phase in radians for each basis state.
1. At the end of the program, you get a result of `Zero` or `One`. Let's look at each step.
    1. **Initialized qubit:** Every qubit that's allocated with the `use` statement starts in the state $|0\rangle$. So `DumpMachine` produces the information that corresponds to a single-qubit register in the state $|0\rangle$.
    
        ```output
        Initialized qubit:
    
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
           |0⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
       ```
    
    1. **Qubit after applying H:** After applying `H`, we prepare the qubit in the superposition state $|\psi\rangle=\frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle$.
    
        ```output
        Qubit after applying H:
    
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
           |0⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
           |1⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
       ```
    
    1. **Qubit after the measurement:** After we measure and store the outcome, which can be a `Zero` or `One`. For example, if the resulting state is `One`, the state of the registers collapses to $|1\rangle$ and is no longer in superposition.
    
        ```output
        Qubit after the measurement:
    
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
           |1⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
       ```
    
    1. **Qubit after resetting:** The operation `Reset` resets the qubit to the state $|0\rangle$. Remember that for any Q# operation, you
       always need to leave the qubits you use in the state $|0\rangle$ so that other operations can use it.
    
        ```output
        Qubit after resetting:
    
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
           |0⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
       ```

    > [!NOTE]
    > Your outputs might differ because the random number generator is probabilistic. The probabilities of the outcomes are not deterministic.

## Explore some superpositions

Now that you know how to inspect the state of a register, you can see operations that modify the state of your qubits and place them into a superposition.

The current random number generator produces either `Zero` or `One` with a 50% probability. Let's look at a second example that generates random numbers with a different probability.

### Skewed random bit generator

Suppose you want to create a random bit generator that's skewed, that is, the probability of getting `Zero` is different from the probability of getting `One`. 

For example, you want the outcome `Zero` with probability $P$ and the outcome `One` with probability $1-P$. Here's a valid qubit state that produces such a random bit generator:

$$|\psi\rangle=\sqrt{P}|0\rangle+\sqrt{1-P}|1\rangle$$

Here, $\alpha=\sqrt{P}$ and $\beta=\sqrt{1-P}$ are the amplitudes of the basis states $|0\rangle$ and $|1\rangle$, respectively.

This state can be obtained by sequentially applying the operator $R_y(2\arccos\sqrt{P})$ to a qubit in the state $|0\rangle.$ You can achieve this result in Q# by
using the operation [Ry](/qsharp/api/qsharp/microsoft.quantum.intrinsic.Ry?azure-portal=true) in the Standard library.

> [!TIP]
> To learn more about the math behind single-qubit operations, check out the
> [Single-Qubit Gates tutorial in Quantum Katas](https://quantum.microsoft.com/en-us/experience/quantum-katas).

1. Modify *Superposition.qs* like the following example, and then save the file. This example chooses $\alpha$ to be about $\frac13$.

    ```qsharp
    namespace ExploringSuperposition {
        open Microsoft.Quantum.Diagnostics;
        open Microsoft.Quantum.Math;
    
        @EntryPoint()
        operation GenerateSpecificState() : Result {
            use q = Qubit();
            let P = 0.333333; // P is 1/3
            Ry(2.0 * ArcCos(Sqrt(P)), q);
            Message("The qubit is in the desired state.");
            Message("");
            DumpMachine(); // Dump the state of the qubit 
            Message("");
            Message("Your skewed random bit is:");
            let skewedrandomBit = M(q);
            Reset(q);
            return skewedrandomBit;
        }
    }
    ```

1. You can see how `DumpMachine` displays the expected state after it applies the operations and displays the associated probabilities. Notice that the probability of getting `Zero` is about 33.33% and the probability of getting `One` is about 66.67%. Thus, the random bit generator is skewed.

    ```output
    The qubit is in the desired state.
    
    DumpMachine:
    
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
       |0⟩ |  0.5773+0.0000𝑖 |    33.3333% |   0.0000
       |1⟩ |  0.8165+0.0000𝑖 |    66.6667% |   0.0000
    
    
    Your skewed random bit is:
    Result: "One"
    ```

    > [!NOTE]
    > Your output might differ because the random number generator is probabilistic. The probabilities of the outcomes are not deterministic.


### Multiple-qubit superposition

Now let's explore superpositions of a register that includes many qubits. For example, if your register consists of three qubits, then you have eight basis states:

$$|000\rangle,|001\rangle,|010\rangle,|011\rangle,|100\rangle,|101\rangle, |110\rangle,|111\rangle $$

So you can express an arbitrary three-qubit state as:

$$|\psi\rangle=\alpha_0|000\rangle+\alpha_1|001\rangle+\alpha_2|010\rangle+\alpha_3|011\rangle+\alpha_4|100\rangle+\alpha_5|101\rangle+\alpha_6 |110\rangle+\alpha_7|111\rangle$$

Here, $\alpha_i$ are complex numbers that satisfy $\sum|\alpha_i|^2=1$.

For example, you can place qubits in a uniform superposition by applying `H` to each qubit. You can use this uniform superposition to create a different version of the quantum random number generator that generates three-bit numbers by measuring three qubits in superposition
instead of measuring one qubit three times.

|Basis|Number|
|---|---|
|$\ket{000}$|0|
|$\ket{001}$|1|
|$\ket{010}$|2|
|$\ket{011}$|3|
|$\ket{100}$|4|
|$\ket{101}$|5|
|$\ket{110}$|6|
|$\ket{111}$|7|

1. Modify *Superposition.qs* like the following example, and then save the file.

    ```qsharp
    namespace ExploringSuperposition {
        open Microsoft.Quantum.Diagnostics;
        open Microsoft.Quantum.Math;
        open Microsoft.Quantum.Convert;
        open Microsoft.Quantum.Arrays;
    
        @EntryPoint()
        operation GenerateRandomNumber() : Int {
            use qubits = Qubit[3];
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
    ```

    Here, we introduce three concepts:

    * The `qubits` variable now represents a `Qubit` array that has a length of three.
    * The operations `ApplyToEach` and `ForEach` are useful to measure and act on multiple qubits, and they use less code. Q# libraries offer many kinds of operations and functions that make writing quantum programs more efficient.
    * The `BoolArrayAsInt` and `ResultArrayAsBoolArray` functions from the `Microsoft.Quantum.Convert` library transform the binary `Result` array that's returned by `ForEach(M, qubits)` into an integer.

1. To run the program, click on **Run** from the list of commands below `@EntryPoint()`, or press **Ctrl+F5**. Your output will appear in the debug console.
1. By using `DumpMachine`, you see how the act of measuring the three qubits collapses the state of the register to one of the eight possible basis states. For example, if you get the result `3`, it means that the state of the register collapsed to $|110\rangle$.

    ```output
    The qubit register in a uniform superposition:
    
    DumpMachine:
    
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
     |000⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |001⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |010⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |011⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |100⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |101⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |110⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
     |111⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
    
    Measuring the qubits collapses the superposition to a basis state.
    
    DumpMachine:
    
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
     |110⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000

    Result: "3"
    ```

    > [!NOTE]
    > Your output might differ because the random number generator is probabilistic. The probabilities of the outcomes are not deterministic.

1. The `ForEach(M, qubit)` operation measures each qubit in turn, gradually collapsing the state. You can also dump the intermediary states after each measurement. To do so, modify *Superposition.qs* like the following example, and then save the file.

    ```qsharp
    namespace ExploringSuperposition {
        open Microsoft.Quantum.Diagnostics;
        open Microsoft.Quantum.Measurement;
        open Microsoft.Quantum.Math;
        open Microsoft.Quantum.Convert;
    
        @EntryPoint()
        operation GenerateUniformState() : Int {
            use qubits = Qubit[3];
            ApplyToEach(H, qubits);
            Message("The qubit register in a uniform superposition: ");
            DumpMachine();
            mutable results = [];
            for q in qubits {
                Message(" ");
                set results += [M(q)];
                DumpMachine();
            }
            Message(" ");
            Message("Your random number is: ");
            ResetAll(qubits);
            return BoolArrayAsInt(ResultArrayAsBoolArray(results));
        }
    }
    ```

1. Here, you use a `for` loop to act on each qubit sequentially. Q# has classical flow control capabilities, such as `for` loops, and `if` statements, that you can use to control the flow of your program.
1. To run the program, click on **Run** from the list of commands below `@EntryPoint()`, or press **Ctrl+F5**.
1. You can see how each consecutive measurement changes the quantum state and therefore the probabilities of obtaining each outcome. For example, if your result is number five, you'll get the following output. Let's look briefly at each step:

    1. **State preparation**: After applying `H` to each qubit of the register, we obtain a uniform superposition.

        ```output
        The qubit register in a uniform superposition: 
        
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
         |000⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |001⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |010⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |011⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |100⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |101⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |110⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
         |111⟩ |  0.3536+0.0000𝑖 |    12.5000% |   0.0000
        ```

    1. **First measurement**: In the first measurement, the result was `One`. Therefore, all of the amplitudes of the states whose rightmost qubit is `Zero` are no longer present. The amplitudes are $|0\rangle=|000\rangle, |2\rangle=|010\rangle, |4\rangle=|100\rangle$, and $|6\rangle= |110\rangle$. The rest of the amplitudes increase to fulfill the normalization condition.

        ```output
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
         |001⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
         |011⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
         |101⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
         |111⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
        ```

    1. **Second measurement**: In the second measurement, the result was `Zero`. Therefore, all of the amplitudes of the states whose second rightmost (middle) qubit is `One` vanish. The amplitudes are $|3\rangle=|011\rangle$ and $|7\rangle=|111\rangle$. The rest of the amplitudes increase to fulfill the normalization condition.

        ```output
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
         |001⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
         |101⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
        ```

    1. **Third measurement**: In the third measurement, the result was `One`. Therefore, all of
       the amplitudes of the states whose leftmost qubit is `Zero` clear out. The only
       compatible state is $|5\rangle=|101\rangle$. This state gets an amplitude probability
       of $1$.

        ```output
        DumpMachine:
        
         Basis | Amplitude      | Probability | Phase
         -----------------------------------------------
         |101⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
        
         
        Your random number is: 
        Result: "5"
        ```

    > [!NOTE]
    > Your output might differ because the random number generator is probabilistic. The probabilities of the outcomes are not deterministic.
