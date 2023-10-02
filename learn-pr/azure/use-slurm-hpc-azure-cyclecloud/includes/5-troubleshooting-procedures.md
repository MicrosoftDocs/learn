After completing this unit, you should be able to describe procedures for common operational status checks and some common problems you may encounter.

## What reasons might cause the job I submitted to Azure Cyclecloud to be stuck in the pending (PD) state?

A job in the PD (pending) state indicates that whilst a job has been submitted, Cyclecloud has not yet found any available nodes to run the job. This could be due to a number of reasons, such as insufficient resources, incorrect job specifications, or node failures.

When configuring a job script, you must ensure that the resources requested are within cluster's limits. This is because the scheduler kills the job once the time allocated is up, even if the job demands more time or the job will be stuck in the queue forever if the job demands more memory than what's available on the system.

## What steps can I take to determine whether nodes have been requested for my Azure Cyclecloud job?

You can use the Slurm squeue command to check for the status of jobs.

## What is the location of slurm logs for nodes/schedulers? (Slurm)

In Azure CycleCloud, the location of Slurm logs for nodes and schedulers depends on the configuration of your Slurm cluster. By default, the logs are stored in the following locations:

The Slurm controller logs are typically stored in `/var/log/slurm/slurmctld.log` on the controller node. The exact path may vary depending on your configuration. You can find the log file path by checking the `SlurmctldLogFile` parameter in the SLURM configuration file (usually `/etc/slurm/slurm.conf`).

Slurm Compute Node Logs:

The Slurm compute node logs are typically stored in `/var/log/slurm/slurmd.log` on each compute node. The exact path may vary depending on your configuration. You can find the log file path by checking the `SlurmdLogFile` parameter in the Slurm configuration file (usually `/etc/slurm/slurm.conf`).

To access the log files, you can log in to the controller or compute nodes via SSH and navigate to the appropriate log file paths. If you need to change the log file paths, you can do so by modifying the `SlurmctldLogFile` and `SlurmdLogFile` parameters in the Slurm configuration file.

## How do I submit jobs? (Slurm)

To submit jobs to Azure CycleCloud when using Slurm as the job scheduler, follow these steps:

1. Log in to your Azure CycleCloud instance.
1. Identify the cluster you want to submit the job to. You can view the list of your clusters on the main dashboard.
1. Connect to the head node (controller) of your Slurm cluster using SSH. 
1. Once connected to the head node, create a Slurm job script. The job script is a simple shell script that contains Slurm directives and the commands you want to execute in your job.
1. Submit the job using the `sbatch` command.
1. Monitor the status of your job using Slurm commands such as `squeue`, `sinfo`, or `sacct`. 
1. Once the job is complete, you can view the output in the specified output file (in this example, `my_job_output.txt`).
