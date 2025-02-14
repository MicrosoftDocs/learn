By the end of this unit, you should be able to describe the basic functions of job schedulers, resource managers, high-performance computing, and high-throughput computing.

## Job schedulers

A cluster computing job scheduler is a software component that manages and assigns computing resources (such as CPUs, memory, and disks) to the jobs submitted to the cluster. Job schedulers determine the most appropriate nodes in the cluster to run a particular job based on the availability of resources, the job's priority, and other factors. Job schedulers ensure that multiple jobs running in parallel don't interfere with each other. Job schedulers include queues for holding pending jobs and a policy for scheduling them.

A job scheduler's main goals are to:

- Minimize the time between the job submission job completion.
- Optimize CPU utilization.
- Maximize the job throughput.

Users submit non-interactive batch jobs to the scheduler. The scheduler stores the batch jobs, evaluates their resource requirements and priorities, and distributes the jobs to suitable compute nodes.

The job script submitted through the scheduler adds the job to a job queue. Depending on the available resources the job needs, the scheduler decides when the job leaves the queue, and on which of the back-end nodes it runs.

There are several basic strategies that schedulers can use to determine which job to run next:

- **First Come, First Serve**: Jobs are run in the same order in which they first enter the queue. The advantage is that every job will definitely run; however, a small set of jobs might wait for an inadequately long time compared to their actual execution time.

- **Shortest Job First**: Based on the execution time declared in the job script, the scheduler estimates the job's execution time. The jobs are ranked in the ascending order of the execution time. While short jobs will start after a short waiting time, long running jobs (or at least jobs declared as such) might never actually start.

- **Backfilling**: The scheduler maintains the concept of First Come, First Serve without preventing long-running jobs from executing. The scheduler runs the job only when the first job in the queue can be executed. Otherwise, the scheduler goes through the rest of the queue to check whether another job can be executed without extending the first job in the queue's wait time. If it finds such a job, the scheduler runs that job. Small jobs usually encounter short queue times.

## Resource manager

A cluster-computing resource manager allocates resources within a computing cluster. Resource managers are responsible for allocating memory, CPU, storage, and network bandwidth to the jobs running in the cluster. This component monitors resource usage within the cluster, detects any idle or underutilized resources, and reallocates them to other jobs or tasks that require them.

## Slurm overview

Slurm is an open-source job scheduler and resource manager for running workloads on Linux clusters. Slurm provides an extensible framework for managing resources and scheduling jobs in a Linux-cluster environment. It supports a wide range of job types, including parallel jobs, batch jobs, and interactive jobs. Slurm allows users to submit jobs through a variety of interfaces, including a command-line interface, web-based interface, and API. Slurm is a popular solution many of the most powerful supercomputers and compute clusters use, and it's available as an option when using High Performance Computing (HPC) on Microsoft Azure.

Slurm allows you to match appropriate compute resource based on resource criteria including CPUs, GPUs, and memory.

The Slurm job scheduler has the following important functions:

- Allocates access to compute nodes in HPC clusters to users so that their tasks can be executed
- Provides a framework for starting, executing, and monitoring work on a set of allocated nodes
- Arbitrates contention for resources by managing a queue of pending jobs

## Slurm jobs

When you use Slurm to run a job on a Linux HPC cluster, the following high-level steps occur:

1. **Job submission**: The first step is that a user submits a job to the Slurm scheduler by creating a job script that includes resource requirements and the set of commands the job requires.
1. **Job allocation**: The next stage involves the Slurm scheduler examining the job's resource requirements, such as the number of nodes, CPUs, and memory needed, as well as any other constraints like partitions and time limits. Based on these requirements, the scheduler determines the best available resources to allocate for the job, considering the current cluster usage and other pending jobs.
1. **Job queuing**: The scheduler determines if the requested resources are available. If the resources are immediately available, the job executes. If the requested resources aren't available immediately, the job is placed in a queue. The scheduler continuously evaluates the queued jobs and their priorities to allocate resources as they become available.
1. **Job execution**: Once the required resources are allocated to the job, the Slurm job starts executing on the assigned nodes. Tasks specified in the script run on nodes.
1. **Job completion**: The final step is job completion, in which compute resources are released back to the cluster and the scheduler updates the job's status to **completed**. Job output and any error messages that might have been generated during job execution are saved to designated output files.
1. **Job accounting and reporting**: Slurm generates accounting data about completed jobs, including resource usage and execution time.

## Slurm commands

You use a set of command-line utilities to perform actions on a compute cluster managed through Slurm. Here are some common Slurm user commands:

|Command   |Function   |
|----------|-----------|
|`sacct`     |This command reports job and job step accounting information about jobs that are active or completed. |
|`salloc`    |Use this command to allocate resources for a job in real time. Allows you to spawn a shell and enact `srun` commands as a way of initiating parallel tasks.  |
|`sattach`   |This command attaches standard input, output, and error-signal capabilities to a currently running job or job step.|
|`sbatch`    |Use this command to submit a job script for later execution. These scripts generally include one or more `srun` commands to initiate parallel tasks.     |
|`scancel`   |Use this command to transfer a file on nodes needed.     |
|`scontrol`  |This is a Slurm administrative tool that allows you to view and modify the Slurm state. Most `scontrol` commands require root privileges.          |
|`sinfo`     |This command displays information on partitions and nodes that Slurm manages.                                         |
|`sprio`     |Use this command to view information on the components impacting a job's priority.                                         |
|`squeue`    |Use this command to view the state of jobs or job steps.                                                                   |
|`srun`      |Use this command to submit a job for execution or to trigger job steps in real time. You can use `srun` to specify resource requirements such as minimum and maximum node count, processor count, and node characteristics.           |
|`sstat`     |Use this command to view information about resources utilized by running jobs or job steps.                                |
|`strigger`  |Use this command to configure or view event triggers such as what to do when a node fails or a job approaches a time limit.|
|`sview`     |Use this command to view state information on jobs, partitions, and nodes that Slurm manages.                                 |

You can learn more about Slurm commands at the [Slurm Quick Start User Guide](https://slurm.schedmd.com/quickstart.html).
