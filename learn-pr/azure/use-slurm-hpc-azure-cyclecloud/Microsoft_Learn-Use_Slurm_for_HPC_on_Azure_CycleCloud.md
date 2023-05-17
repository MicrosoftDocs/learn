<span class="smallcaps">Skill Level: Beginner</span>

<span class="smallcaps">Role: Administrator</span>

<span class="smallcaps">Solution-Architect</span>

<span class="smallcaps">Product: azure-cyclecloud</span>

| Title of release branch | NEW-slurm-hpc-azure-cyclecloud                 |
|-------------------------|------------------------------------------------|
| New folder name         | /learn-pr/azure/use-slurm-hpc-azure-cyclecloud |

# Module metadata (index.yml) 

<table>
<colgroup>
<col style="width: 32%" />
<col style="width: 67%" />
</colgroup>
<thead>
<tr class="header">
<th>title</th>
<th>(<a
href="https://review.learn.microsoft.com/en-us/help/learn/id-guidance-title?branch=main">further
instructions</a>, if you need it)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>metadata:</td>
<td></td>
</tr>
<tr class="even">
<td>title</td>
<td>Use Slurm for HPC on Azure CycleCloud</td>
</tr>
<tr class="odd">
<td>description</td>
<td>Learn how to use the Slurm job scheduler with Azure CycleCloud.</td>
</tr>
<tr class="even">
<td>ms.date</td>
<td></td>
</tr>
<tr class="odd">
<td>author</td>
<td>Orin-Thomas</td>
</tr>
<tr class="even">
<td>ms.author</td>
<td>orthomas</td>
</tr>
<tr class="odd">
<td>ms.topic</td>
<td>Interactive-tutorial</td>
</tr>
<tr class="even">
<td>ms.prod</td>
<td>Azure-cyclecloud</td>
</tr>
<tr class="odd">
<td>summary</td>
<td>This module helps you understand how to use SLURM to manage HPC jobs
running with Azure CycleCloud and how to troubleshoot common
issues.</td>
</tr>
<tr class="even">
<td>Abstract (learning objectives)</td>
<td><p>By the end of this module you’ll be able to:</p>
<ul>
<li><p>Describe the Slurm job scheduler and resource manager. </p></li>
<li><p>Understand how Slurm integrates with Azure CycleCloud. </p></li>
<li><p>Troubleshoot common problems for Slurm-managed jobs that run in
Azure CycleCloud.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td>prerequisites</td>
<td><ul>
<li><p>Basic understanding of Azure CycleCloud at the beginner
level </p></li>
<li><p>Basic understanding of HPC job management at the beginner
level </p></li>
</ul></td>
</tr>
<tr class="even">
<td>iconUrl (if badge is ready; if not, then use the generic on the
right)</td>
<td>/training/achievements/generic-badge.svg</td>
</tr>
<tr class="odd">
<td>ratingEnabled</td>
<td>false</td>
</tr>
<tr class="even">
<td>levels</td>
<td>beginner</td>
</tr>
<tr class="odd">
<td>roles</td>
<td><p><span class="smallcaps">ADMINISTRATOR</span></p>
<p><span class="smallcaps">SOLUTION-ARCHITECT</span></p></td>
</tr>
<tr class="even">
<td>products</td>
<td><span class="smallcaps">AZURE-CYCLECLOUD</span></td>
</tr>
</tbody>
</table>

# Unit 1: Introduction 

# Metadata (unit.yml)

| title                                   | Introduction                                                                |
|-----------------------------------------|-----------------------------------------------------------------------------|
| metadata:                               |                                                                             |
| title                                   | Introduction                                                                |
| description                             | This content is part of the “Use Slurm for HPC on Azure CycleCloud” module. |
| ms.date                                 |                                                                             |
| author                                  | Orin-Thomas                                                                 |
| ms.author                               | orthomas                                                                    |
| ms.topic                                | Interactive-tutorial                                                        |
| ms.prod                                 | Azure-cyclecloud                                                            |
| durationInMinutes (use your best guess) | 3                                                                           |

You are an IT operations professional at Contoso, an organization which
helps client organizations deploy and operate high performance computing
(HPC) technologies. Recent projects include economic forecasting,
financial services, industrial design and, artificial intelligence.
Contoso relies heavily on Slurm (Simple Linux Utility for Resource
Management) as a job scheduler and resource manager for the Linux HPC
clusters on which these projects run. As their existing hardware ages
and requires replacement, Contoso is exploring the feasibility of moving
some of their HPC workloads into Azure using the Azure CycleCloud HPC
management platform. As an IT professional responsible for managing
Contoso’s HPC technologies, you are interested in understanding how you
can integrate Slurm with Azure CycleCloud to meet your organization’s
HPC computing project needs.

