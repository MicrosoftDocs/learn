<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m02_mapReduce\x-oli-workbook_page\_u05_m02_8_YARN.xml -->

##  Hadoop 2.0 and YARN

Hadoop has undergone a major overhaul to address several inherent technical deficiencies, including the reliability and availability of the JobTracker (JT) and the static resource (map and reduce slots) allocation at TaskTrackers (TTs), to mention a few. The redesigned framework addresses such problems in the JT, Hadoop's master node and, therefore, a single point of failure (SPOF). Another major objective for the new Hadoop is to support, in addition to MapReduce, other distributed analytics engines. This allows for increased utilization of Hadoop clusters and eliminates the need for a large cluster to be deployed for each framework. For Hadoop, the result is a new version named **Yet Another Resource Negotiator** (YARN). We next introduce YARN and point out how it differs from the previous Hadoop MapReduce, which we call MapReduce 1.0.

YARN is the second generation Hadoop (version 2.0 and higher). The main advantage of YARN from the previous generation of Hadoop is that the resource allocation is no longer fixed, and YARN is not bound to any single programming framework. This allows YARN to function as an independent cluster scheduler, which is capable of scheduling different workloads and applications. YARN is a two-level scheduler, the responsibility of the Job Tracker in Hadoop v1 in YARN is separated into resource allocation and task management, which enables YARN clusters to easily scale up.

##  Architecture and Workflow

The fundamental change pursued in redesigning MapReduce 1.0 was segregating JT functionalities into multiple, independent daemons, illustrated in Figure 5.22. YARN still employs a master-slave topology but adds several enhancements:

1. To support other distributed analytics engines in addition to MapReduce, the resource management module has been entirely detached from the JT and defined as a separate entity, the **ResourceManager (RM)**. RM has been further sliced into two main components, the **Scheduler (S)** and the **ApplicationsManager (AsM)**. 
1. Instead of using a single master, JT, for all applications, YARN appoints one master per application, an **ApplicationMaster (AM)**. AMs can be distributed across cluster nodes to avoid application SPOFs and potential performance degradations. 
1. TTs have remained effectively unchanged but are now called **NodeManagers (NMs)**.

![Figure 5.22: Elements of the YARN architecture: one RM, one ASM, one S, many AMs, and many NMs](../media/YARN_architecture.png)

_Figure 5.22: Elements of the YARN architecture: one RM, one ASM, one S, many AMs, and many NMs_


##  Components of YARN

![Figure 5.23: The architecture of a YARN cluster](../media/YARN.png)

_Figure 5.23: The architecture of a YARN cluster_


A per-cluster **Resource Manager (RM)** resides in the master node (Figure 5.23). The RM accepts application/job submissions by a client, allocates resources to jobs, monitors the cluster state and manages the access to resources. The RM has two components: the Scheduler (S), which schedules job, and the Applications Manager, which creates, manages, monitors, restarts and kills jobs. 

The RM is the central authority, it arbitrates resource allocations among various competing applications/jobs. The RM dynamically allocates resources as leases to applications in the form of containers. Containers are a logical representation of resources in the form of amount of memory or number of CPUs. Currently, the RM handles memory capacities and CPU resources but does not yet support disk, or network resources. The RM interacts with Node Managers (NMs) to assemble a global view of the cluster and to enforce resource assignments. The RM tracks resource usage and node liveness through a heartbeat mechanism.

The **Scheduler** is a part of the RM and builds a global plan for cluster resources, serves application resource needs, and schedules jobs using strategies such as Capacity or Fair scheduling. The Applications Manager, another part of RM, accepts submitted jobs, negotiates with the Scheduler to initialize resources, a container, to run a job’s Application Master (AM), and provides services for tolerating/restarting the AMs when failures occur.

The **Application Master (AM)** coordinates the application’s (or job’s) execution in a YARN cluster. Each job, be it a MapReduce job, MPI job, or Spark job, has a dedicated AM in the YARN cluster. The AM runs in a common container as other tasks do. The AM is responsible for getting containers and allocating its tasks on to them. It computes the set of resources it needs based on the tasks it has to run and sends a request to the RM. Once the resources are allocated it runs the tasks on those containers and once they complete it gives them back to the RM. Below we explain this process in more detail.

