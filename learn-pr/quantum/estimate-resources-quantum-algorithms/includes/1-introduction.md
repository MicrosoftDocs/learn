Quantum computers have the potential to help solve significant scientific and commercial problems. To become commercially viable, quantum computers need to be large-scale and fault-tolerant machines with many qubits in superposition and low physical error rates. To achieve fault tolerance, quantum computers need some type of quantum error correction (QEC) implementation. However, QEC requires additional resources such as increased computation time and more physical qubits. Given these requirements, it's important to estimate the amount of resources that are required to run a specific quantum algorithm on a particular type of hardware.

The Microsoft Quantum resource estimator helps you analyze how different architectural parameters, like physical qubits and QEC models, affect overall physical resource estimates. In this module, you learn how to use the Microsoft Quantum resource estimator to estimate the resources needed to run a quantum algorithm on a real quantum computer.

## Learning objectives

By the end of this module, you can:

- Explain what the Microsoft Quantum resource estimator is.
- Define the target parameters of the resource estimator.
- Use the resource estimator to estimate the resources needed to run a quantum algorithm.

## Prerequisites

- The latest version of [Visual Studio Code](https://code.visualstudio.com/download).
- The latest version of the [Microsoft Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension.
- A Python environment with [Python and Pip](https://apps.microsoft.com/detail/9NRWMJP3717K) installed.
- VS Code with [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter) extensions installed.