### Learning objectives

By the end of this module, you’ll be able to describe the following:

- Describe the Slurm job scheduler and resource manager

- Understand how Slurm integrates with Azure CycleCloud.

- Troubleshoot common problems for Slurm-managed jobs that run in Azure
  CycleCloud.

### Prerequisites

For the best learning experience from this module, you should already
have the following knowledge and experience:

- Basic understanding of Azure CycleCloud

- Basic understanding of HPC job management

# Unit 2: Describe cluster scheduler concepts

# Metadata (unit.yml)

| title             | Describe cluster scheduler concepts                                         |
|-------------------|-----------------------------------------------------------------------------|
| metadata:         |                                                                             |
| title             | Describe cluster scheduler concepts                                         |
| description       | This content is part of the “Use Slurm for HPC on Azure CycleCloud” module. |
| ms.date           |                                                                             |
| author            | Orin-Thomas                                                                 |
| ms.author         | orthomas                                                                    |
| ms.topic          | Interactive-tutorial                                                        |
| ms.prod           | Azure-cyclecloud                                                            |
| durationInMinutes | 7                                                                           |

After completing this unit, you should be able to describe the basic
functions of job schedulers, resource managers, high performance
computing and high throughput computing.

### Job schedulers

A cluster computing job scheduler is a software component that manages
and assigns computing resources (such as CPUs, memory, and disk) to the
jobs submitted to the cluster. Job schedulers determine the most
appropriate nodes in the cluster to run a particular job based on the
availability of resources, the job's priority, and other factors. Job
schedulers ensure that multiple jobs running in parallel do not
interfere with each other. Job schedulers include queues for holding
pending jobs and a policy for scheduling them.

A job scheduler's main goals are to:

- Minimize the time between the job submission and finishing the job,

- optimize CPU utilization

- maximize the job throughput.

Users submit non-interactive batch jobs to the scheduler. The scheduler
stores the batch jobs, evaluate their resource requirements and
priorities, and distributes the jobs to suitable compute nodes.

The job script submitted through the scheduler will add the job to a job
queue. Depending on the available resources the job needs, the scheduler
will decide when the job will leave the queue, and on which of the
back-end nodes it will run.

There are several basic strategies that schedulers can use to determine
which job to run next:

- First Come, First Serve Jobs are run in the exact same order in which
  they first enter the queue. The advantage is that every job will
  definitely be run, however, only small set of jobs might wait for an
  inadequately long time compared to their actual execution time.

- Shortest Job First Based on the execution, time declared in the job
  script, the scheduler estimates the job execution time. The jobs are
  ranked in the ascending order of the execution time. While short jobs
  will start after a short waiting time, long running jobs (or at least
  jobs declared as such) might never actually start.

- Backfilling: Scheduler maintains the concept of First Come, First
  Serve without preventing long running jobs to execute. The scheduler
  runs the job only when the first job in the queue can be executed. If
  otherwise, the scheduler goes through the rest of the queue to check
  whether another job can be executed without extending the waiting time
  of the first job in queue. If it finds such a job, the scheduler runs
  that job. Small jobs will usually encounter short queue times.

### Resource manager

A cluster computing resource manager allocates resources within a
computing cluster. Resource managers are responsible for allocating
memory, CPU, storage, and network bandwidth to the jobs running in the
cluster. This component monitors the usage of resources within the
cluster, detects any idle or underutilized resources, and reallocates
them to other jobs or tasks that require them.

### Slurm overview

Slurm is an open-source job scheduler and resource manager for running
workloads on Linux clusters. Slurm provides an extensible framework for
managing resources and scheduling jobs in a Linux cluster environment.
It supports a wide range of job types, including parallel jobs, batch
jobs, and interactive jobs. Slurm allows users to submit jobs through a
variety of interfaces, including a command-line interface, web-based
interface, and API. Slurm is a popular solution used by many of the most
powerful supercomputers and compute clusters and is available as an
option when using High Performance Computing (HPC) on Microsoft Azure.

Slurm allows you to match appropriate compute resource based on resource
criteria including CPUs, GPUs, and memory.

The Slurm job scheduler has the following important functions:

- Allocates access to compute nodes in high performance computing HPC
  clusters to users so that their tasks can be executed.

- Provides a framework for starting, executing, and monitoring work on a
  set of allocated nodes.

- Arbitrates contention for resources by managing a queue of pending
  jobs.

### Slurm jobs

When you use Slurm to run a job on a Linux HPC cluster, the following
high level steps occur:

1.  Job submission. The first step is that a user will submit a job to
    the Slurm scheduler through the creation of a job script that
    includes resource requirements and the set of commands required by
    the job.