As the AM runs in a container, it sends periodic heartbeats to the RM to update its liveness and to update its resource demands. The AM calculates the resources demands of its job and makes a request for containers along with preferences and constraints within its periodic heartbeat message to the RM. In turn, the RM dynamically responds to the heartbeat in the form of container leases (provided as tokens). The AM uses the tokens when contacting the corresponding NMs to start a job’s tasks. The AM keeps track of the status of its running tasks through an umbilical mechanism. During a job’s execution, the RM is blind to the AM’s scheduling. For a MapReduce job, the AM is like the JobTracker in Hadoop version 1.0.

The **Node Manager (NM)** resides on each node, a single NM per YARN cluster node. The NMs authenticate container leases and monitor resource utilization. NMs contact the RM through heartbeats and kill containers as directed by the RM or AM.

A **container** represents a lease for an allocated resource in the cluster. A lease is a logical bundle of resources bound to a node. The RM is the sole authority to allocate any container to jobs. Every allocated container has a unique ContainerId, which is globally unique. Each container has a number of non-static attributes: CPU, memory, disk BW, network BW. Containers can be compared to MapReduce slots in Hadoop version 1.0. A container is killed shortly after the task running in it finishes, and RM revokes the resources and makes use of it later.

When requiring compute resources, the AM presents to the RM Scheduler a series of container requests. The protocol understood by the Scheduler is `<priority, (host, rack, *), resources, #containers>`. The RM Scheduler assigns or allocates containers in the same format. A snapshot from the RM log, shows how the RM allocates a container (Figure 5.24):

![Figure 5.24: Log snapshot of a container assignment in YARN. The important infromation in this entry are: 1. ContainerID, 2. Computer resources in this ContainerID, 3. ID of the node where the ContainerID resides, and 4. Resource report of this node after allocation ](../media/YARN_log1.png)

_Figure 5.24: Log snapshot of a container assignment in YARN. The important infromation in this entry are: 1. ContainerID, 2. Computer resources in this ContainerID, 3. ID of the node where the ContainerID resides, and 4. Resource report of this node after allocation_


##  Job and Task Scheduling

YARN is a two-level scheduler, the RM schedules jobs and the AM schedules its tasks on the containers it gets allocated by the RM. The Scheduler, which is responsible for job scheduling in the RM employs different scheduling strategies:

- **FIFO Scheduler**: is a basic and simple scheduler which has a single first in first out queue and schedules the container requests based on that. Typically, a job can exclusively occupy resources within the cluster while running. Though each job can be offered large resources, this creates problems such as starving other jobs or not sharing the available resources fairly. The FIFO scheduler allows job priorities to be set, hence, the job with the highest priority is selected as the next job to run. However, since the FIFO scheduler does not support preemption the problem of job starvation still exists. A high-priority job can be blocked by a long-running but low-priority job.
- **Capacity Scheduler**: assumes that Hadoop jobs are running on a shared, multi-tenant cluster and maximizes the throughput and utilization of the cluster. The Capacity Scheduler guarantees to users that are sharing a large cluster to get capacity guarantees. The Capacity Scheduler organizes jobs in queues. Typically, the queues are setup by administrators based on how the YARN cluster will be partitioned and utilized by different groups of users (group 1, queue 1 gets 50% of the cluster). The Capacity Scheduler offers a set of limits to make sure a single job or queue cannot consume disproportionate amount of resources in the cluster. 
- **Fair Scheduler**: focuses on running different YARN jobs fairly, providing jobs with an equal share of resources over time. By default, a scheduling decision made by the Fair Scheduler is based only on memory. However, the Fair Scheduler is configurable, and it can schedule with both memory and CPU. The Fair Scheduler ensures some short jobs to finish in a reasonable amount of time without starving large or time-consuming jobs. It is also a desirable scheduler for multiple users sharing the same cluster. Besides allocating resources equally, the Fair Scheduler can also schedule jobs with different priorities. Priorities, set by users, can be used to determine how many resources each job should be assigned.
- **Your Scheduler**: users can plug in their own job scheduler.

The strategies of scheduling can be configured in the file `yarn-site.xml`. There are also many properties that can be set in `yarn-site.xml` to tune the operational parameters of the schedulers mentioned above.

After a job is allocated resources (containers), the AM is in charge of scheduling a job’s tasks on these containers. The AM schedules tasks in the same way the JobTracker does in Hadoop version 1.0. Moreover, the AM also takes the responsibility of monitoring the status of tasks, which is done by TaskTracker in Hadoop version 1.0.

##  Fault Tolerance in YARN

The Resource Manager (RM) is a single point of failure (SPOF) of a YARN cluster. The Resource Manager checkpoints its state to persistent storage periodically. If the RM fails, it can be restarted from one of the checkpoints. All running AMs are then killed and restarted and the applications and tasks that are pending from the checkpoint state can be scheduled and executed. 

