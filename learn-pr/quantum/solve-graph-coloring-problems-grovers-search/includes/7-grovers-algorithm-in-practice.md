In unit 2 we've seen that there are plenty of problems that can be formulated as a search problem. Now that we're familiar with Grover's search algorithm and its implementation, let's revisit the question: are all search problems going to benefit from the quantum speedup offered by this algorithm?

It turns out that this is not the case. In this unit, we will look into the types of problems that can be a good fit for Grover's search algorithm.

## Problems that don't have a specialized classical algorithm

We've seen that Grover's algorithm doesn't rely on the internal structure of the function $f$. However, when you try to solve a problem, you try to approach it from different angles, including analyzing the problem structure and looking for the ways to use it to speed up your solution. It turns out that search problems often have a well-defined problem structure that a classical algorithm can exploit to run much faster.

> For example, database search is frequently mentioned as a potential application of Grover's algorithm. 
> In practice real-life databases that store information don't perform search by trying each of the records to see whether it matches the query; instead they rely on [indexes](https://en.wikipedia.org/wiki/Database_index) that enable much faster lookup.
> Large databases can also take advantage of distributed storage and processing.

This observation gives us the first part of the answer: the problems that are best poised to benefit from Grover's algorithm are the ones for which we can easily check whether the given $x$ is the answer, but we cannot easily exploit problem structure or parallel processing to find the answer.

## Problems that allow efficient oracle implementation

Remember that the complexity analysis of Grover's algorithm uses the number of function evaluations necessary to find the answer as a metric: $O(\sqrt{N})$, as opposed to $O(N)$ used by an exhaustive classical search.

However, this analysis doesn't take into account the complexity of evaluating the function, both in classical and in quantum cases. If a function evaluation is a lot more complicated on a quantum computer than on a classical one, the overall algorithm runtime will be worse in the quantum case, even though technically it will use fewer queries.

Thus, only the problems that allow to compute success criteria fast on a quantum computer can be a practical application for Grover's algorithm.


## Conclusion

Grover's search algorithm is one of the most widely studied algorithms in quantum computing. However, using it for solving practical problems covers several areas of active research, including methods for efficient implementation of quantum oracles and identifying problems that can demonstrate a practical speedup.
