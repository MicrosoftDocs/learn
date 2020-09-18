We now move on to discuss another distributed analytics engine that is growing in popularity and adoption. 

Studies reveal that while MapReduce provides a good fit for a wide array of large-scale problems, it is ill suited for distributed graph processing and other applications that are iterative in nature. These applications pose challenges due to the problem scale (normally billions of vertices and trillions of edges), poor locality, little data and work per vertex, and changing problem scale over the course of execution (when the graph rises or shrinks over time). Problems such as web graph analytics, social network processing, disease outbreak path identification, transportation route calculation, and newspaper article similarity, among others, involve distributed processing of large-scale graphs. 

This module covers the Apache Spark framework. Spark is an open-source cluster-computing framework developed at the [UC Berkeley AMPLab](https://amplab.cs.berkeley.edu/). It uses in-memory primitives that allow it to perform over 100x faster than traditional MapReduce for some applications. 

Spark was optimized toward three classes of parallel distributed applications: 

- Iterative, such as most machine learning tasks that iterate over a training dataset until convergence is met.
- Interactive, where low-latency results are expected after rapid querying.
- Streaming application, where input data is continuously arriving from one or a few streams, leading to an update of the stored state.

Several libraries have grown around Spark, allowing fast execution of SQL-like queries, machine learning applications, and graph computation applications. In this module, we cover the core Spark framework and some parts of the Spark ecosystem. We start with an overview of Spark's architecture, discuss the lifecycle of resilient distributed datasets (RDDs) (which provide a distributed abstraction to express in-memory computations), delve into fault tolerance and recovery, and finally look at several libraries for different types computation on Spark. 

## Learning objectives

In this module, you will:
- Recall the features of an iterative programming framework
- Describe the architecture and job flow in Spark
- Recall the role of resilient distributed datasets (RDDs) in Spark
- Describe the properties of RDDs in Spark
- Compare and contrast RDDs with distributed shared-memory systems
- Describe fault-tolerance mechanics in Spark
- Describe the role of lineage in RDDs for fault tolerance and recovery
- Understand the different types of dependencies between RDDs
- Understand the basic operations on Spark RDDs
- Step through a simple iterative Spark program
- Recall the various Spark libraries and their functions

## Prerequisites

- Understand what cloud computing is, including cloud service models and common cloud providers
- Know the technologies that enable cloud computing
- Understand how cloud service providers pay for and bill for the cloud
- Know what datacenters are and why they exist
- Know how datacenters are set up, powered, and provisioned
- Understand how cloud resources are provisioned and metered
- Be familiar with the concept of virtualization
- Know the different types of virtualization
- Understand CPU virtualization
- Understand memory virtualization
- Understand I/O virtualization
- Know about the different types of data and how they're stored
- Be familiar with distributed file systems and how they work
- Be familiar with NoSQL databases and object storage, and how they work
- Know what distributed programming is and why it's useful for the cloud
- Understand MapReduce and how it enables big data computing
