<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m03_spark\x-oli-workbook_page\_u05_m03_1_spark.xml -->
We now move on to discuss another distributed analytics engine that is growing in popularity and adoption. 

Studies reveal that while MapReduce provides a good fit for a wide array of large-scale problems, it is ill-suited for distributed graph processing and other applications which are iterative in nature. These applications pose challenges due to the problem scale (normally billions of vertices and trillions of edges), poor locality, little data and work per vertex, and changing problem scale over the course of execution (when the graph rises or shrinks over time). Problems such as web graph analytics, social network processing, disease outbreak path identification, transportation route calculation, and newspaper article similarity, among others, involve distributed processing of large-scale graphs. 

This module covers the Apache Spark framework. Spark is an open source cluster computing framework developed at the [UC Berkeley AMPLab](https://amplab.cs.berkeley.edu/). It uses in-memory primitives that allow it to perform over 100x faster than traditional MapReduce for some applications. 

Spark was optimized towards three classes of parallel distributed applications: 


- Iterative: such as most machine learning tasks that iterate over a training data set until convergence is met
- Interactive: where low-latency results are expected after rapid querying
- Streaming application: where input data is continuously arriving from one or a few streams leading to an update of the stored state 
Several libraries have grown around Spark, allowing fast execution of SQL-like queries, Machine Learning and Graph Computation applications. In this module, we cover the core Spark framework and some parts of the Spark ecosystem. We start with an overview of Spark’s architecture, discuss the lifecycle of Resilient Distributed Datasets (RDDs) which provide a distributed abstraction to express in-memory computations, delve into fault tolerance and recovery and finally look at several libraries for different types computation on Spark. 