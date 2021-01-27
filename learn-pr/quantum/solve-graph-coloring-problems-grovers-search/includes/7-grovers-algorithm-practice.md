In unit 2, you learned that there are plenty of problems that can be formulated as a search problem, therefore be solved using Grover's algorithm. Now that you're familiar with Grover's search algorithm and its implementation, let's revisit the question. Can all search problems benefit from the quantum speedup offered by Grover's algorithm? 

The answer, unfortunately, is no. In this unit, we look at the types of problems that can be a good fit for Grover's algorithm.

## Problems that don't have a specialized algorithm

We've seen that Grover's algorithm doesn't rely on the internal structure of the function $f$. However, when you try to solve a problem, you try to approach it from different angles, including analyzing the problem structure and looking for ways to use it to speed up your solution. It turns out that search problems often have a well-defined problem structure that a classical algorithm can exploit to run much faster.

For example, database searches are frequently mentioned as a potential application of Grover's algorithm. In practice, real-life databases that store information don't perform searches by trying each of the records to see whether it matches the query. Instead, they rely on indexes that enable a much faster lookup. Large databases can also take advantage of distributed storage and processing.

Another example is the integer factorization problem. While no efficient classical algorithm is known, Shor's algorithm offers a better quantum approach.

This observation gives us the first part of the answer; the problems that benefit from Grover's algorithm are the ones for which we can easily check whether the given $x$ is the answer, but we can't easily exploit the problem structure or parallel processing to find the answer.

## Problems that allow efficient oracle implementation

Remember that the complexity analysis of Grover's algorithm uses the number of function evaluations necessary to find the answer as a metric; approximately $\sqrt{\frac{N}{M}}$, where $N$ is the size of the search space, and $M$ is the number of solutions to the problem. 
For comparison, doing an exhaustive classical search (choosing a random input, calculating the value of the function for it, and checking whether it is 1) takes approximately $\frac{N}{M}$ function evaluations.

However, this analysis doesn't consider the complexity of evaluating the function, both in classical and in quantum cases. If a function evaluation is much more complicated on a quantum computer than on a classical one, the overall algorithm runtime will be longer in the quantum case, even though technically, it will use fewer queries.

For example, if the function is defined as a classical "opaque box", where the implementation of the function is not known, you can't use the internal structure of the function to implement the quantum oracle efficiently. Each quantum query has to evaluate the classical function for each of the $N$ inputs. In this scenario, it would be more efficient to run an exhaustive classical search!

Thus, only problems that allow you to compute success criteria quickly on a quantum computer can be considered as a practical application for Grover's algorithm.
