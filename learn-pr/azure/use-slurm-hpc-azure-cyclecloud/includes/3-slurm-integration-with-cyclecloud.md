After completing this unit, you should be able to describe how Slurm integrates with Azure CycleCloud and describe key integration areas between Slurm and Azure CycleCloud.

## What is Azure CycleCloud?

Azure CycleCloud is a tool for deploying HPC clusters in Azure and managing their workloads. It offers a wide range of HPC capabilities, including:

- Template-based deployment of HPC clusters. Azure CycleCloud provides built-in customizable templates for deployment of the most common cluster schedulers, including Slurm, OpenPBS, LSF, Grid Engine, and HTCondor. Many other predefined templates, which you can import into your Azure CycleCloud instance, are available from the CycleCloud GitHub repository.
- Manual and automated scaling of cluster nodes. Azure CycleCloud allows for manual and automated horizontal scaling of managed clusters according to the length of job queues and governance policies. It also offers a REST API for developing autoscaling adapters for custom schedulers.
- Node configuration through cloud-init scripts. Azure CycleCloud supports configuration management based on custom scripts that run within managed cluster nodes before any other CycleCloud-specific configuration tasks.
- Management of the internal and external cluster storage. Azure CycleCloud allows you to configure cluster storage by provisioning, mounting, and formatting Azure managed disks and Network Attached Storage such as NFS servers or BeeGFS clusters.
- Monitoring, logging, and alerting. Azure CycleCloud offers built-in cluster monitoring and integrates with Azure Monitor. It's also possible to store log data from CycleCloud clusters to Log Analytics and create custom metrics dashboards. You can also create custom alerts and email notifications triggered by telemetry data. All Azure CycleCloud activities are logged.
- Authentication and authorization. Azure CycleCloud supports built-in local authentication. Alternatively, you can integrate it with Active Directory Domain Services (AD DS) or other Lightweight Directory Access Protocol (LDAP)-based identity providers. By default, the locally defined users have access to the operating system on the managed cluster nodes, but it's possible to administer cluster users separately. For management of resources in an Azure subscription, you can use an Azure Active Directory (Azure AD) service principal or managed identity.
- Near real-time cost reporting and controls. Azure CycleCloud tracks cluster usage and estimates the corresponding cost. This feature allows you to set up budget alerts triggered when the cluster cost exceeds the monetary amount you specified. Azure CycleCloud also integrates with Microsoft Cost Management.

## Azure CycleCloud and Azure Batch

Azure CycleCloud and Azure Batch are Azure services designed to manage and run large-scale parallel and high-performance computing workloads in the cloud. These services differ in their target audiences, feature sets, and use cases.

Azure CycleCloud is focused on creating, managing, and optimizing HPC and HTC clusters in Azure. CycleCloud targets domain-specific HPC and HTC workloads, such as computational fluid dynamics, genomics, and engineering simulations. CycleCloud supports various cluster schedulers like Slurm, Grid Engine, LSF, and HTCondor. It also integrates with Azure services like Azure Blob Storage, Azure Managed Disks, and Azure NetApp Files for storage solutions.

Azure Batch is a managed service designed for running large-scale parallel and batch processing workloads in Azure. Azure Batch is suitable for various types of batch processing tasks, such as data processing, rendering, and machine learning model training. Azure Batch takes care of managing resources, scheduling tasks, and scaling compute nodes based on the workload requirements.

Azure CycleCloud is specifically designed for HPC and HTC workloads with support for multiple cluster schedulers, while Azure Batch is more general-purpose, supporting various types of parallel and batch processing tasks. 

## Understanding HPC and HTC partitions

An Azure CycleCloud partition is a logical grouping of compute nodes with a specific configuration, purpose, or workload type. The terms "HPC partition" and "HTC partition" refer to partitions configured to handle High-Performance Computing and High-Throughput Computing workloads.

HPC partitions uses a large number of CPU or GPU-based virtual machines to perform complex tasks. HTC is an architecture that uses many computing resources over long periods of time to accomplish a large number of loosely-coupled tasks. You use HPC partitions when you need to perform large and complex computations such as those involved in scientific and engineering simulations.

HTC partitions uses a large number of CPU or GPU-based virtual machine nodes to solve complex mathematical tasks that require tight coupling and fast communication. HTC jobs are typically independent, sequential, and can be scheduled on different computing resources across multiple sites. HPC jobs are typically parallel, interdependent, and need to run on a single site with low-latency interconnects.  HTC is appropriate for processing large volumes of smaller tasks and is good for batch processing data-intensive tasks that can be broken up into small elements. Batch processing in HTC allows for the processing of large amounts of data or computational tasks by dividing them into smaller, manageable groups known as "batches". Clusters process these batches in parallel by allocating each batch to a different node in the compute cluster.

