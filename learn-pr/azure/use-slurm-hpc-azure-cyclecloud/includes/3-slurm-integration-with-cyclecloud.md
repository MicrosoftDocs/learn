By the end of this unit, you should be able to describe how Slurm integrates with Azure CycleCloud and describe key integration areas between Slurm and Azure CycleCloud.

## What's Azure CycleCloud?

Azure CycleCloud is a tool for deploying HPC clusters in Azure and managing their workloads. It offers a wide range of HPC capabilities, including:

- **Template-based deployment of HPC clusters**: Azure CycleCloud provides built-in, customizable templates deploying the most common cluster schedulers, including Slurm, OpenPBS, LSF, Grid Engine, and HTCondor. Many other predefined templates, which you can import into your Azure CycleCloud instance, are available from the CycleCloud GitHub repository.
- **Manual and automated scaling of cluster nodes**: Azure CycleCloud allows for manual and automated horizontal scaling of managed clusters according to scheduler demand and governance policies. It also offers a REST API for developing autoscaling adapters for custom schedulers.
- **Node configuration through cloud-init scripts**: Azure CycleCloud supports configuration management based on custom scripts that run within managed cluster nodes before any other CycleCloud-specific configuration tasks.
- **Managing the internal and external cluster storage**: Azure CycleCloud allows you to configure cluster storage by provisioning, mounting, and formatting Azure managed disks and Network Attached Storage such as NFS servers or BeeGFS clusters.
- **Monitoring, logging, and alerting**: Azure CycleCloud offers built-in cluster monitoring and integrates with Azure Monitor. It's also possible to store log data from CycleCloud clusters to Log Analytics and create custom metrics dashboards. You can also create custom alerts and email notifications triggered by telemetry data. All Azure CycleCloud activities are logged.
- **Authentication and authorization**: Azure CycleCloud supports built-in local authentication. Alternatively, you can integrate it with Active Directory Domain Services (AD DS) or other Lightweight Directory Access Protocol (LDAP)-based identity providers. Built-in node user management is enabled by default, but a locally defined CycleCloud account doesn't automatically grant SSH access. Node access requires separate per-user enablement, cluster authorization, and an SSH public key. You can disable built-in node user management and administer cluster users separately. For managing resources in an Azure subscription, you can use a Microsoft Entra service principal or managed identity.
- **Cost reporting and alerts**: Azure CycleCloud tracks cluster usage and estimates the corresponding cost. You can set up budget alerts when estimated cost exceeds a specified amount, and use Microsoft Cost Management to review billed costs. Estimates and alerts aren't hard spending caps: alerts don't stop instances, notification delivery isn't immediate, and Azure billing data can lag. For more information, see [Cost and usage](/azure/cyclecloud/concepts/usage-tracking?view=cyclecloud-8&preserve-view=true).

## Azure CycleCloud and Azure Batch

Azure CycleCloud and Azure Batch both support large-scale parallel and high-performance computing workloads in the cloud. These offerings differ in their scheduling and operating models.

Azure CycleCloud is focused on creating, managing, and optimizing HPC and HTC clusters in Azure. CycleCloud targets domain-specific HPC and HTC workloads, such as computational fluid dynamics, genomics, and engineering simulations. CycleCloud supports various cluster schedulers like Slurm, Grid Engine, LSF, and HTCondor. It also integrates with Azure services like Azure Blob Storage, Azure Managed Disks, and Azure NetApp Files for storage solutions.

Azure Batch is a managed service designed for running large-scale parallel and batch processing workloads in Azure. Azure Batch is suitable for various types of batch processing tasks, such as data processing, rendering, and machine learning model training. Azure Batch takes care of managing resources, scheduling tasks, and scaling compute nodes based on the workload requirements.

Use CycleCloud when you need to operate Slurm and preserve scheduler-specific scripts, policies, or integrations. Azure Batch provides scheduling through its own pools, jobs, tasks, and APIs; it can also run MPI workloads. Choose based on scheduler compatibility and the operating model, not just the application's industry or whether it uses parallel processing.

## Understanding HPC and HTC partitions

A Slurm partition groups compute nodes and defines scheduling policies. CycleCloud node arrays provide the Azure VM configuration for those nodes. Names such as `hpc` (high-performance computing) and `htc` (high-throughput computing) are template conventions, not mandatory categories built into Slurm.

The `hpc` partition is intended for appropriately configured tightly coupled workloads, such as multinode Message Passing Interface (MPI) simulations whose concurrent processes exchange data frequently. These workloads can benefit from low-latency interconnects and suitable placement.

The `htc` partition is intended for independent or loosely coupled tasks, such as separate rendering frames or parameter-sweep jobs. These tasks generally don't need specialized internode networking. Dependencies between sequential jobs don't, by themselves, make a workload tightly coupled.

Both workload types can run in one cluster using suitable partitions, VM types, and application software. CPU and GPU workloads can exhibit either communication pattern. For more information, see [Plan and size HPC clusters](/azure/cyclecloud/concepts/plan-and-size-hpc-clusters?view=cyclecloud-8&preserve-view=true).

## Implementing Azure CycleCloud

CycleCloud is implemented as a Linux-based web application, which you can install in any location from which you can access your Azure environment. The simplest way to set it up is by deploying an Azure VM by using the corresponding Azure Marketplace image, with the option of automating the deployment by using an Azure Resource Manager (ARM) template. Alternatively, you can use `yum` or `apt` packages, or a container image available from Microsoft's Container Registry. A container-hosted CycleCloud application requires persistent storage for its application and managed-cluster state; follow the [container deployment guidance](/azure/cyclecloud/how-to/run-in-container?view=cyclecloud-8&preserve-view=true#persistent-storage) before removing or replacing the container.

