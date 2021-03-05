To tolerate faults in the event of failures, GraphLab suggests using distributed checkpointing and promotes two distributed checkpointing mechanisms: synchronous and asynchronous. To capture a distributed checkpoint, the synchronous mechanism suspends the entire execution of the update functions across cluster machines. By doing so, the mechanism flushes out all in-transit communication messages (induced internally by the engines) and takes a local checkpoint (snapshot) of all altered data at each machine since the last captured checkpoint. The captured local checkpoints collectively form a distributed checkpoint, which is then stored in files<sup>**2**</sup> in the engine's underlying storage layer (e.g., HDFS). In case of a machine/engine failure, the distributed checkpoint can be exploited to restart execution.

Although synchronous checkpointing is simple, it introduces a major inefficiency by suspending the entire GraphLab execution to capture a distributed checkpoint. To address this weakness, the asynchronous mechanism specifies at each cluster machine a checkpointing update function that executes on each vertex, collecting snapshots covering the period since the last saved snapshot. At each machine, checkpointing update functions proceed as shown in Algorithm 2. They are prioritized over regular update functions (used by GraphLab user programs) and follow the edge consistency model. Hence, when the scope of a vertex $v$ is locked, as required by the edge consistency model, it remains so until Algorithm 2 completes at $v$ before proceeding to another vertex. This asynchronous mechanism is based on the Chandy-Lamport checkpointing strategy<sup>[1][^1]</sup> and guarantees consistent distributed checkpoints. Finally, both synchronous and asynchronous checkpointing mechanisms are triggered by GraphLab at fixed intervals, computed as in Young's "A First Order Approximation to the Optimum Checkpoint Interval."<sup>[2][^2]</sup>

With fault tolerance, we close our discussion on GraphLab. This engine employs graph-parallel, shared-memory, asynchronous, and peer-to-peer models. It supports three levels of consistency that trade off parallelism against consistency, allowing users to select—from full consistency, edge consistency, and vertex consistency—a level that suits their application needs. It further ensures serializability (requisite for many machine-learning and data-mining [MLDM] algorithms) with respect to the appropriate consistency model. GraphLab also suggests two types of asynchronous engines, Chromatic and Locking. The Chromatic engine executes vertices partially asynchronously, while the Locking engine executes vertices fully asynchronously. The Chromatic engine uses graph coloring and promotes the color-step concept, which is analogous to the super-step concept in the bulk synchronous parallel model. In essence, GraphLab with the Chromatic engine and the edge consistency model can mimic Pregel. Finally, to achieve fault tolerance, GraphLab suggests using synchronous and asynchronous distributed checkpointing. 

> [!div class="alert is-tip"]
> **Algorithm 2**
>
> Capturing checkpoint at vertex $v$
> 
> - **If** $v$ was already checkpointed **then**
>    - Quit
> - Save $D_{v}$ //save each vertex
> - **foreach** **$u \in N[v]$** **do** //loop over neighbors 
>    - **if** $u$ was not checkpointed **then**
>       - Save data on edge $D_{(u \leftrightarrow v)}$
>       - Schedule $u$ for a checkpoint capturing
>
> - Mark $v$ as checkpointed
>
<br>

***
<!-- Footnotes -->
<sup>**2**</sup> The distributed checkpoint consists of every local checkpoint captured at every cluster machine. Each local checkpoint can be stored in a file, and all files corresponding to local checkpoints can be associated together (in metadata) in order to indicate that they all belong to the same distributed checkpoint.
<br>

***
### References

1. _K. M. Chandy and L. Lamport (1985). [Distributed Snapshots: Determining Global States of Distributed Systems](https://dl.acm.org/doi/10.1145/214451.214456) ACM Trans. Comput. Syst., 3(1):63–75_
2. _J. W. Young (1974). [A First Order Approximation to the Optimum Checkpoint Interval](https://dl.acm.org/doi/10.1145/361147.361115) Communications ACM, 17:530–531_

***

[^1]: <https://dl.acm.org/doi/10.1145/214451.214456> "K. M. Chandy and L. Lamport (1985). *Distributed Snapshots: Determining Global States of Distributed Systems* ACM Trans. Comput. Syst., 3(1):63–75"
[^2]: <https://dl.acm.org/doi/10.1145/361147.361115> "J. W. Young (1974). *A First Order Approximation to the Optimum Checkpoint Interval* Communications ACM, 17:530–531"