In cloud based environments such as Azure CycleCloud, HTC and HPC can run on the same cluster architecture.

## Implementing Azure CycleCloud

CycleCloud is implemented as a Linux-based web application, which you can install in any location from which you can access your Azure environment. The simplest way to set it up is by deploying an Azure VM by using the corresponding Azure Marketplace image, with the option of automating the deployment by using an Azure Resource Manager (ARM) template. Alternatively, you can use yum or apt packages, or a container image available from the Microsoft's Container Registry.

During the initial configuration, you have the option to provide an SSH key to secure access to the operating system hosting the CycleCloud application and to the subsequently deployed cluster nodes. To enable the CycleCloud application to interact with ARM, you'll need to choose an Azure AD identity that will provide security context for this interaction and assign to it sufficient permissions in the target Azure subscription by using Azure role-based access control (RBAC). This identity can take the form of a service principal, or if hosting the Azure CycleCloud application on an Azure VM, a managed identity.

An Azure CycleCloud instance also requires an Azure storage account and an accompanying blob container. This container, referred to as a "locker", provides the staging area for the deployment of projects to cluster nodes.

Once installed, the Azure CycleCloud application provides a graphical user interface that allows a user to manage and monitor HPC systems and a command-line interface (CLI) that facilitates automation and integration of CycleCloud into existing workflows. You can also use CLI to import templates, automate cluster provisioning, and perform more advanced management tasks.

## Understanding CycleCloud cluster autoscaling

Azure CycleCloud facilitates deployment of schedulers in Azure, which in turn, distribute and manage jobs running on clusters composed of Azure resources. Azure CycleCloud doesn't function as a scheduler. Instead, it functions as an intermediary between schedulers and the underlying platform. Azure CycleCloud also simplifies development of autoscaling functionality for the corresponding schedulers by providing a REST API-based programming interface and a Python-based client library.

Azure CycleCloud allows you to correlate the autoscaling behavior of managed clusters with the length of the cluster job queues. You can further customize this behavior by defining template parameters that control, for example, the amount of time after which idle nodes are terminated or the frequency of autostop checks.

All of the built-in templates expose the autoscaling settings directly in the Azure CycleCloud graphical interface. In each case, the settings include the option to specify the lower and upper limits of the autoscaling range, expressed in the number of CPU cores. The upper limit helps you to minimize the possibility of unanticipated charges. You can further mitigate this risk by setting budget alerts.

With the lower threshold set to 0, creating a cluster will result in provisioning of the scheduler head node only. However, when the scheduler detects queued jobs, it initiates provisioning of the compute nodes that are necessary to execute the corresponding workload, up to the limit you defined. To support loosely coupled or parallel jobs, where individual tasks execute independently of each other, jobs will start running as soon as the first node becomes available. For tightly coupled jobs, such as those using the Message Passing Interface (MPI) functionality, the wait time will be longer, depending on the extent of internode dependencies. After the job queue has been empty for the amount of time exceeding the allowed idle time, the compute nodes will begin to autostop and your cluster will once again consist of the scheduler head node only.

## Slurm Integration with CycleCloud

You can integrate Slurm with Azure CycleCloud by setting up a Slurm-based cluster in CycleCloud, where CycleCloud manages the underlying infrastructure and Slurm takes care of job scheduling and resource management.

Slurm integrates with Azure CycleCloud in the following manner:

- Cluster Configuration. When creating a new cluster in Azure CycleCloud, you can choose Slurm as the cluster scheduler. This means that CycleCloud will configure the cluster resources (for example, VMs, storage, networking) and deploy the Slurm scheduler on the master node (or controller node) of the cluster.
- Cluster Deployment. Azure CycleCloud deploys the Slurm cluster in Azure, creating the necessary VMs for the master node and compute nodes. The master node runs the Slurm controller daemon (slurmctld), and the compute nodes run the Slurm daemon (slurmd) responsible for executing jobs. CycleCloud sets up the network and storage resources and configures the Slurm cluster according to the specified settings.
- Autoscaling. Azure CycleCloud can dynamically scale Slurm clusters by adding or removing compute nodes based on the workload requirements and defined autoscaling policies. This helps optimize resource usage and control costs. When new jobs are submitted, and resources are insufficient, CycleCloud can automatically provision additional compute nodes and add them to the Slurm cluster. Similarly, when the workload decreases, CycleCloud can automatically remove idle compute nodes to save costs.
- Monitoring and Management. Azure CycleCloud provides monitoring and management features for the Slurm cluster, such as tracking cluster performance, resource usage, and job status. You can also manage the cluster lifecycle, start/stop the cluster, and apply updates as needed.
- Job Submission. You can submit jobs to the Slurm cluster using standard Slurm commands like sbatch, srun, and salloc. These jobs are then scheduled and executed on the Azure VMs that comprise the compute nodes of the Slurm cluster.
