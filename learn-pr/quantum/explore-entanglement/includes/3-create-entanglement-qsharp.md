In the previous unit, you learned about the concept of quantum entanglement and Bell states.

In this unit, you use the Microsoft Quantum Development Kit (QDK) to write Q# code that creates entangled Bell states between two qubits. To create your first Bell state, you apply two quantum operations: the Hadamard operation and the Controlled-NOT (CNOT) operation.

First, let's understand how these operations work and why they create entangled states.

## The Hadamard operation

Recall that the Hadamard, or H, operation, puts a qubit that's in a pure :::no-loc text="$\\ket{0}$"::: state or :::no-loc text="$\\ket{1}$"::: state into an equal superposition state.

:::no-loc text="$$ H \\ket{0} = \\frac1{\\sqrt2} \\ket{0} + \\frac1{\\sqrt2} \\ket{1}$$":::
:::no-loc text="$$ H \\ket{1} = \\frac1{\\sqrt2} \\ket{0} - \\frac1{\\sqrt2} \\ket{1}$$":::

The first step to create your Bell state is to perform a Hadamard operation on one of the qubits.

## The Controlled-NOT (CNOT) operation

When two qubits are entangled, the state of one qubit is dependent on the state of the other qubit. Therefore, to entangle two qubits you need to apply a multi-qubit operation, which is an operation that acts on both qubits at the same time. The Controlled-NOT, or CNOT, operation is a multi-qubit operation that helps create entanglement.

The CNOT operation takes two qubits as input. One of the qubits is the control qubit and the other qubit is the target qubit. If the control qubit is in the :::no-loc text="$\\ket{1}$"::: state, then the CNOT operation flips the state of the target qubit. Otherwise, CNOT does nothing.

For example, in the following two-qubit states, the control qubit is the leftmost qubit and the target qubit is the rightmost qubit.

| Input to `CNOT`                 | Output from `CNOT`              |
|---------------------------------|---------------------------------|
| :::no-loc text="$\\ket{00}$"::: | :::no-loc text="$\\ket{00}$"::: |
| :::no-loc text="$\\ket{01}$"::: | :::no-loc text="$\\ket{01}$"::: |
| :::no-loc text="$\\ket{10}$"::: | :::no-loc text="$\\ket{11}$"::: |
| :::no-loc text="$\\ket{11}$"::: | :::no-loc text="$\\ket{10}$"::: |

In Q#, the `CNOT` operation acts on an array of two qubits, and it flips the second qubit only if the first qubit is `One`.

## Entanglement with Hadamard and CNOT operations

Suppose that you have a two-qubit system in the state :::no-loc text="$\\ket{00}$":::. In this state, the qubits aren't entangled. To put these qubits into the entangled Bell state :::no-loc text="$\\ket{\\phi^+}=\\frac1{\\sqrt2}(\\ket{00}+\\ket{11})$":::, apply the Hadamard and CNOT operations.

Here's how it works:

1. Choose one qubit in the c state to be the control qubit and the other qubit to be the target qubit. Here, we choose the leftmost qubit to be the control and the rightmost qubit to be the target.
1. Put only the control qubit into an equal superposition state. To do so, apply an H operation to only the control qubit:

   :::no-loc text="$$H \\ket{0_c} = \\frac{1}{\\sqrt{2}}(\\ket{0_c} + \\ket{1_c})$$":::

   > [!NOTE]
   > The subscripts :::no-loc text="${}_c$"::: and :::no-loc text="${}_t$"::: specify the control and target qubits, respectively.

1. Apply a CNOT operation to the qubit pair. Recall that the control qubit is in a superposition state and the target qubit is in the :::no-loc text="$\\ket{0_t}$"::: state.

    $$
    \\begin{aligned}
    CNOT \\frac{1}{\\sqrt{2}}(\\ket{0_c}+\\ket{1_c})\\ket{0_t} &= CNOT \\frac{1}{\\sqrt2}(\\ket{0_c 0_t}+\\ket{1_c 0_t})\\\\
    &= \\frac{1}{\\sqrt2}(CNOT \\ket{0_c 0_t} + CNOT \\ket{1_c 0_t})\\\\
    &= \\frac{1}{\\sqrt2}(\\ket{0_c 0_t}+\\ket{1_c 1_t})
    \\end{aligned}
    $$

