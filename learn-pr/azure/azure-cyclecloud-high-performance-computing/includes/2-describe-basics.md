Many organizations seek to transition their on-premises HPC workloads to Azure to benefit from its hyperscale capabilities. Yet, they also want to minimize the learning curve associated with such a transition and leverage the expertise tied to the existing deployments, tied typically to the choice of a specific HPC scheduler. At the same time, they expect visibility into the performance and cost of the cloud-based cluster resources, in the manner that parallels their on-premises environments.

Implementing a custom solution that addresses these needs would be far from trivial, requiring in-depth knowledge of Azure compute, networking, and storage resources that serve as building blocks of cloud-based HPC clusters. In addition, without a corresponding management interface, operating such a solution by relying on standard Azure management tools would result in significant administrative overhead.

Azure CycleCloud addresses these concerns, providing a simple, secure, and scalable way to implement HPC schedulers in Azure. In this unit, you will learn about its basic functionality.

> [!NOTE]
> Azure CycleCloud targets deployment scenarios which require the use of a specific HPC scheduler. This complements Azure Batch, which provides a Scheduler as a Service on Azure.

## What is Azure CycleCloud?

Azure CycleCloud is a tool for deploying HPC clusters in Azure and managing their workloads. It offers a wide range of HPC capabilities, including: 

- template-based deployment of HPC clusters. Azure CycleCloud provides built-in customizable templates for deployment of the most common cluster schedulers, including Slurm, PBSPro, LSF, Grid Engine, and HT-Condor. A number of other predefined templates, which you can import into your Azure CycleCloud instance, are available from the CycleCloud GitHub repository. 

   > [!NOTE]
   > Templates are INI-formatted files that use declarative syntax to describe how nodes are organized in a CycleCloud cluster, including their respective relationships. Templates contain references to projects, which define node configuration. 

- manual and automated scaling of cluster nodes. Azure CycleCloud allows for manual and automated horizontal scaling of managed clusters according to the length of job queues and governance policies. It also offers a REST API for developing autoscaling adapters for custom schedulers.
- node configuration through cloud-init scripts. Azure CycleCloud supports configuration management based on custom scripts that run within managed cluster nodes before any other CycleCloud specific configuration tasks.
- management of the cluster internal and external storage. Azure CycleCloud provides the ability to configure cluster storage by provisioning, mounting, and formatting Azure managed disks and Network Attached Storage such as NFS servers or BeeGFS clusters.
- monitoring, logging, and alerting. Azure CycleCloud offers built-in cluster monitoring and integrates with Azure Monitor. It's also possible to store log data from CycleCloud clusters to Log Analytics and create custom metrics dashboards. You also have the option to create custom alerts and email notifications triggered by telemetry data. All Azure CycleCloud activities are logged.
- authentication and authorization. Azure CycleCloud supports built-in local authentication. Alternatively, you can integrate it with Active Directory Domain Services (AD DS) or other LDAP-based identity providers. By default, the locally defined users have access to the operating system on the managed cluster nodes, but it is possible to administer cluster users separately. For management of resources in an Azure subscription, you can use an Azure Active Directory service principal or managed identity. 
- near-real time cost reporting and controls. Azure CycleCloud tracks cluster usage and estimates the corresponding cost. This allows you to set up budget alerts triggered when the cluster cost exceeds the monetary amount you specified. Azure CycleCloud also integrates with Azure Cost Management.

   > [!NOTE]
   > Slurm-based clusters support stopping and deallocate nodes as an alternative to terminating them during auto-stop.

## How do you implement and use Azure CycleCloud?

CycleCloud is implemented as a Linux-based web application, which you can install in any location from which you can access your Azure environment. The simplest way to set it up is by deploying an Azure VM by using the corresponding Azure Marketplace image, with the option of automating the deployment by using an Azure Resource Manager (ARM) template. Alternatively, you can use for this purpose yum or apt packages or a container image available from the Microsoft's Container Registry.

