
In the previous units, you learned how quantum entanglement works and that entanglement can be an excellent resource for quantum communication. In this unit, you learn how to use entanglement as a resource for quantum communication through one of the most famous applications of entanglement: the quantum teleportation protocol.

Quantum teleportation uses entanglement to transfer the state of a qubit from one location to another. The state of one qubit is transferred to another qubit, but the qubit itself doesn't physically move.

The teleportation protocol uses a combination of entanglement and classical communication. The classical communication is important because the teleportation protocol requires the sender to communicate the results of their measurements to the receiver. This means that teleportation can't send information faster than the speed of light. The classical communication between the sender and the receiver is limited by the speed of light.

Let's review the quantum teleportation protocol.

## The quantum teleportation protocol

Alice and Bob work together in the same company. Alice is based in Seattle, and Bob is based in Los Angeles. They're working on a project that requires them to share quantum information. They decide to use quantum teleportation to send information between them.

### Initial setup

Alice and Bob each have a qubit. Their qubits are already entangled in the Bell state $\ket{\phi^+}$

$$\ket{\phi^+}=\frac1{\sqrt2}(\ket{0_A 0_B} + \ket{1_A 1_B})$$

where the subscript $A$ denotes Alice's qubit and $B$ denotes Bob's qubit.

Alice also has another qubit, called the message qubit. Alice wants to send the state of the message qubit to Bob by teleportation. Here's the state of the message qubit:

$$\ket{m}=\alpha \ket{0}_m + \beta \ket{1}_m$$

The subscript $m$ denotes that this is the messenger qubit. The probability amplitudes $\alpha$ and $\beta$ are complex numbers, but their values are unknown to both Alice and Bob.

The whole system consists of the entangled qubits, $A$ and $B$, and the message qubit, $m$. The state of this three-qubit system is given by the following:

$$\ket{\text{System}} = (\alpha\ket{0}_m + \beta\ket{1}_m) \otimes \frac1{\sqrt2}(\ket{0_A 0_B}+ \ket{1_A 1_B}) $$

:::image type="content" source="../media/teleportation-step-1.png" alt-text="Diagram showing two face emojis of a woman and a man representing Alice and Bob. Alice owns two qubits, one is entangled with Bob's qubit. The entangled qubits are the same color. The message qubit is a different color.":::

> [!NOTE]
> The symbol $\otimes$ means that we take the tensor product of the kets on the left with the kets on the right.

### Alice entangles her qubits

Alice uses a CNOT gate to entangle the message qubit, $m$, with her other qubit, $A$. The message qubit is the control qubit, and Alice's other qubit is the target qubit. This creates a three-qubit entangled state.

:::image type="content" source="../media/teleportation-step-1-b.png" alt-text="Diagram showing two face emojis of a woman and a man representing Alice and Bob, and a hammer emoji representing that Alice manipulates her qubits. The three qubits are the same color, representing that they're entangled.":::

The message qubit is in the unknown state $\alpha \ket{0}_m + \beta \ket{1}_m$, so after Alice applies the CNOT gate, her qubits are in a superposition of the four Bell states. Here's the overall state of the three qubits:

NEW 1

$$ \ket{\text{System}} = \frac1{2} \ket{\phi^+}\_\text{mA} (\alpha\ket{0}\_B + \beta\ket{1}\_B) $$
$$ + \frac1{2} \ket{\phi^-}\_\text{mA} (\alpha\ket{0}\_B - \beta\ket{1}\_B) $$
$$ + \frac1{2} \ket{\psi^+}\_\text{mA} (\alpha\ket{1}\_B + \beta\ket{0}\_B) $$
$$ + \frac1{2} \ket{\psi^-}\_\text{mA} (\alpha\ket{1}\_B - \beta\ket{0}\_B) $$

NEW 2

$$ \ket{\text{System}} = \frac1{2} \ket{\phi^+}\_\text{mA} (\alpha\ket{0}\_B + \beta\ket{1}\_B) $$
$$\qquad + \frac1{2} \ket{\phi^-}\_\text{mA} (\alpha\ket{0}\_B - \beta\ket{1}\_B) $$
$$\qquad + \frac1{2} \ket{\psi^+}\_\text{mA} (\alpha\ket{1}\_B + \beta\ket{0}\_B) $$
$$\qquad + \frac1{2} \ket{\psi^-}\_\text{mA} (\alpha\ket{1}\_B - \beta\ket{0}\_B) $$