The state :::no-loc text="$\\frac{1}{\\sqrt2}(\\ket{0_c 0_t}+\\ket{1_c 1_t})$"::: is entangled. This particular entangled state is one of the four Bell states, :::no-loc text="$\\ket{\\phi^{+}}$":::.

> [!NOTE]
> In quantum computing, operations are often called gates. For example, the H gate and the CNOT gate.

## Create quantum entanglement in Q\#

To create a Bell state with Q# code, follow these steps in Visual Studio Code (VS Code):

1. Open VS Code.
1. Open the **File** menu, and then choose **New Text File** to create a new file.
1. Save the file as Main.qs.

### Create a Bell state

To create the Bell state :::no-loc text="$\\ket{\\phi^+}$"::: in Q#, follow these steps:

1. Import the `Std.Diagnostics` namespace from the Q# standard library so that you can use the `DumpMachine` function. This function shows information about the qubit states when you call the function in your code. To import the namespace, copy the following Q# code into your **Main.qs** file:

    ```qsharp
    import Std.Diagnostics.*;
    ```

1. Create the `Main` operation that returns two `Result` type values, which are the measurement results of the qubits.

    ```qsharp
    import Std.Diagnostics.*;

    operation Main() : (Result, Result) {
        // Your code goes here
    }
    ```

1. Inside the `Main` operation, allocate two qubits to be entangled, `q1` and `q2`.

    ```qsharp
    import Std.Diagnostics.*;

    operation Main() : (Result, Result) {
        use (q1, q2) = (Qubit(), Qubit());
    }
    ```

1. Apply the Hadamard gate, `H`, to the control qubit,`q1`. This puts only that qubit into a superposition state. Then apply the CNOT gate, `CNOT`, to both qubits to entangle the two qubits. The first argument to `CNOT` is the control qubit and the second argument is the target qubit.

    ```qsharp
    import Std.Diagnostics.*; 

    operation Main() : (Result, Result) {
        use (q1, q2) = (Qubit(), Qubit());

        H(q1);
        CNOT(q1, q2);
    }
    ```

1. Use the `DumpMachine` function to display the state of the qubits after you entangle them. Note that `DumpMachine` doesn't perform a measurement on the qubits, so `DumpMachine` doesn't affect the qubit states.

    ```qsharp
    import Std.Diagnostics.*;

    operation Main() : (Result, Result) {
        use (q1, q2) = (Qubit(), Qubit());

        H(q1);
        CNOT(q1, q2);

        DumpMachine();
    }
    ```

1. Use the `M` operation to measure the qubits, and store the results in `m1` and `m2`. Then use the `Reset` operation to reset the qubits.

    ```qsharp
    import Std.Diagnostics.*;

    operation Main() : (Result, Result) {

        use (q1, q2) = (Qubit(), Qubit());

        H(q1);
        CNOT(q1, q2);
        DumpMachine();

        let (m1, m2) = (M(q1), M(q2));
        Reset(q1);
        Reset(q2);

    }
    ```

1. Return the measurement results of the qubits with the `return` statement. Here is final program in your **Main.qs** file:

    ```qsharp
    import Std.Diagnostics.*;

    operation Main() : (Result, Result) {
        use (q1, q2) = (Qubit(), Qubit());

        H(q1);
        CNOT(q1, q2);

        DumpMachine();

        let (m1, m2) = (M(q1), M(q2));
        Reset(q1);
        Reset(q2);

        return (m1, m2);
    }
    ```

1. To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation, or press **Ctrl + F5**. Your output appears in the debug console.
1. The measurement outcomes are correlated, so at the end of the program you get a result of `(Zero, Zero)` or `(One, One)` with equal probability. Rerun the program multiple times and observe the output to convince yourself of the correlation.
1. To visualize the circuit diagram, choose the **Circuit** code lens above the `Main` operation. The circuit diagram shows the Hadamard gate applied to the first qubit and the CNOT gate applied to both qubits.

    :::image type="content" source="../media/circuit-bellstates.png" alt-text="Screenshot of the circuit that creates the Bell state.":::

