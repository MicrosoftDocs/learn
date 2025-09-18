
In the previous units, you learned about superposition and Dirac notation. That's enough theory for now! Let's write some code to explore superposition in Q#.

In this unit, you create quantum superposition states in Q# and explore the role of probability in measurement results. You also use the `DumpMachine` function in Q# to examine how the state of a system changes during a quantum computation.

## Create a new Q# file

1. Open Visual Studio Code (VS Code).
1. Open the **File** menu, and then choose **New Text File** to create a new file.
1. Save the file as **Main.qs**.

## Get started with superposition

Let's start with a simple Q# program that uses a qubit in a superposition state to generate a random bit value, 0 or 1. In our code, we use the `DumpMachine` function to see the state of the qubit at different points in the program.

1. Copy and paste the following code into the **Main.qs** file:

    ```qsharp
    import Std.Diagnostics.*;
    
    operation Main() : Result {
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
    ```

1. To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation or press **Ctrl + F5**. Your output appears in the debug console.
1. Examine the debug console to find the result of your measurement, either `Zero` or `One`.

The `DumpMachine` function creates a table of information that describes the state of the quantum system, which in this case is a single qubit. Information from `DumpMachine` includes the probability amplitude, the measurement probability, and the phase in radians for each basis state.

Your code calls the `DumpMachine` function four times:

- After you allocate the qubit
- After you put the qubit into a superposition state
- After you measure the qubit's state
- After you reset the qubit

Let's examine the output from each call to `DumpMachine`:

- **Initialized qubit:** When you allocate a qubit with the `use` statement, the qubit always starts in the $|0\rangle$ state.

    ```output
    Initialized qubit:

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
       |0⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
    ```

- **Qubit after applying H:** After you apply the `H` operation, the qubit is in an equal superposition state, $|\psi\rangle=\frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle$.

    ```output
    Qubit after applying H:

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
       |0⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
       |1⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
    
    ```

- **Qubit after the measurement:** After you measure the qubit, the result is either `Zero` or `One`, and the qubit is fully in the state that you measured.

    ```output
    Qubit after the measurement:

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
       |1⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
    ```

    > [!NOTE]
    > Your output from `DumpMachine` after measurement might differ from the example output because you have a 50% chance to measure each state. The probabilities of the outcomes are deterministic, but the result of an individual measurement is not.

- **Qubit after resetting:** The `Reset` operation resets the qubit to the state $|0\rangle$ so that it can be used again for future computations.

    ```output
    Qubit after resetting:

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
       |0⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
    ```

## Explore other superposition states

Now that you know how to inspect the state of a qubit system with `DumpMachine`, let's explore other operations that put the system into different kinds of superposition states.

The current random bit generator produces either `Zero` or `One` with a 50% probability. In the next example, the probabilities aren't equal.

### Skewed random bit generator

Suppose you want to create a random bit generator that's skewed, which means that the probability of getting `Zero` is different from the probability of getting `One`.

For example, you want the outcome `Zero` with probability $P$ and the outcome `One` with probability $1 - P$. Here's a valid qubit state that produces such a random bit generator:

$$|\psi\rangle=\sqrt{P}|0\rangle+\sqrt{1 - P}|1\rangle$$

For this state $|\psi\rangle$, $\alpha=\sqrt{P}$ and $\beta=\sqrt{1 - P}$ are the probability amplitudes of the basis states $|0\rangle$ and $|1\rangle$, respectively.

To obtain this state, you can sequentially apply the operator $R_y(2\cos^{-1}\sqrt{P})$ to a qubit that starts in the $|0\rangle$ state. To achieve this result in Q#, use the [`Ry`](/qsharp/api/qsharp/microsoft.quantum.intrinsic.Ry?azure-portal=true) from the standard library.

