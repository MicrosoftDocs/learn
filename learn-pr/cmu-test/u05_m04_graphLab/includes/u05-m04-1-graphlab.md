<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_1_graphLab.xml -->

Machine-learning and data-mining (MLDM) problems are growing exponentially in scale today. Interest in analytics engines that can execute MLDM algorithms efficiently on distributed systems, such as clouds, is increasing correspondingly. Designing, implementing, and testing distributed MLDM applications can be challenging because they usually require experts who know how to address synchronization, deadlocks, communication, scheduling, distributed-state management, and fault-tolerance concerns effectively. Many recent advances in MLDM algorithmic designs have focused on modeling such algorithms as graphs. 
##  Expressing Data and Computation using a Graph Abstraction

As a motivating example, lets take a look at a few examples of data modelled as graphs and how computation can be expressed in this model. Mathematically, a graph is modelled as a set: 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>G</m:mi><m:mo>=</m:mo><m:mo lspace="0px" rspace="0px" fence="true">lcub</m:mo><m:mi>V</m:mi><m:mo>,</m:mo><m:mi>E</m:mi><m:mo lspace="0px" rspace="0px" fence="true" form="postfix">rcub</m:mo></m:mrow></m:math>
-->

 , where 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>V</m:mi></m:mrow></m:math>
-->

 is a set of vertices 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

 and 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>E</m:mi></m:mrow></m:math>
-->

 is a set of edges 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>e</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

. Furthermore, every edge 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>e</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

 in 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>G</m:mi></m:mrow></m:math>
-->

 represents an edge between exactly two vertices 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mo lspace="0px" rspace="0px" fence="true">lcub</m:mo><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi><m:mo>,</m:mo><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi><m:mo lspace="0px" rspace="0px" fence="true" form="postfix">rcub</m:mo><m:mo lspace="2px" rspace="2px">isin</m:mo><m:mi>V</m:mi></m:mrow></m:math>
-->

 . There are many types of graphs; they can be undirected which means 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>e</m:mi><m:mo>=</m:mo><m:mo lspace="0px" rspace="0px" fence="true">lcub</m:mo><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi><m:mo>,</m:mo><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi><m:mo lspace="0px" rspace="0px" fence="true" form="postfix">rcub</m:mo><m:mo>=</m:mo><m:mo lspace="0px" rspace="0px" fence="true">lcub</m:mo><m:mi>v</m:mi><m:mi mathsize="small">j</m:mi><m:mo>,</m:mo><m:mi>v</m:mi><m:mi mathsize="small">i</m:mi><m:mo lspace="0px" rspace="0px" fence="true" form="postfix">rcub</m:mo><m:mo rspace="3px">forall</m:mo><m:mi>e</m:mi><m:mo lspace="2px" rspace="2px">isin</m:mo><m:mi>E</m:mi></m:mrow></m:math>
-->

 (i.e. all edges are equivalent and bidirectional), or directed, where the edges are distinct and not equal. Graphs can also be weighted if an additional parameter, known as the weight 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mi>w</m:mi><m:mi mathsize="small">i</m:mi></m:mrow></m:math>
-->

 exists 
<!-- TODO fix
<m:math display="inline" xmlns:m="urn:http://namespaceurl.com"><m:mrow><m:mo rspace="3px">forall</m:mo><m:mi>e</m:mi><m:mo lspace="2px" rspace="2px">isin</m:mo><m:mi>E</m:mi></m:mrow></m:math>
-->

 . Furthermore, vertices may also be weighted, and as we will see, this comes in handy in different applications. Typical graph computations include the calculation of the shortest path between two points, partitioning the graph into subgraphs based on some optimization metric (minimum number of edges cut, or maximum flow between the graphs), the calculation of maximum degree (the vertex with the most number of edges), and so on. 
![Figure 5.42: A webgraph where the vertices represent web pages and edges represent the links between pages. As a result of running pagerank on this graph, each vertex has an associated value, known as the rank, which is a representation of the importance of a page, calculated from the number of incoming and outgoing links to that page. ](../media/pagerank.png)