2.  Job allocation. The next stage involves the Slurm scheduler
    examining the job's resource requirements, such as the number of
    nodes, CPUs, and memory needed, as well as any other constraints
    like partition and time limits. Based on these requirements, the
    scheduler determines the best available resources to allocate for
    the job, considering the current cluster usage and other pending
    jobs.

3.  Job queuing. The scheduler determines if the requested resources are
    available. If the resources are immediately available, the job
    executes. If the requested resources are not available immediately,
    the job is placed in a queue. The scheduler continuously evaluates
    the queued jobs and their priorities to allocate resources as they
    become available.

4.  Job execution. Once the required resources are allocated to the job,
    the Slurm job starts executing on the assigned nodes. Tasks
    specified in the script run on nodes.

5.  Job completion. The final step is job completion in which compute
    resources are released back to the cluster, and the scheduler
    updates the job's status to 'completed'. Job output and any error
    messages that may have been generated during job execution will be
    saved to designated output files.

6.  Job accounting and reporting. Slurm generates accounting data about
    completed jobs including resource usage and execution time.

### Slurm Commands

You use a set of command line utilities to perform actions on a compute
cluster managed through Slurm. Some common Slurm user commands are
listed in the table below.

| Command  | Function                                                                                                                                                                                                                  |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| sacct    | Reports job and job step accounting information about jobs that are active or completed.                                                                                                                                  |
| salloc   | Use to allocate resources for a job in real time. Allows you to spawn a shell and enact srun commands as a way of initiating parallel tasks.                                                                              |
| sattach  | Attach standard input, output and error signal capabilities to a currently running job or job step.                                                                                                                       |
| sbatch   | Use this to submit a job script for later execution. These scripts generally include one or more srun commands to initiate parallel tasks.                                                                                |
| scancel  | Use this to transfer a file on nodes needed                                                                                                                                                                               |
| scontrol | Slurm administrative tool that allows you to view and modify the Slurm state. Most scontrol commands require root privileges.                                                                                             |
| Sinfo    | Displays information on partitions and nodes managed by Slurm.                                                                                                                                                            |
| Sprio    | View information on the components impacting a job’s priority.                                                                                                                                                            |
| squeue   | View the state of jobs or job steps.                                                                                                                                                                                      |
| Srun     | Use this command to submit a job for execution or to trigger job steps in real time. You can use srun to specify resource requirements such as minimum and maximum node count, processor count, and node characteristics. |
| Sstat    | View information about resources utilized by running jobs or job steps.                                                                                                                                                   |
| strigger | Configure or view event triggers such as what to do when a node fails or a job approaches a time limit.                                                                                                                   |
| Sview    | View state information on jobs, partitions, and nodes managed by Slurm                                                                                                                                                    |

You can learn more about Slurm commands at:
https://slurm.schedmd.com/quickstart.html

# Unit 3: Describe Slurm integration with Azure CycleCloud

# Metadata (unit.yml)

| title             | Describe Slurm integration with Azure CycleCloud                            |
|-------------------|-----------------------------------------------------------------------------|
| metadata:         |                                                                             |
| title             | Describe Slurm integration with Azure CycleCloud                            |
| description       | This content is part of the “Use Slurm for HPC on Azure CycleCloud” module. |
| ms.date           |                                                                             |
| author            | Orin-Thomas                                                                 |
| ms.author         | orthomas                                                                    |
| ms.topic          | Interactive-tutorial                                                        |
| ms.prod           | Azure-cyclecloud                                                            |
| durationInMinutes | 10                                                                          |

After completing this unit, you should be able to describe how Slurm
integrates with Azure CycleCloud and describe key integration areas
between Slurm and Azure CycleCloud.

### What is Azure CycleCloud?

Azure CycleCloud is a tool for deploying HPC clusters in Azure and
managing their workloads. It offers a wide range of HPC capabilities,
including:

- Template-based deployment of HPC clusters. Azure CycleCloud provides
  built-in customizable templates for deployment of the most common
  cluster schedulers, including Slurm, OpenPBS, LSF, Grid Engine, and
  HTCondor. Many other predefined templates, which you can import into
  your Azure CycleCloud instance, are available from the CycleCloud
  GitHub repository.

- Manual and automated scaling of cluster nodes. Azure CycleCloud allows
  for manual and automated horizontal scaling of managed clusters
  according to the length of job queues and governance policies. It also
  offers a REST API for developing autoscaling adapters for custom
  schedulers.

- Node configuration through cloud-init scripts. Azure CycleCloud
  supports configuration management based on custom scripts that run
  within managed cluster nodes before any other CycleCloud-specific
  configuration tasks.

