# Introduction to Quantum Inspired Optimization (QIO)
In this unit, you will learn about quantum-inspired optimization methods, that will be available on Azure Quantum. Quantum-inspired optimization is a subset of quantum annealing methods. We will give an introduction to these methods and the types of optimization problems they can be used for.

## What is QIO?

There are many models of quantum computing. If you have viewed the [*Write your first quantum program with the Quantum Development Kit* module](), you'll have gained familiarity with the Gate Model, in which we define quantum programs by writing operations that make use of quantum gates. 

Quantum Inspired Optimization (QIO) is based on a different computational model, namely adiabatic quantum computing. This approach uses a concept from quantum physics known as the adiabatic theorem which works as follows:
- Begin by preparing a system and initializing it to its lowest energy state. For a simple system, one which we understand everything about, this is easy to construct.
- Next, slowly transform that system into a more complex one, one which describes the problem we are trying to solve.
The adiabatic theorem states that, as long as this transformation moves slowly enough, the system will stay in that lowest energy configuration. So at the end, we've solved our problem.

[Adiabatic quantum computation](https://en.wikipedia.org/wiki/Adiabatic_quantum_computation) has been well-studied, and as a result, a number of techniques have been developed to simulate this type of physics.
These classical algorithms, which we can run on classical computers today, are also known as quantum inspired approaches.

## Why is QIO useful?

Optimization problems are commonplace in industry, from manufacturing, to finance, to transportation and much more. 
These problems involve searching over all the feasible solutions to find the best, often lowest cost, solution. 
Adiabatic quantum algorithms are naturally suited to solving optimization problems of this kind.

In the long term, adiabatic quantum algorithms can be run on quantum computers, once we have devices of a large enough scale and quality. (Can we give an estimate of scale, e.g. 200 fault-free qubits? Because this statement probably will provoke people to ask "how many qubits?") 
You can learn more about building a scalable quantum computer in [this blog post](https://cloudblogs.microsoft.com/quantum/2018/05/16/achieving-scalability-in-quantum-computing/). 

In the meantime, we can emulate these algorithms using quantum inspired techniques today on classical hardware, and often see improvements in performance over other state-of-the-art classical optimization techniques. 
[Theory suggests](https://arxiv.org/pdf/1910.01659.pdf) we'll see further speedups once quantum hardware is available.

Applying QIO to real-world problems might offer businesses' new insights, or help lower costs by making their processes more efficient. QIO is a advantageous method in these scenarios:
1. For a fixed use case and fixed quality of solution, finding the solution faster.
2. For a fixed problem and fixed amount of time, finding a higher quality solution.
3. By extending the problem to consider more variables, finding a solution to a more realistic model.