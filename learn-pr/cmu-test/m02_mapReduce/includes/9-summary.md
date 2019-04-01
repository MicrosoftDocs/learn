<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m02_mapReduce\x-oli-workbook_page\_u05_m02_9_summary.xml -->
##  Distributed Analytics Engines for the Cloud: MapReduce Summary

- MapReduce is a data-parallel framework for processing big-data applications on large clusters. Hadoop is an open-source implementation of MapReduce.
- MapReduce programs typically have a map and a reduce phase. MapReduce also uses an underlying distributed file system, which, in the case of Hadoop, is HDFS.
- In the map phase, the input data is divided into splits and processed independently by map tasks. The output of the map tasks is sorted and shuffled into partitions that are copied to reduce tasks. Reduce tasks process the partitions and produce the final output.
- Data in MapReduce is always formatted as a set of key-value pairs. Keys in MapReduce are used for shuffling data in between the map and reduce phases.
- Examples of MapReduce programs discussed in this module include WordCount, Sort, and Sobel edge detection.
- A MapReduce cluster comprises a JobTracker (which is the master node) and TaskTrackers (slave nodes). 
- JobTrackers assign tasks to TaskTrackers using a pull strategy and monitor TaskTrackers and their progress in executing tasks through a heartbeat mechanism.
- Hadoop supports multiple job schedulers, including FIFO, Fair, and Capacity, among others. 
- The FIFO scheduler is the default scheduler which executes jobs in the order they arrive at the cluster. It does not consider job priority or size, and a small job that might take minutes to run will have to wait for a long-running job that is in the queue to complete first.
- The Fair Scheduler allows cluster resources to be shared among multiple jobs such that all jobs get an equal share of the cluster slots over time.
- The Capacity Scheduler is a more complex version of the Fair Scheduler that creates multiple job queues and schedules jobs on a priority basis. 
- Map tasks in Hadoop are executed on nodes that are closest to the split that needs to be processed. Reduce tasks, however, are processed on any node by default, without paying attention to locality.
- Data redundancy in Hadoop is provided by HDFS through block replication.
- Tasks resiliency in Hadoop is provided by speculative execution, whereby task progress is continually monitored by the JobTracker and slow/stuck tasks are reexecuted on another node as a speculative task.
- Hadoop 2.0 provides a new resource manager called YARN, which provides several enhancements over MapReduce 1.0.