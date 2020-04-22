# Introduction to Quantum Inspired Optimization (QIO)

## What is QIO?

There are many models of quantum computing. If you have viewed the *Get Started SDK* module, you'll have gained familiarity with the Gate Model, in which we define quantum programs by writing operations that make use of quantum gates. 

Quantum Inspired Optimization (QIO) is based on a different computational model, namely adiabatic quantum computing. This approach uses a concept from quantum physics known as the adiabatic theorem which works as follows:
- Begin by preparing a system and initializing it to its lowest energy state. For a simple system, one which we understand everything about, this is easy to construct.
- Next, slowly transform that system into a more complex one, one which describes the problem we are trying to solve.
The adiabatic theorem states that, as long as this transformation moves slowly enough, the system will stay in that lowest energy configuration. So at the end, we've solved our problem.

Adiabatic quantum computation has been well-studied, and as a result, a number of techniques have been developed to simulate this type of physics.
These classical algorithms, which we can run on computers today, are also known as quantum inspired approaches.

## Why is QIO useful?

Optimization problems are commonplace in industry, from manufacturing, to finance, to transportation and much more. These problems involve searching over all the feasible solutions to find the best, often lowest cost, solution. Adiabatic quantum algorithms are naturally suited to solving optimization problems of this kind.

In the long term, adiabatic quantum algorithms can be run on quantum computers, once we have devices of a large enough scale and quality. You can learn more about building a scalable quantum computer in [this blog post](https://cloudblogs.microsoft.com/quantum/2018/05/16/achieving-scalability-in-quantum-computing/). 

In the meantime, we can emulate these algorithms using quantum inspired techniques today, and often see improvements in performance over other state-of-the-art classical optimization techniques. Theory suggests we'll see further speedups once quantum hardware is available.

Applying QIO to real-world problems might offer businesses new insights, or help lower costs by making their processes more efficient. In the following sections we'll learn how QIO works and where these techniques perform well.

# Explain general ideas of optimization
In this unit, you will learn about the quantum-inspired solutions enabled by Azure Quantum.
objective function, cost function, gradient descent
finding global minimum 

Shall we explain what NP-hard is?

This is the relationship between objective and cost functions: In most optimization problems the dominant computational cost is the cost of the evaluations of the objective function. The cost is usually negligible for the processing that is used to determine, based on the evaluations performed so far, what assignment of the variables to try next. Thus the total CPU-time typically used by an optimization algorithm is approximately the number of evaluations of the objective function that it makes multiplied by the processing time for one evaluation. 

# Explain QIO

explain mathematically the similarities and differences: Thermal jump, quantum tunnel, simulated annealing, quantum annealing, quantum-inspired = simulated quantum annealing

Is Ising model the only quantum model? How do we use it?

Is there a workflow to show the commonality of establishing a QIO solutions:
e.g. construct cost function -> describe with Hamiltonian -> minimum energy


# Mapping an everyday problem to QIO e.g. Ship-loading example

(Imagine that you are the owner of a freight shipping company. You've just received your first order to deliver some cargo, and it's going to require two of your ships. The cargo consists of containers that are of varying weights - how do you load the ships so that their respective weights are as similar as possible? 

In number theory and computer science, this is known as the partition problem. lt can be thought of as an optimization problem if you consider a set of elements S, that must be partitioned into subsets S1 and S2. The sum of the elements in these subsets must be minimized in order to solve the problem. (Note: This version is NP-­hard, but can be efficiently solved.) )

Why is this example QIO (minimizing Hamiltonian)? How does it relate to the concepts above (why is Hamiltonian a cost function)? How would people do this optimization classically? 

How is our example connected to the terms introduced earlier?


# What kind of problems are good for QIO

[landscape plots]()
