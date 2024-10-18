Now, let's create some quantum entanglement using Q# and the Azure Quantum Development Kit.


## The Controlled-NOT (CNOT) operation

When two qubits are entangled, the state of one qubit is dependent on the state of the other qubit. Therefore, to entangle two qubits you need an operation that acts on both qubits at the same time. This is called a *multiqubit operation or gate*.

To create quantum entanglement, you need the multiqubit `CNOT` operation, which stands for *Controlled-NOT*. This operation takes two qubits as input, one acts as control qubit and the other is the target qubit. The `CNOT` gate flips the state of the second qubit (the target qubit) if, and only if, the state of the first qubit (the control qubit) is $|1\rangle$. 

|Input|Output|
|-|-|
|$\ket{00}$|$\ket{00}$|
|$\ket{01}$|$\ket{01}$|
|$\ket{10}$|$\ket{11}$|
|$\ket{11}$|$\ket{10}$|

In Q#, the `CNOT` operation acts on an array of two qubits, and it flips the second qubit if the first qubit is `One`.

## Entanglement with a CNOT operation

By applying the `H` operation and the `CNOT` operation, you can transform two qubits in the state $|00\rangle$ to the Bell state $\ket{\phi^+}=\frac1{\sqrt2}(|00\rangle+|11\rangle)$.

Here's how it works:

1. Take two qubits in the state $|00\rangle$. The first qubit is the control qubit and the second qubit is the target qubit.
1. Create a superposition state only in the control qubit by applying $H$.

   $$H |0_c\rangle= \frac{1}{\sqrt{2}}(|0_c\rangle+|1_c\rangle)$$

   > [!NOTE]
   > The subscripts ${}_c$ and ${}_t$ specify the control and target qubits.

1. Apply the $CNOT$ operator to the control qubit, which is in a superposition state, and the target qubit, which is in the state $|0_t\rangle$.

    $$ CNOT \frac{1}{\sqrt{2}}(\ket{0_c}+\ket{1_c})\ket{0}_t = CNOT \frac{1}{\sqrt2}(\ket{0_c 0_t}+|\ket{1_c 0_t})= $$
    $$ =\frac{1}{\sqrt2}(CNOT \ket{0_c 0_t} + CNOT \ket{1_c 0_t})= $$
    $$= \frac{1}{\sqrt2}(\ket{0_c 0_t}+\ket{1_c 1_t})$$

## Create and measure the Bell states using Q#

1. Open Visual Studio Code.
1. Select **File > New Text File** and save it as `Entanglement.qs`.
1. Select **View -> Command Palette** and type **Q#: Set the Azure Quantum QIR target profile**. Press **Enter**.
1. Select **Q#: Unrestricted**.

### Create the Bell state $\ket{\phi^+}$

Let's start by creating the Bell state $\ket{\phi^+}=\frac1{\sqrt2}(|00\rangle+|11\rangle)$. 

1. Copy and paste the following Q# code into the `Entanglement.qs` file. 

    ```qsharp
    namespace Entanglement {
        open Microsoft.Quantum.Diagnostics;
    
        @EntryPoint()
        operation EntangleQubits() : (Result, Result) {
            // Allocate the two qubits that will be entangled.
            use (q1, q2) = (Qubit(), Qubit());
    
            // Set the first qubit in superposition by calling the `H` operation,
            // which applies a Hadamard transformation to the qubit.
            // Then, entangle the two qubits using the `CNOT` operation.
            H(q1);
            CNOT(q1, q2);
    
            // Show the entangled state using the `DumpMachine` function.
            DumpMachine();
    
            // Measurements of entangled qubits are always correlated.
            let (m1, m2) = (M(q1), M(q2));
            Reset(q1);
            Reset(q2);
            return (m1, m2);
        }
    }
    ```

1. To run your program locally on the built-in simulator, click on **Run** from the list of commands below `@EntryPoint()`, or press **Ctrl+F5**. Your output will appear in the debug console.

    :::image type="content" source="../media/codelens-run-bellstates.png" alt-text="Screenshot of VS Code showing how to run a Q# file using the codelens under entry point. ":::

