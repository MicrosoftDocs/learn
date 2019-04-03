<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_5_computation_model.xml -->

As discussed on the previous page, GraphLab supports multiple engines which can execute the vertex functions either _synchronously_ or _asynchronously_. The three engines currently supported by GraphLab are the following: 

- Synchronous Engine
- Asynchronous Engine
- Asynchronous Engine - Serializable
##  Synchronous Engine

The synchronous engine executes the gather, apply and scatter (GAS) phases in order for each of the active vertices assigned to a machine. Once a machine completes updating all the vertices assigned to it for a particular iteration, it waits for the next iteration. Vertices that are activated in each iteration are scheduled for execution for the next iteration. In this execution mode, GraphLab actually executes the computation in Bulk-Synchronous (BSP) fashion, similar to systems such as Pregel. As a result, the computation performed by the synchronous engine is guaranteed to follow the _full consistency_ model as discussed in the previous page.

The Synchronous engine can perform extremely poorly when executing MLDM algorithms because a phase/stage/super-step during that execution cannot finish before the last task/vertex in that computation commits, and execution time of each phase/stage/super-step is determined by its slowest task/vertex (see the section Introduction to Distributed Programming for the Cloud ). 
##  Asynchronous Engine

Using the asynchronous engine, GraphLab executes active vertices as machines become available. Changes made to the vertex and edge data during the apply and scatter functions are immediately committed to the graph and made available for subsequent computation on neighboring vertices. The main benefit in using an asynchronous engine is in the elimination of waiting before the next iteration can proceed, which allows for increased parallelism and performance. The asynchronous engine executes vertex computations using the _vertex consistency_ model as discussed in the previous page.

Although asynchronous engines can result in empirical and algorithmic gains for a range of common MLDM applications, they pose a critical challenge. In particular, asynchronous execution presents design and debugging complexities and can yield nondeterministic results . For example, when statistical simulation is run asynchronously, there is a high potential for nondeterministic outcomes. If this condition is not carefully controlled, instability or even divergence can occur . In certain applications, the increased parallelism of asynchronous execution is offset by the increased number of iterations required to achieve convergence. 
##  Asynchronous-Serializable Engine

Graphlab provides a balanced tradeoff between the synchronous and asynchronous engines with the option of using the asynchronous-serializable engine. In this engine. GraphLab prevents adjacent vertices’ GAS functions from running concurrently by using fine-grained, parallel locking protocol, known as the Chandy-Misra scheme. Using this scheme, a machine executing a vertex acquires locks on adjacent edges that are present on the machine (this is determined during the Greedy-Edge cut partitioning described earlier). The resulting execution is guaranteed to be _serializable_; i.e. there exists some serial ordering of execution whose results are equivalent to the results when executed using the asynchronous-seralizable engine. The asynchronous-serializable execution of a graph is equivalent to the _edge consistency_ model as discussed in the previous page.

### References

1. _Y. Low, J. Gonzalez, A. Kyrola, D. Bickson, C. Guestrin, and J. M. Hellerstein (2012). Distributed GraphLab: A Framework for Machine Learning and Data Mining in the Cloud PVLDB_
2. _J. Gonzalez, Y. Low, H. Gu, D. Bickson, and C. Guestrin (October, 2012). PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs In Proc. of the 10th USENIX Conference on Operating Systems Design and Implementation_
3. _D. P. Bertsekas and J. N. Tsitsiklis (1989). Parallel and Distributed Computation: Numerical Methods Prentice Hall_
4. _J. Gonzalez, Y. Low, and C. Guestrin (2009). Residual Splash for Optimally Parallelizing Belief Propagation In AISTATS, vol. 5, pp. 177–184_
5. _R. Neal and G. Hinton (1998). A View of the EM Algorithm that Justiﬁes Incremental, Sparse, and Other Variants In Learning in Graphical Models, pp. 355–368_
6. _A. G. Siapas (1996). Criticality and Parallelism in Combinatorial Optimization PhD thesis, Massachusetts Institute of Technology_
7. _A. J. Smola and S. Narayanamurthy (2010). An Architecture for Parallel Topic Models PVLDB, 3(1):703-710_
8. _J. Gonzalez, Y. Low, A. Gretton, and C. Guestrin (2011). Parallel Gibbs Sampling: From Colored Felds to Thin Junction Trees In AISTATS, vol. 15, pp. 324-332_
9. _Chandy, K. M. and Misra, J. (1984). The Drinking Philosophers Problem ACM Trans. Program. Lang. Syst.  632--646_