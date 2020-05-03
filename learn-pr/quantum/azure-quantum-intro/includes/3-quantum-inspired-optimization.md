In this module, you’ll learn about quantum-inspired optimization (QIO). You'll apply what you've learned to solve this  actual optimization problem. 

Contoso Logistics Inc. is a freight company that operates two container ships.

**TODO-INSERT PICTURE**

Contoso Logistics needs to distribute containers between the two ships as evenly as possible. If one ship is significantly heavier than the other it will be slower and consume more fuel. The results are delayed shipments and significant cost increases. To make the problem harder, the weights of individual containers vary greatly so you can’t simply divide them between the two ships. How can you optimize the weight distribution of the containers?

In this module, you will:

- Learn about QIO and some QIO techniques
- Learn which problems are particularly suited to QIO
- Use QIO to solve the Contoso Logistics problem

## Prerequisites
- Complete the random number generator module

**TODO-make this the end of a unit**


**TODO-start a new unit called What is QIO?**

There are many models of quantum computing. If you have gone through the [*Write your first quantum program with the Quantum Development Kit* module](https://docs.microsoft.com/learn/modules/get-started-qdk), you are already gained familiar with the Gate Model. With that model,  we create quantum programs by writing operations that use of quantum gates. 

Quantum Inspired Optimization (QIO) is based on a different computational model called <i>adiabatic quantum computing</i>. This approach uses a concept from quantum physics known as the adiabatic theorem. When you apply that theorem to solve a problem, you:
- First prepare a system and initialize it to its lowest energy state. For a simple system, one which we completely understand, this is easy to do.
- Next, slowly transform that system into a more complex one that describes the problem we are trying to solve. The adiabatic theorem states that, as long as this transformation happens slowly enough, the system will stay in that lowest energy configuration. When we're done with our transformations, we've solved our problem.

Adiabatic quantum computation is well understood and, as a result, a number of techniques have been developed to simulate this type of physics. These classical algorithms, which we can run on classical computers today, are also known as quantum inspired approaches.

**TODO-make this the end of a unit**

**TODO-make the following section a unit Why is QIO useful?**

Optimization problems are common in many industries, such as manufacturing, finance and transportation. To solve these problems, we search through all the feasible solutions to find the best solution, which is often the one with the lowest cost. Adiabatic quantum algorithms are well-suited to solving many optimization problems.

In the future, adiabatic quantum algorithms will run on quantum computers, once we have large-scale, high-quality devices. Today, we can emulate these algorithms by using quantum-inspired techniques on classical hardware. These techniques often perform better than state-of-the-art classical optimization techniques.  


Applying QIO to real-world problems may offer businesses' new insights or help lower costs by making their processes more efficient. QIO is well suited for these types of scenarios.

- It can find the solution faster than other optimization techniqes for a fixed use case and fixed quality of solution.
- It can find a higher quality solution that other optimization techniques for a fixed problem and fixed amount of time.
- It can use a more realistic model than other optimization techniques by extending the problem to consider more variables. 

