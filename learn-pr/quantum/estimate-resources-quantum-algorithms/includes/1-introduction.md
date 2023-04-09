Quantum computers promise to solve important scientific and commercial problems. To achieve commercial viability by using quantum computers, you must have  large-scale, fault-tolerant computers that have both a large number of qubits (or *quantum bits*, the basic unit of measurement in quantum computing) in superposition and physical error rates below a certain threshold. You also need quantum error correction (QEC) schemes to achieve fault tolerance. QEC is both time intensive and space intensive, so the execution time for algorithm-level or logical-level operations increases. Then, you need more physical qubits to store and compute information.

Given these requirements, resource estimation becomes crucial as you development quantum computers and quantum solutions for commercial uses. It's important to  understand the impact of architectural design choices and QEC schemes.

So, get ready! Azure Quantum has a tool that you can use to analyze the impact of various choices for architectural parameters such as physical qubit and QEC models on the overall physical resource estimates. In this module, you'll learn some basic concepts about resource estimation in fault-tolerant quantum computing, and you'll explore the Azure Quantum Resource Estimator.

## Learning objectives

After completing this module, you'll be able to:

- Describe what resource estimation is and why it's important.
- Use the Azure Quantum Resource Estimator.
- Estimate the resources of an algorithm with practical quantum advantage.

## Prerequisites

- An Azure Quantum workspace

If you don't have a workspace yet, we recommend that you complete the [Get started with Azure Quantum](/training/modules/get-started-azure-quantum/?azure-portal=true) module first.