_Figure 5.42: A webgraph where the vertices represent web pages and edges represent the links between pages. As a result of running pagerank on this graph, each vertex has an associated value, known as the rank, which is a representation of the importance of a page, calculated from the number of incoming and outgoing links to that page. _


Figure 5.42 illustrates an example of the WebGraph. The vertices denote web pages and the edges denote links between web pages. The canonical example of computation performed on a webgraph is PageRank, which calculates the importance of a webpage, based on the pages that are linked to it. Recall the detailed description of PageRank we covered in the previous module. Similarly a social network graph illustrated in Figure 5.43 shows people represented as vertices and edges representing a relationship such as "is a friend", or "follows". Interesting computations here include calculation of the most popular people (calculating the vertices with the most number of edges), or finding strongly knit communities of people who all know each other (triangle counting). 

![Figure 5.43: Visualization of a Facebook social graph for a limited number of users. Source](../media/facebook-network.png)

_Figure 5.43: Visualization of a Facebook social graph for a limited number of users._ ([Source](https://griffsgraphs.wordpress.com/2012/07/02/a-facebook-network/))



As you can imagine, some of the problems mentioned above are growing in scale and complexity. One of the largest publicly available [webgraphs](http://webdatacommons.org/hyperlinkgraph/) consists of 1.7 billion web pages and 64 billion hyperlinks, and is widely believed to be a much smaller than the data handled by production systems of web services companies such as Google and Microsoft. It would be impossible to encapsulate all this data into the memory of a single computer, but we still need efficient systems that can handle the processing of such large-scale data.
![Figure 5.44 : The Bulk-Synchronous Parallel (BSP) parallel paradigm.](../media/bsp.png)

_Figure 5.44 : The Bulk-Synchronous Parallel (BSP) parallel paradigm._


An example of a system designed to process large graphs in a distributed manner is Google's _Pregel_. Pregel performs computations on Graphs in an iterative, lock-step manner (also known as the _Bulk-Synchronous Parallel_ or BSP approach). A Pregel program runs in a series of globally-synchronized iterations, which can result in some computation performed in the context of each vertex in a graph (Figure 5.44). The vertices can then exchange messages with their neighbours, typically this is done to update state or other variables. Pregel then runs the next iteration once all the vertices have completed processing the current execution. Messages exchanged between machines in iteration `i` are delivered in iteration `i+1`. The program will run subsequent iterations until either a convergence condition is met or it completed `N` iterations, where `N` is a user defined number of maximum iterations to be executed. 

Although Pregel offers a promising option as a distributed, graph-parallel analytics engine it suffers from a major deficiency: Pregel runs computation synchronously, which can impact performance as the runtime of each iteration is always dictated by the last thread to complete execution. One can also imagine the implications if a graph is unbalanced in terms of the degree of vertices. This is in fact the case with a large number of graphs of interest to big data analytics. Social graphs, for example, show a power-law distribution, wherein a small number of vertices, have a large number of edges. An example of this phenomenon is the Twitter followers graph (Figure 5.45), where celebrities and influential people have millions of followers, while most other normal users have a much smaller number of followers. 
![Figure 5.45 : Power-law distribution in the Twitter follower graph. Notice how a small number of vertices (< 100) have a very high in and out-degree (>>10,000) Graph from ](../media/power_law.png)

_Figure 5.45 : Power-law distribution in the Twitter follower graph. Notice how a small number of vertices (< 100) have a very high in and out-degree (>>10,000) Graph from _


In this module, we present GraphLab, a variant graph-parallel distributed analytics engine that can efficiently and correctly execute both synchronous and asynchronous MLDM problems and others. GraphLab is also well suited to graphs that show power-law distribution. In this module, 

1. We first discuss the data structure that should be used in storing input graphs for GraphLab to consume, process and show how input graphs flow through the GraphLab engine, starting from getting consumed to generating results.
1. We identify the architectural model of GraphLab.
1. We present the programming model employed by GraphLab and the consistency mechanisms supported for protecting shared data from read-write/write-write conflicts. 
1. We discuss the asynchronous computation model that underlies GraphLab. 
1. We examine GraphLab's fault-tolerance techniques.