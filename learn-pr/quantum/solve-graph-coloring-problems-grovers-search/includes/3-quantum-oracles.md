Now that we understand the classical problem we're trying to solve, let's see how to convert this problem description into a quantum operation that can be used by Grover's algorithm and executed on a quantum computer.


## How to do computations on a superposition state?

One of the key properties of quantum computing is the ability to perform calculations not only on individual inputs, but also on superpositions of inputs. When we work with a search problem and a specific function $f(x)$ that describes the instance of a search problem we're trying to solve, we need to be able to compute this function on a superposition of inputs as well.

There are two most common ways to encode the effects of computing a function for a superposition state. 

Let's say we start with a superposition state $a_0 |0\rangle + a_1 |1\rangle$, and want to implement a quantum operation $U_f$ that computes a function $f(x)$ that takes a single bit as an input and produces a single bit as an output.

1. We can encode the values $f(0)$ and $f(1)$ in the *relative phases* of basis states $|0\rangle$ and $|1\rangle$, respectively.  
In this case, applying the operation $U_f^{phase}$ converts the state $a_0 |0\rangle + a_1 |1\rangle$ into a state $(-1)^{f(0)} a_0 |0\rangle + (-1)^{f(1)} a_1 |1\rangle$. In other words, the operation $U_f^{phase}$ doesn't change the phase of the basis states for which $f(x) = 0$, and multiplies the phase of the basis states for which $f(x) = 1$ by $-1$.

2. Alternatively, we can allocate an extra qubit $y$ and encode the values $f(0)$ and $f(1)$ in the state of that qubit.  
In this case, we split the joint state of our data qubit and the extra qubit into a linear combination of basis states $a_{00} |0\rangle_x|0\rangle_y + a_{01} |0\rangle_x|1\rangle_y + a_{10} |1\rangle_x|0\rangle_y + a_{11} |1\rangle_x|1\rangle_y$ and apply the operation $U_f^{state}$ to each of the basis states separately. 
This operation will transform a basis state $|x\rangle|y\rangle$ into $|x\rangle|y \oplus f(x)\rangle$ ($\oplus$ is addition modulo 2). 
In other words, the operation $U_f^{state}$ doesn't change the basis states for which $f(x) = 0$, and flips the state of the extra qubit for the states for which $f(x) = 1$. 
The full effect on the superposition can be deduced using the fact that quantum operations are linear: our starting state will be transformed to $a_{00} |0\rangle_x|f(0)\rangle_y + a_{01} |0\rangle_x|1 \oplus f(0)\rangle_y + a_{10} |1\rangle_x|f(1)\rangle_y + a_{11} |1\rangle_x|1 \oplus f(1)\rangle_y$. 
In this case, the extra qubit will often end up entangled with the data qubits.

> [!NOTE]
> Performing computations this way is not the same as "being able to evaluate the function on all inputs at once"! 
> Recall that quantum measurements limit the amount of information we can extract from a quantum system, so in both cases we won't be able to extract all of the function values from such a computation. 
> We need to construct a clever algorithm that will take advantage of performing the computation in superposition to find the answer we're looking for.

The best way to represent classical computations in a quantum algorithm depends on the goals. 

* Many quantum algorithms call for using the first approach, encoding the classical function values in phases of basis states, since this approach simplifies expressing the algorithm. 
* The second approach, encoding the classical function values in the states of extra qubits, makes implementing the classical computations easier.
* In practice we'll often see the second approach used to implement the classical computations, and then converted to the first format as the last step before the operation is plugged into the rest of the quantum algorithm.

## Quantum oracles

A quantum oracle is a "black box" operation that is used as input to another algorithm (in this case Grover's search algorithm, but the term "oracle" is broadly used in classical computing as well). 
Some quantum algorithms are described in terms of quantum oracles to emphasize that they can be applied to a broad class of problems and do not depend on the specific problem, as long as it can be efficiently implemented as a quantum oracle. 
For such algorithms, their runtime analysis is usually done in terms of the number of oracle calls (that is, function evaluations), rather than in terms of primitive operations the algorithm will do.

When we use an algorithm described in terms of quantum oracles to solve a specific problem, we need to implement the quantum oracle for this problem — in case of Grover's search algorithm, the oracle computes the value of the function $f(x)$ that we're trying to invert.

A branch of classical computer science called *reversible computing* gives us the techniques we need to implement classical computations on a quantum computer as well. We will return to the question of implementing quantum oracles efficiently in the last unit when we discuss the types of problems that can benefit from Grover's algorithm.

In the next section you'll see how to implement the example problem, graph coloring problem, as a quantum oracle using Q#.
