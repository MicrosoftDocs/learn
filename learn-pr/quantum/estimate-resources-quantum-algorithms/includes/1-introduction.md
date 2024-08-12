The potential of quantum computers to solve important scientific problems extends to commercial problems, as well. To achieve commercial viability in using quantum computers, you must have  large-scale, fault-tolerant computers that have both a large number of qubits (or *quantum bits*, the basic unit of measurement in quantum computing) in superposition and physical error rates below a certain threshold. You also need quantum error correction (QEC) schemes to achieve fault tolerance. QEC is both time intensive and space intensive, so the execution time for algorithm-level or logical-level operations increases. Then, you need more physical qubits to store and compute more information.

Given these requirements, resource estimation becomes crucial as you develop quantum computers and quantum solutions for commercial uses. It's important to understand the impact of architectural design choices and QEC schemes as you plan your quantum computing solution.

You can use the Azure Quantum Resource Estimator to analyze the impact of various choices for architectural parameters like physical qubit and QEC models on overall physical-resource estimates. In this module, you'll learn some basic concepts about resource estimation in fault-tolerant quantum computing, and you'll explore the Azure Quantum Resource Estimator.

## Learning objectives

By the end of this module, you'll be able to:

- Explain what the Azure Quantum Resource Estimator is.
- Define the target parameters of the Azure Quantum Resource Estimator.
- Estimate the resources of a quantum algorithm using the Azure Quantum Resource Estimator.

## Prerequisites

- The latest version of [Visual Studio Code](https://code.visualstudio.com/download) or open [VS Code on the Web](https://vscode.dev/)
- The latest version of the [Azure Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension
- A Python environment with [Python and Pip](https://apps.microsoft.com/detail/9NRWMJP3717K) installed
- VS Code with [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter) extensions installed