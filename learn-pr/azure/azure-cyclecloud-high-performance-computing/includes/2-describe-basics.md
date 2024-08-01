Many organizations want to transition their on-premises HPC workloads to Azure to benefit from its hyperscale capabilities. They also want to minimize the learning curve associated with such a transition and use the expertise associated with the existing deployments, such as a specific HPC scheduler. Finally, they seek insight into the performance and cost of cloud-based cluster resources, in the manner that parallels their on-premises environments.

Implementing a custom solution that addresses these needs is challenging. It requires in-depth knowledge of Azure compute, networking, and storage resources that serve as building blocks of cloud-based HPC clusters. Also, without a corresponding management interface, operating such a solution by relying on standard Azure management tools would result in significant administrative overhead.

Azure CycleCloud addresses these concerns, providing a simple, secure, and scalable way to implement HPC schedulers in Azure. In this unit, you'll learn about its basic functionality.

> [!NOTE]
> Azure CycleCloud targets deployment scenarios that require the use of a specific HPC scheduler. This complements Azure Batch, which provides a scheduler as a service on Azure.

## What is Azure CycleCloud?

Azure CycleCloud is a tool for deploying HPC clusters in Azure and managing their workloads. It offers a wide range of HPC capabilities, including:

- **Template-based deployment of HPC clusters**. Azure CycleCloud provides built-in customizable templates for deploying the most common cluster schedulers, including Slurm, OpenPBS, LSF, Grid Engine, and HTCondor. Many other predefined templates, which you can import into your Azure CycleCloud instance, are available from the CycleCloud GitHub repository.

   > [!NOTE]
   > Templates are INI-formatted files that use declarative syntax to describe how nodes are organized in a CycleCloud cluster, including their respective relationships. Templates contain references to projects, which define node configuration.

- **Manual and automated scaling of cluster nodes**. Azure CycleCloud allows for manual and automated horizontal scaling of managed clusters according to the length of job queues and governance policies. It also offers a REST API for developing autoscaling adapters for custom schedulers.

- **Node configuration through cloud-init scripts**. Azure CycleCloud supports configuration management based on custom scripts that run within managed cluster nodes before any other CycleCloud-specific configuration tasks.

- **Management of the internal and external cluster storage**. Azure CycleCloud allows you to configure cluster storage by provisioning, mounting, and formatting Azure managed disks and network attached storage such as NFS servers or BeeGFS clusters.

- **Monitoring, logging, and alerting**. Azure CycleCloud offers built-in cluster monitoring and integrates with Azure Monitor. It's also possible to store log data from CycleCloud clusters to Log Analytics and create custom metrics dashboards. In addition, you can create custom alerts and email notifications triggered by telemetry data. All Azure CycleCloud activities are logged.

- **Authentication and authorization**. Azure CycleCloud supports built-in local authentication. Alternatively, you can integrate it with Active Directory Domain Services or other Lightweight Directory Access Protocol (LDAP)-based identity providers. By default, the locally defined users have access to the operating system on the managed cluster nodes, but it's possible to administer cluster users separately. For management of resources in an Azure subscription, you can use a Microsoft Entra service principal or managed identity.

- **Near-realtime cost reporting and controls**. Azure CycleCloud tracks cluster usage and estimates the corresponding cost. This feature allows you to set up budget alerts triggered when the cluster cost exceeds the monetary amount you specified. Azure CycleCloud also integrates with Microsoft Cost Management.

## How do you implement and use Azure CycleCloud?

CycleCloud is implemented as a Linux-based web application, which you can install in any location from which you can access your Azure environment. The simplest way to set it up is by deploying an Azure VM by using the corresponding Azure Marketplace image, with the option of automating the deployment by using an Azure Resource Manager (ARM) template. Alternatively, you can use yum or apt packages, or a container image available from the Microsoft Container Registry.