- Management of the internal and external cluster storage. Azure
  CycleCloud allows you to configure cluster storage by provisioning,
  mounting, and formatting Azure managed disks and Network Attached
  Storage such as NFS servers or BeeGFS clusters.

- Monitoring, logging, and alerting. Azure CycleCloud offers built-in
  cluster monitoring and integrates with Azure Monitor. It's also
  possible to store log data from CycleCloud clusters to Log Analytics
  and create custom metrics dashboards. You can also create custom
  alerts and email notifications triggered by telemetry data. All Azure
  CycleCloud activities are logged.

- Authentication and authorization. Azure CycleCloud supports built-in
  local authentication. Alternatively, you can integrate it with Active
  Directory Domain Services (AD DS) or other Lightweight Directory
  Access Protocol (LDAP)-based identity providers. By default, the
  locally defined users have access to the operating system on the
  managed cluster nodes, but it's possible to administer cluster users
  separately. For management of resources in an Azure subscription, you
  can use an Azure Active Directory (Azure AD) service principal or
  managed identity.

- Near-real time cost reporting and controls. Azure CycleCloud tracks
  cluster usage and estimates the corresponding cost. This feature
  allows you to set up budget alerts triggered when the cluster cost
  exceeds the monetary amount you specified. Azure CycleCloud also
  integrates with Microsoft Cost Management.

### Azure CycleCloud and Azure Batch

Azure CycleCloud and Azure Batch are Azure services designed to manage
and run large-scale parallel and high-performance computing workloads in
the cloud. These services differ in their target audiences, feature
sets, and use cases.

Azure CycleCloud is focused on creating, managing, and optimizing HPC
and HTC clusters in Azure. CycleCloud targets domain-specific HPC and
HTC workloads, such as computational fluid dynamics, genomics, and
engineering simulations. CycleCloud supports various cluster schedulers
like Slurm, Grid Engine, LSF, and HTCondor. It also integrates with
Azure services like Azure Blob Storage, Azure Managed Disks, and Azure
NetApp Files for storage solutions.

Azure Batch is a managed service designed for running large-scale
parallel and batch processing workloads in Azure. Azure Batch is
suitable for various types of batch processing tasks, such as data
processing, rendering, and machine learning model training. Azure Batch
takes care of managing resources, scheduling tasks, and scaling compute
nodes based on the workload requirements.

Azure CycleCloud is specifically designed for HPC and HTC workloads with
support for multiple cluster schedulers, while Azure Batch is more
general-purpose, supporting various types of parallel and batch
processing tasks.

### Understanding HPC and HTC partitions.

An Azure CycleCloud partition is a logical grouping of compute nodes
with a specific configuration, purpose, or workload type. The terms "HPC
partition" and "HTC partition" refer to partitions configured to handle
High-Performance Computing and High-Throughput Computing workloads.

HPC partitions uses a large number of CPU or GPU-based virtual machines
to perform complex tasks. HTC is an architecture that uses many
computing resources over long periods of time to accomplish a large
number of loosely-coupled tasks. You use HPC partitions when you need to
perform large and complex computations such as those involved in
scientific and engineering simulations.

HTC partitions uses a large number of CPU or GPU-based virtual machine
nodes to solve complex mathematical tasks that require tight coupling
and fast communication. HTC jobs are typically independent, sequential,
and can be scheduled on different computing resources across multiple
sites. HPC jobs are typically parallel, interdependent, and need to run
on a single site with low-latency interconnects. HTC is appropriate for
processing large volumes of smaller tasks and is good for batch
processing data-intensive tasks that can be broken up into small
elements. Batch processing in HTC allows for the processing of large
amounts of data or computational tasks by dividing them into smaller,
manageable groups known as "batches". Clusters process these batches in
parallel by allocating each batch to a different node in the compute
cluster.

In cloud based environments such as Azure CycleCloud, HTC and HPC can
run on the same cluster architecture.

### Implementing Azure CycleCloud

CycleCloud is implemented as a Linux-based web application, which you
can install in any location from which you can access your Azure
environment. The simplest way to set it up is by deploying an Azure VM
by using the corresponding Azure Marketplace image, with the option of
automating the deployment by using an Azure Resource Manager (ARM)
template. Alternatively, you can use yum or apt packages, or a container
image available from the Microsoft's Container Registry.

During the initial configuration, you'll have the option to provide an
SSH key to secure access to the operating system hosting the CycleCloud
application and to the subsequently deployed cluster nodes. To enable
the CycleCloud application to interact with ARM, you'll need to choose
an Azure AD identity that will provide security context for this
interaction and assign to it sufficient permissions in the target Azure
subscription by using Azure role-based access control (RBAC). This
identity can take the form of a service principal, or if hosting the
Azure CycleCloud application on an Azure VM, a managed identity.

