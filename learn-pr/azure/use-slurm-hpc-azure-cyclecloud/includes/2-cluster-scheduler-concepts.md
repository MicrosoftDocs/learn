By the end of this unit, you should be able to describe the basic functions of job schedulers, resource managers, high-performance computing, and high-throughput computing.

## Job schedulers

A cluster computing job scheduler is a software component that manages and assigns computing resources (such as CPUs, memory, and disks) to the jobs submitted to the cluster. Job schedulers determine the most appropriate nodes in the cluster to run a particular job based on the availability of resources, the job's priority, and other factors. Schedulers coordinate resource allocations to reduce contention. Resource isolation and enforcement depend on the cluster's configuration. Job schedulers include queues for holding pending jobs and a policy for scheduling them.

A job scheduler's main goals are to:

- Minimize the time between job submission and job completion.
- Optimize CPU utilization.
- Maximize the job throughput.

Users submit non-interactive batch jobs to the scheduler. The scheduler stores the batch jobs, evaluates their resource requirements and priorities, and distributes the jobs to suitable compute nodes.

The job script submitted through the scheduler adds the job to a job queue. Depending on the available resources the job needs, the scheduler decides when the job leaves the queue, and on which of the back-end nodes it runs.

There are several basic strategies that schedulers can use to determine which job to run next:

- **First Come, First Served**: Jobs are considered in the order in which they enter the queue. This provides a simple ordering policy, but short jobs can wait behind longer jobs.

- **Shortest Job First**: Based on the execution time declared in the job script, the scheduler estimates the job's execution time. The jobs are ranked in the ascending order of the execution time. While short jobs will start after a short waiting time, long-running jobs (or at least jobs declared as such) might never actually start.

- **Backfilling**: The scheduler can run jobs farther down the queue if they don't delay the expected start of jobs ahead of them. This allows suitable jobs to use resources that would otherwise be idle.

Slurm considers job priority rather than arrival order alone. Its backfill scheduler can start lower-priority work when doing so doesn't delay the expected start of higher-priority jobs. Appropriate job time limits help the scheduler make these decisions. For more information, see the [Slurm Scheduling Configuration Guide](https://slurm.schedmd.com/sched_config.html).

## Resource manager

A cluster-computing resource manager tracks configured resources and allocates them according to job requests and scheduling policy. Resources become available when allocations release them or configured sharing or preemption policies permit reuse. Low CPU utilization alone doesn't make an allocated resource available to another Slurm job.

## Slurm overview

Slurm is an open-source job scheduler and resource manager for running workloads on Linux clusters. Slurm provides an extensible framework for managing resources and scheduling jobs in a Linux-cluster environment. It supports a wide range of job types, including parallel jobs, batch jobs, and interactive jobs. Slurm allows users to submit jobs through a variety of interfaces, including a command-line interface, web-based interface, and API. Slurm is a popular solution many of the most powerful supercomputers and compute clusters use, and it's available as an option when using High Performance Computing (HPC) on Microsoft Azure.

Slurm allows you to match appropriate compute resources based on resource criteria including CPUs, GPUs, and memory.

The Slurm job scheduler has the following important functions:

- Allocates access to compute nodes in HPC clusters to users so that their tasks can be executed
- Provides a framework for starting, executing, and monitoring work on a set of allocated nodes
- Arbitrates contention for resources by managing a queue of pending jobs

A job receives a resource allocation. A job step launches tasks within that allocation. `sbatch` submits a script and runs one copy of it on a batch node; requesting multiple nodes doesn't automatically execute every script command on every node. Use an appropriate launcher, such as `srun`, for job steps.

## Slurm jobs

When you use Slurm to run a job on a Linux HPC cluster, the following high-level steps occur:

1. **Job submission**: The first step is that a user submits a job to the Slurm scheduler by creating a job script that includes resource requirements and the set of commands the job requires.
1. **Job queuing**: The scheduler evaluates the submitted job's requirements and priority. A job remains pending until scheduling policy and available resources permit an allocation.
1. **Job allocation**: Slurm allocates resources that satisfy the job's requirements, such as nodes, CPUs, memory, partition, and time limit, while considering other pending jobs.
1. **Job execution**: The batch script starts on the batch node when Slurm's readiness conditions are met. Job steps launch tasks within the allocation as their requested resources become ready.
1. **Job termination**: After execution and cleanup, Slurm releases the allocation and records the outcome. Successful execution results in `COMPLETED`; other outcomes include `FAILED`, `CANCELLED`, `TIMEOUT`, and `OUT_OF_MEMORY`. Inspect the state, exit code, and output/error files when diagnosing a job.
1. **Job accounting and reporting**: When accounting collection and storage are configured, Slurm records job and step history, resource usage, and execution information for reporting.

## Slurm commands

You use a set of command-line utilities to perform actions on a compute cluster managed through Slurm. Here are some common Slurm user commands:

|Command   |Function   |
|----------|-----------|
|`sacct`     |This command reports job and job step accounting information about jobs that are active or completed. |
|`salloc`    |Use this command to allocate resources for a job in real time. Allows you to spawn a shell and enact `srun` commands as a way of initiating parallel tasks.  |
|`sattach`   |Attach to the standard input, output, and standard error of a running job step using `sattach JOB_ID.STEP_ID`. It can't attach directly to batch or extern steps.     |
|`sbatch`    |Use this command to submit a job script for later execution. These scripts generally include one or more `srun` commands to initiate parallel tasks.     |
|`scancel`   |Cancel a pending or running job or job step, or send a signal. For example, `scancel JOB_ID` cancels the specified job.     |
|`scontrol`   |View or modify Slurm configuration and state. Read-only queries such as `scontrol show job JOB_ID` are normally available to users; changes require the privileges specified for each operation.     |
|`sinfo`     |This command displays information on partitions and nodes that Slurm manages.                                         |
|`sprio`     |Use this command to view information on the components impacting a job's priority.                                         |
|`squeue`    |Use this command to view the state of jobs or job steps.                                                                   |
|`srun`      |Use this command to submit a job for execution or to trigger job steps in real time. You can use `srun` to specify resource requirements such as minimum and maximum node count, processor count, and node characteristics.           |
|`sstat`     |Use this command to view information about resources utilized by running jobs or job steps.                                |
|`strigger`  |Use this command to configure or view event triggers such as what to do when a node fails or a job approaches a time limit. When `SlurmUser` isn't `root`, only that account (`slurm` in the stock CycleCloud template) can set triggers.|
|`sview`     |Use this command to view state information on jobs, partitions, and nodes that Slurm manages.                                 |

> [!NOTE]
> Accounting commands depend on the cluster's accounting configuration. Installed commands alone don't guarantee that historical records or resource-usage measurements are available. See [Slurm accounting](https://slurm.schedmd.com/accounting.html) for the collection and storage requirements.

You can learn more about Slurm commands at the [Slurm Quick Start User Guide](https://slurm.schedmd.com/quickstart.html).