Any AM may fail. The RM will notice an AM’s failure to send a heartbeat, and will restart the AM. However, the AM has to resync with all running containers to ensure the job finishes smoothly.

The NM failures can also be detected by the RM. When a NM fails, all containers on this node will be killed and the failure will be reported to all running AMs. The AMs are responsible for acquiring new resources in the form of containers from the RM to run the killed tasks, and no more containers will be assigned on the failed node in the cluster until it recovers and reports back to the RM.

##  Job Flow for MapReduce on YARN

![Figure 5.25: Job flow in YARN executing a MapReduce job](../media/YARN_flow.png)

_Figure 5.25: Job flow in YARN executing a MapReduce job_


Figure 5.25 illustrates a typical MapReduce job flow in YARN. The steps in this flow are the following:

###  Job submission

1. The MapReduce client uses the same API as Hadoop version 1.0 to submit a job to YARN. When `mapreduce.framework.name` is set to `yarn` in the job configuration, the `ClientProtocol` of YARN is activated. A job is referred to as an application in YARN.
1. Unlike in Hadoop version 1.0 where the JobTacker manages all jobs in the cluster, in YARN, the new job ID is retrieved from the RM. However, sometimes a `jobID` in YARN is also called `applicationID`.
1. Necessary job resources, such as the job JAR, configuration files, and split information are copied to a shared file system in preparation to run the job.
1. The job client calls `submitApplication()` on the RM to submit the job.

###  Job initialization

1. The RM will pass the job request to its Scheduler after it receives the call of **submitApplication()**. The Scheduler allocates resources to run a container where the Application Master (AM) will reside. Then the RM sends the resource lease to some Node Manager (NM).
1. The NM receives a message form RM and launches a container for the AM.
1. The AM takes the responsibility of initializing the job. Several bookkeeping objects are created to monitor the job. Afterwards, while the job is running, the AM will keep receive updates with the progress of its tasks.
1. The AM interacts with the shared file system (e.g. HDFS) to get its input splits and other information which were copied to the shared file system in Step 3.

###  Task assignment

1. 
The AM computes the number of map tasks, which is decided by the number of input splits (similar to Hadoop version 1.0). The number of reduce tasks is a configurable parameter which is set in the configuration file. The AM requests resources for all the map and reduce tasks from the RM in the form of a request for containers. A request includes preferences in terms of data locality (for map tasks), the amount of memory and the number of CPUs in each container.
``` text
ResourceRequest: &lt;Priority: 20,
Resource: &lt;vCores: 1, memory: 1024&gt;,
Num Containers: 2,
Desired Host: 192.1.1.1,
Relax Locality: true&gt;
```


In the above example, `priority` defines the priority of the container which can be configured based on the type of task (e.g. mapper or reducer). The resources required for this task is designated as a sub-record called `Resource`. Here the number of `vCores` (CPUs) has been denoted as `1`, while `memory` is an integer parameter which is defined in MB. `Num containers` denote the number of such containers that is needed by YARN. `Desired host` denotes the locality requirement of the request. `Relax locality` denotes whether the defined locality requirement is stringent, or if any other allocation is also acceptable for this task.

1. & 11. After the RM responds with container leases, the AM communicates with the NMs, and the NMs start the containers.

1. The AM assigns a task to this container based on its knowledge of locality. The task will be executed by a Java application whose main class is `YarnChild`.

###  Status reports

![Figure 5.26: Heartbeating and Status reports in YARN](../media/YARN_status.png)

_Figure 5.26: Heartbeating and Status reports in YARN_


While the job is running, the tasks keep reporting their progress and status to the corresponding AM, which ensures that the AM has an aggregate view of the job (Figure 5.26). The Node Managers report liveness and resource utilization to the RM, which has a global view of the cluster.

###  Job completion

Every five seconds the job client checks the job status to see if the job has finished. The function called is `waitForCompletion()`. Once the job completes, the clean-up method is called. All containers and the working state of the AM will be cleaned up. The job history server keeps track of the information related to this job. 

##  An example: WordCount

Here we present an example of running WordCount on a YARN cluster consisting of 1 master node and 4 slave nodes. We employ the m1.large instance (2 vCPU, 6.5ECU, 7.5GB Memory) offered by Amazon Web Service (AWS). The input data is partitioned as 39 plain text files on the distributed file system, which are 2.32 GB in total. The number of map tasks is computed to be 39, and we manually configure the number of reduce tasks in the job configuration file to be 7.

