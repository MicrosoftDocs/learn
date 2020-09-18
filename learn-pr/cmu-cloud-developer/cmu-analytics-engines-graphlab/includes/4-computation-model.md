As discussed earlier, GraphLab supports multiple engines that can execute the vertex functions either **synchronously** or **asynchronously**. The three engines currently supported by GraphLab are the following: 

- Synchronous engine
- Asynchronous engine
- Asynchronous-serializable engine

## Synchronous engine

The synchronous engine executes the Gather, Apply, and Scatter (GAS) phases in order for each of the active vertices assigned to a machine. Once a machine completes updating all the vertices assigned to it for a particular iteration, it waits for the next iteration. Vertices that are activated in each iteration are scheduled for execution for the next iteration. In this execution mode, GraphLab actually executes the computation in Bulk-Synchronous Parallel (BSP) fashion, similar to systems such as Pregel. As a result, the computation performed by the synchronous engine is guaranteed to follow the **full consistency** model as discussed earlier.

The synchronous engine can perform extremely poorly when executing MLDM algorithms because a phase, stage, and super-step during that execution can't finish before the last task and vertex in that computation commit. And execution time of each phase, stage, and super-step is determined by its slowest task and vertex. 

## Asynchronous engine

Using the asynchronous engine, GraphLab executes active vertices as machines become available. Changes made to the vertex and edge data during the apply and scatter functions are immediately committed to the graph and made available for subsequent computation on neighboring vertices. The main benefit in using an asynchronous engine is in the elimination of waiting before the next iteration can proceed, which allows for increased parallelism and performance. The asynchronous engine executes vertex computations using the **vertex consistency** model as discussed earlier.

Although asynchronous engines can result in empirical and algorithmic gains for a range of common MLDM applications, they pose a critical challenge. In particular, asynchronous execution presents design and debugging complexities and can yield nondeterministic results.<sup>[1][^1]</sup> For example, when statistical simulation is run asynchronously, there is a high potential for nondeterministic outcomes. If this condition is not carefully controlled, instability or even divergence can occur.<sup>[2][^2]</sup> In certain applications, the increased parallelism of asynchronous execution is offset by the increased number of iterations required to achieve convergence. 

## Asynchronous-serializable engine

GraphLab provides a balanced tradeoff between the synchronous and asynchronous engines with the option of using the asynchronous-serializable engine. In this engine, GraphLab prevents adjacent vertices' GAS functions from running concurrently by using a fine-grained, parallel locking protocol, known as the Chandy-Misra scheme.<sup>[3][^3]</sup> Using this scheme, a machine executing a vertex acquires locks on adjacent edges that are present on the machine. (This is determined during the greedy edge-cut partitioning described earlier.) The resulting execution is guaranteed to be **serializable**; i.e., there exists some serial ordering of execution whose results are equivalent to the results when executed using the asynchronous-serializable engine. The asynchronous-serializable execution of a graph is equivalent to the **edge consistency** model as discussed earlier.
<br>

<!-- References 1, 3, 4, 5, 6, 7 not cited in this topic. Removed. Renumbered remaining references. -->
***
### References

1. _J. Gonzalez, Y. Low, H. Gu, D. Bickson, and C. Guestrin (October, 2012). [PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs](https://www.usenix.org/node/170825) In Proceedings of the 10th USENIX Conference on Operating Systems Design and Implementation_
2. _J. Gonzalez, Y. Low, A. Gretton, and C. Guestrin (2011). [Parallel Gibbs Sampling: From Colored Felds to Thin Junction Trees](http://proceedings.mlr.press/v15/gonzalez11a/gonzalez11a.pdf) In AISTATS, vol. 15, pp. 324-332_
3. _Chandy, K. M. and Misra, J. (1984). [The Drinking Philosophers Problem](https://dl.acm.org/doi/10.1145/1780.1804) ACM Trans. Program. Lang. Syst.  632--646_

***

[^1]: <https://www.usenix.org/node/170825> "J. Gonzalez, Y. Low, H. Gu, D. Bickson, and C. Guestrin (October, 2012). *PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs* In Proceedings of the 10th USENIX Conference on Operating Systems Design and Implementation"
[^2]: <http://proceedings.mlr.press/v15/gonzalez11a/gonzalez11a.pdf> "J. Gonzalez, Y. Low, A. Gretton, and C. Guestrin (2011). *Parallel Gibbs Sampling: From Colored Felds to Thin Junction Trees* In AISTATS, vol. 15, pp. 324-332"
[^3]: <https://dl.acm.org/doi/10.1145/1780.1804> "Chandy, K. M. and Misra, J. (1984). *The Drinking Philosophers Problem* ACM Trans. Program. Lang. Syst. 632--646"
