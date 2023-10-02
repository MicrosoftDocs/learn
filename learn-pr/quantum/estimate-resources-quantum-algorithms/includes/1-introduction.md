The potential of quantum computers to solve important scientific problems extends to commercial problems, as well. To achieve commercial viability in using quantum computers, you must have  large-scale, fault-tolerant computers that have both a large number of qubits (or *quantum bits*, the basic unit of measurement in quantum computing) in superposition and physical error rates below a certain threshold. You also need quantum error correction (QEC) schemes to achieve fault tolerance. QEC is both time intensive and space intensive, so the execution time for algorithm-level or logical-level operations increases. Then, you need more physical qubits to store and compute more information.

Given these requirements, resource estimation becomes crucial as you develop quantum computers and quantum solutions for commercial uses. It's important to  understand the impact of architectural design choices and QEC schemes as you plan your quantum computing solution.

So, get ready! Azure Quantum has a tool that you can use to analyze the impact of various choices for architectural parameters like physical qubit and QEC models on overall physical resource estimates. In this module, you learn some basic concepts about resource estimation in fault-tolerant quantum computing, and you explore the Azure Quantum Resource Estimator.

## Learning objectives

After you complete this module, you'll be able to:

- Identify what resource estimation is and why it's important.
- Use the Azure Quantum Resource Estimator.
- Estimate the resources of an algorithm for practical quantum advantage.

## Prerequisites

- An Azure Quantum workspace

If you don't have a workspace yet, we recommend that you complete the [Get started with Azure Quantum](/training/modules/get-started-azure-quantum/?azure-portal=true) module first.
