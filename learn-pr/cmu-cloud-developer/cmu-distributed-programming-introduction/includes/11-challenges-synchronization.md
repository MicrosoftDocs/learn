To achieve maximum performance, distributed tasks need the ability to operate simultaneously on shared data without risking data corruption or inconsistency. Synchronization mechanisms address this requirement by allowing programmers to control the sequence of operations (reads and writes) that tasks perform. For instance, GraphLab allows multiple tasks to operate on different vertices of the same graph simultaneously. This capability could lead to race conditions in which two tasks try to modify data on a shared edge at the same time, resulting in a corrupted value. The solution lies in a synchronizing means to assure that distributed tasks can obtain mutually exclusive data access, the **mutual exclusion** property.

As discussed in the section about the shared-memory programming model, three synchronization methods are widely used: semaphores, locks, and barriers. Applying these methods efficiently is a critical goal in developing distributed programs. For instance, although a barrier is easy to implement, a distributed program's overall execution time then becomes dependent on the slowest task. In distributed systems such as the cloud, in which heterogeneity is the norm, this situation can seriously degrade performance. The challenge is to employ synchronization methods without paying performance penalties. 

In addition to mutual exclusion, synchronization mechanisms must guarantee other properties for distributed programs. To begin, if one task attempts to access a critical section, it should eventually succeed. If two tasks try simultaneously to access a critical section, only one should succeed. However, things may not always go as expected. For instance, if task $A$ succeeds in acquiring `lock1` and, at about the same time, task $B$ succeeds in acquiring `lock2`; then if task $A$ attempts to acquire `lock2`, and task $B$ attempts to acquire `lock1`, we have what is known as a **deadlock**. Avoiding such stalemates presents a significant challenge in developing distributed programs, especially when the number of tasks scales up, and any mutual exclusion mechanism must ensure the deadlock-free property. 

To build upon the example of tasks $A$ and $B$, let us assume a larger set of tasks: $\lbrace A, B, C, \cdots, Z \rbrace$. In ensuring mutual exclusion, task $A$ might wait on task $B$, if $B$ is holding a lock required by $A$. In return, task $B$ might wait on task $C$ if $C$ is holding a lock required by $B$. The "wait on" sequence can carry on all the way up to task $Z$. Specifically, task $C$ might wait on task $D$, and task $D$ might wait on task $E$, all the way until task $Y$, which might also wait on task $Z$. Such a "wait-on" chain is usually referred to as transitive closure. When a transitive closure occurs, a circular wait is said to arise. This situation normally leads to stark deadlocks that can bring an entire distributed program/system to a grinding halt. Lastly, we note that the wait-on relation lies at the heart of every mutual exclusion mechanism. In particular, no mutual exclusion protocol, no matter how clever, can preclude it.<sup>[2][^2]</sup> In normal scenarios, a task expects to "wait on" for a limited (reasonable) amount of time. But what if a task that is holding a lock/token crashes? This scenario brings us to another major challenge for distributed programs, namely, fault tolerance. 

