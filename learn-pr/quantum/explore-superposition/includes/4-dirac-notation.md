How do we write quantum states in a way that's easy to understand and work with? A handy notation to write quantum states is the *Dirac bra-ket* notation.

## What's Dirac bra-ket notation?

Dirac notation is a shorthand notation that eases writing quantum states and computing linear algebra. In this notation, we describe the possible states of quantum systems by using symbols called _kets_ $| \rangle$.

For example, $|0\rangle$ and $|1\rangle$ represents the 0 and 1 quantum states, respectively.

A qubit in the state $|\psi\rangle = |0\rangle$ means that the probability of observing `Zero` when we measure the qubit is 100 %. Similarly, if we measure a qubit in the state $|\psi\rangle =|1\rangle$, we always get `One`.

For example, a qubit in superposition can be written as $|\psi\rangle = \frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle$. This state is a superposition of the $|0\rangle$ and $|1\rangle$ states. The probability of measuring `Zero` is $\frac12$ and the probability of measuring `One` is also $\frac12$.

## What are quantum operators?

A *quantum operator* is a function that acts on a state of a quantum system and transforms it to another state. For example, you can transform a $|0\rangle$ state into a $|1\rangle$ state, by applying the `X` operator.

$$X |0\rangle = |1\rangle$$

The `X` operator is also called the *Pauli-X gate*. It's a fundamental quantum operation that flips the state of a qubit. There're three Pauli gates: `X`, `Y`, and `Z`. Each gate or operator has a specific effect on the qubit state.

| Operator | Effect on $\ket{0}$ | Effect on $\ket{1}$ |
|----------|-----------------------|-----------------------|
| X        | $X \ket{0} = \ket{1}$           |$X\ket{1} = \ket{0}$|
| Y        | $Y\ket{0}=i\ket{1}$         | $Y\ket{1}=-i\ket{0}$         |
| Z        | $Z\ket{0}=\ket{0}$          | $Z\ket{1}=-\ket{1}$          |


> [!NOTE]
> Sometimes we talk about *quantum gates* instead of *quantum operations*. The term *quantum gate* is an analogy to classical logic gates. It's rooted in the early days of quantum computing when quantum algorithms were visualized as diagrams similar to circuit diagrams in classical computing.



You can use an operator to put a qubit in superposition. The Hadamard operator, `H`, puts a qubit that's in the state $|0\rangle$ into superposition of $|0\rangle$ and $|1\rangle$ states. Mathematically, this equation is 

$$  H |0\rangle = \frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle.$$

In this case, the probability of measuring each state is $P(0)=\left|\frac1{\sqrt{2}}\right|^2=\frac12$ and $P(1)=\left|\frac1{\sqrt{2}}\right|^2=\frac12$. Each state has a 50% probability of being measured. You also can check that $\frac12 + \frac12 = 1$.

## What is measurement?

There are many interpretations of the concept of *measurement* in
quantum mechanics, but the details are beyond the scope of this module. For
quantum computing, you don't have to worry about it.

In this module you understand measurement to be the informal idea of "observing" a qubit, which immediately collapses the quantum superposition to one of the two basis states that correspond to **0** and **1**.

To learn more about measurement in the context of quantum mechanics and its historical discussion, see the Wikipedia article about the [Measurement problem](https://wikipedia.org/wiki/Measurement_problem).





