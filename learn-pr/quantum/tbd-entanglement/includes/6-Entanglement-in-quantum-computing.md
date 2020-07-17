So far, we have been exploring quantum superposition and interference. However,
those two properties alone aren't exclusive of quantum mechanics. There are many
wave-like phenomena in the nature that could be harnessed to exploit wave
dynamics to perform computations. In this section we will introduce the concept
of quantum entanglement, a truly new property of quantum systems that enables
the power of quantum computing.

## Correlations between qubits

We already have seen superpositions involving several qubits in which each of
the possible outcomes has associated a probability amplitude. These probability
amplitudes are represented by complex numbers.

Let's suppose now that we have a register with only two qubits. The possible
outcomes are four:

$$\ket{00}, \ket{01}, \ket{10}, \ket{11}$$

Then, a possible superposition would be:

$$\ket{\psi}=\frac1{\sqrt2}\ket{00}+\frac1{\sqrt2}\ket{11}$$

This apparently innocent state is the main ingredient of many of the most
striking processes of quantum computing and quantum information. Let's
understand why.

In such state, we can obtain only two different outcomes, **00** and **11**,
each of them with a probability of $\frac12$. The outcomes **01** and **10**
have zero probability amplitude, and therefore we can't observe them if the
register is in this superposition. Then the second qubit always gives the same
result as the measurement of the first qubit. This means that by measuring one
qubit we immediately know the state of the other without having to measure it.
We say that the measurement outcomes are correlated and the qubits are
**entangled**.

It is possible to manipulate these states with different operations so that
advantageous correlations still exist between both qubits. This correlations are
proven to be stronger than could ever exists between classical bits.

## Entangled states are difficult to simulate

Entanglement is something that happens in nature, not only in quantum computers.
Atoms in molecules or compounds obeying the laws of quantum physics also get
entangled. From this entanglement many physical properties of interest array.

We would like to simulate these physical systems to learn and predict new
properties in fields like drug development, industrial chemical processes, and
many others. However, simulating entanglement is hard for classical
systems.

Suppose we have a molecule with $n$ different atoms that can become entangled.
The state of the system would be described by a superposition of states of the
form $\ket{\x_0,x_1,...,x_{n-1}}$, where $x_i$ is the individual state of the
$i_{\text{th}}$ atom. If each atom can be only in two states, this means that we
need $2^n$ complex parameters to represent the probability amplitudes for
each possible state.

With ~50 atoms our best classical supercomputers start to struggle. For N≈80 we
will need more parameters than transistors are in the Earth. For  N≈280 we need
more parameters than the estimated number of atoms in the Universe. Even
supposing that we need only one bit per parameter (which is not true) we will
need more transistors than atoms exist in the universe to simulate a relatively
small system. In a quantum computer we don’t need to store the parameters
because the computer itself can be in a superposition! We just need to embed the
quantum state of the system that we want to simulate in the computer and run the
simulation with a specific set of quantum gates.