1. The measurement outcomes are correlated, so at the end of the program, you get a result of `(Zero, Zero)` or `(One, One)` with equal probability.
1. You can visualize the circuit diagram by clicking on **Circuit** from the list of commands below `@EntryPoint()`. The circuit diagram shows the Hadamard gate applied to the first qubit and the CNOT gate applied to both qubits.

    :::image type="content" source="../media/circuit-bellstates.png" alt-text="Screenshot of the circuit of the Bell state.":::

### Create the Bell state $\ket{\phi^-}$

To create other Bell states, you need to apply additional Pauli $X$ and $Z$ operations to the qubits.

For example, to create the Bell state $\ket{\phi^-}=\frac1{\sqrt2}(|00\rangle-|11\rangle)$, you can apply the Pauli $Z$ operation to the control qubit after applying the Hadamard gate. The $Z$ operation flips the state $\ket{+}$ to $\ket{-}$.

> [!NOTE]
> The states $\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$ and $\frac{1}{\sqrt{2}}(|0\rangle -|1\rangle)$ are also known as $\ket{+}$ and $\ket{-}$, respectively.

Here's how it works:

1. Take two qubits in the state $|00\rangle$. 
1. Create a superposition state only in the control qubit by applying $H$.

   $$H |0_c\rangle= \frac{1}{\sqrt{2}}(|0_c\rangle+|1_c\rangle) = \ket{+}_c$$

1. Apply the $Z$ operation to the control qubit.

    $$Z \frac{1}{\sqrt{2}}(|0_c\rangle+|1_c\rangle)= \frac{1}{\sqrt{2}}(|0_c\rangle-|1_c\rangle)= \ket{-}_c$$

1. Apply the $CNOT$ operator to the control qubit and the target qubit, which is in the state $|0_t\rangle$.

    $$ CNOT \frac{1}{\sqrt{2}}(\ket{0_c}-\ket{1_c})\ket{0}_t = CNOT \frac{1}{\sqrt2}(\ket{0_c 0_t}-|\ket{1_c 0_t})= $$
    $$ =\frac{1}{\sqrt2}(CNOT \ket{0_c 0_t} - CNOT \ket{1_c 0_t})= $$
    $$= \frac{1}{\sqrt2}(\ket{0_c 0_t}-\ket{1_c 1_t})$$

Modify the Q# code to create the Bell state $\ket{\phi^-}$. Run the program to see the entangled state and the circuit diagram.

```qsharp
namespace Entanglement {
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation EntangleQubits() : (Result, Result) {
        // Allocate the two qubits that will be entangled.
        use (q1, q2) = (Qubit(), Qubit());

        // Set the first qubit in superposition by calling the `H` operation,
        // which applies a Hadamard transformation to the qubit.
        // Then, entangle the two qubits using the `CNOT` operation.
        H(q1);
        Z(q1); // Apply the Pauli Z operation to the control qubit
        CNOT(q1, q2);

        // Show the entangled state using the `DumpMachine` function.
        DumpMachine();

        // Measurements of entangled qubits are always correlated.
        let (m1, m2) = (M(q1), M(q2));
        Reset(q1);
        Reset(q2);
        return (m1, m2);
    }
}
```

### Extra exercise: Create the Bell states $\ket{\psi^+}$ and $\ket{\psi^-}$

Similarly, Bell states $\ket{\psi^+}$ and $\ket{\psi^-}$ can be created by applying the Pauli $X$ and $Z$ operations to the qubits.

- The Bell state $\ket{\psi^+}=\frac1{\sqrt2}(|01\rangle+|10\rangle)$ can be created by applying the Pauli $X$ operation to the target qubit after applying the Hadamard gate.
- The Bell state $\ket{\psi^-}=\frac1{\sqrt2}(|01\rangle-|10\rangle)$ can be created by applying the Pauli $Z$ to the control qubit and the Pauli $X$ to the target qubit after applying the Hadamard gate.

Modify the *Entanglement.qs* program to create the Bell states $\ket{\psi^+}$ and $\ket{\psi^-}$.
