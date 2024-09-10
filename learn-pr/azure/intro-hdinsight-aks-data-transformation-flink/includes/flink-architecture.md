Apache Flink on HDInsight on AKS consists of three main components: a JobManager, one or more TaskManagers and the History Server. 

When a user submits a job, the job client sends the job to the job manager, which then converts it into an execution graph consisting of multiple tasks. The JobManager schedules these tasks on the TaskManagers and creates splits of the data for parallel execution. 

- **Job Manager**: Responsible for tracking distributed tasks, decides when to schedule the next task (or set of tasks), and reacts to finished tasks or execution failures. The JobManager receives the JobGraph and partitions it into a series of tasks to be executed in parallel across the Apache Flink cluster.  

- **Task Manager**: The TaskManagers (also called workers) execute the tasks of a dataflow, and buffer and exchange the data streams. There must always be at least one TaskManager. The smallest unit of resource scheduling in a TaskManager is a task slot. The number of task slots in a TaskManager indicates the number of concurrent processing tasks. 

- **History Server**: All completed jobs run in an Apache Flink cluster are saved in an external storage and history Server shows the complete jobs. 

### Checkpoints 

Checkpoints in Apache Flink enable fault tolerant by allowing state and the corresponding stream positions to be recovered. This mechanism involves taking a snapshot of the state of a running Apache Flink job and storing them in a durable storage system, such as HDFS, allowing recovery of failures. When checkpointing is enabled, managed state persists to ensure consistent recovery in failures.  

### How does it work? 

Apache Flink's checkpointing mechanism works by periodically capturing  snapshots of  state of each parallel operator in a job and storing it in a checkpoint. The checkpoint also includes metadata that describes the state of the job at the time of the checkpoint, such as the timestamp of the last processed event. 

To learn more about Apache Flink, visit the [Apache Flink Documentation](https://nightlies.apache.org/flink/flink-docs-stable/) and our [Azure documentation](/azure/hdinsight-aks/flink/flink-overview). 
