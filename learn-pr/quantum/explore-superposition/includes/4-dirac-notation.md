How do we write quantum states in a way that's easy to understand and work with? A handy notation to write quantum states is the *Dirac bra-ket* notation.

## What's Dirac bra-ket notation?

Dirac notation is a shorthand notation that eases writing quantum states and computing linear algebra. In this notation, we describe the possible states of quantum systems by using symbols called _kets_ $| \rangle$.

For example, $|0\rangle$ and $|1\rangle$ represents the 0 and 1 quantum states, respectively.

A qubit in the state $|\psi\rangle = |0\rangle$ means that the probability of observing `Zero` when we measure the qubit is 100 %. Similarly, if we measure a qubit in the state $|\psi\rangle =|1\rangle$, we always get `One`.

> [!NOTE]
> There are many interpretations of the concept of *measurement* in
> quantum mechanics, but the details are beyond the scope of this module. For
> quantum computing, you don't have to worry about it. Here we will understand 
> measurement to be the informal idea of "observing" a qubit, which immediately
> collapses the quantum superposition to one of the two basis states that correspond to classical values **0** and **1**. 
>
> To learn more about measurement in the
> context of quantum mechanics and its historical discussion, see the
> Wikipedia article about the [Measurement
> problem](https://wikipedia.org/wiki/Measurement_problem).

## What are quantum operators?

A *quantum operator* is a function that acts on a state of a quantum system and transforms it to another state. For example, you can transform a $|0\rangle$ state into a $|1\rangle$ state, by applying the `X` operator.

$$X |0\rangle = |1\rangle$$

You can use an operation to put a qubit in superposition. The operation Hadamar, `H`, puts a qubit that's in the state $|0\rangle$ into superposition of $|0\rangle$ and $|1\rangle$ states. Mathematically, this equation is 

$$  H |0\rangle = \frac1{\sqrt2} |0\rangle + \frac1{\sqrt2} |1\rangle.$$

In this case, the probability for each state is

$$P(0)=\left|\frac1{\sqrt{2}}\right|^2=\frac12;$$

$$P(1)=\left|\frac1{\sqrt{2}}\right|^2=\frac12.$$

Each state has a 50% probability of being measured. We also can check that $\frac12 + \frac12 = 1$.

### Operators and gates

Sometimes people talk about *quantum gates* instead of *quantum operations*. The term *quantum gate* is an analogy to classical logic gates. It's rooted in the early days of quantum computing when algorithms were merely a theoretical construct. They were visualized as diagrams similar to circuit diagrams in classical computing.