An Azure CycleCloud instance also requires an Azure storage account and
an accompanying blob container. This container, referred to as a
"locker", provides the staging area for the deployment of projects to
cluster nodes.

Once installed, the Azure CycleCloud application provides a graphical
user interface that allows a user to manage and monitor HPC systems and
a command-line interface (CLI) that facilitates automation and
integration of CycleCloud into existing workflows. You can also use CLI
to import templates, automate cluster provisioning, and perform more
advanced management tasks.

### Understanding CycleCloud cluster autoscaling.

Azure CycleCloud facilitates deployment of schedulers in Azure, which in
turn, distribute and manage jobs running on clusters composed of Azure
resources. Azure CycleCloud doesn't function as a scheduler. Instead, it
functions as an intermediary between schedulers and the underlying
platform. Azure CycleCloud also simplifies development of autoscaling
functionality for the corresponding schedulers by providing a REST
API-based programming interface and a Python-based client library.

Azure CycleCloud allows you to correlate the autoscaling behavior of
managed clusters with the length of the cluster job queues. You can
further customize this behavior by defining template parameters that
control, for example, the amount of time after which idle nodes are
terminated or the frequency of autostop checks.

All of the built-in templates expose the autoscaling settings directly
in the Azure CycleCloud graphical interface. In each case, the settings
include the option to specify the lower and upper limits of the
autoscaling range, expressed in the number of CPU cores. The upper limit
helps you to minimize the possibility of unanticipated charges. You can
further mitigate this risk by setting budget alerts.

With the lower threshold set to 0, creating a cluster will result in
provisioning of the scheduler head node only. However, when the
scheduler detects queued jobs, it will initiate provisioning of the
compute nodes that are necessary to execute the corresponding workload,
up to the limit you defined. To support loosely coupled or parallel
jobs, where individual tasks execute independently of each other, jobs
will start running as soon as the first node becomes available. For
tightly coupled jobs, such as those using the Message Passing Interface
(MPI) functionality, the wait time will be longer, depending on the
extent of internode dependencies. After the job queue has been empty for
the amount of time exceeding the allowed idle time, the compute nodes
will begin to autostop and your cluster will once again consist of the
scheduler head node only.

### Slurm Integration with CycleCloud

You can integrate Slurm with Azure CycleCloud by setting up a
Slurm-based cluster in CycleCloud, where CycleCloud manages the
underlying infrastructure and Slurm takes care of job scheduling and
resource management.

Slurm integrates with Azure CycleCloud in the following manner:

- Cluster Configuration: When creating a new cluster in Azure
  CycleCloud, you can choose Slurm as the cluster scheduler. This means
  that CycleCloud will configure the cluster resources (e.g., VMs,
  storage, networking) and deploy the Slurm scheduler on the master node
  (or controller node) of the cluster.

- Cluster Deployment: Azure CycleCloud deploys the Slurm cluster in
  Azure, creating the necessary VMs for the master node and compute
  nodes. The master node runs the Slurm controller daemon (slurmctld),
  and the compute nodes run the Slurm daemon (slurmd) responsible for
  executing jobs. CycleCloud sets up the network and storage resources
  and configures the Slurm cluster according to the specified settings.

- Autoscaling: Azure CycleCloud can dynamically scale Slurm clusters by
  adding or removing compute nodes based on the workload requirements
  and defined autoscaling policies. This helps optimize resource usage
  and control costs. When new jobs are submitted, and resources are
  insufficient, CycleCloud can automatically provision additional
  compute nodes and add them to the Slurm cluster. Similarly, when the
  workload decreases, CycleCloud can automatically remove idle compute
  nodes to save costs.

- Monitoring and Management: Azure CycleCloud provides monitoring and
  management features for the Slurm cluster, such as tracking cluster
  performance, resource usage, and job status. You can also manage the
  cluster lifecycle, start/stop the cluster, and apply updates as
  needed.

- Job Submission: You can submit jobs to the Slurm cluster using
  standard Slurm commands like sbatch, srun, and salloc. These jobs are
  then scheduled and executed on the Azure VMs that comprise the compute
  nodes of the Slurm cluster.

# Unit 4: Describe how to run Slurm with Azure CycleCloud

# Metadata (unit.yml)

| title             | Describe how to run Slurm with Azure CycleCloud                             |
|-------------------|-----------------------------------------------------------------------------|
| metadata:         |                                                                             |
| title             | Describe how to run Slurm with Azure CycleCloud                             |
| description       | This content is part of the “Use Slurm for HPC on Azure CycleCloud” module. |
| ms.date           |                                                                             |
| author            | Orin-Thomas                                                                 |
| ms.author         | orthomas                                                                    |
| ms.topic          | Interactive-tutorial                                                        |
| ms.prod           | Azure-cyclecloud                                                            |
| durationInMinutes | 10                                                                          |

