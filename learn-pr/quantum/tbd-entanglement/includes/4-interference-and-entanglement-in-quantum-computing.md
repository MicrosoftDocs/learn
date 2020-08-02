Until now, we only have been using superpositions with real positive amplitudes.
You might be wondering, why not use directly the probabilities to represent the
superposition? Well, this aspect is one of the main ingredients that makes
quantum computing work. Let's explain it.

## Waves of probabilities

The term *wave function* might be familiar to you (in fact, the `DumpMachine`
function we just used names the quantum state as "wave function"). Physicists
often use this term as a synonym to design the quantum state of a system. This
is because the Schrödinger equation that we introduced at the beginning of this
module has the same mathematical structure as classical wave equations.

![Figure5](../media/KittyYeungQ35.png)

You might have also heard the term "probability wave". In fact, the term
*probability amplitude* is inspired directly from the term *amplitude* of a
wave.

If probability amplitudes of qubits are governed by a wave-like equation, this
implies that we'll observe many of the different well-known physical
properties of waves. Quantum algorithms exploit these properties to perform
calculations. In particular, quantum computers exploit the phenomenon of **wave
interference**.

## Complex numbers to describe waves

We have mentioned earlier, the probability amplitudes can be complex numbers.
Complex numbers are a handy mathematical tool to describe waves. In fact, they
were already used to describe waves long before the discovery of quantum
mechanics. They provide intuition to understand interference. 

But, what is wave interference? Waves are governed by a linear equation
(remember, waves, and quantum states are mathematically the same thing). This
implies that waves can be superposed, just like we discussed for quantum states
in the previous units. Superposition of different waves enables their amplitudes
to interfere, resulting in different effects on the overall state. There are two
types of interference:

- **Constructive interference**: two waves add up to increase the amplitude of
  the resulting wave. For example, in our daily experience, when two water waves
  meet in a pool, we may see a bigger wave when their peaks add up.
- **Destructive interference**: two waves subtract to decrease the amplitude of
  the resulting wave. Again in our daily experience, some fancy headphones use
  an external microphone to catch the noise in the environment. It then
  reproduces sound waves that have the same magnitude but opposite phase to the
  noise and plays them in the inner speakers to cancel the noise for the
  listener. This is using destructive interference for noise cancellation.

![Noise cancellation](../media/noise-cancellation.jpg)

Constructive and destructive interference are due to **relative phases** between
the waves.

![Relative phase](../media/relative-phase.jpg)

In general an amplitude is a complex number, which describes both the magnitude
and the phase of the wave.

![image.png](../media/complex-plane.jpg)

## Interference in quantum computing

Qubit states follow the same mathematics as waves.

We used the following superposition to create the quantum random number
generator:

$$\ket{\psi_1}= \frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$$.

In this case, the probabilities of measuring **0** and **1** are both $\frac12$
(remember each amplitude squared gives the probability of obtaining each state).
The following state is probabilistically equivalent:

$$\ket{\psi_2}= \frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$$.

Notice the minus sign, which makes the relative phase between the $\ket{0}$ and
$\ket{1}$ states different.

If we then put $\ket{\psi_1}$ and $\ket{\psi_2}$ in superposition:

$$\ket{\psi}=\frac1{\sqrt2}\ket{\psi_1}+\frac1{\sqrt2}\ket{\psi_2}=
\frac1{\sqrt2}\left(\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}\right)+\frac1{\sqrt2}\left(\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}\right)$$
$$= \frac12 \left(\ket{0}+\ket{0}\right)+ \frac12\left(\ket{1}-\ket{1}\right)=
\ket{0}$$.

The amplitudes of $\ket{0}$ had the same phase. Like waves, they constructively
interfered doubling the probability of obtaining **0**. On the other hand, the
amplitudes of $\ket{1}$ had the opposite phase and destructively interfered,
eliminating the probability of obtaining **1**.

Interference is one of the basic principles behind the power of quantum
computing. Quantum interference can be harnessed to perform computations to
bring advantage over classical algorithms.

## Quantum entanglement

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

In the next section, we're going to see how can we use Q# to
explore quantum interference and entanglement.
