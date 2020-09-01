Quantum computing promises to enable algorithms that are much faster than their classical counterparts for certain types of problems. 
Identifying the problems for which quantum speedup is possible and coming up with algorithms that offer it is an area of ongoing research.

One of such algorithms is Grover's search algorithm - one of the most famous algorithms in quantum computing. 
The problem it solves is often referred to as "searching a database", but it is more accurate to think of it as "search problem" or "inverting a function": given a function that returns 0 or 1, find any input for which the function returns 1. 
This formulation seems rather mathematical at first, but it is powerful enough to express a broad class of problems. 
The core idea of Grover's algorithm also turns out to be an important building block of other, more complicated quantum algorithms.

In this module, we'll introduce the necessary concepts and tools for implementing Grover's algorithm and applying it to solving a simple problem. Then we'll demonstrate the implementation in Q#.
Finally, we'll outline some practical aspects of using Grover's search for solving problems.

## Learning objectives

In this module, you will:

- Learn to build _quantum oracles_ that implement classical functions on a quantum computer.
- Understand the roles _superposition_, _interference_ and _entanglement_ play in building quantum algorithms.
- Write a Q# program that uses Grover's search algorithm to solve a graph coloring problem.
- Consider the practical aspects of applying Grover's algorithm to solving problems and learn to recognize the kinds of problems for which it can offer speedup compared to classical algorithms.

## Prerequisites

- [Create your first Q# program by using the Quantum Development Kit](https://docs.microsoft.com/learn/modules/qsharp-create-first-quantum-development-kit)
- [TODO: 2nd Q# module]()