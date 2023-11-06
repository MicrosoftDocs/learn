Quantum computers use the special rules of quantum physics to do calculations. This introduces new concepts to traditional programming methods.

Let's see how quantum computing differs from classical computing and how to build a quantum computer.

## The birth of quantum computing

The idea of a quantum computer was born out of the difficulty of simulating quantum systems on a classical computer. In the 1980s, Richard Feynman and Yuri Manin independently suggested that hardware based on quantum phenomena might be more efficient for the simulation of quantum systems than conventional computers.

There are many ways to understand why quantum mechanics is hard to simulate. The simplest is to see that matter, at a quantum level, is in a multitude of possible configurations (known as states).

### Quantum computing grows exponentially

Consider a system of electrons where there are $40$ possible locations. The system therefore may be in any of $2^{40}$ configurations (since each locations can either have or not have an electron). To store the quantum state of the electrons in a conventional computer memory would require in excess of $130$ GB of memory! If we allowed the particles to be in any of $41$ positions, there would be twice as many configurations at $2^{41}$ which in turn would require more than $260$ GB of memory to store the quantum state.

This game of increasing the number of locations cannot be played indefinitely if we want to store the state conventionally as we quickly exceed memory capacities of the world's most powerful machines. At a few hundred electrons the memory required to store the system exceeds the number of particles in the universe; thus there is no hope with our conventional computers to ever simulate their quantum dynamics.

### Turning difficulty into opportunity

The observation of this exponential growth led to ask a powerful question: can we turn this difficulty into an opportunity? Specifically, if quantum dynamics are hard to simulate what would happen if we were to build hardware that had quantum effects as fundamental operations? Could we simulate quantum systems of interacting particles using a machine that exploits exactly the same laws of physics? And could we use those that machine to investigate other tasks that are absent from quantum particles, but are crucial for us? These questions led to the genesis of Quantum Computing.

In 1985, David Deutsch showed that a quantum computer could efficiently simulate the behavior of any physical system. This was the first indication that quantum computers could be used to solve problems that are intractable on classical computers.

In 1994, Peter Shor discovered a quantum algorithm for factoring integers that runs exponentially faster than the best known classical algorithm. Solving factoring brings with it the ability to break many of our public key cryptosystems underlying the security of e-commerce today, including RSA and Elliptic Curve Cryptography. This discovery sparked a huge interest in quantum computing and led to the development of quantum algorithms for many other problems.

Since that time, fast and efficient quantum computer algorithms have been developed for many of our hard classical tasks: simulating physical systems in chemistry, physics, and materials science, searching an unordered database, solving systems of linear equations, and machine learning.

## What is a qubit?

Just as bits are the fundamental object of information in classical computing, *qubits* (quantum bits) are the fundamental object of information in quantum computing.

A qubit is the basic unit of information in quantum computing. Qubits play a similar role in quantum computing as bits play in classical computing, but they behave very differently. Classical bits are binary and can hold only a position of $0$ or $1$, but qubits can hold a superposition of all possible states. This means that a qubit can be in a state of $0$, $1$, or any quantum superposition of the two. There are infinite possible superpositions of $0$ and $1$, and each of them is a valid qubit state.

In quantum computing, the information is encoded in the superposition of the states $0$ and $1$. For example, with $8$ bits, we could encode $256$ different values, but we have to choose one of them to encode it. With $8$ qubits, we could encode the $256$ values at the same time. This is because a qubit can be in a superposition of all possible states.

## How to build a quantum computer

A quantum computer is a computer that takes advantage of quantum mechanical phenomena. The foundational core of quantum computing is to store information in quantum states of matter and to use quantum operations to compute on that information, by harnessing and learning to "program" quantum interference.

When building a quantum computer, we need to think about how to create the qubits and how to store them. We also need to think about how to manipulate them and how to read the results of our computations.

Most used qubit technologies are trapped-ion qubits, superconducting qubits, and topological qubits. For some methods of qubit storage, the unit that houses the qubits is kept at a temperature just above absolute zero to maximize their coherence and reduce interference. Other types of qubit housing use a vacuum chamber to help minimize vibrations and stabilize the qubits. Signals can be sent to the qubits using a variety of methods, including microwaves, laser, and voltage.

### The five criteria for a quantum computer

In general, a functional quantum computer should fulfill the following criteria:

1. **Scalability:** Quantum computers are based on the manipulation of quantum information by using qubits. We need a system that allows scalability to a large number of qubits.
1. **Ability to initialize the qubits in a specific state:** Having many qubits isn't useful if we can't trust their initial state. A fundamental characteristic of a quantum computer is its ability to initialize the qubits reliably to a specific state (usually, the state $0$).
1. **Resilient qubits:** Quantum states are delicate. The smallest interaction with the environment can "contaminate" the state of the qubits and ruin our computations. Qubit registers need to be able to remain in a consistent quantum state long enough for us to perform the computations. The amount of time that a qubit can remain in a specific quantum state is called *coherence time*.
1. **A universal set of quantum operations:** Like in classical computing, any quantum algorithm can be decomposed as the application of a sequence of operations. A set of universal quantum operations is a set of quantum operations such that any other operation can be written (executed) as a sequence of them. Thus, a quantum computer doesn't need to perform every possible operation, only the operations in the universal set. A quantum computer that can perform a universal set of operations can be programmed to run any quantum algorithm.
1. **Reliable measurements:** To obtain the results of quantum computations, we need to measure each qubit with high precision.

These five criteria are often known as the Di Vincenzo criteria for quantum computation.

Building devices that meet these five criteria is one of the most demanding engineering challenges ever faced by humankind. Microsoft is partnering with some of the best-in-class quantum-computer manufacturers around the world to give you access to the latest quantum computing solutions through Azure Quantum.