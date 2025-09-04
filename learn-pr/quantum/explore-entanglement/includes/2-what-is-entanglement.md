Entanglement is one of the key features of quantum mechanics that distinguishes it from classical mechanics. But what is entanglement? How does it work? And why is it so important for quantum information? 

In this unit, you learn how to define and describe quantum entanglement, and understand why entanglement is such a powerful resource for quantum computing.

## Understanding quantum entanglement

Imagine that you have two qubits, $A$ and $B$. The qubits are independent from each other, which means that the information about the state of qubit $A$ has nothing to do with the state of qubit $B$. Similarly, information about the state of qubit $B$ has nothing to do with the state of qubit $A$. In this case, the qubits aren't entangled because they don't share any information with each other.

Now imagine that you entangle the qubits (you learn how to do this later). If qubits $A$ and $B$ are entangled, then information about the state of qubit $A$ depends on the state of qubit $B$. In other words, the states of qubits $A$ and $B$ are correlated.

:::image type="content" source="../media/entanglement-qubits.png" alt-text="Diagram showing two qubits in two different situations, not entangled and entangled. When entangled, information is shared between both qubits, and there's no way to infer information belonging to only qubit A or qubit B.":::

If two quantum particles are entangled, then they can't be described independently, but only as a whole system.

## Describing quantum entanglement

Imagine two qubits $A$ and $B$ such that the state of the two-qubit system $\ket{\phi}$ is:

$$\ket{\phi}=\frac1{\sqrt2}(\ket{0_A 0_B}+ \ket{1_A 1_B})$$

> [!NOTE]
> In Dirac notation, $\ket{0_A 0_B}= |0\rangle_\text{A} |0\rangle_\text{B}$. Here, the leftmost position corresponds to the first qubit, and the rightmost position corresponds to the last qubit.

The system $\ket{\phi}$ is in a superposition of the states $\ket{00}$ and $\ket{11}$. If you measure both qubits, then the only possible outcomes are $\ket{00}$ and $\ket{11}$, each with probability $\frac{1}{2}$. The outcomes $\ket{01}$ and $\ket{10}$ are impossible for this system.

But what is the individual state of qubit $A$? And of qubit $B$? In this case, you can't describe the state of qubit $A$ without considering the state of qubit $B$. That's because the individual qubit systems $A$ and $B$ are entangled, which means that they're correlated and can't be described independently.

> [!TIP]
> In the language of linear algebra, a multi-qubit system is entangled when the system can't be constructed as a tensor product of the individual qubit states. A good exercise is to try to decompose the $\ket{\phi}$ state into a tensor product of that state of qubit $A$ and the state of qubit $B$. You see that it's impossible to do so.

The quantum state $\ket{\phi}$ is a special entangled state in quantum computing, called the Bell state. There are four Bell states:

$$\ket{\phi^{+}}=\frac1{\sqrt2}\ket{00} + \frac1{\sqrt2}\ket{11}$$
$$\ket{\phi^{-}}=\frac1{\sqrt2}\ket{00} - \frac1{\sqrt2}\ket{11} $$
$$\ket{\psi^{+}}=\frac1{\sqrt2}\ket{01} + \frac1{\sqrt2}\ket{10} $$
$$\ket{\psi^{-}}=\frac1{\sqrt2}\ket{01} - \frac1{\sqrt2}\ket{10} $$

## Using entanglement as a resource

At this point, you might be wondering: what's the big deal about entanglement?

When two qubits are entangled, their individual states are correlated and can't be described independently. But here's the interesting part: their measurement outcomes are also correlated! That is, whenever you measure the state of one qubit in an entangled pair, you also have information about the state of the other qubit.

For example, consider the $\ket{\phi^{+}}$ Bell state:

$$\ket{\phi^{+}}=\frac1{\sqrt2}\ket{00} + \frac1{\sqrt2}\ket{11}$$

If you measure both qubits together, then you get either $\ket{00}$ or $\ket{11}$ with equal probability. There's zero probability that you get the states $\ket{01}$ or $\ket{10}$.

But what happens if you measure only one qubit?

If you measure only qubit $A$ and you get the $\ket{0}$ state, then it means that the two-qubit system has to be in the state $\ket{00}$. This is the only possible outcome because the probability of measuring $\ket{01}$ is zero.

Therefore, you know the state of qubit $B$ without measuring it. The measurement outcomes of qubit $A$ and qubit $B$ are correlated because the qubits are entangled.

Entanglement between two particles doesn't depend on their distance from each other. This correlation of quantum entanglement is a key resource for quantum information processing tasks such as quantum teleportation, quantum cryptography, and quantum computing.

In the next unit, you write a Q# program that creates entangled Bell states from qubits that start out in non-entangled states.
