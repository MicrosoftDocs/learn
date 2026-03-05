Classical computers don't generate truly random numbers, but rather pseudorandom numbers. A pseudorandom number generator generates a deterministic sequence of numbers based on some initial value (called a seed). To better approximate true randomness, the seed is often set according to the current time from the CPU's clock.

Quantum computers, on the other hand, can generate truly random numbers. This is because the measurement of a qubit in superposition is a probabilistic process. The result of the measurement is random, and there's no way to accurately predict the outcome. This is the basic principle of quantum random number generators.

In this module, you write your first quantum program in the Microsoft Quantum Development Kit. You write a quantum program to generate random numbers, and learn about the structure of a Q# program. A quantum random number generator is a great introduction to quantum concepts and quantum computing. And it requires only a few lines of Q# code to create a quantum random number generator!

## Learning objectives

After you complete this module, you can:

- Allocate qubits and apply quantum operations to them in Q#.
- Create and run Q# programs in Visual Studio Code.
- Understand the structure and components of a Q# program.

## Prerequisites

- A basic understanding of quantum computing concepts.
- Basic knowledge of classical programming concepts.
- Install the latest version of [Visual Studio Code](https://code.visualstudio.com/download).
- Install the latest version of the [Microsoft Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension. Or, open [Visual Studio Code for the web](https://vscode.dev/quantum), which already includes the Quantum Development Kit extension.