> [!TIP]
> To learn more about the math behind single-qubit operations, check out the
> [Single-Qubit Gates tutorial in Quantum Katas](https://quantum.microsoft.com/tools/quantum-katas).

To create a skewed superposition state in Q#, follow these steps:

1. Replace all the code in **Main.qs** with the following example, and then save the file. This example chooses $\alpha$ to be approximately $\frac13$.

    ```qsharp
    import Std.Diagnostics.*;
    import Std.Math.*;

    operation Main() : Result {
        use q = Qubit();
        let P = 0.333333; // P is 1/3
        Ry(2.0 * ArcCos(Sqrt(P)), q);
        Message("The qubit is in the desired state.");
        DumpMachine(); // Dump the state of the qubit 
        Message("Your skewed random bit is:");
        let skewedrandomBit = M(q);
        Reset(q);
        return skewedrandomBit;
    }
    ```

1. To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation or press **Ctrl + F5**. Your output appears in the debug console.
1. Examine the output from `DumpMachine` and the result of your measurement. For example, the output is similar to the following:

    ```output
    The qubit is in the desired state.

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
       |0⟩ |  0.5773+0.0000𝑖 |    33.3333% |   0.0000
       |1⟩ |  0.8165+0.0000𝑖 |    66.6667% |   0.0000

    Your skewed random bit is:

    One
    ```

Notice that the probability of a `Zero` measurement result is about 33.33% and the probability of a `One` result is about 66.67%. This random bit generator is skewed towards `One`.

> [!NOTE]
> Your measurement result output might differ from the example output because the random bit generator is probabilistic. The probabilities of the outcomes are deterministic, but the result of an individual measurement is not.

### Multiple-qubit superposition

So far, we've considered only single-qubit systems. But a good quantum computer needs a lot of qubits to perform useful calculations. How do quantum states and superposition work when our system has more than one qubit?

As an example, consider a system of three qubits. Each qubit can have a value of 0 or 1 when you measure them, so there are eight possible states that you can find the system to be in:

$$|000\rangle,|001\rangle,|010\rangle,|011\rangle,|100\rangle,|101\rangle, |110\rangle,|111\rangle $$

There are eight possible states for this system because each qubit can independently be either a 0 or 1 state when we take a measurement. In general, the number of possible states is equal to $2^n$, where $n$ is the number of qubits.

Just like with a single qubit, an arbitrary superposition state for the 3-qubit system is represented as a weighted sum of these eight states, where the weights are the probability amplitudes:

$$|\psi\rangle=\alpha_0|000\rangle+\alpha_1|001\rangle+\alpha_2|010\rangle+\alpha_3|011\rangle+\alpha_4|100\rangle+\alpha_5|101\rangle+\alpha_6 |110\rangle+\alpha_7|111\rangle$$

Once again, the amplitudes $\alpha_i$ are complex numbers that satisfy the condition $\sum\limits_{i=0}^{i=7}|\alpha_i|^2=1$.

For example, you can place qubits in a uniform superposition by applying `H` to each qubit. You can then use this uniform superposition to create a quantum random number generator that generates three-bit numbers instead of one-bit numbers:

| Basis state |Number|
|-------------|------|
| $\ket{000}$ | 0    |
| $\ket{001}$ | 4    |
| $\ket{010}$ | 2    |
| $\ket{011}$ | 6    |
| $\ket{100}$ | 1    |
| $\ket{101}$ | 5    |
| $\ket{110}$ | 3    |
| $\ket{111}$ | 7    |

> [!NOTE]
> The standard way to write bit strings is to have the smallest digit on the right and the largest digit on the left, just like with regular decimal numbers. In Q# (and many other quantum programming languages), the order is reversed so that the smallest digit is on the left and the largest digit is on the right. Because the `DumpMachine` function displays quantum states in the standard order, the decimal integers that the states correspond to aren't ordered sequentially from 0 to $n-1$.

To create this kind of random number generator, follow these steps:

1. Replace your code in **Main.qs** with the following example, and then save the file:

    ```qsharp
    import Std.Diagnostics.*;
    import Std.Convert.*;
    
    operation Main() : Int {
        use qubits = Qubit[3];
        ApplyToEach(H, qubits);
        Message("The qubit register in a uniform superposition: ");
        DumpMachine();
        let result = MeasureEachZ(qubits);
        Message("Measuring the qubits collapses the superposition to a basis state.");
        DumpMachine();
        ResetAll(qubits);
        return ResultArrayAsInt(result);
    }
    ```

1. To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation or press **Ctrl + F5**. Your output appears in the debug console.
1. Examine the output from `DumpMachine` and the result of your measurement. For example, the output is similar to the following:

    ```output
    The qubit register in a uniform superposition: 

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

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
     |011⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000

    6
    ```

    > [!NOTE]
    > Your output probably has a different result than the example output because the random number generator is probabilistic. The probabilities of the outcomes are deterministic, but the result of an individual measurement is not.

To work with multiple qubits, your Q# code has the following modifications:

- The `qubits` variable now represents a `Qubit` array that has a length of three.
- The operations `ApplyToEach` and `MeasureEachZ` apply quantum operations to multiple qubits with just one line of code. The Q# libraries offer many functions and operations that simplify quantum programming for you.
- The function `ResultArrayAsInt` from the `Std.Convert` library transforms the binary `Result` array into a decimal integer.

The output from `DumpMachine` shows that the act of measurement collapses the superposition state into one of the eight possible basis states, just like with a single qubit. For example, if you get the result `6`, then it means that the state of the system collapsed to $|011\rangle$.

Now let's take a deeper look at how the system changes as we measure each qubit. The preceding code used the `MeasureEachZ` operation to measure all three qubits at once. Instead, let's use a `for` loop to measure the qubits one at a time, and use `DumpMachine` to view the state of the system after each measurement.

1. Replace the code in **Main.qs** with the following example, and then save the file:

    ```qsharp
    import Std.Diagnostics.*;
    import Std.Convert.*;
    
    operation Main() : Int {
        use qubits = Qubit[3];
        ApplyToEach(H, qubits);
        Message("The qubit register is in a uniform superposition: ");
        DumpMachine();
        mutable results = [];
        for q in qubits {
            Message(" ");
            results += [M(q)];
            DumpMachine();
        }
        ResetAll(qubits);
        Message("Your random number is: ");
        return ResultArrayAsInt(results);
    }
    ```

1. To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation or press **Ctrl + F5**. Your output appears in the debug console.
1. Examine the output from `DumpMachine` and the result of your measurement.

The output shows how each consecutive measurement changes the quantum state and therefore the probabilities to obtain each outcome. For example, let's examine each part of the output in the case that your result is `5`:

- **State preparation**: The system is in an equal superposition state after you apply `H` to each qubit.

    ```output
    The qubit register is in a uniform superposition: 

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

- **First measurement**: The result is `One` for the first measurement, so now the only possible states that the system can end up in are the states where the leftmost bit is 1. The amplitudes of the states where the leftmost qubit is 0 have disappeared, and the probabilities of the remaining possible states increase from 12.5% to 25.0% so that the sum of probabilities remains 100%.

    ```output
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
     |100⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
     |101⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
     |110⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
     |111⟩ |  0.5000+0.0000𝑖 |    25.0000% |   0.0000
    ```

- **Second measurement**: The result is `Zero` for the second measurement, so now the only possible states that the system can end up in are the states where the two leftmost bits are 10. Now we're left with only two possible outcomes when we measure the third qubit, with a probability of 50% for each outcome.

    ```output
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
     |100⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
     |101⟩ |  0.7071+0.0000𝑖 |    50.0000% |   0.0000
    ```

- **Third measurement**: In the third measurement, the result is `One`. The system is fully measured, and therefore no longer in a superposition state, as expected.

    ```output
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
     |101⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000

    Your random number is: 

    5
    ```

With Q#, you can create a system of qubits, put the qubits into a superposition state, and examine how the system changes as you apply quantum operations or take measurements.
