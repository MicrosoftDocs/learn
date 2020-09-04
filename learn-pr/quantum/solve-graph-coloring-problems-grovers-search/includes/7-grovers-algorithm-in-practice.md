Notes from outline:

Discussion of high-level algorithm properties:

* The algorithm is probabilistic, not deterministic (you need to verify the results you got)
* More iterations is not necessarily better (periodic behavior of result probability, optimal number of iterations to do before measuring)
* What to do if you don't know the number of iterations up front



## What problems are a good fit for Grover's search algorithm?

In unit 2 we've seen that there are plenty of problems that can be formulated as a search problem. Now that we're familiar with Grover's search algorithm and its implementation, let's revisit the question: are all search problems going to benefit from the quantum speedup offered by this algorithm?

It turns out that this is not the case. We've seen that Grover's algorithm doesn't rely on the internal structure of the function $f$. However, when you try to solve a problem, you try to approach it from different angles, including analyzing the problem structure and looking for the ways to use it to speed up your solution. It turns out that search problems often have a well-defined problem structure that a classical algorithm can exploit to run much faster. 

> For example, database search is frequently mentioned as a potential application of Grover's algorithm. In practice real-life databases that store information don't perform search by trying each of the records to see whether it matches the query; instead they rely on [indexes](https://en.wikipedia.org/wiki/Database_index) that enable much faster lookup.

This observation gives us the first part of the answer: the problems that are best poised to benefit from Grover's algorithm are the ones for which we can easily verify whether the given $x$ is the answer, but we cannot easily exploit problem structure to find the answer.

**TODO** Second part of the answer - problems that have a nice oracle implementation


---
