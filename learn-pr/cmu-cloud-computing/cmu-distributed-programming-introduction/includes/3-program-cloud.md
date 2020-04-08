Distributed programs run on networked computers. Networks of computers are ubiquitous. The internet, high-performance computing (HPC) clusters, mobile phones, and in-car networks, among others, present common examples. Many networks of computers are deemed distributed systems. We define a **distributed system** as one in which networked computers communicate using message passing and/or shared memory and coordinate their actions to solve a particular problem or offer a specific service. Because a cloud is defined as a set of internet-based software, platform, and infrastructure services offered through a cluster (or clusters) of networked computers (i.e., datacenters), a cloud is thus a distributed system. Another consequence of our definition is that distributed programs (versus sequential or parallel) will be the norm in clouds. In particular, we define distributed programs in the section as parallel programs that run on separate processors at different machines. Thus, the only way for tasks in distributed programs to interact over a distributed system is either by sending and receiving messages explicitly or by reading and writing from/to a shared distributed memory supported by the underlying distributed system (e.g., by using distributed shared memory [DSM] hardware architecture).<sup>[1][^1]</sup> We next identify the different models by which distributed programs for clouds (or _cloud programs_) can be built and recognize some of the challenges that cloud programs must address.

## Programming the cloud

The effectiveness of cloud programs hinges on the manner in which they are designed, implemented, and executed. The development process must address several considerations:

- Which underlying programming model is most appropriate, message passing or shared memory? 
- Does the application better fit a synchronous or asynchronous computation model? 
- What is the best way to configure data for computational efficiency: by using data parallelism or graph parallelism? 
- Which architectural and management structure will most enhance program complexity, efficiency, and scalability: master-subordinate or peer to peer? 

For cloud programs in particular, several issues—spanning design, implementation, tuning, and maintenance—require special attention:

- Computational scalability is hard to achieve in large systems (e.g., clouds) for several reasons, including inability to parallelize algorithms completely, high probability of load imbalance, and inevitability of synchronization and communication overheads. 
- Communication that exploits data locality and minimizes network traffic can be tricky, particularly on (public) clouds, where network topologies are usually hidden. 
- Two common cloud realities—virtual environments and datacenter component diversity—introduce heterogeneity that complicates scheduling tasks and masks hardware and software differences among cloud nodes. 
- To avoid deadlocks and transitive closures and to guarantee mutually exclusive access, which are highly desirable capabilities in distributed settings, the underlying system must provide, and the designer must exploit, effective synchronization mechanisms. 
- As failure likelihood increases with cloud scale, system designs must employ fault-tolerance mechanisms, including task resiliency, distributed checkpointing, and message logging. 
- For effective and efficient execution, task and job schedulers must support control of task locality, parallelism, and elasticity as well as service-level objectives (SLOs). 

Addressing all of these development considerations and cloud issues imposes a major burden on programmers. Designing, developing, verifying, and debugging all (or even some) of these capabilities present inherently difficult problems and can introduce significant correctness and performance challenges, in addition to consuming significant time and resources. 

Modern distributed analytics engines promise to relieve developers of these responsibilities. These engines provide application programming interfaces (APIs) that enable users to present their programs as simple, sequential functions. The engines then automatically create, parallelize, synchronize, and schedule tasks and jobs. They also handle failures without requiring user involvement. At the end of this unit, we detail how distributed analytics engines effectively abstract and address the challenges of developing cloud programs. In the next section, however, we first present the two traditional distributed programming models: shared memory and message passing. Second, we discuss the computation models that cloud programs can employ. Specifically, we explain the synchronous and asynchronous computation models. Third, we present the two main parallelism categories of cloud programs, data parallelism and graph parallelism. Last, we describe the architectural models that cloud programs can typically utilize: master-subordinate and peer-to-peer architectures. 
<br>
***
### References

1. _A. S. Tanenbaum (September 4, 1994). [Distributed Operating Systems](https://cds.cern.ch/record/400319/files/p101.pdf) Prentice Hall, First Edition_

[^1]: <https://cds.cern.ch/record/400319/files/p101.pdf> "A. S. Tanenbaum (September 4, 1994). *Distributed Operating Systems* Prentice Hall, First Edition"
