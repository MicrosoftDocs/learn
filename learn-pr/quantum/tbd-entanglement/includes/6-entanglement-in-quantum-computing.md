Another effect that superposition enables is quantum entanglement. In this unit,
we'll explore this effect, which proves to be a powerful tool in quantum
computing.

### Correlations between qubits

Suppose we have a register with only two qubits. There are four possible states:

$$\ket{00}, \ket{01}, \ket{10}, \ket{11}$$.

It is possible to put two of these options into a superposition:

$$\ket{\psi}=\frac1{\sqrt2}\ket{00}+\frac1{\sqrt2}\ket{11}$$.

In such a state, only two outcomes are possible: **00** and **11**, each with a
probability of $\frac12$. There is zero probability of obtaining **01** and
**10**. If we measure the first qubit to be **0**, we would know the second
qubit would be **1** as well, without even having to measure it. We say that the
measurement outcomes are correlated and the qubits are **entangled**. 

Similarly, we can set up a superposition state

$$\ket{\psi}=\frac1{\sqrt2}\ket{01}+\frac1{\sqrt2}\ket{10}$$.

In this case, only **01** and **10** are possible outcomes. Again we would know
by measuring one of the qubits, what the result of the other one would be. This
correlation can be very useful in algorithms.

### Entangled states are difficult to simulate

Entanglement is a phenomenon that happens in nature, not only in quantum
computers. Quantum mechanical objects, such as atoms, electrons, and photons, can
all involve in entanglement.

We would like to simulate these physical systems to learn and design material
properties for drug development, industrial chemical processes, and many others.

Suppose we have a molecule with $n$ different atoms that are entangled. The
state of the system would be described by a superposition of states in the form
$\ket{x_0,x_1,...,x_{n-1}}$, where $x_i$ is the individual state of the
$i_{\text{th}}$ atom. If each $x_i$ has two states in superposition, then we
need $2^n$ complex parameters to represent the probability amplitudes for each
possible state of the whole system.

If we want to simulate this molecule with a
classical computer, with n≈50 atoms, we would need $2^n$ bits. Our best
classical supercomputers start to struggle. For n≈80, we'll need more parameters than the number of transistors we have
ever made on Earth. For n≈280, we need more parameters than the estimated number
of atoms in the Universe.

Simulating entanglement would be difficult for classical systems. But because
quantum computers are intrinsically built on superposition, this becomes an
achievable task. In a quantum computer, we can describe each atom using one qubit, as each qubit can have two states in superposition.

In the next section, you are going to use Q# to explore quantum entanglement.