## Create other Bell states

To create other Bell states, apply additional Pauli :::no-loc text="$X$"::: or :::no-loc text="$Z$"::: operations to the qubits.

For example, to create the Bell state :::no-loc text="$\\ket{\\phi^-}=\\frac1{\\sqrt2}(\\ket{00}-\\ket{11})$":::, apply the Pauli $Z$ operation to the control qubit after you apply the Hadamard gate, but before you apply CNOT. The :::no-loc text="$Z$"::: operation flips the state :::no-loc text="$\\ket{+}$"::: to :::no-loc text="$\\ket{-}$":::.

> [!NOTE]
> The states :::no-loc text="$\\frac{1}{\\sqrt{2}}(\\ket{0}+\\ket{1})$"::: and :::no-loc text="$\\frac{1}{\\sqrt{2}}(\\ket{0} - \\ket{1})$"::: are also known as :::no-loc text="$\\ket{+}$"::: and :::no-loc text="$\\ket{-}$":::, respectively.

Here's how to create the :::no-loc text="$\\ket{\\phi^-}$"::: state:

1. Create two qubits in the state :::no-loc text="$\\ket{00}$":::.
1. Put the control qubit into a superposition state with the :::no-loc text="$H$"::: operation:

   :::no-loc text="$$H \\ket{0_c} = \\frac{1}{\\sqrt{2}}(\\ket{0_c} + \\ket{1_c}) = \\ket{+_c}$$":::

1. Apply the :::no-loc text="$Z$"::: operation to the control qubit.

    :::no-loc text="$$Z \\frac{1}{\\sqrt{2}}(\\ket{0_c} + \\ket{1_c}) = \\frac{1}{\\sqrt{2}}(\\ket{0_c} - \\ket{1_c}) = \\ket{-_c}$$":::

1. Apply the CNOT operation to the control qubit and the target qubit, which is in the :::no-loc text="$\\ket{0_t}$"::: state.

    $$
    \\begin{aligned}
    CNOT \\frac{1}{\\sqrt{2}}(\\ket{0_c}-\\ket{1_c})\\ket{0_t} &= CNOT \\frac{1}{\\sqrt2}(\\ket{0_c 0_t}-\\ket{1_c 0_t})\\\\
    &= \\frac{1}{\\sqrt2}(CNOT \\ket{0_c 0_t} - CNOT \\ket{1_c 0_t})\\\\
    &= \\frac{1}{\\sqrt2}(\\ket{0_c 0_t}-\\ket{1_c 1_t})
    \\end{aligned}
    $$

To create the :::no-loc text="$\\ket{\\phi^-}$"::: Bell state in Q#, replace the code in the your **Main.qs** with the following code:

```qsharp
import Std.Diagnostics.*;
    
operation Main() : (Result, Result) {
    use (q1, q2) = (Qubit(), Qubit());
    
    H(q1);
    Z(q1); // Apply the Pauli Z operation to the control qubit
    CNOT(q1, q2);
    
    DumpMachine();
    
    let (m1, m2) = (M(q1), M(q2));
    Reset(q1);
    Reset(q2);

    return (m1, m2);
}
```

Similarly, you can create the Bell states :::no-loc text="$\\ket{\\psi^+}$ and $\\ket{\\psi^-}$"::: by applying the Pauli $X$ and $Z$ operations to the qubits.

- To create the Bell state :::no-loc text="$\\ket{\\psi^+}=\\frac1{\\sqrt2}(\\ket{01}+\\ket{10})$":::, apply the Pauli $X$ gate to the target qubit after you apply the Hadamard gate to the control qubit. Then apply the CNOT gate.
- To create the Bell state :::no-loc text="$\\ket{\\psi^-}=\\frac1{\\sqrt2}(\\ket{01}-\\ket{10})$":::, apply the Pauli $Z$ to the control qubit and the Pauli $X$ to the target qubit after you apply the Hadamard gate to the control qubit. Then apply the CNOT gate.

In the next unit, you learn how to use entanglement to send quantum information, a process known as quantum teleportation.