NEW 3

$$ \ket{\text{System}} = \frac1{2} \ket{\phi^+}\_\text{mA} (\alpha\ket{0}\_B + \beta\ket{1}\_B) $$
$$\qquad\qquad + \frac1{2} \ket{\phi^-}\_\text{mA} (\alpha\ket{0}\_B - \beta\ket{1}\_B) $$
$$\qquad\qquad + \frac1{2} \ket{\psi^+}\_\text{mA} (\alpha\ket{1}\_B + \beta\ket{0}\_B) $$
$$\qquad\qquad + \frac1{2} \ket{\psi^-}\_\text{mA} (\alpha\ket{1}\_B - \beta\ket{0}\_B) $$

The three-qubit state of Alice and Bob's qubits is an equal superposition of four possible states.

### Alice measures her qubits

Alice then measures the message qubit and her other qubit, $A$. She measures her qubits in the Bell basis, which consists of the four Bell states, $\lbrace \ket{\phi^+}, \ket{\phi^-}, \ket{\psi^+}, \ket{\psi^-} \rbrace$.

When Alice measures the message qubit and her qubit $A$ in the Bell basis, her qubits are found to be in one of the four Bell states, each with equal probability. Because Alice's qubits are entangled with Bob's qubit, Alice's measurement results are correlated with Bob's. When Alice measures her qubits, Bob's qubit is also projected into the correlated state.

For example, if Alice measures her qubits and observes the state $\ket{\phi^-}$, then Bob's qubit is projected into the state $\alpha\ket{0}_B - \beta\ket{1}_B$.

:::image type="content" source="../media/teleportation-step-2.png" alt-text="Diagram showing two face emojis of a woman and a man representing Alice and Bob, and a hammer emoji representing that Alice manipulates her qubits. Alice's qubits are the same color, representing they're entangled, while Bob's qubit is a different color.":::

### Alice calls Bob

Alice calls Bob and tells him the result of her measurement. She uses a classical communication channel, like a phone call or a text message.

:::image type="content" source="../media/teleportation-step-3.png" alt-text="Diagram showing two face emojis of a woman and a man representing Alice and Bob, and a telephone emoji representing that Alice calls Bob.":::

Because Bob's qubit, $B$, is entangled with Alice's qubit, $A$, Bob now knows the state of his own qubit without the need to measure it. However, Bob wants his qubit to be in the same state as the message qubit that Alice wants to teleport. Remember that neither Alice nor Bob knows the state of the message qubit.

### Bob applies the necessary quantum operations

Next, Bob applies quantum operations to his qubit, $B$, so that it has the same state as the message qubit. The operations that Bob applies depend on what Alice told him by phone.

:::image type="content" source="../media/teleportation-step-4.png" alt-text="Diagram showing two face emojis of a woman and a man representing Alice and Bob. Bob applies an operation to his qubit, represented by a hammer emoji. Bob's qubit is the same color as the message qubit.":::

The quantum operations that Bob applies are either a Pauli $X$ gate, a Pauli $Z$ gate, both gates, or no gates.

For example, if the result of Alice's measurement is $\ket{\phi^-}$, then Bob knows that his qubit is in the state $(\alpha \ket{0}_B - \beta \ket{1}_B)$. He needs to apply only a Pauli $Z$ gate to recover the original state of the message qubit. Here are the operations that Bob needs to apply to his qubit for each measurement result that Alice sends him:

| Alice measures | Bob applies                           |
|----------------|---------------------------------------|
| $\ket{\phi^+}$ | No operation                          |
| $\ket{\phi^-}$ | Pauli Z gate                          |
| $\ket{\psi^+}$ | Pauli X gate                          |
| $\ket{\psi^-}$ | Pauli X gate followed by Pauli Z gate |

This final operation effectively teleports the state of the message qubit onto Bob’s qubit. Mission accomplished!

> [!IMPORTANT]
> Applying a gate to a qubit isn't the same as measuring a qubit. When Bob applies a gate, he doesn't measure his qubit. Gates affect the state of a qubit, but the effects of gates are reversible. The effects of measurements are irreversible.

In the next unit, you implement the quantum teleportation protocol in a Q# program.
