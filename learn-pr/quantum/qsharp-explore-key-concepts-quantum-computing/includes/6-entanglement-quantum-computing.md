Another effect that superposition enables is quantum entanglement. As you'll see in this part,
this effect is a powerful resource in quantum
computing.

## Correlations between qubits

Suppose you have a register that consists of only two qubits. Since each qubit is a two-state system, four basis states are possible:

$$|00\rangle, |01\rangle, |10\rangle, |11\rangle$$

Where the first position corresponds to the first qubit; and the second position to the second qubit. For example, the quantum state $|01\rangle$, denotes the joint of the first qubit in the $|0\rangle$ state and the second qubit in the $|1\rangle$ state. Two of these options can be put into superposition:

$$|\psi\rangle=\frac1{\sqrt2}|00\rangle+\frac1{\sqrt2}|11\rangle.$$

In such a state, only two outcomes are possible when you measure the state of both qubits in the standard basis: **$|00\rangle$** and **$|11\rangle$**. Notice that each outcome has the same probability of $\frac12$. There's zero probability of obtaining **$|01\rangle$** and **$|10\rangle$**. If you measure the first qubit and you get that it is in **$|0\rangle$** state, then you can be positive that the second qubit is also in **$|0\rangle$** state, even without measuring it. The measurement outcomes are correlated, and the qubits are *entangled*.

> [!NOTE]
> Not every correlation between the measurements of two qubits means
> that the two qubits are entangled. Classical bits can also be correlated. Two
> qubits are entangled when they present correlations that can't be reproduced by
> using classical bits. This difference between classical and quantum
> correlations is subtle, but it's essential for the speedup provided by quantum
> computers. The formal details of this difference are beyond the
> scope of this module.

Similarly, you can set up this superposition state:

$$|\psi\rangle=\frac1{\sqrt2}|01\rangle+\frac1{\sqrt2}|10\rangle.$$

In this case, only **$|01\rangle$** and **$|01\rangle$** are possible outcomes. Again, by measuring just one of the qubits, you already know the result of the other qubit. This correlation can be useful in algorithms.

The states we've reviewed aren't the only entangled states. In general, we say that two systems are entangled when the state of the global system can't be written as a linear combination of the subsystems. For example, consider the following two-qubit quantum state:

$$|\phi\rangle=\frac1{\sqrt2}|00\rangle+\frac1{\sqrt2}|01\rangle = |0\rangle \lbrace \frac1{\sqrt2}(|0\rangle +|1\rangle) \rbrace.$$

In the preceding quantum state two qubits are in superposition, but they aren't entangled as the system can be expressed as a linear combination of the states of the individual qubits. The first qubit is in the $|0\rangle$ state while the second qubit is in the $\frac1{\sqrt2}(|0\rangle +|1\rangle)$ state.

Entanglement is a quantum correlation, which is very different from classical correlations. In entanglement, the state of the systems isn't determined, and you can talk only about the probabilities associated with the outcomes. The global system must be considered as one. In fact, you can say that two systems are entangled when local classical physics can't explain the correlations between the measurements of both systems.

## Entanglement and superposition are difficult to simulate

Entanglement is a phenomenon that happens in nature, not only in quantum
computers. Quantum mechanical objects, such as atoms, electrons, and photons,
can all exist in entangled states.

We would like to be able to simulate these physical systems to improve drug development, 
industrial chemical processes, and many other areas.
But some of these entangled systems are difficult
to simulate on classical computers.

Suppose you have a molecule that has $n$ entangled atoms. You could describe the system's state
by superposing states in the form
$|x_0,x_1,...,x_{n-1}\rangle$. Here, $x_i$ is the individual state of the
$i^{\text{th}}$ atom. If each $x_i$ has two states in superposition, then we
need $2^n$ complex parameters to represent the probability amplitudes for each
possible state of the whole system. 

The number of operations that we need to
represent a transformation of this state also scales up exponentially.
To simulate a molecule of n≈50
atoms on a classical computer, we need $2^n$ bits. Our best classical supercomputers would
struggle under these demands. For n≈80, we need more parameters than the number of transistors
that have ever been made. For n≈280, we need more parameters than the
estimated number of atoms in the universe.

Simulating entanglement can be difficult for classical systems. But because
quantum computers are built on quantum systems, the simulation is
achievable. In a quantum computer, you can describe each atom by using qubit
registers that you can directly set into superposition or entangled states or both.
You can simulate quantum systems by using controllable quantum systems.

In the next section, you'll use Q# to see quantum entanglement in action.