For a VM-hosted installation, configure SSH access to the CycleCloud application host. Configure cluster node access separately. To enable the CycleCloud application to interact with ARM, you'll need to choose a Microsoft Entra identity that'll provide security context for this interaction and assign it sufficient permissions in the target Azure subscription by using Azure role-based access control (RBAC). This identity can take the form of a service principal, or if you're hosting the Azure CycleCloud application on an Azure VM, a managed identity.

With built-in node user management, select **Enable node access for this user**, grant cluster node-access permission through ownership, sharing, or an applicable role, and configure the user's SSH public key. Enabling this setting alone doesn't grant authorization. Application administrative permissions and Azure deployment-identity permissions are separate from node-login authorization. For more information, see [Cluster user access](/azure/cyclecloud/how-to/user-access?view=cyclecloud-8&preserve-view=true).

An Azure CycleCloud instance also requires an Azure storage account and an accompanying blob container. This container, referred to as a *locker*, provides the staging area for deploying projects to cluster nodes.

> [!IMPORTANT]
> A locker distributes initialization projects; it isn't automatically a shared filesystem for application inputs and outputs. Slurm transfers the batch script, not all application binaries and data. Make those files available at consistent paths on compute nodes and write valuable output to shared or durable storage before nodes are removed.

Once installed, the Azure CycleCloud application provides a graphical user interface that allows a user to manage and monitor HPC systems and a command-line interface (CLI) that facilitates automating and integrating CycleCloud into existing workflows. You can also use the CLI to import templates, automate cluster provisioning, and perform more advanced management tasks.

> [!IMPORTANT]
> This module uses the Slurm project-4.x integration. Record the CycleCloud application version, Slurm project/template release, Slurm scheduler version, and node image; these are separate components. Use a compatible combination from the [selected project release](https://github.com/Azure/cyclecloud-slurm/releases). Updating the CycleCloud application doesn't upgrade existing cluster templates or node software. To adopt a newer Slurm template, [validate a replacement cluster before moving workloads](/azure/cyclecloud/how-to/migrate-slurm-cluster?view=cyclecloud-8&preserve-view=true). Reapplying configuration isn't a template upgrade.

## Understanding CycleCloud cluster autoscaling

Azure CycleCloud facilitates deploying schedulers in Azure, which in turn distribute and manage jobs running on clusters composed of Azure resources. Azure CycleCloud doesn't function as a scheduler. Instead, it functions as an intermediary between schedulers and the underlying platform. Azure CycleCloud also simplifies developing autoscaling functionality for the corresponding schedulers by providing a REST API-based programming interface and a Python-based client library.

Autoscaling responds to schedulable demand and configured limits, not just queue length. Settings depend on the scheduler and template version. Current stock Slurm templates use maximum node counts for the HPC, HTC, and GPU arrays; some other arrays or custom templates use core counts. `MaxCount` limits nodes, whereas `MaxCoreCount` limits cores. Initial-count settings control startup size rather than guaranteeing a continuously maintained minimum. Check the units displayed by your template. Configured limits and Azure quotas don't reserve Azure capacity.

With no initial compute nodes, a cluster starts its configured infrastructure, such as scheduler, login, and storage nodes. Slurm requests additional compute capacity for eligible allocations. Batch-script startup depends on the batch node and Slurm's waiting settings; each job step needs its requested resources before it can run. Independent single-node jobs can start as suitable nodes become ready.

Eligible idle compute nodes can be suspended after the configured idle interval, even if other jobs remain queued or running. Exclusions can retain idle compute nodes, and infrastructure nodes remain according to their configuration.

Scaling compute capacity to zero doesn't stop every cluster-related charge. Persistent disks, external storage, accounting databases, infrastructure nodes, and the CycleCloud application server can continue accruing charges. Review retained resources separately rather than relying on budget alerts to stop spending.

## Slurm Integration with CycleCloud

You can integrate Slurm with Azure CycleCloud by setting up a Slurm-based cluster in CycleCloud, where CycleCloud manages the underlying infrastructure and Slurm makes allocation and scheduling decisions. The CycleCloud application server and Slurm scheduler are separate components.

Slurm's suspend/resume integration requests compute-node operations, which the CycleCloud Slurm adapter translates into infrastructure operations.

Slurm integrates with Azure CycleCloud in the following manner:

- **Cluster Configuration**: When creating a new cluster in Azure CycleCloud, you can choose Slurm as the cluster scheduler. This means that CycleCloud configures the cluster resources (for example, VMs, storage, networking) and deploys the Slurm scheduler on the cluster's scheduler (or controller) node.
- **Cluster Deployment**: Azure CycleCloud deploys the Slurm cluster in Azure, creating the necessary VMs for the scheduler, configured infrastructure, and requested compute nodes. The scheduler node runs the Slurm controller daemon (`slurmctld`), and the compute nodes run the Slurm daemon (`slurmd`) responsible for executing jobs. A compute VM must finish provisioning and configuration and register with Slurm before its resources are usable.
- **Autoscaling**: For eligible allocations that need more capacity, Slurm requests additional compute nodes through the adapter. Slurm's idle-node suspension policy can remove eligible idle compute nodes to reduce compute costs. These operations remain subject to the configured limits and exclusions.
- **Monitoring and Management**: Use the CycleCloud UI and event/node details for provisioning status and cluster lifecycle management. Use `squeue`, `sinfo`, and `scontrol` for job, partition, and node information. Historical job reports require accounting. A VM running in Azure isn't proof that Slurm can schedule work on it.
- **Job Submission**: You can submit jobs to the Slurm cluster using standard Slurm commands like `sbatch`, `srun`, and `salloc`. These jobs are then scheduled and executed on the Azure VMs that comprise the compute nodes of the Slurm cluster.
