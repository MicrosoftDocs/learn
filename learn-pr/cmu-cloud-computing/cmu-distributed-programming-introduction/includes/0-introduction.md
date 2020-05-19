Developing cloud programs (i.e., designing and implementing software systems that successfully exploit the capabilities of massively distributed computational resources) presents formidable challenges. The difficulties arise from the multiplicity of possible logical interactions and temporal interleavings among numerous software and hardware components. Program bugs can be difficult to reproduce, and due to some cloud programs' nondeterministic performance behavior, analyzing and reasoning a system's behavior can exceed mere human ability.

As researchers and practitioners have gradually gained a better understanding of this problem, they have developed models of programming and computation that mitigate cloud systems' inherent complexity. These models, which are embodied in software/hardware systems, stand between the developer and underlying computational resources, providing the programmer stylized design patterns, a relatively simpler way of thinking about distributed programming, and a flexible interface to applications, data, and resources. 

The current generation of cloud programming models builds on classical predecessors that support interprocess communication based on shared memory and message passing. Although those earlier versions provide basic facilities for interaction among distributed tasks, they lack the capability to parallelize and distribute tasks automatically and to recover from faults. Those versions' modern descendants, including Hadoop MapReduce, Pregel, and GraphLab, provide greater sophistication and specifically address the demands of distributed programming and computing in cloud environments. Among other advantages, these current models relieve developers from concerns with many of the difficult aspects of distributed programming and allow programmers to focus on sequential portions of their application's algorithms. 

Echoing Babbage's 1837 design for the first programmable computer, we distinguish today's cloud-programming models by referring to them as **distributed analytics engines**. This module examines the concepts and challenges of cloud computing and provides current examples of analytics engines for developing cloud applications. 

## Learning objectives

In this module, you will:

- Classify programs as sequential, concurrent, parallel, and distributed
- Indicate why programmers usually parallelize sequential programs
- Explain why cloud programs are important for solving complex computing problems
- Define distributed systems, and indicate the relationship between distributed systems and clouds
- Define distributed programming models
- Indicate why synchronization is needed in shared memory systems
- Describe how tasks can communicate by using the message-passing programming model
- Outline the difference between synchronous and asynchronous programs
- Explain the bulk synchronous parallel (BSP) model
- Outline the difference between data parallelism and graph parallelism
- Distinguish between these distributed programs: single program, multiple data (SPMD); and multiple program, multiple data (MPMD)
- Discuss the two main techniques that can be incorporated in distributed programs so as to address the communication bottleneck in the cloud
- Define heterogeneous and homogenous clouds, and identify the main reasons that cause heterogeneity in the cloud
- State when and why synchronization is required in the cloud
- Identify the main technique that can be used to tolerate faults in clouds
- Outline the difference between task scheduling and job scheduling

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
