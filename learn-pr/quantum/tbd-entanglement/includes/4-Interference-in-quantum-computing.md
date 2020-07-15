Until now, we only have been using superpositions with real positive amplitudes. So you might be wondering, why not to use directly the probabilities to represent the superposition? Well, this is one of the main ingredients that makes quantum computing work. Let's explain it.

## Waves of probabilities

The term *wave function* might be familiar to you (in fact, the `DumpMachine` function we just used names the quantum state as "wave function"). Physicist often use this term as a synonym to design the quantum state of a system. This is because the Schrödinger equation that we introduced at the beginning of this module has the same mathematical structure than classical wave equations.

This means that the function defining the probability amplitudes behaves like a physical wave, and therefore is called wave function. This is why you sometimes might hear the term "probability wave". In fact, the term *probability amplitude* is inspired directly from the term *amplitude* of a wave.

If probability amplitudes of qubits are governed by a wave-like equation, this implies that we will observe many of the different well-known physical properties of waves. Quantum algorithms exploit these properties to perform calculations. In particular, quantum computers exploit the phenomenon of **wave interference**.

## Complex numbers to describe waves

Complex numbers are a handy mathematical tool to describe waves. In fact, they were already used to describe waves long
before the discovery of quantum mechanics. They are an intuitive form of describing waves to explain phenomena like wave interference. 

But, what is wave interference? Waves are governed by a linear equation
(remember, waves and quantum states are mathematically the same thing). This
implies that waves can be superposed, just like we discussed for quantum states
in the previous units. However, the superposition of different waves can have different
effects on the amplitude of the resulting superposition.

Some waves, when superposed, form a wave of a greater amplitude. This is known as **constructive interference**: two waves are added to increase the amplitude of the resulting wave. For example, when two waves meet in a pool and the height of the resulting wave increases.

But other waves, when superposed, form a wave of lower amplitude. This is known
as **destructive interference**: two waves are added to decrease the amplitude
of the resulting wave. For example, some fancy headphones use an external
microphone to catch the sounds on environment an reproduce specific sound waves
in the inner speakers to cause destructive interference. This achieves to
suppress the environmental noise and the person wearing the headphones cannot
hear it. This is known as *active noise cancellation*.

![Noise cancellation](../media/noise-cancellation.jpg)

But, why do some waves interfere constructively whereas others interfere destructively? Well, this is due to the **relative phase** between the waves. 

![Relative phase](../media/relative-phase.jpg)

The phase of a wave is just a number that represents the relative position of the wave in the cycle. It is usually interpreted as an angle because waves are often described in terms of trigonometric functions $\sin$ and $\cos$.

Then, to characterize a wave-like object we need two things: the *amplitude*, i.e. the intensity of the wave, and the **phase**,i.e. the relative position in the cycle. It happens to be that complex numbers are a natural mathematical tool to describe both things at the same time! This is why we use the concept of **complex amplitude**.

![image.png](../media/complex-plane.jpg)

A single complex number can store the amplitude and the phase of a given quantum state. If we used real amplitudes instead we would need two different numbers, one for the amplitude and another for the phase. When working with many possible states and many qubits this would involve a lot of messiness. Using complex numbers keeps things much more intuitive.

## Interference in quantum computing

You might be confused now. What do waves have to do with qubits? Do you need to know wave mechanics to program quantum algorithms? Let's explore it. But we advance you that you DON'T need to know wave mechanics to use quantum computers! Is much more intuitive than you think.

We used the following superposition to create the quantum random number generator:

$$\ket{\psi_1}= \frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$$

And we used that state because the probabilities of measuring **0** and **1** where both $\frac12$ (remember that these probabilities were obtained squaring the probability amplitude of each state in the superposition). But we could very well have used the following state:

$$\ket{\psi_2}= \frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$$

Notice the minus sign. We can check that for $\ket{\psi{2}}$ the probabilities of measuring **0** and **1** are also $\frac12$, since $\left|-\frac1{\sqrt2}\right|^2=\frac12$. Then, what is the meaningful difference between $\ket{\psi_1}$ and $\ket{\psi_2}$? The difference is the relative phase between the states in each superposition.

This difference of phase has implications when we superpose this states. Let's superpose $\ket{\psi_1}$ and $\ket{\psi_2}$ to see what happens.

$$\ket{\psi}=\frac1{\sqrt2}\ket{\psi_1}+\frac1{\sqrt2}\ket{\psi_2}= \frac1{\sqrt2}\left(\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}\right)+\frac1{\sqrt2}\left(\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}\right)$$
$$= \frac12 \left(\ket{0}+\ket{0}\right)+ \frac12\left(\ket{1}-\ket{1}\right)= \ket{0}$$

What did happen here? The amplitudes of $\ket{0}$ had the same phase and like waves, constructively interfered doubling the probability of obtaining **0**. On the other hand, the amplitudes of $\ket{1}$ had different phase and destructively interfered, vanishing the probability of obtaining **1**.

This kind of quantum interference is one of the basic principles behind the power of quantum computing. Our objective will
be to harness quantum interference to perform computations much faster than with classical algorithms.

In the next section we will explore interference examples with Q# and the Quantum Development Kit.