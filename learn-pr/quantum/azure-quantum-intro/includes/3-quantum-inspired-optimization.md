# Introduction to Quantum Inspired Optimization (QIO)

## What is QIO?

There are many models of quantum computing. If you have viewed the *Get Started SDK* module, you'll have gained familiarity with the Gate Model, in which you define quantum programs by writing operations that make use of quantum gates. 

Quantum Inspired Optimization (QIO) is based on a different model, namely adiabatic quantum computation. This approach uses a concept from quantum physics known as the adiabtic theorem which works as follows:
- Begin by preparing a system and initializing it to its lowest energy state. For a simple system, one which you understand everything about, this is easy to construct.
- Next, slowly transform that system into a more complex one, one which describes the problem you are trying to solve.
The adiabatic theorem states that, as long as this transformation moves slowly enough, the system will stay in that lowest configuration. So at the end, you've solved the problem.

A simple analogy to think of it is this, imagine you have a glass of water that is neither half full nor half empty, it is filled to the brim.
If you move this glass quickly, the contents will spill. That's because the system had too much energy, and didn't remain in the lowest energy state.
Instead, move the glass slowly, and the system has time to adapt, so the water does not spill. Now our system is in a different configuration, but remains in the lowest energy state.

Adiabatic quantum computation has been well-studied, and as a result, a number of techniques have been developed to simulate this type of physics.
These classical algorithms, which we can run on computers today to simulate adiabatic evolution, are also known as quantum inspired approaches.

## Why is QIO useful?

In this unit, you will learn about the quantum-inspired solutions enabled by Azure Quantum.


Optimization problems are ubiquitous in industry. Examples include traffic routing, flight scheduling, toolpath optimization, portfolio optimization, risk management, power grid management, computer aided design, verification and validation, satisfiability (constraint satisfaction) problems and many others. Furthermore, optimization algorithms are at the core of many machine learning methods. A number of sophisticated optimization algorithms have been developed that can solve certain special classes of optimization problems very efficiently. However, many real-world optimization problems remain intractable despite the remarkable advancement in both algorithms and computing power over the past decades. Quantum inspired optimization refers to a class of algorithms originally designed to study quantum physics problems, applied to hard optimization problems across industry. They have been demonstrated to be disruptive, but their potential remains vastly untapped. 

Quantum algorithms have been proposed for classes of optimization problems whose solution has resisted conventional approaches. In particular, adiabatic quantum algorithms are a class of methods which are naturally suited to solving optimization problems and which can be run either on universal quantum computers (once they are built) or on special purpose quantum annealers(which are now commercially available). One intuition behind adiabatic quantum algorithms is that they can use a phenomenon called quantum tunneling to escape local optima that trap more conventional optimization techniques. Recently, it has been discovered that classical algorithms can be devised which mimic the effects of quantum tunneling and in some cases dramatically outperform both quantum annealers and state of the art classical optimization software. The new field of study that has been sparked by this discovery is known as Quantum-Inspired Optimization (QIO).

# Explain general ideas of optimization

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