After completing this unit, you should be able to use Slurm on Azure
CycleCloud.

### Enabling Slurm on CycleCloud

You can deploy a HPC cluster using Azure CycleCloud by performing the
following steps:

1.  Connect to a deployed Azure CycleCloud Instance and authenticate.

2.  On the Create a New Cluster page, review the available options, and
    in the Schedulers section, select Slurm.

<img src="media/image1.png" style="width:9.45082in;height:6.33388in"
alt="A screenshot depicting the Create a New Cluster page of the Azure CycleCloud web application." />

3.  On the About tab of the New Slurm Cluster page, in the Cluster Name
    text box, provide a name for the Slurm cluster.

4.  On the Required Settings tab of the New Slurm Cluster page, in the
    Cluster Name text box, configure the following settings:

    - **Region.** This defines which datacenter will host cluster nodes.

    <!-- -->

    - **Scheduler VM Type.** Allows you to specify the VM SKU of the
      virtual machine that will host the job scheduler.

    - **HPC VM Type.** Allows you to specify the VM SKU of the virtual
      machine that will host HPC partition workloads.

    - **HTC VM Type.** Allows you to specify the VM SKU of the virtual
      machine that will host HTC partition workloads.

    - **Autoscale.** Allows you to enable or disable the starting and
      stopping of VM instances that host partition nodes when those
      nodes are required or no longer required.

    - **Max HPC Cores.** The maximum number of CPU cores that can be
      allocated to HPC partitions when autoscaling.

    - **Max HTC Cores.** The maximum number of CPU cores that can be
      allocated to HTC partitions when autoscaling.

    - **Max VMs per Scaleset.** Maximum number of VMs that can be used
      to host partition workloads.

    - **Use Spot Instances.** Whether you want to allow Azure spot
      instances to be used. Whilst spot instances are substantially
      cheaper to run, they can be removed without warning which can
      impact job execution.

    - **Subnet ID.** The Azure virtual network subnet that will host
      cluster node VMs.

<img src="media/image2.png" style="width:9.45082in;height:6.33388in"
alt="A screenshot depicting the Required Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." />

5.  On the Network Attached Storage page configure whether you will use
    the Builtin or External NFS options for the network attached storage
    mount. When you select **Builtin** the scheduler node will be
    configured as a NSF server that functions as the mountpoint for
    other nodes. If you specify External NFS you can then provide the
    details of a network attached storage device such as Azure Netapp
    Files, HPC Cache, or a specially configured VM running an NFS
    server.

6.  On the Advanced Settings page you can specify the following
    settings:

    - **Slurm Version.** The version of Slurm that will be used with the
      cluster.

    - **Job Accounting.** Whether you want to enable job accounting and
      the settings you will chose to store accounting data.

    - **Shutdown Policy.** You can chose between terminating the
      instance or deallocating the instance.

    - **Credentials.** The credentials used to connect to the associated
      Azure subscription.

    - **Scheduler OS.** Which Linux operating system is used to host the
      scheduler. The default is CentOS 8 but you can chose a custom
      image.

    - **HPC OS.** Which Linux operating system is used to host the
      scheduler. The default is CentOS 8 but you can chose a custom
      image.

    - **HTC OS.** Which Linux operating system is used to host the
      scheduler. The default is CentOS 8 but you can chose a custom
      image.

    - **Scheduler Cluster Init.** Custom instructions to apply to the
      scheduler VM.

    - **HTC Cluster Init.** Custom instructions to apply to HTC nodes.

    - **HPC Cluster Init.** Custom instructions to apply to HPC nodes.

    - **Advanced Networking.** Allows you to enable Return Proxy,
      whether the head node can be accessed from internet addresses and
      whether execute nodes can be accessed from the internet.

#### <img src="media/image3.png" style="width:17.46077in;height:12.58509in"
alt="A screenshot depicting the Advanced Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." />

7.  Cloud-init allows you to pass custom configuration settings to
    virtual machine nodes after they are deployed.

### Memory settings

CycleCloud automatically sets the amount of available memory for Slurm
to use for scheduling purposes. Because the amount of available memory
can change slightly due to different Linux kernel options, and the OS
and VM can use up a small amount of memory that would otherwise be
available for jobs, CycleCloud automatically reduces the amount of
memory in the Slurm configuration. By default, CycleCloud holds back 5%
of the reported available memory in a VM, but this value can be
overridden in the cluster template by setting slurm.dampen_memory to the
percentage of memory to hold back. For example, to hold back 20% of a
VM's memory:

