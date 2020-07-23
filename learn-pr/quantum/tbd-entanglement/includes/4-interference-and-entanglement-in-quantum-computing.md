Until now, we only have been using superpositions with real positive amplitudes. You might be wondering, why not use directly the probabilities to represent the superposition? Well, this is one of the main ingredients that makes quantum computing work. Let's explain it.

## Waves of probabilities

The term *wave function* might be familiar to you (in fact, the `DumpMachine` function we just used names the quantum state as "wave function"). Physicist often use this term as a synonym to design the quantum state of a system. This is because the Schrödinger equation that we introduced at the beginning of this module has the same mathematical structure as classical wave equations.

You might have also heard the term "probability wave". In fact, the term *probability amplitude* is inspired directly from the term *amplitude* of a wave.

If probability amplitudes of qubits are governed by a wave-like equation, this implies that we will observe many of the different well-known physical properties of waves. Quantum algorithms exploit these properties to perform calculations. In particular, quantum computers exploit the phenomenon of **wave interference**.

## Complex numbers to describe waves

We have mentioned earlier, the probability amplitudes can be complex numbers. Complex numbers are a handy mathematical tool to describe waves. In fact, they were already used to describe waves long
before the discovery of quantum mechanics. They provide intuition to understand interference. 

But, what is wave interference? Waves are governed by a linear equation
(remember, waves and quantum states are mathematically the same thing). This
implies that waves can be superposed, just like we discussed for quantum states
in the previous units. Superposition of different waves enables their amplitudes to interfere, resulting in different
effects on the overall state.

Some waves, when superposed, form a wave of a greater amplitude. This is known as **constructive interference**: two waves are added to increase the amplitude of the resulting wave. For example, when two waves meet in a pool and the height of the resulting wave increases.

But other waves, when superposed, form a wave of lower amplitude. This is known
as **destructive interference**: two waves are added to decrease the amplitude
of the resulting wave. For example, some fancy headphones use an external
microphone to catch the sounds on environment an reproduce specific sound waves
in the inner speakers to cause destructive interference. This achieves to
suppress the environmental noise and the person wearing the headphones cannot
hear it. This is known as *active noise cancellation*.

![Noise cancellation](../media/noise-cancellation.jpg)

Constructive and destructive interference are due to **relative phases** between the waves. 

![Relative phase](../media/relative-phase.jpg)

In general an amplitude is a complex number, which describes both the magnitude and the phase of the wave. 

![image.png](../media/complex-plane.jpg)

A single complex number can store the amplitude and the phase of a given quantum state. If we used real amplitudes instead we would need two different numbers, one for the amplitude and another for the phase. When working with many possible states and many qubits this would involve a lot of messiness. Using complex numbers keeps things much more intuitive.

## Interference in quantum computing

Qubit states have the same mathematics as waves.

We used the following superposition to create the quantum random number generator:

$$\ket{\psi_1}= \frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$$.

In this case, the probabilities of measuring **0** and **1** are both $\frac12$ (remember each amplitude squared gives the probability of obtaining each state). The following state is probabilistically equivalent:

$$\ket{\psi_2}= \frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$$.

Notice the minus sign, which makes the relative phase between the $\ket{0}$ and $\ket{1}$ states different.

If we then put $\ket{\psi_1}$ and $\ket{\psi_2}$ in superposition:

$$\ket{\psi}=\frac1{\sqrt2}\ket{\psi_1}+\frac1{\sqrt2}\ket{\psi_2}= \frac1{\sqrt2}\left(\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}\right)+\frac1{\sqrt2}\left(\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}\right)$$
$$= \frac12 \left(\ket{0}+\ket{0}\right)+ \frac12\left(\ket{1}-\ket{1}\right)= \ket{0}$$.

The amplitudes of $\ket{0}$ had the same phase. Like waves, they constructively interfered doubling the probability of obtaining **0**. On the other hand, the amplitudes of $\ket{1}$ had the opposite phase and destructively interfered, eliminating the probability of obtaining **1**.

Interference is one of the basic principles behind the power of quantum computing. Quantum interference can be harnessed to perform computations to bring advantage over
classical algorithms.

## Quantum entanglement

So far, we have been exploring quantum superposition and interference. However,
those two properties alone aren't exclusive of quantum mechanics. There are many
wave-like phenomena in the nature that could be harnessed to exploit wave
dynamics to perform computations. In this section we will introduce the concept
of quantum entanglement, a truly new property of quantum systems that enables
the power of quantum computing.

### Correlations between qubits

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

### Entangled states are difficult to simulate

Entanglement is something that happens in nature, not only in quantum computers.
Atoms in molecules or compounds obeying the laws of quantum physics also get
entangled. From this entanglement many physical properties of interest array.

We would like to simulate these physical systems to learn and predict new
properties in fields like drug development, industrial chemical processes, and
many others. However, simulating entanglement is hard for classical
systems.

Suppose we have a molecule with $n$ different atoms that can become entangled.
The state of the system would be described by a superposition of states of the
form $\ket{x_0,x_1,...,x_{n-1}}$, where $x_i$ is the individual state of the
$i_{\text{th}}$ atom. If each atom can be only in two states, this means that we
need $2^n$ complex parameters to represent the probability amplitudes for
each possible state.

With ~50 atoms our best classical supercomputers start to struggle. For n≈80 we
will need more parameters than transistors are in the Earth. For  nfix≈280 we need
more parameters than the estimated number of atoms in the Universe. Even
supposing that we need only one bit per parameter (which is not true) we will
need more transistors than atoms exist in the universe to simulate a relatively
small system. In a quantum computer we don’t need to store the parameters
because the computer itself can be in a superposition! We just need to embed the
quantum state of the system that we want to simulate in the computer and run the
simulation with a specific set of quantum gates.

In the next section we are going to see how can we use Q# to explore quantum
interference and entanglement.