> [!div class="alert is-tip"]
> ### Did you know?
>
> Mutual exclusion in distributed systems can be categorized into two main classes, **token based** and **permission based**.
>
> In the token-based approach, mutual exclusion is accomplished by passing a single message denoted as token between tasks of a distributed program. Obtaining the token can be deemed as acquiring the lock. As such, a task that holds the token can access the shared data, while every other task will wait until its turn arrives. Tasks using the token-based approach are usually organized logically as a ring. When a task is done, it passes the token to the next task on the ring. The next task can either choose to access the shared data or simply pass the token to the subsequent task on the ring.
>
> The token-based approach avoids starvation because it can fairly ensure that each task will have the chance to access the shared data. On the other hand, it suffers from a reliability issue. In particular, if the token is lost on the network (e.g., due to a network failure), or the task that is currently holding the token crashes, an intricate distributed procedure usually has to be involved to make sure the distributed program will continue functioning properly. Losing a token in a distributed system becomes more challenging if the system is scaled up. This problem stems from the increasing probabilities of machine and network failures in large-scale systems.
>
> In the permission-based approach, distributed mutual exclusion can be achieved by requiring tasks to ask for permissions (e.g., locks) in order to access shared data. This approach can be implemented using either **centralized** or **decentralized** algorithms. In centralized algorithms, a coordinator for granting permissions is employed. A task can always make requests to the coordinator, asking for permissions. The coordinator can either provide or deny permissions, depending on whether there are tasks already accessing the requested data. The coordinator ensures that only one task can write on a shared piece of data at a time, yet can allow multiple reads from multiple tasks on the same data to proceed.
>
> Centralized algorithms are easy to implement, are robust to starvation, and exhibit fairness. In particular, permissions can be provided in the order that they are asked for and for specified allotted times, which ensures that every task gets a chance to make requests. Nonetheless, centralized algorithms suffer from serious problems. First, the coordinator exposes a single point of failure (SPOF). That is, if the coordinator fails, the whole system will go down. Second, the coordinator can become a performance bottleneck, especially when scaling up the quantities of nodes and users.
>
> To address these two main drawbacks of centralized algorithms, decentralized algorithms suggest splitting the central coordinator into multiple coordinators.<sup>[1][^1]</sup> Subsequently, for a task to acquire (write) permission, it needs to get a majority vote from coordinators (see unit 4 in this module for an introduction on voting mechanisms). Clearly, obtaining these permissions makes the distributed program less vulnerable to an SPOF. More precisely, a distributed program with a decentralized, mutually exclusive algorithm can tolerate $K$ out of $2K + 1$ coordinator failures.<sup>[1][^1]</sup> Also, decentralized algorithms remove the performance bottleneck revealed in centralized algorithms. Decentralized algorithms are more complex to implement and maintain than centralized ones. In general, implementation and maintenance complexities can impede scalability, especially if the number of control messages increases dramatically.
> 
<br>

***
### References

1. _A. S. Tanenbaum and M. V. Steen (October 12, 2006). [Distributed Systems: Principles and Paradigms](https://dl.acm.org/doi/book/10.5555/1202502) Prentice Hall, Second Edition_
2. _M. Herlihy and N. Shavit (March 14, 2008). [The Art of Multiprocessor Programming](https://dl.acm.org/doi/book/10.5555/1734069) Morgan Kaufmann, First Edition_

***

[^1]: <https://dl.acm.org/doi/book/10.5555/1202502> "A. S. Tanenbaum and M. V. Steen (October 12, 2006). *Distributed Systems: Principles and Paradigms* Prentice Hall, Second Edition"
[^2]: <https://dl.acm.org/doi/book/10.5555/1734069> "M. Herlihy and N. Shavit (March 14, 2008). *The Art of Multiprocessor Programming* Morgan Kaufmann, First Edition"

<!-- First code block in YAML is built from the following code block.
     No code fence set to get coloring shown in original course.

   1 - Remove comments from around code block.
   2 - Look at code block in Preview mode.
   3 - Screen capture code block as an image. 
   4 - Code block saved as "quiz-code-1.png" in media folder.

```
1 transaction (Account source, Account destination, double amount)
2 {
3   Acquire lock on source;
4   Acquire lock on destination;
5   withdraw(from, amount);
6   deposit(to,amount);
7   Release lock on destination;
8   Release lock on source;
9 }
```
-->

<!-- Second code block in YAML is built from the following code block.
     No code fence set to get coloring shown in original course.

   1 - Remove comments from around code block.
   2 - Look at code block in Preview mode.
   3 - Screen capture code block as an image. 
   4 - Code block saved as "quiz-code-2.png" in media folder.

```
1 Transaction(A,B,50); and Transaction(B,A,10);
```
-->  