slurm.dampen_memory=20

### Configuring Slurm Partitions

The default template that ships with Azure CycleCloud has two partitions
(hpc and htc), and you can define custom nodearrays that map directly to
Slurm partitions. For example, to create a GPU partition, add the
following section to your cluster template:

\[\[nodearray gpu\]\]

MachineType = \$GPUMachineType

ImageName = \$GPUImageName

MaxCoreCount = \$MaxGPUExecuteCoreCount

Interruptible = \$GPUUseLowPrio

AdditionalClusterInitSpecs = \$ExecuteClusterInitSpecs

\[\[\[configuration\]\]\]

slurm.autoscale = true

\# Set to true if nodes are used for tightly-coupled multi-node jobs

slurm.hpc = false

\[\[\[cluster-init cyclecloud/slurm:execute:2.0.1\]\]\]

\[\[\[network-interface eth0\]\]\]

AssociatePublicIpAddress = \$ExecuteNodesPublic

### Editing existing Slurm Clusters

If you modify and apply changes to an existing Slurm cluster, it is
necessary to rebuild the slurm.conf file and update the existing nodes
in the cluster. You can do this using a script that is present on Slurm
clusters deployed in Azure cyclecloud using a special script named
cyclecloud_slurm.sh that is located in the /opt/cycle/slurm directory on
the Slurm scheduler node. Once you’ve made any changes to the cluster,
run the following script as root with the apply_changes parameter. For
example:

/opt/cycle/slurm/cyclecloud_slurm.sh apply_changes

If you make changes that impact nodes that participate in a Message
Passing Interface (MPI) partition.

### Disabling Autoscale for nodes or partitions

You can disable autoscale for a running Slurm cluster by editing the
slurm.conf file directly. You can exclude either individual nodes or
entire partitions from being autoscaled.

To exclude a node or multiple nodes from autoscale, add
SuspendExcNodes=\<listofnodes\> to the Slurm configuration file. For
example, to exclude nodes 1 and 2 from the hpc partition, add the
following to /sched/slurm.conf and then restart the slurmctld service:

SuspendExcNodes=hpc-pg0-\[1-2\]

You exclude partitions from you also modify the /sched/slurm.conf file.
For example, to exclude the hpc partition from autoscale, add the
following line to slurm.conf and restart the slurmctld service.

SuspendExcParts=hpc

# Unit 5: Conduct common troubleshooting procedures

# Metadata (unit.yml) 

| title             | Conduct common troubleshooting procedures                                   |
|-------------------|-----------------------------------------------------------------------------|
| metadata:         |                                                                             |
| title             | Conduct common troubleshooting procedures                                   |
| description       | This content is part of the “Use Slurm for HPC on Azure CycleCloud” module. |
| ms.date           |                                                                             |
| author            | Orin-Thomas                                                                 |
| ms.author         | orthomas                                                                    |
| ms.topic          | Interactive-tutorial                                                        |
| ms.prod           | Azure-cyclecloud                                                            |
| durationInMinutes | 10                                                                          |

After completing this unit, you should be able to describe procedures
for common operational status checks and some common problems you may
encounter.

**What reasons might cause the job I submitted to Azure Cyclecloud to be
stuck in the pending (PD) state?**

A job in the PD (pending) state indicates that whilst a job has been
submitted, Cyclecloud has not yet found any available nodes to run the
job. This could be due to a number of reasons, such as insufficient
resources, incorrect job specifications, or node failures.

When configuring a job script, you must ensure that the resources
requested are within cluster’s limits. This is because the scheduler
kills the job once the time allocated is up, even if the job demands
more time or the job will be stuck in the queue forever if the job
demands more memory than what's available on the system.

**What steps can I take to determine whether nodes have been requested
for my Azure Cyclecloud job?**

You can use the Slurm squeue command to check for the status of jobs.

**What is the location of slurm logs for nodes/schedulers? (Slurm)**

In Azure CycleCloud, the location of Slurm logs for nodes and schedulers
depends on the configuration of your Slurm cluster. By default, the logs
are stored in the following locations:

