Classical computers don't produce random numbers, but rather _pseudorandom_ numbers. A pseudorandom number generator generates a deterministic sequence of numbers based on some initial value (called a _seed_). To better approximate random values, this seed is often the current time from the CPU's clock.

Quantum computers, on the other hand, can generate truly random numbers. This is because the measurement of a qubit in superposition is a probabilistic process. The result of the measurement is random, and there's no way to predict the outcome. This is the basic principle of quantum random number generators.

In this module, you write your first quantum program by using the Azure Quantum Development Kit (QDK). 

You write a quantum program to generate random numbers. A quantum random number generator is a perfect introduction to quantum computing because it illustrates quantum behavior and requires only a few lines of code. You also review the basic structure of a Q# program.

## Learning objectives

After completing this module, you're able to:

- Allocate qubits and apply quantum operations to them.
- Create and run Q# programs in Visual Studio Code.
- Understand the structure and components of a Q# program.

## Prerequisites

- A basic understanding of quantum computing concepts.
- Basic knowledge of classical programming concepts.
- Install the latest version of [Visual Studio Code](https://code.visualstudio.com/download).
- Install the latest version of the [Azure Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension.

    - You can also open [VS Code on the Web](https://vscode.dev/quantum), which already includes the Azure Quantum Development Kit extensions.