During the initial configuration, you have the option to provide an SSH key to secure access to the operating system hosting the CycleCloud application and to the cluster nodes deployed later. To enable the CycleCloud application to interact with Azure Resource Manager, you need to choose a Microsoft Entra identity that provides security context for this interaction and assign to it sufficient permissions in the target Azure subscription by using Azure role-based access control (RBAC). This identity can take the form of a service principal, or a managed identity if hosting the Azure CycleCloud application on an Azure VM.

An Azure CycleCloud instance also requires an Azure storage account and an accompanying blob container. This container, known as a *locker*, provides the staging area for the deployment of projects to cluster nodes.

Once installed, the Azure CycleCloud application provides a graphical user interface that allows a user to manage and monitor HPC systems and a command-line interface (CLI) that facilitates automation and integration of CycleCloud into existing workflows. You can also use CLI to import templates, automate cluster provisioning, and perform more advanced management tasks.

:::image type="content" source="../media/u2-cyclecloud-gui.png" alt-text="Screenshot of the graphical interface of the Azure CycleCloud web application." border="false" lightbox="../media/u2-cyclecloud-gui.png":::

## What is the architecture of Azure CycleCloud?

Azure CycleCloud provides an added layer of abstraction compared to Azure Resource Manager, minimizing the need for its users to deal directly with Azure compute and storage resources. Its role is to translate scheduler-level configurations that are accessible through its graphical interface or CLI into ARM API calls that interact with Azure VMs and Azure VM Scale Sets in user-defined virtual networks and subnets. These calls also consider regional vCPU quotas, cluster size limits, and constraints of InfiniBand network topology. They also facilitate optimizing cluster performance by using such constructs as proximity placement groups or connecting cluster nodes to the same InfiniBand switch.

> [!NOTE]
> A proximity placement group enables collocating Azure VMs close to each other but doesn't consider InfiniBand networking. Azure CycleCloud allows you to use its own specific construct, referred to as *PlacementGroupId* to group cluster nodes into a single Azure VM Scale Set connected to the same networking switch. You can combine these two features, but this might reduce the number of nodes that you can provision within the same Azure VM Scale Set.

Azure CycleCloud orchestrates the lifecycle of HPC clusters, which typically consist of one or more HPC scheduler head nodes and compute nodes, but might also include Network Attached Storage such as an NFS server or BeeGFS cluster, Azure NetApp Files, Azure HPC Cache, and Microsoft Entra Domain Services. It includes an internal NoSQL datastore that caches cluster and node states. Its node monitoring system enables alerting. Its management functionality is exposed through REST API, and accessible through the web and CLI.

Autoscaling of the managed cluster relies on Demand Calculator and Autoscale Library. You'll learn about their characteristics in the next unit of this course.

:::image type="content" source="../media/u2-cyclecloud-architecture.png" alt-text="Diagram of the high-level architecture of Azure CycleCloud." border="false" lightbox="../media/u2-cyclecloud-architecture.png":::

## What is Azure CycleCloud cluster lifecycle?

The lifecycle of a cluster starts with selecting a template that contains its definition. You have the option of using one of the built-in templates or creating a custom one and importing it into the CycleCloud application. The template typically includes several parameters, which allow you to customize cluster configuration during its creation. The specifics of the cluster creation process depend on whether you use the web or CLI.

After you create a cluster, you can start it. Starting a cluster triggers a sequence of tasks for each node that's part of the cluster template-based definition. This sequence consists of a call to Azure Resource Manager requesting provisioning of an Azure VM, referred to as the *Acquiring* state. This is followed by the configuration of the VM, including the execution of its initialization that's defined in the corresponding project, execution of scripts to install and configure the scheduling software, and provisioning and mounting file system volumes. When the sequence completes, the node reaches the *Started* state. Any unhandled or unknown error results in the *Error* state.

After the cluster nodes are running, they're accessible remotely through SSH or RDP, depending on their operating system. You can use such connections to submit cluster jobs. Depending on the cluster configuration, this might trigger scaling of the cluster.

You can terminate a cluster when it completes all the submitted jobs. Terminating the cluster stops and removes its nodes and deletes any non-persistent volumes, leaving the cluster in the *Off* state.