The Slurm controller logs are typically stored in
\`/var/log/slurm/slurmctld.log\` on the controller node. The exact path
may vary depending on your configuration. You can find the log file path
by checking the \`SlurmctldLogFile\` parameter in the SLURM
configuration file (usually \`/etc/slurm/slurm.conf\`).

Slurm Compute Node Logs:

The Slurm compute node logs are typically stored in
\`/var/log/slurm/slurmd.log\` on each compute node. The exact path may
vary depending on your configuration. You can find the log file path by
checking the \`SlurmdLogFile\` parameter in the Slurm configuration file
(usually \`/etc/slurm/slurm.conf\`).

To access the log files, you can log in to the controller or compute
nodes via SSH and navigate to the appropriate log file paths. If you
need to change the log file paths, you can do so by modifying the
\`SlurmctldLogFile\` and \`SlurmdLogFile\` parameters in the Slurm
configuration file.

**How do I submit jobs? (Slurm) –**

To submit jobs to Azure CycleCloud when using Slurm as the job
scheduler, follow these steps:

1\. Log in to your Azure CycleCloud instance.

2\. Identify the cluster you want to submit the job to. You can view the
list of your clusters on the main dashboard.

3\. Connect to the head node (controller) of your Slurm cluster using
SSH.

4\. Once connected to the head node, create a Slurm job script. The job
script is a simple shell script that contains Slurm directives and the
commands you want to execute in your job.

5\. Submit the job using the \`sbatch\` command:

6\. Monitor the status of your job using Slurm commands such as
\`squeue\`, \`sinfo\`, or \`sacct\`. For example:

7\. Once the job is complete, you can view the output in the specified
output file (in this example, \`my_job_output.txt\`).

# Unit 6: Knowledge Check

# Metadata (unit.yml)

| title             | Knowledge check      |
|-------------------|----------------------|
| metadata:         |                      |
| title             | Knowledge check      |
| description       |                      |
| ms.date           |                      |
| author            | Orin-Thomas          |
| ms.author         | orthomas             |
| ms.topic          | Interactive-tutorial |
| ms.prod           | Azure-cyclecloud     |
| durationInMinutes | 4                    |

1\. Which command can you use to display information on jobs,
partitions, and nodes managed by Slurm?

A\) Sstat. \[Incorrect. View information about resources utilized by
running jobs or job steps.\]

B\) Sview. \[Correct. Sview allows you to view state information on
jobs, partitions, and nodes managed by Slurm

C\) Sinfo. \[Incorrect. Displays information on partitions and nodes
managed by Slurm.\]

D\) sbatch. \[Incorrect. Use this to submit a job script for later
execution. These scripts generally include one or more srun commands to
initiate parallel tasks.\]

2\. You have a job that has a large number of complex sequential steps
with each new step depending on calculations performed in the previous
step. Which type of Azure CycleCloud partition would be appropriate for
this job?

A\) HTC partition. \[Incorrect. HTC partitions are appropriate for
workloads that are largely independent of one another and where similar
tasks can be delegated across different cluster nodes.\]

B\) HPC partition. \[Correct. HPC partitions are appropriate for
workloads that have dependencies on prior steps and where the job
executes more quickly when greater resources are allocated to the job.\]

3\. Which of the following tools do you run after changing the Slurm
configuration to apply the changes to the Azure CycleCloud cluster?

A\) sinfo. \[Incorrect. Displays information on partitions and nodes
managed by Slurm.\]

B\) cyclecloud_slurm.sh. \[Correct. You use the cyclecloud_slurm.sh
script to apply changes after you have modified the Slurm
configuration.\]

C\) srun. \[Incorrect. Use this tool to run a job task.\]

D sbatch. \[Incorrect. Use this to submit a job script for later
execution. These scripts generally include one or more srun commands to
initiate parallel tasks.\]

# Unit 7: Summary 

# Metadata (unit.yml)

| title             | Summary                                                                     |
|-------------------|-----------------------------------------------------------------------------|
| metadata:         |                                                                             |
| title             | Summary                                                                     |
| description       | This content is part of the “Use Slurm for HPC on Azure CycleCloud” module. |
| ms.date           |                                                                             |
| author            | Orin-Thomas                                                                 |
| ms.author         | orthomas                                                                    |
| ms.topic          | Interactive-tutorial                                                        |
| ms.prod           | Azure-cyclecloud                                                            |
| durationInMinutes | 3                                                                           |

Slurm is a widely used job scheduler and resource manager for cluster
computing. You can use Slurm with Azure CycleCloud to get the benefit of
using a familiar tool to submit and manage cluster workloads executing
on cluster nodes whilst having Azure CycleCloud manage cluster node
deployment and termination.

#### Further learning links 

Slurm Support and Development <https://www.schedmd.com/>

Slurm on GitHub: <https://github.com/SchedMD/>

High Performance Computing:
<https://learn.microsoft.com/azure/architecture/topics/high-performance-computing>

What is Azure CycleCloudL
<https://learn.microsoft.com/en-us/azure/cyclecloud/overview?view=cyclecloud-8>

Azure CycleCloud on GitHub. https://github.com/Azure/cyclecloud-slurm

Learning Path: Run high-performance computing (HPC) applications on
Azure
https://learn.microsoft.com/en-us/training/paths/run-high-performance-computing-applications-azure/
