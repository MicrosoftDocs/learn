# Introduction to the QDK

The Microsoft's Quantum Development Kit (QDK) comprises a wide range of tools which give developers everything they need to start writing quantum programs. The QDK uses the programming language Q#, domain-specific programming language used for expressing quantum algorithms. It provides quantum programmers a framework to focus on the algorithms without having to worry about technical details like gate sequence optimization or the physical implementation of a quantum computer.

Video showing the interactivity of QDK. Explaining what people expect from this modules, the process of downloading and installing QDK and running a sample program, e.g. "you can make a quantum random number generator", "explore entanglement", "do a Grover search", "estimate the ground state energies of molecular hydrogen", "set up a quantum machine learning algorithm", etc. 
> [!VIDEO https://www.microsoft.com/...]

Video should also include the following about QDK with visuals:
"
Alongside the Q# language, the QDK includes:

- the Q# libraries, which allow developers to hit the ground running and create real-world quantum applications today
- various target machines on which Q# programs can be run. These include resource estimators and simulators for larger quantum programs, as well as a full-state quantum simulator, which behaves as a noise-free quantum computer. The latter is very useful for tinkering with ideas, debugging programs, and learning about quantum physics, but only efficient for programs with relatively few qubits. We're very much looking forward to making quantum computing hardware available as target machines in the future.
- tools for making work with Q# as seamless as possible, such as extensions for Visual Studio and VS Code, and packages for use with Python and Jupyter Notebooks.
- API documentation for pairing Q# with classical host languages such as Python and C#
"

## Learning objectives

In this module you will:
- Prepare your development environment for writing quantum programs
- Understand how to use Q# to express quantum algorithms
- Learn how to combine Q# with a host program in Python
- Start your journey as a quantum developer
- Learn how to contribute to the open-source quantum community

## Prerequisites

- Basic understanding of quantum computing concepts
- Ability to code in any programming language, at the beginner level
- Experience using Visual Studio Code, at the beginner level *may not need if we enable embedded coding excercises 

## Why are you here?

Since you're here you are probably interested at some level in quantum computing, maybe you're a quantum computing researcher
that wants to try the Microsoft Quantum Development Kit or a hobbyist that want to want to understand what quantum programming 
looks like and to contribute with your own projects to this emerging community. In any case, this is a great place to start
exploring what tools Microsoft offers to quantum developers and how you can start today to write your own quantum programming 
projects.

:::image type="content" source="../.../....jpg" alt-text="software dev":::

## What you will do in this module

In the following units you will go through these steps:

- Install the QDK (*if we are enabling embedded coding experience, we may chose a fixed method and environment)
- Create a Q# project
- Combine Q# and Python to create a quantum random number generator
- As a call to action: learn more about QDK and Q# on the docs page, practice on quanutm katas, contribute to the QDK 
