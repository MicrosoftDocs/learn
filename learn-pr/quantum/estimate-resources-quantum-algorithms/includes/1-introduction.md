Quantum computers have the potential to tackle significant scientific and commercial problems. To become commercially viable, quantum computers need to be large-scale, fault-tolerant machines with many qubits in superposition and low physical error rates. To achieve fault tolerance, we need to implement quantum error correction (QEC) into quantum computers. However, QEC requires additional resources such as increased computation time and more physical qubits. Given these requirements, it's important to estimate the amount of resources that are required to run a specific quantum algorithm on a particular type of hardware.

The Azure Quantum Resource Estimator helps you analyze how different architectural parameters, like physical qubits and QEC models, affect overall physical resource estimates. In this module, you learn how to use the Azure Quantum Resource Estimator to estimate the resources needed to run a quantum algorithm on a real quantum computer.

## Learning objectives

By the end of this module, you can:

- Explain what the Azure Quantum Resource Estimator is.
- Define the target parameters of the Azure Quantum Resource Estimator.
- Estimate the resources of a quantum algorithm with the Azure Quantum Resource Estimator.

## Prerequisites

- The latest version of [Visual Studio Code](https://code.visualstudio.com/download).
- The latest version of the [Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension.
- A Python environment with [Python and Pip](https://apps.microsoft.com/detail/9NRWMJP3717K) installed.
- VS Code with [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter) extensions installed.
