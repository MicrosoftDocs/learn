Another effect that superposition enables is quantum entanglement. As you'll see in this part,
this effect is a powerful resource in quantum
computing.

## Correlations between qubits

Suppose you have a register that consists of only two qubits. Four basis states are possible:

$$|00\rangle, |01\rangle, |10\rangle, |11\rangle$$

Two of these options can be put into superposition:

$$|\psi\rangle=\frac1{\sqrt2}|00\rangle+\frac1{\sqrt2}|11\rangle.$$

In such a state, only two outcomes are possible when you measure the state 
of both qubits in the standard basis: **00** and **11**. Each outcome has a
probability of $\frac12$. There is zero probability of obtaining **01** and
**10**. If you measure the first qubit as **0**, then you know that the second 
qubit is **0**, even without measuring it. The measurement outcomes 
are correlated, and the qubits are *entangled*.

> [!NOTE]
> Not every correlation between the measurements of two qubits means
> that the two qubits are entangled. Classical bits can also be correlated. Two
> qubits are entangled when they present correlations that can't be reproduced by
> using classical bits. This difference between classical and quantum
> correlations is subtle, but it's essential for the speedup provided by quantum
> computers. The formal details of this difference are beyond the
> scope of this module.

Similarly, you can set up a superposition state:

$$|\psi\rangle=\frac1{\sqrt2}|01\rangle+\frac1{\sqrt2}|10\rangle.$$

In this case, only **01** and **10** are possible outcomes. Again, by 
measuring one of the qubits, you know the result of the other qubit. This
correlation can be useful in algorithms.

The states we've reviewed aren't the only entangled states. In general, we say that two subsystems
are entangled when the state of the global system, that is, the joint system of
both, can't be represented as states of its subsystems. The global system must be considered
as one.

Entanglement is different from classical correlations. In entanglement, the state of the
systems isn't determined, and you can talk only about the probabilities
associated with the outcomes. In fact, you can say that two systems are entangled
when local classical physics can't explain the correlations between the measurements of both systems.

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
