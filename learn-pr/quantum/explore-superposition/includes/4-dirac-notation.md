In the previous unit, you learned how to represent superposition states for a single qubit on a Bloch sphere. But quantum computing requires systems of many qubits to be useful, so we need a better way to represent superposition states in larger quantum systems. In practice, use the laws of quantum mechanics and the language of linear algebra to describe quantum states in general.

In this unit, you learn how to express quantum states in Dirac bra-ket notation, and use that notation to simplify the linear algebra calculations that form the foundation of quantum mechanics and quantum computing.

## Dirac bra-ket notation

Dirac bra-ket notation, or Dirac notation for short, is a shorthand notation that makes it much easier to write out quantum states and perform linear algebra computations. In Dirac notation, the possible states of a quantum system are described by symbols called kets, which look like this: $|\rangle$.

For example, $|0\rangle$ and $|1\rangle$ represent the 0 and 1 states of a qubit, respectively. In general, we represent the state of a qubit as $|\psi\rangle$, where $|\psi\rangle$ is a weighted sum (or linear combination) of the two states $|0\rangle$ and $|1\rangle$:

$|\psi\rangle = \alpha|0\rangle + \beta|1\rangle$

A qubit in the state $|\psi\rangle = |0\rangle$ means that $\alpha = 1$, $\beta = 0$, and there's a 100% probability that you observe the 0 state when you measure the qubit. Similarly, if you measure a qubit in the state $|\psi\rangle =|1\rangle$, then you always observe the 1 state. Any other values of  $\alpha$ and $\beta$ represent a superposition state, so long as the normalization condition $|\alpha|^2 + |\beta|^2 = 1$ is true.

A qubit in an equal superposition state can be written as $|\psi\rangle = \frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle$. The probability of measuring 0 is $\frac12$ and the probability of measuring 1 is also $\frac12$.

## Quantum operators

In quantum computing, quantum states are manipulated over time to perform computations. These manipulations are represented by quantum operators, which are functions that act on the state of a quantum system to transform the system into another state. For example, the `X` operator transforms the $|0\rangle$ state into the $|1\rangle$ state:

$$X |0\rangle = |1\rangle$$

The `X` operator is also called the Pauli-X gate. It's a fundamental quantum operation that flips the state of a qubit. There are three Pauli gates: `X`, `Y`, and `Z`. Each gate, or operator, has a specific effect on the qubit state.

| Operator | Effect on $\ket{0}$   | Effect on $\ket{1}$  |
|----------|-----------------------|----------------------|
| X        | $X \ket{0} = \ket{1}$ | $X\ket{1} = \ket{0}$ |
| Y        | $Y\ket{0}=i\ket{1}$   | $Y\ket{1}=-i\ket{0}$ |
| Z        | $Z\ket{0}=\ket{0}$    | $Z\ket{1}=-\ket{1}$  |

> [!NOTE]
> Quantum operations are often referred to as gates in the context of quantum computing. The term quantum gate is an analogy to logic gates in classical computer circuits. The term is rooted in the early days of quantum computing when quantum algorithms were visualized as diagrams similar to circuit diagrams in classical computing.

You can also use an operator to put a qubit into a superposition state. The Hadamard operator, `H`, puts a qubit into a Hadamard state, which is an equal superposition of the $|0\rangle$ state and the $|1\rangle$ state:

$$  H |0\rangle = \frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle$$
$$  H |1\rangle = \frac1{\sqrt2} |0\rangle - \frac1{\sqrt2} |1\rangle$$

When you measure a qubit in a Hadamard state, you have a 50% chance to observe 0 and a 50% chance to observe 1.

## What does it mean to do a measurement?

In the classical world, we think of measurements as separate from the system that we measure. For example, a radar beam that measures the speed of a baseball doesn't affect the baseball in any meaningful way. But in the quantum world, measurements affect the systems that we measure. When we hit an electron with a photon to take a measurement, it has a fundamental effect on the state of the electron.

In quantum computing, a measurement irreversibly puts a qubit into one of its possible states, 0 or 1. In the Hadamard state example, if we measure the qubit and find that it's in the 0 state, then every subsequent measurement of that qubit always gives 0.

To learn more about measurement in the context of quantum mechanics, see the Wikipedia article about the [Measurement problem](https://wikipedia.org/wiki/Measurement_problem).
