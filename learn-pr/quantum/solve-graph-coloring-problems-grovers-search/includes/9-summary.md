Congratulations! In this module, you've learned a lot about Grover's search - one of the most widely studied algorithms in quantum computing - and the steps necessary to apply it to a real-world problem.

* The first step is to represent the problem as a search problem, and to figure out how to check whether a given set of values is a solution to the problem.
* Reversible computing techniques allow you to implement classical computations on a quantum computer. 
* Grover's algorithm allows to use quadratically fewer function evaluations compared to an exhaustive classical search.
* Implementing the algorithm in Q# gave you a lot of practice in quantum programming! You learned multiple language features that make expressing quantum algorithms in Q# compact and readable, such as specialized control flow structures `within ... apply` and `repeat ... until` and passing operations as parameters to other operations.
* Using Grover's algorithm for solving practical problems is an open research topic, which includes methods for efficient implementation of quantum oracles and identifying problems that can demonstrate a practical speedup.

## Learn more

* Continue exploring the behavior of Grover's search algorithm in [this hands-on tutorial](https://github.com/microsoft/QuantumKatas/tree/master/tutorials/ExploringGroversAlgorithm).
* [Learn to solve Boolean satisfiability problems using Grover's algorithm](https://github.com/microsoft/QuantumKatas/blob/master/SolveSATWithGrover).
* [Deep dive into solving graph coloring problems using Grover's algorithm](https://github.com/microsoft/QuantumKatas/blob/master/GraphColoring).
* ["Is quantum search practical" paper by Viamontes, Markov, and Hayes](https://web.eecs.umich.edu/~imarkov/pubs/jour/cise05-grov.pdf) offers a great discussion of the practicality of various applications of Grover's search algorithm.
