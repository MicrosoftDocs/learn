Congratulations! In this module, you've learned a lot about Grover's search algorithm - one of the most widely studied algorithms in quantum computing - and the steps necessary to apply it to a real-world problem.

* The first step is figuring out how to check whether a given set of values is a solution to the problem.
* Reversible computing techniques allow you to implement classical computations on a quantum computer. 
* Grover's algorithm uses quadratically fewer function evaluations compared to an exhaustive classical search.
* Implementing Grover's algorithm and the oracle for the graph coloring problem in Q# provided plenty of practice in quantum programming! You learned multiple language features that make expressing quantum algorithms in Q# compact and readable, such as the specialized control flow structures `within ... apply` and `repeat ... until`, and the ability to pass operations as parameters to other operations.
* Using Grover's algorithm for solving practical problems is an open research topic. It includes methods for efficient implementation of quantum oracles, as well as identifying problems that can demonstrate a practical speedup.

## Learn more

* [Deep dive into the implementation details of Grover's search algorithm](https://github.com/microsoft/QuantumKatas/tree/main/GroversAlgorithm).
* Continue exploring the behavior of Grover's search algorithm in this [hands-on tutorial](https://github.com/microsoft/QuantumKatas/tree/main/tutorials/ExploringGroversAlgorithm).
* [Learn to solve Boolean satisfiability problems using the search algorithm](https://github.com/microsoft/QuantumKatas/tree/main/SolveSATWithGrover).
* [Deep dive into solving graph coloring problems using the search algorithm](https://github.com/microsoft/QuantumKatas/tree/main/GraphColoring).
* ["Is quantum search practical" paper by Viamontes, Markov, and Hayes](https://web.eecs.umich.edu/~imarkov/pubs/jour/cise05-grov.pdf) offers a great discussion of the practicality of Grover's search algorithm.
