By the end of this unit, you should be able to describe procedures for common operational status checks and some common problems you may encounter.

## Why is my Slurm job pending?

`PD` means Slurm has queued the job but hasn't started it. It doesn't by itself indicate an Azure or CycleCloud failure. Check the scheduling reason before investigating provisioning. Causes include occupied resources, priority, dependencies, held jobs, future start times, partition restrictions, and account or quality-of-service (QOS) limits.

Request resources supported by the selected partition and permitted by your account. An impossible memory request can be rejected at submission; an accepted request might remain pending because resources are busy or a scheduling limit applies. Inspect the error or reason rather than assuming it'll wait forever.

Use Slurm's configured node memory when sizing requests, not just the VM's advertised memory. During execution, reaching the effective job time limit causes termination; exceeding an enforced memory limit can cause an out-of-memory failure. These are different from a job waiting for resources.

For more information, see the Slurm [job states](https://slurm.schedmd.com/job_state_codes.html), [pending reasons](https://slurm.schedmd.com/job_reason_codes.html), and [resource-request options](https://slurm.schedmd.com/sbatch.html).

## How do I trace a job's node-start request?

Run these commands on the cluster's Linux login node, or in an administrator-approved scheduler session. Replace `JOB_ID` with the submitted job's ID:

```bash
squeue -j JOB_ID -o "%.18i %.12T %R"
scontrol show job JOB_ID
sinfo -N -l
```

Use the output to trace the request through these checks:

1. Check the reason first. Priority, dependencies, and holds don't establish an Azure fault. Even `Resources` alone doesn't prove that a VM request was sent.
1. Examine node states. `~` denotes powered-down capacity; `#` denotes powering up or configuration. These are Slurm states, not confirmation of successful Azure allocation.
1. Correlate timestamps and node identifiers with the scheduler controller log and integration `resume.log`, `suspend.log`, and `autoscale.log`. In project 4.0.11, the resume-failure callback invokes `azslurm suspend`, so inspect `suspend.log` for its cleanup diagnostics.
1. In CycleCloud, inspect the cluster **Issues** view and the affected node's **Show Detail** status cards. Distinguish no eligible allocation or resume request, Azure allocation failure, VM initialization failure, and Slurm registration failure.
1. For allocation failures, inspect the actual error, node-array limits, regional and VM-family quotas, SKU availability, and capacity. For initialization failures, inspect `/opt/cycle/jetpack/logs/jetpack.log` and cluster-init logs on the affected node. A quota increase isn't a universal remedy and doesn't reserve capacity.

The [Slurm power-saving guide](https://slurm.schedmd.com/power_save.html) explains resume requests and node registration. Use [CycleCloud issue reporting](/azure/cyclecloud/how-to/report-issues) to examine infrastructure failures.

## Where are the Slurm logs?

Locate Slurm daemon logs from the installed cluster's configuration rather than assuming one universal directory. On a working cluster, inspect the effective settings:

```bash
scontrol show config | grep -E 'SlurmctldLogFile|SlurmdLogFile'
```

The standard CycleCloud Slurm project 4.0.11 configuration uses these locations:

| Component | Host | Configured path |
| --- | --- | --- |
| Slurm controller | Scheduler | `/var/log/slurmctld/slurmctld.log` |
| Slurm compute daemon | Affected compute node | `/var/log/slurmd/slurmd.log` |
| CycleCloud Slurm integration | Scheduler | `/opt/azurehpc/slurm/logs/autoscale.log`, `resume.log`, and `suspend.log` |

Custom templates and other project versions can differ. If the controller is unavailable, inspect its configured `slurm.conf`, usually `/etc/slurm/slurm.conf`, and included files directly. If file logging isn't configured, consult the configured system logging destination. Obtain administrator assistance if log access is restricted.

Changing log destinations isn't necessary to inspect diagnostics. Any deliberate change must use valid directories, ownership and permissions, and the appropriate administrative configuration procedure.

The tagged [daemon configuration](https://github.com/Azure/cyclecloud-slurm/blob/4.0.11/azure-slurm-install/templates/slurm.conf.template), [integration logging configuration](https://github.com/Azure/cyclecloud-slurm/blob/4.0.11/azure-slurm/conf/logging.conf), and [resume-failure callback](https://github.com/Azure/cyclecloud-slurm/blob/4.0.11/azure-slurm/sbin/resume_fail_program.sh) identify the different destinations. For CycleCloud application and node-configuration logs, see [log locations](/azure/cyclecloud/log-locations).

## What if the controller is unreachable or nodes are DOWN or DRAINED?

Run these read-only commands from the cluster login node or scheduler. Replace `NODE_NAME` with the affected node's name:

```bash
scontrol ping
sinfo -R
scontrol show node NODE_NAME
```

If the controller is unreachable, commands requiring it can fail; inspect scheduler services and logs directly. For DOWN or DRAINED nodes, investigate the recorded reason before changing their state. A powered-down elastic node isn't automatically faulty, and health checks can intentionally drain unhealthy nodes.

An authorized administrator checks the controller on the **scheduler**:

```bash
sudo systemctl --no-pager status slurmctld
```

Check the compute daemon on the **affected compute node**:

```bash
sudo systemctl --no-pager status slurmd
scontrol show slurmd
```

`scontrol show slurmd` reports the daemon on the host where it's run. Check the appropriate logs and, where indicated, name resolution and network reachability, authentication and service-identity consistency, or configured versus registered resources. Don't blindly restart services or mark nodes usable to hide the symptom.

For escalation, retain job and node identifiers, timestamps, state and reason output, and errors. An authorized administrator should capture logs as root on each affected node. Enter a root login shell and set a restrictive umask:

```bash
sudo -i
umask 077
```

Confirm that the current working directory is access-restricted, such as the root account's private home directory. The capture script writes its archive into that directory:

```bash
/opt/cycle/capture_logs.sh
exit
```

Review the archive for sensitive information before sharing it through an approved support channel. Exit the root shell after capture.

For more information, see [Slurm troubleshooting](https://slurm.schedmd.com/troubleshoot.html), [CycleCloud Slurm health checks and support capture](/azure/cyclecloud/slurm-4-operations), and the [capture script's output behavior](https://github.com/Azure/cyclecloud-slurm/blob/4.0.11/azure-slurm-install/capture_logs.sh).

## How do I submit and inspect a batch job?

Connect to the configured login node, or use the scheduler if the administrator permits. Work as a normal user in a writable shared directory mounted at the same path on the submission and HTC compute nodes. The mount path is site-specific; a locker or arbitrary local directory isn't sufficient.

Create `hello-slurm.sh` in that directory:

```bash
#!/bin/bash
#SBATCH --job-name=hello-slurm
#SBATCH --partition=htc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:05:00
#SBATCH --output=hello-slurm-%j.out

set -euo pipefail
srun hostname
```

Confirm that the HTC partition has room for a compute node and that quota and capacity are available. Supply your site's account or QOS options if required, then submit:

```bash
sbatch hello-slurm.sh
```

Record the returned job ID. Replace `JOB_ID` below with that number:

```bash
squeue -j JOB_ID
scontrol show job JOB_ID
sinfo -p htc
```

`squeue` shows queued or running jobs; `scontrol` shows details while the controller retains the record. Cold compute-node provisioning takes time, but the small test might finish before it appears in a subsequent queue listing. `sinfo` describes partition and node state, not the test job's success.

After execution finishes, inspect the explicitly named output file, again replacing `JOB_ID`:

```bash
cat hello-slurm-JOB_ID.out
```

The output should contain a compute-node hostname. `%j` in the script becomes the job ID; without an explicit output option, an ordinary batch job instead uses `slurm-<job-id>.out`.

> [!NOTE]
> Slurm transfers the batch script, not other application inputs or binaries. Keep required files accessible to compute nodes and preserve results before those nodes are removed.

If accounting is enabled and its storage is available, inspect job and step outcomes:

```bash
sacct -j JOB_ID --format=JobID,State,ExitCode,Reason
```

Check the state and exit code alongside output and error files. Distinguish successful completion from `FAILED`, `TIMEOUT`, `OUT_OF_MEMORY`, and `NODE_FAIL`. Without accounting, use the retained controller record and output/error files, and ask the administrator about historical records. An empty accounting result or disappearance from `squeue` isn't proof of success or proof that the job never ran.

If you need to cancel **your exercise job**, use:

```bash
scancel JOB_ID
```

This cancels the job; it doesn't copy files. Don't cancel another user's work during troubleshooting.

For more information, see [batch-script and output semantics](https://slurm.schedmd.com/sbatch.html), [job accounting reports](https://slurm.schedmd.com/sacct.html), and [CycleCloud accounting prerequisites](/azure/cyclecloud/slurm-4-operations#configure-slurm-job-accounting).