During the initial configuration, you will have the option to provide an SSH key to secure access to the operating system hosting the CycleCloud application and to the subsequently deployed cluster nodes. To enable the CycleCloud application to interact with ARM, you will also need to designate an Azure Active Directory (Azure AD) identity that will provide security context for this interaction and assign to it sufficient permissions in the target Azure subscription by using Azure Role Based Access Control (RBAC). This identity can take the form of a service principal or, if hosting the Azure CycleCloud application on an Azure VM, a managed identity. 

An Azure CycleCloud instance also requires an Azure storage account and an accompanying blob container. This container, referred to as a "locker", provides the staging area for deployment of projects to cluster nodes.

Once installed, the Azure CycleCloud application provides a graphical user interface that allows a user to manage and monitor HPC systems as well as a command line interface (CLI) that facilitates automation and integration of CycleCloud into existing workflows. You can also use CLI to import templates, automate cluster provisioning, and perform more advanced management tasks. 

:::image type="content" source="../media/u2-cyclecloud-gui.png" alt-text="The screenshot depicts the graphical interface of the Azure CycleCloud web application." border="false":::


## What is the architecture of Azure CycleCloud?

Azure CycleCloud provides a layer of abstraction above ARM, minimizing the need for its users to deal directly with Azure compute and storage resources. Its role is to translate scheduler-level configurations accessible via its graphical interface or CLI into ARM API calls that interact with Azure VMs and Azure VM scale sets in user-defined virtual networks and subnets. These calls additionally take into account such considerations as regional vCPU quotas, cluster size limits, and constraints of InfiniBand network topology. They also facilitate optimizing cluster performance by leveraging such constructs as proximity placement groups or connecting cluster nodes to the same Infiniband switch.

> [!NOTE]
> A proximity placement group enables collocating Azure VMs close to each other, but does not take into account InfiniBand networking. Azure CycleCloud allows you to use its own specific construct, referred to as PlacementGroupId to group cluster nodes into a single Azure VM scale set connected to the same networking switch. You can combine these two features, but this may reduce the number of nodes that you can provision within the same Azure VM scale set.

Azure CycleCloud orchestrates the lifecycle of HPC clusters, which typically consist of one or more HPC scheduler head nodes and compute nodes, but may also include Network Attached Storage such as an NFS server or BeeGFS cluster, Azure NetApp Files, Azure HPC Cache, and Azure Active Directory Domain Service. It includes an internal NoSQL datastore that caches cluster and node state. Its node monitoring system enables alerting. Its management functionality is exposed through REST API, accessible via the web and command line interface. 

Autoscaling of the managed cluster relies on Demand Calculator and Autoscale Library. You will learn about their characteristics in the next unit of this course.

:::image type="content" source="../media/u2-cyclecloud-architecture.png" alt-text="The image depicts the high-level architecture of Azure CycleCloud." border="false":::


## What is Azure CycleCloud cluster lifecycle?

The lifecycle of a cluster starts with selection of a template that contains its definition. You have the option of using one of the built-in templates or creating a custom one and importing it into the CloudCycle application. The template typically includes a number of parameters, which allow you to customize cluster configuration during its creation. The specifics of the cluster creation process depends on whether you use the web or command line interface.

After you created a cluster, you can start it. Starting a cluster will trigger a sequence of tasks for each node that is part of the cluster template-based definition. This sequence consists of a call to ARM requesting provisioning of an Azure VM, referred to as the *Acquiring* state, followed by configuration of the VM, including execution of its initialization defined in the corresponding project, execution of scripts to install and configure the scheduling software, as well as provisioning and mounting file system volumes. When the sequence completes, the node reaches the *Started* state. Any unhandled or unknown error results in the *Error* state. 

Once the cluster nodes are running, they are accessible remotely via either SSH or RDP, depending on their operating system. You can use such connections to submit cluster jobs. Depending on the cluster configuration, this might trigger scaling of the cluster.

You can terminate a cluster when it has completed all the submitted jobs. Terminating the cluster will stop and remove its nodes and delete any non­persistent volumes, leaving the cluster in the *Off* state.
