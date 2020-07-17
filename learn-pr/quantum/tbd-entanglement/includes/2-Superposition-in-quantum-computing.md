For some computational tasks, quantum computing seems to provide an exponential
benefit. For other tasks, the benefits appear to be more limited. We would like
to know what are the fundamental quantum ingredients that give rise to augmented
performance of quantum computers in order to exploit them. Note that these issue
is not yet understood. Quantum computing scientist are working hard to unveil
why quantum computers provide these advantages. However, there is evidence that
some properties of quantum systems are essential for the quantum boost. In this
module we will explore three of them: superposition, interference and
entanglement.

## Quantum computers are quantum systems

Quantum computers are controllable quantum mechanical devices that exploit the properties of
quantum physics to perform computations. And, like every quantum mechanical
system, can be described with the Schrödinger equation:

$$i \hbar \frac{\partial}{\partial t}\psi(t)=\hat H \psi(t)$$

Don't worry if you don't understand every term in this equation, fortunately,
you don't need to in order to learn quantum computing. In practice, nobody
thinks in terms of the Schrödinger equation when writing quantum algorithms. But
it will help us to understand some concepts of quantum computing.

The Schrödinger equation determines the evolution of an important property of
quantum systems: the **probability amplitude** $\psi$. The probability amplitude determines probability of finding the system in a specific state, and
therefore, determines the state of the quantum system. This is an important
difference with respect to classical physics (and therefore classical
computing): we don't describe the systems as being in determined factual states,
but in terms of the probabilities of finding those states when we observe them.

A handy notation to describe quantum states is the Dirac bra-ket notation. In
this notation, we describe the possible states of quantum systems with kets $\ket{ }$. For example, for qubit systems, the state $\ket{0}$ represents the state whose
probability of observing `Zero` when measuring the qubit is 100%. Analogously,
$\ket{1}$ represents the state that always yields `One` after a measurement.

## Linear operators

An **operator** (sometimes known as **gate**) is a
function that transforms the state of a quantum system to another state.

$$\hat A \ket{\psi} = \ket{\psi'}$$

We say that an operator $\hat A$ is linear when it presents two simple
properties, additivity

$$\hat A(\ket{\psi_1} + \ket{\psi_2}) = \hat A\ket{\psi_1} + \hat A\ket{\psi_2}$$

and homogeneity

$$\hat A(a\ket{\psi})=a \hat A(\ket{\psi})$$

where $a$ is a complex number.

## Quantum superposition

The Schrödinger equation is a linear equation, since all the operators involved
in the equation are linear. This implies that if two states $\ket{\psi_1}$ and
$\ket{\psi_2}$ are solutions of the Schrödinger equation (i.e. valid quantum
states), then any linear combination of them is also a valid quantum state. This
property allows superpositions of quantum states:

$$\ket{\psi}=a\ket{\psi_1}+b\ket{\psi_2}$$

Remember that in the module [Create your first Q# program by using the Quantum Development Kit](todo)
we already used superposition to create a quantum random number generator. To do 
so we used the operator `H` to put a qubit in the state $\ket{0}$ into superposition. Mathematically this 
is:

$$ \hat H \ket{0} = \frac1{\sqrt2} \ket{0} + \frac1{\sqrt2} \ket{1} $$

Linearity is a fundamental property of quantum mechanics and therefore of quantum computing.

## Quantum computers are probabilistic

A fundamental difference between classical computers and quantum computers is that
programs in quantum computers are probabilistic. Quantum algorithms consists in the
application of linear operations to a register of qubits to modify its state to 
a particular superposition. Each superposition has different probabilities of giving
a result when we measure the qubits. This means that sometimes we have to run the
algorithm several times to find the wanted output reliably. This might look 
inefficient, but running several times quantum algorithms in many cases is much 
more efficient than the classical equivalent.

How do we know the probabilities associated with a given superposition? Well, it's 
very easy. Suppose we have a register of two qubits that consists on a superposition of
four different states:

$$\ket{\psi} = a \ket{00} + b \ket{01} + c \ket{10} + d \ket{11}$$

Then the probability for observing $\ket{00}$ is $P(00)=|a|^2$, for $\ket{01}$ is $P(01)=|b|^2$ and so on. Remember that $a,b,c$ and $d$ are probability amplitudes for each state, and therefore complex numbers.  The symbol $|a|$ represents the module of $a$. The module of a complex number is a real number, so it can represent a probability. 

An extra condition that happens in every valid quantum superposition is that all probabilities sum to one. In this case this means that $|a|^2+|b|^2+|c|^2+|d|^2=1$. This is often known as the normalization condition. You can think of it as the fact
that you always obtain an outcome when you measure, so the probabilities of measuring every possible outcome must sum to one.

For example, in the state we produced for the quantum random bit generator, $\ket{\psi}=\frac1{\sqrt2} \ket{0} + \frac1{\sqrt2} \ket{1}$ the probabilities for each state are:

$$P(0)=\left|\frac1{\sqrt{2}}\right|^2=\frac12$$
$$P(1)=\left|\frac1{\sqrt{2}}\right|^2=\frac12$$

so each state has a 50% probability of being measured and hence we have a balanced bit generator. We also can check that $\frac12 + \frac12 = 1$.

In the next unit we are going to use Q# to see how we can create different superpositions of qubits and output the probabilities.