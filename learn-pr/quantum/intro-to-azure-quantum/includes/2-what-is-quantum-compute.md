Quantum computers introduce new concepts to traditional programming methods by using the special rules of quantum physics to do calculations.

Let's see how quantum computing differs from classical computing and how to build a quantum computer.

## The birth of quantum computing

The idea of a quantum computer was born out of the difficulty of simulating quantum systems on a classical computer. In the 1980s, Richard Feynman and Yuri Manin independently suggested that hardware based on quantum phenomena might be more efficient for the simulation of quantum systems than conventional computers.

There are many ways to understand why quantum mechanics is hard to simulate. The simplest is to see that matter, at a quantum level, is in a multitude of possible configurations (known as states).

### Quantum computing grows exponentially

Consider a system of electrons where there are $40$ possible locations. The system therefore might be in any of $2^{40}$ configurations (since each location can either have or not have an electron). To store the quantum state of the electrons in a conventional computer memory, would require in excess of $130$ GB of memory! If we allowed the particles to be in any of $41$ positions, there would be twice as many configurations at $2^{41}$, which in turn would require more than $260$ GB of memory to store the quantum state.

This game of increasing the number of locations can't be played indefinitely. If we want to store the state conventionally, we would quickly exceed the memory capacities of the world's most powerful machines. At a few hundred electrons, the memory required to store the system exceeds the number of particles in the universe; thus there's no hope with our conventional computers to ever simulate their quantum dynamics.

### Turning difficulty into opportunity

The observation of this exponential growth led us to ask a powerful question: can we turn this difficulty into an opportunity? Specifically, if quantum dynamics are hard to simulate what would happen if we were to build hardware that had quantum effects as fundamental operations? Could we simulate quantum systems of interacting particles using a machine that exploits exactly the same laws of physics? And could we use that machine to investigate other tasks that are absent from quantum particles, but are crucial for us? These questions led to the genesis of Quantum Computing.

In 1985, David Deutsch showed that a quantum computer could efficiently simulate the behavior of any physical system. This discovery was the first indication that quantum computers could be used to solve problems that are intractable on classical computers.

In 1994, Peter Shor discovered a quantum algorithm for factoring integers that runs exponentially faster than the best known classical algorithm. Solving factoring makes possible the ability to break many of our public key cryptosystems underlying the security of e-commerce today, including RSA and Elliptic Curve Cryptography. This discovery sparked a huge interest in quantum computing and led to the development of quantum algorithms for many other problems.

Since that time, fast and efficient quantum computer algorithms were developed for many of our hard classical tasks: simulating physical systems in chemistry, physics, and materials science, searching an unordered database, solving systems of linear equations, and machine learning.

## What is a qubit?

Just as bits are the fundamental object of information in classical computing, *qubits* (quantum bits) are the fundamental object of information in quantum computing.

A qubit is the basic unit of information in quantum computing. Qubits play a similar role in quantum computing as bits play in classical computing, but they behave differently. Classical bits are binary and can hold only a position of $0$ or $1$, but qubits can hold a superposition of all possible states. This behavior means that a qubit can be in a state of $0$, $1$, or any quantum superposition of the two. There are infinite possible superpositions of $0$ and $1$, and each of them is a valid qubit state.

In quantum computing, the information is encoded in the superposition of the states $0$ and $1$. For example, with $8$ bits, we could encode $256$ different values, but we have to choose one of them to encode it. With $8$ qubits, we could encode the $256$ values at the same time, because a qubit can be in a superposition of all possible states.

## How to build a quantum computer

A quantum computer is a computer that takes advantage of quantum mechanical phenomena.  Quantum computers use quantum states of matter to store and compute information. They can "program" quantum interference to do things faster or better than classical computers.

When building a quantum computer, we need to think about how to create the qubits and how to store them. We also need to think about how to manipulate them and how to read the results of our computations.

The most used qubit technologies are trapped-ion qubits, superconducting qubits, and topological qubits. For some methods of qubit storage, the unit that houses the qubits is kept at a temperature near to absolute zero to maximize their coherence and reduce interference. Other types of qubit housing use a vacuum chamber to help minimize vibrations and stabilize the qubits. Signals can be sent to the qubits using various methods, including microwaves, laser, and voltage.

### The five criteria for a quantum computer

A good quantum computer should have these five features:

1. **Scalable:** It can have many qubits.
1. **Initializable:** It can set the qubits to a specific state (usually the $0$ state).
1. **Resilient:** It can keep the qubits in superposition state for a long time.
1. **Universal:** A quantum computer doesn't need to perform every possible operation, only a set of operations called *universal set*. A set of universal quantum operations is such that any other operation can be decomposed into a sequence of them.
1. **Reliable:** It can measure the qubits accurately.

These five criteria are often known as the Di Vincenzo criteria for quantum computation.

The engineering challenge of building devices that meet these five criteria is one of the most demanding ever faced by humankind. Microsoft is partnering with some of the best-in-class quantum-computer manufacturers around the world to give you access to the latest quantum computing solutions through Azure Quantum.