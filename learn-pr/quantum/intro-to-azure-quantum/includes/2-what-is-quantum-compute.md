Quantum computers introduce new concepts to traditional programming methods through the special rules of quantum physics to do calculations.

Let's see how quantum computing differs from classical computing and how to build a quantum computer.

## The birth of quantum computing

Quantum systems, such as atoms and molecules, can be difficult or impossible to simulate on a classical computer. In the 1980s, Richard Feynman and Yuri Manin suggested that hardware based on quantum phenomena might be more efficient for the simulation of quantum systems than conventional computers.

There are several reasons why quantum systems are difficult to simulate on regular computers. One main reason is that matter, at a quantum level, is described as a combination of multiple configurations (known as states) at the same time.

### Quantum systems grow exponentially

Consider a system of particles, and 40 possible locations where those particles can exist. The system could be in any of $2^{40}$ unique states because each location can either have or not have a particle. If these are classical particles, then the system is always in only one of the $2^{40}$ states, so a classical computer needs only 40 bits to describe the state of the system. But if these are quantum particles, then the system exists in a combination of all $2^{40}$ states. A classical computer needs to store $2^{40}$ numbers to describe the quantum system, which requires over 130 GB of memory. However, a quantum computer needs only 40 quantum bits to describe this quantum system.

If we add another location to the system so that the electrons can exist in 41 locations, then the number of unique configurations of the system doubles to $2^{41}$. It would take more than 260 GB of memory to store that quantum state on a classical computer. We can't play this game of increasing the number of locations forever. To store a quantum state on a conventional computer, you quickly exceed the memory capacities of the world's most powerful machines. At a few hundred electrons, the memory required to store the system exceeds the number of particles in the universe. There's no hope with our conventional computers to completely simulate quantum dynamics for larger systems!

### Turning difficulty into opportunity

The observation of this exponential growth posed a powerful question: is it possible to turn this difficulty into an opportunity? If quantum systems are difficult to simulate on regular computers, what would happen if we build a machine that uses quantum effects for its fundamental operations? Could we simulate quantum systems with a machine that exploits exactly the same laws of physics? And could we use that machine to investigate other important problems outside of quantum mechanics? These are the kinds of questions that gave rise to the fields of quantum information and quantum computing.

In 1985, David Deutsch showed that a quantum computer could efficiently simulate the behavior of any physical system. This discovery was the first indication that quantum computers could be used to solve problems that are too difficult to solve on classical computers.

In 1994, Peter Shor discovered a quantum algorithm to find the prime factors of large integers. Shor's algorithm runs exponentially faster than the best known classical algorithm for this factoring problem. Such a fast algorithm could potentially break many of our modern public key cryptosystems that we use to secure transactions in e-commerce, such as Rivest–Shamir–Adleman (RSA) and Elliptic Curve Cryptography. This discovery sparked a huge interest in quantum computing and led to the development of quantum algorithms for many other problems.

Since that time, fast and efficient quantum computer algorithms were developed for other problems that are difficult to solve on classical computers. For example, we now have quantum algorithms to search an unordered database, to solve systems of linear equations, to perform machine learning, and to simulate physical systems in chemistry, physics, and materials science.

## What is a qubit?

Just as bits are the fundamental object of information in classical computing, qubits (quantum bits) are the fundamental object of information in quantum computing.

Qubits play a similar role in quantum computing as bits play in classical computing, but qubits behave differently than bits. Classical bits are binary and, at any given time, can be in only one of two states, 0 or 1. But qubits can be in a superposition of both the 0 and 1 states at the same time. In fact, there are infinite possible superpositions of 0 and 1, and each of them is a valid qubit state.

In quantum computing, information is encoded in superpositions of the states 0 and 1. For example, 8 regular bits can encode up to 256 unique values, but these 8 bits can only represent one of the 256 values at a time. With 8 qubits, we could encode all 256 values at the same time, because the qubits can be in a superposition of all 256 possible states.

## How to build a quantum computer

A quantum computer uses quantum systems and the properties of quantum mechanics to solve computational problems. The systems in a quantum computer consist of the qubits, the interactions between qubits, and operations on the qubits to store and compute information. We can use quantum computers to program effects like quantum entanglement and quantum interference to accurately solve certain problems faster than on classical computers.

To build a quantum computer, we need to consider how to create and store the qubits. We also need to think about how to manipulate the qubits and how to measure the results of our computations.

Popular qubit technologies include trapped-ion qubits, superconducting qubits, and topological qubits. For some methods of qubit storage, the unit that houses the qubits must be kept at a temperature near absolute zero to maximize their coherence and reduce interference. Other types of qubit housing use a vacuum chamber to help minimize vibrations and stabilize the qubits. Signals can be sent to the qubits through various methods, such as microwaves, lasers, or voltages.

### The five criteria for a quantum computer

A good quantum computer should have these five features:

1. **Scalable:** It can have many qubits.
1. **Initializable:** It can always set the qubits to a specific initial state (usually the 0 state).
1. **Resilient:** It can keep the qubits in superposition states for a long time.
1. **Universal:** It can perform a set of universal quantum operations such that any other operation can be decomposed into a sequence of universal operations.
1. **Reliable:** It can measure the qubits accurately and consistently.

These five criteria are often known as the DiVincenzo criteria for quantum computation.

Building a device that meets all five criteria is one of the most demanding engineering challenges of our time. Microsoft is partnering with some of the best-in-class quantum computer manufacturers around the world to give you access to the latest quantum computing solutions through Azure Quantum.
