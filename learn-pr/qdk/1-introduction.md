The Microsoft's Quantum Development Kit (QDK) comprises a wide range of tools which give developers everything they need to start writing quantum programs. The QDK uses the programming language Q#, which provides quantum programmers a framework to focus on the algorithms without having to worry about technical details like gate sequence optimization or the physical implementation of a quantum computer.

Alongside the Q# language, the QDK includes:

the Q# libraries, which allow developers to hit the ground running and create real-world quantum applications today
various target machines on which Q# programs can be run. These include resource estimators and simulators for larger quantum programs, as well as a full-state quantum simulator, which behaves as a noise-free quantum computer. The latter is very useful for tinkering with ideas, debugging programs, and learning about quantum physics, but only efficient for programs with relatively few qubits. We're very much looking forward to making quantum computing hardware available as target machines in the future.
tools for making work with Q# as seamless as possible, such as extensions for Visual Studio and VS Code, and packages for use with Python and Jupyter Notebooks.
API documentation for pairing Q# with classical host languages such as Python and C#

Video showing the interactivity of QDK. Explaining what people expect from this modules, the process of downloading and installing QDK and running a sample program, e.g. "you can make a quantum random number generator", "explore entanglement", "do a Grover search", etc. 
> [!VIDEO https://www.microsoft.com/...]

## Learning objectives

In this module you will:

- Gain hands-on experience using the Azure Quantum service
- Understand the Quantum-Inspired Optimization techniques
- Understand the XYZ techniques
- Run code on hardware through Azure Quantum

## Prerequisites

- Have taken the "Azure Quantum Overview" introductory module
- Ability to use Python, at the beginner level
- Experience using Visual Studio Code, at the beginner level 
<span style="color:red">some **May not need** text</span>
- Ability to use the Azure CLI


## Learn the scenario

Suppose you are a software developer for a logistics company that helps their client optimize delivery routes for their goods. (Can be the same scenario as the one in the overview, except persona change. QIO, Q#, dev, researcher)

:::image type="content" source="../.../....jpg" alt-text="software dev":::

## What you will do in this module

In the following units you will go through these steps:

- Install the Python SDK
- Connect to a Quantum Workspace
- Run advanced usage patterns for the Python SDK
- Run a Quantum-Inspired Optimization example