We use snapshots to detail the execution process of this job on YARN:

1. The client starts to run the WordCount job.
1. The RM assigns a `jobID` for this WordCount job.
1. Information of this WordCount job is saved or copied to HDFS.
1. The WordCount job is submitted to the RM (Figure 5.27).

![Figure 5.27: Job submission log](../media/YARN_log2.png)

_Figure 5.27: Job submission log_


1. The RM communicates with the NM to allocate a container for the AM.
1. The NM authenticates the container lease from the RM.
1. The RM succeeds in launching the AM for the WordCount job (Figure 5.28). 

![Figure 5.28 Job allocation log](../media/YARN_log3.png)

_Figure 5.28 Job allocation log_


1. The AM starts running, and it computes resources it needs to finish the WordCount job: 39 map tasks and 7 reduce tasks.
1. The RM receives requests from the AM and allocates resources in the form of containers.
1. The AM sends the lease to NMs and a bunch of containers get running.
1. The AM starts map task attempts, ready to run in containers. In our case, the AM, in the first place, starts 12 map task attempts because there aren’t enough resources for other container on our 4-node cluster.
1. The AM then assigns containers to map task attempts based on its knowledge of data locality (Figure 5.29). 

![Figure 5.29: Job assignment log](../media/YARN_log4.png)

_Figure 5.29: Job assignment log_


1. The map tasks start running. While running, the AM keeps track of the status of each task attempt through a heartbeat mechanism. • At some point, a map task finishes executing in a container and the AM is informed.
1. This container is then cleaned by the AM. Compute resources are retrieved and a new container will be started by the NM through the same process mentioned above. The AM will assign new map or reduce task attempt to the new container. Only one task can be run in one container.
1. Because of the early shuffle, when several map tasks finish (at least 5% by default), the AM will assign a reduce task attempt to an available container. A reduce phase consists of the shuffle, merge and sort, and the execution of the reduce function. Only after the output bytes of the reduce task are written to HDFS can a reduce task finish.
1. The AM manages all the map and reduce tasks, it waits for their completion. Once the last reduce task finishes, the whole job will be marked FINISHED.
1. The AM communicates with the NMs to clean up all remaining containers.
1. The AM will notify the RM that the job is completed.
1. The RM cleans up the AM. The whole WordCount job ends (Figure 5.30). 

![Figure 5.30: Job cleanup log](../media/YARN_log5.png)

_Figure 5.30: Job cleanup log_



###  A timeline of tasks for an example WordCount job:

Shortly after the job starts, 12 map tasks (blue bars) start running (Figure 5.31). No more map task can be run because no more resources (containers) are available in the cluster to start another map task. We refer to several map tasks running in parallel as a wave, so, we have 12 map tasks in the first wave. After a period of time, some of the map tasks finish. Due to the **early shuffle** mechanism (by default when 5% of the map tasks finish, reduce tasks are scheduled and the begin to shuffle). In this example, there are enough resources for four reduce tasks to start. Each reduce task has 3 sequential subphases: **shuffle**(red), **merge&sort**(yellow), **reduce function**(pink). While the 4 reduce tasks are performing an early shuffle, the second wave of map tasks begins to run. When the last map task completes, the whole map phase ends. Afterwards, the **merge&sort** and **reduce functions** can run. Afterwards, there are enough containers to run 3 more reduce tasks. The job finishes shortly after the last reduce task ends.

![Figure 5.31: Job execution timeline for wordcount](../media/wordcount_timeline.png)

_Figure 5.31: Job execution timeline for wordcount_


<sup>10</sup>The number of map and reduce slots are configurable parameters, which the users can set before submitting jobs to Hadoop MapReduce.

### References

1. _Big-Data Analytics Predictions for 2011 ().  http://tdwi.org/articles/2011/03/16/big-data-analytics-predictions.aspx/_
2. _T. White (2012). Hadoop: The Definitive Guide, 3nd Edition O'Reilly_
3. _A. C. Murthy, C. Douglas, M. Konar, O. O'Malley, S. Radia, S. Agarwal, and K. V. Vinod (2011). Architecture of Next Generation Apache Hadoop MapReduce Framework Apache Jira_
4. _Vavilapalli, Vinod Kumar and Murthy, Arun C and Douglas, Chris and Agarwal, Sharad and Konar, Mahadev and Evans, Robert and Graves, Thomas and Lowe, Jason and Shah, Hitesh and Seth, Siddharth and others (2013). Apache hadoop yarn: Yet another resource negotiator Proceedings of the 4th annual Symposium on Cloud Computing_