<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_2_data_structure_graph_flow.xml -->
##  Data Structure and Graph Flow in Graphlab

Developed by Carnegie Mellon University, GraphLab provides an example of graph-parallel distributed analytics engines for the cloud. As with any graph-parallel engine, GraphLab assumes input problems modeled as graphs, in which vertices represent computations and edges encode data dependencies or communication. 

|A Note on GraphLab's Evolution and Versions|
|--|
| _GraphLab_ was initially developed as a graph processing framework that targets shared memory systems (multi-core machines). GraphLab then included a distributed execution engine to allow for computation of extremely large graphs across a cluster of machines. _PowerGraph_ (also known as GraphLab 2.0), emerged using techniques that allowed for faster distributed processing of graphs that followed the power-law distribution (such as social graphs). GraphLab has been since spun-off into a commercial startup called Dato Inc., which provides the [GraphLab Create](https://dato.com/products/create/) software package. Our discussion on GraphLab in this module will cover the latest open-source version, PowerGraph (GraphLab 2.0)|


In GraphLab, graphs are initially stored as files in an underlying distributed storage layer, such as HDFS, as shown in Figure 5.46. GraphLab is composed of two phases: _initialization_ and _execution_. During initialization, the GraphLab engine reads input graph files from the underlying storage and divides them into multiple partitions that can be distributed among multiple machines in the cluster. During the execution phase, each machine runs the user-defined computation on the graph vertices, transmitting updates and iterating until some convergence condition is met.
###  Initialization Phase
![Figure 5.46: The GraphLab system. In the initialization phase the atoms are constructed using MapReduce (for example), and in the GraphLab execution phase, the atoms are assigned to cluster machines and loaded by machines from a distributed file system (e.g., HDFS).](../media/graphLab_system.png)

_Figure 5.46: The GraphLab system. In the initialization phase the atoms are constructed using MapReduce (for example), and in the GraphLab execution phase, the atoms are assigned to cluster machines and loaded by machines from a distributed file system (e.g., HDFS)._


In the first phase, the input graph is divided into _k_ partitions, called _atoms_, where _k_ is much larger than the number of cluster machines. As demonstrated in Figure 5.46, atoms can be constructed either sequentially or using parallel loading techniques, including MapReduce. GraphLab does not store the actual vertices and edges in atoms but rather the commands to generate them, in the form of a journal. This allows GraphLab to reconstuct portions of the graph in case of node failures. In addition, GraphLab maintains in each atom information about its neighboring vertices and edges. This information, denoted in GraphLab as _ghost_ vertices, provides a caching capability for efficient adjacency data accessibility as explained in the section .
![Figure 5.47 Graph Paritioning Strategies. (a) Illustrates the edge-cut partitioning technique, while (b) illustrates the vertex cut technique.](../media/graph_cuts.png)

_Figure 5.47 Graph Paritioning Strategies. (a) Illustrates the edge-cut partitioning technique, while (b) illustrates the vertex cut technique._


The graph can be partitioned across the cluster machines in a number of ways (Figure 5.47). A simple technique is _edge-cut_, where graph is partitioned along each vertex (Figure 5.47(a)). Each vertex is randomly assigned to a machine along with all its associated edges. As a result, _ghost_ vertices are generated so that edges can be associated with a vertex that is not in a particular machine. However, for graphs with power-law distribution of edges, this means that the edge-cut partitioning will be unbalanced and some machines will be more loaded than others (due to the star-like motifs of a small number of vertices). To deal with such graphs, GraphLab uses a novel technique (known as _Greedy Vertex Cuts_) to partition high-degree vertices across machines in order to distribute the computation more effectively. Vertices of high degree are replicated across machines, with each machine receiving a subset of the edges for that vertex (Figure 5.47(b)). The machine that holds a given edge for a vertex is decided using the following algorithm: 

______________________________________________________________________________________

_Algorithm 1:_ Greedy Edge-Cuts for placement of edge 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>e</m:mi><m:mo>=</m:mo><m:mo lspace="0px" rspace="0px" fence="true">lcub</m:mo><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi><m:mo>,</m:mo><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi><m:mo lspace="0px" rspace="0px" fence="true" form="postfix">rcub</m:mo></m:mrow></m:math>
-->

 for vertex 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->



______________________________________________________________________________________

- _if_ there exists a machine that has been assigned both 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

 and 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi></m:mrow></m:math>
-->

_then_
    - Assign 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi></m:mrow></m:math>
-->

 to this machine

- _else if _
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

 and 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi></m:mrow></m:math>
-->

 are assigned to different machines _then_
    - Assign 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>e</m:mi></m:mrow></m:math>
-->

 to the machine that has the least number of edges assigned to it

- _else if _
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

 and 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi></m:mrow></m:math>
-->

 are assigned to different machines _then_
    - Assign 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>e</m:mi></m:mrow></m:math>
-->

 to the machine that has the least number of edges assigned to it

- _else_
    - Assign 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>e</m:mi></m:mrow></m:math>
-->

 to the least loaded machine

- Mark edge 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>e</m:mi></m:mrow></m:math>
-->

 as assigned

______________________________________________________________________________________

Loading of these partitions can be done in a distributed and coordinated manner, which ensures that the assignment of vertices and edges across the cluster is optimal, but the time taken to load is much higher than a random placement. On the other hand, random placement will lead to unbalanced load and loss of locality. A compromise between these two approaches, wherein each machine estimates the assignments of the edges and vertices in the cluster, is a tradeoff suggested in. 

Users, however, do need to store graphs in formats that can be consumed and parsed by GraphLab during its initialization phase. Clearly, this depends on the underlying storage layer and the parsing engine that GraphLab employs. For instance, if MapReduce is used to read and parse input graph files from HDFS, the input graph files have to be formatted using MapReduce's key-value data structure. 

Generating atoms for a given input graph completes the first phase of GraphLab's partitioning strategy. Subsequently, the engine stores the connectivity structure and atom locations in an index file denoted also as a _meta-graph_ (Figure 5.46). The atom index file encompasses _k_ vertices, each corresponding to an atom, and edges encoding connectivity among them. In the second phase, the atom index file is split evenly across cluster machines. Atoms are then loaded by cluster machines, and each machine constructs its partition(s) of the given graph by executing the journal in each of its assigned atoms. By generating partitions from atom journals (and not directly mapping partitions to cluster machines), GraphLab allows future graph changes to be simply appended as journal commands, without needing to repartition the entire graphs. Furthermore, the same graph atoms can be reused for different cluster sizes by simply re-dividing the corresponding atom index file and re-executing atom journals, thus repeating only the second partitioning phase. 

Construction of graph partitions at cluster machines concludes GraphLab's initialization phase, and the execution phase begins. 
###  Execution Phase

As shown in Figure 5.46, each cluster machine runs an instance of the GraphLab engine, which incorporates two main parts: the data graph, and the user-defined functions that operate on the data graph. The data graph represents the user program state at a cluster machine and includes a directed graph 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>G</m:mi><m:mo>=</m:mo><m:mfenced open="(" close=")"><m:mrow><m:mi>V</m:mi><m:mo>,</m:mo><m:mi>E</m:mi><m:mo>,</m:mo><m:mi>D</m:mi></m:mrow></m:mfenced></m:mrow></m:math>
-->

 , where 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>V</m:mi></m:mrow></m:math>
-->

 is the set of vertices, 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>E</m:mi></m:mrow></m:math>
-->

 is the set of edges, and 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>D</m:mi></m:mrow></m:math>
-->

 is the user-defined data (e.g., parameters, user input data, and even statistical data). In GraphLab, data is associated with both vertices and edges. 

Computation is then represented as a stateless program that is executed on each vertex of the graph in parallel. This program consists of three distinct phases namely, _Gather_, _Apply_, and _Scatter_ ( _GAS_). 

_Gather Phase_: In the gather phase, each vertex (henceforth refferred to as the central vertex) gathers information from adjacent vertices and edges. GraphLab can then apply a user-defined aggregation or sum operation: 
![(C) CMU Cloud Computing Course](../media/gather.png)


In the equation above 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>D</m:mi><m:mi mathsize="small">u</m:mi></m:mrow></m:math>
-->

, 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>D</m:mi><m:mi mathsize="small">v</m:mi></m:mrow></m:math>
-->

, and 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>D</m:mi><m:mo mathsize="small" stretchy="false">(</m:mo><m:mi mathsize="small">u</m:mi><m:mo mathsize="small">,</m:mo><m:mi mathsize="small">v</m:mi><m:mo mathsize="small" stretchy="false">)</m:mo></m:mrow></m:math>
-->

 denote values and metadata for vertices 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>u</m:mi></m:mrow></m:math>
-->

,
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>v</m:mi></m:mrow></m:math>
-->

 and edge 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mfenced open="(" close=")"><m:mrow><m:mi>u</m:mi><m:mo>,</m:mo><m:mi>v</m:mi></m:mrow></m:mfenced></m:mrow></m:math>
-->

 respectively. The user defined sum (
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mo lspace="2px" rspace="2px">CirclePlus</m:mo></m:mrow></m:math>
-->

) operation must be commutative and associative and can range from a numerical sum to the union of the data on all neighboring vertices and edges. 

_Apply Phase_: In the apply phase, the resulting value 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mo rspace="2px" largeop="false">sum</m:mo></m:mrow></m:math>
-->

 is used to update the value of the central vertex:
![(C) CMU Cloud Computing Course](../media/apply.png)


_Scatter Phase_: Finally in the scatter phase, the new value of the central vertex is sent to all adjacent vertices: 
![(C) CMU Cloud Computing Course](../media/scatter.png)


With the end of the scatter operation, one iteration of the computation for the vertex is complete. 

The GAS functions are executed on a set of active vertices on every iteration. During the initial iteration, all vertices are placed in the set of active vertices, and based on the logic of the GAS functions, a vertex can mark one of its neighbors as active, so that it can be computed upon in the next iteration. 
![Figure 5.48: Execution of the Gather-Apply-Scatter functions on two machines that a subset of edges of the same vertex.](../media/gas_execution.png)

_Figure 5.48: Execution of the Gather-Apply-Scatter functions on two machines that a subset of edges of the same vertex._


Figure 5.48 illustrates the resulting communication pattern of employing the GAS functions on a graph partitioned using the Greedy Edge-Cuts algorithm described earlier. Gather functions run locally on each machine that contains the ghost of a vertex. During the accumulation, these gathered values are sent to the machine that has the master copy of the vertex, where it can compute the function defined in the apply stage. Finally, the updated vertex data is copied to all machines that have ghost copies of the vertex and the scatter function is executed to propagate values to the adjacent vertices. 

_Delta Caching_: There are situations where a vertex program will be triggered (made active) because of a change in only few of its neighbors. When the vertex is triggered, it will execute a gather operation from all neighbors, many of whom have not executed and hence will return values which are unchanged since the last time this particular vertex ran. GraphLab introduces a subtle optimization called delta caching, where the result of gather operations from all of the neighbors of a vertex are cached at that vertex. During the scatter operation that is run at the neighbouring vertices, an optional parameter, 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>Delta</m:mi><m:mi>a</m:mi></m:mrow></m:math>
-->

 can be sent, summarizing the change in the value of variable 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>a</m:mi></m:mrow></m:math>
-->

 between iterations. This value can be used to bypass the gather phase and added to the cached value of 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>a</m:mi></m:mrow></m:math>
-->

 to speed up execution. 

### References

1. _Y. Low, J. Gonzalez, A. Kyrola, D. Bickson, C. Guestrin, and J. M. Hellerstein (2010). GraphLab: A New Parallel Framework for Machine Learning Conference on Uncertainty in Artificial Intelligence (UAI)_
2. _Y. Low, J. Gonzalez, A. Kyrola, D. Bickson, C. Guestrin, and J. M. Hellerstein (2012). Distributed GraphLab: A Framework for Machine Learning and Data Mining in the Cloud PVLDB_
3. _J. Gonzalez, Y. Low, H. Gu, D. Bickson, and C. Guestrin (October, 2012). PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs In Proc. of the 10th USENIX Conference on Operating Systems Design and Implementation_