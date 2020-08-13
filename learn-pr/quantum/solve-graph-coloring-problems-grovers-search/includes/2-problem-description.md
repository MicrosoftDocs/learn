The first step of any algorithm discussion is introducing the problem this algorithm is designed to solve. 

In this unit we will define the problem solved by Grover's search algorithm - so-called "search problem" - and take a closer look at the ways various real-life problems can be represented in terms of this problem.

## The search problem

The search problem is formulated as follows: you are given a function $f$ that takes an $N$-bit input and returns a 1-bit output, 0 or 1. Your goal is to find any input $x_0$ such that $f(x_0) = 1$.

> Notice that you are not given any information about the structure of the function you are given! You only have access to a "black box" that implements this function, i.e., takes the input and returns the corresponding output.

## What problems can be framed as search problems?

The search problem is by design very generic. Indeed, any problem that allows to check whether a given value $x$ is a valid solution for it (a "yes/no problem") can be formulated in terms of the search problem, if we define $f(x)$ as "1 if and only if $x$ is a valid solution for our problem".

Here are just some examples:

* [Boolean satisfiability problem](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem): is the set of Boolean variables $x$ an interpretation that satisfies the given Boolean formula?
* [Traveling salesman problem](https://en.wikipedia.org/wiki/Travelling_salesman_problem): does $x$ describe the shortest possible loop that connects all cities?
* Database search problem: does the database table contain a record $x$?
* Integer factorization problem: is the fixed number $N$ divisible by the number $x$?

Some of these problems are better suited to benefit from using Grover's algorithm than the others. We'll use graph coloring problem as an example throughout this module, and the last unit we will return to the question of the quantum speedup and the types of problems that can be solved using Grover's algorithm faster than using a classical algorithm.


## Graph coloring problem

Graph coloring problem (more precisely called [proper vertex coloring](https://en.wikipedia.org/wiki/Graph_coloring#Vertex_coloring)) is formulated as follows: given a graph, assign a label ("color") to each of the graph's vertices so that no two vertices connected by an edge have the same label.

Here is an example graph:

![Figure 1. A graph](../media/2-uncolored-graph.png)

Here is an attempt to color the vertices of this graph using three colors. 

![Figure 2. Invalid vertex coloring](../media/2-invalid-coloring.png)

We see that this is not a valid vertex coloring using our definition - vertices 0 and 3 are assigned the same color, even though they are connected by an edge.

In fact, the vertices of this graph cannot be labeled using just three colors; you'll need at least four colors to do that.

![Figure 3. Valid vertex coloring](../media/2-valid-coloring.png)

In general graph coloring is an NP-complete problem and the best known solutions take exponential time to run. 

In the next units of this module we'll see how quantum computing can help speed up solving this problem.

