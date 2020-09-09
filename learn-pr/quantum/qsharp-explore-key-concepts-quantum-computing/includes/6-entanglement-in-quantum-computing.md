Another effect that superposition enables is quantum entanglement. In this part,
you explore this effect, which proves to be a powerful resource in quantum
computing.

### Correlations between qubits

Suppose you have a register with only two qubits. There are four possible basis states:

$$\ket{00}, \ket{01}, \ket{10}, \ket{11}.$$

It's possible to put two of these options into superposition:

$$\ket{\psi}=\frac1{\sqrt2}\ket{00}+\frac1{\sqrt2}\ket{11}.$$

In such a state, only two outcomes are possible when measuring the state of both qubits in the standard basis: **00** and **11**, each with a
probability of $\frac12$. There is zero probability of obtaining **01** and
**10**. If you measure the first qubit to be **0**, you would know the second qubit would be **0** as well, without even having to measure it. You say that the measurement outcomes are correlated and the qubits are *entangled*.

> [!NOTE]
> Not every correlation between the measurements of two qubits means
> that two qubits are entangled. Classical bits can also be correlated. Two
> qubits are entangled when they present correlations that cannot be reproduced
> using classical bits. This difference between classical and quantum
> correlations is subtle but essential for the speedup provided by quantum
> computers. Unfortunately, the formal details of this difference are out of the
> scope of this module.

Similarly, you can set up a superposition state:

$$\ket{\psi}=\frac1{\sqrt2}\ket{01}+\frac1{\sqrt2}\ket{10}.$$

In this case, only **01** and **10** are the possible outcomes. Again you would know
by measuring one of the qubits, what the result of the other one would be. This
correlation can be useful in algorithms.

These aren't the only entangled states. In general, we say that two subsystems
are entangled when the state of the global system, that is, the joint system of
both, cannot be represented as states of its subsystems, but must be considered
as one.

Entanglement is different from classical correlations, since the state of the
systems is not determined and you can talk only about the probabilities
associated to the outcomes. In fact, you can say that two systems are entangled
when the correlations between measurements of both systems can't be explained
with local classical physics.

### Entanglement and superposition are difficult to simulate

Entanglement is a phenomenon that happens in nature, not only in quantum
computers. Quantum mechanical objects, such as atoms, electrons, and photons,
can all exist in entangled states.

We would like to simulate these physical systems to learn and design material
properties for drug development, industrial chemical processes, and many others.
However, some of these entangled systems seem to be difficult
to simulate with classical computers.

Suppose you have a molecule with $n$ different atoms that are entangled. The
state of the system would be described by a superposition of states in the form
$\ket{x_0,x_1,...,x_{n-1}}$, where $x_i$ is the individual state of the
$i^{\text{th}}$ atom. If each $x_i$ has two states in superposition, then we
need $2^n$ complex parameters to represent the probability amplitudes for each
possible state of the whole system. Also, the number of operations needed to
represent a transformation of this state also scale-ups exponentially.

If you want to simulate this molecule with a classical computer, with n≈50
atoms, you would need $2^n$ bits. Our best classical supercomputers start to
struggle. For n≈80, you'll need more parameters than the number of transistors
have been ever made on Earth. For n≈280, you need more parameters than the
estimated number of atoms in the Universe.

Simulating entanglement would be difficult for classical systems. But because
quantum computers are intrinsically built on quantum systems, this becomes an
achievable task. In a quantum computer, you can describe each atom using qubit
registers that can directly be set into superposition and/or entangled states.
You can simulate quantum systems using controllable quantum systems.

In the next section, you'll use Q# to see quantum entanglement in action.
