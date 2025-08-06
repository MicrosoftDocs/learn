Azure offers several compute services. _Compute_ refers to the hosting model for the computing resources that your applications run on. Azure provides a decision [flowchart](/azure/architecture/guide/technology-choices/compute-decision-tree) with high-level guidance for how to select the appropriate Azure compute service for your scenario. 

> [!NOTE]
> The following diagram only shows the Azure services described in this module. 

The output from this decision flowchart is a **starting point** for your planning. You need to do a detailed evaluation of the services to determine exactly which solution meets your requirements. As you work through this module, refer to this diagram to become familiar with the considerations and options. 

:::image type="content" source="../media/compute-flowchart.png" alt-text="Diagram that shows considerations and options for Azure compute solutions." border="false":::

### Things to know about Azure compute services

Let's take a quick look at the Azure compute services we review in this module.

- **Azure Virtual Machines**: Deploy and manage virtual machines inside an Azure virtual network.

- **Azure Batch**: Apply this managed service to run large-scale parallel and high-performance computing (HPC) applications.

- **Azure App Service**: Host web apps, mobile app backends, RESTful APIs, or automated business processes with this managed service.

- **Azure Functions**: Use this managed service to run code in the cloud, without worrying about the infrastructure.

- **Azure Logic Apps**: Configure this cloud-based _platform_ to create and run automated workflows similar to capabilities in Azure Functions.

- **Azure Container Instances**: Run containers in Azure in a fast and simple manner without creating virtual machines or relying on a higher-level service.

- **Azure Kubernetes Service (AKS)**: Run containerized applications with this managed Kubernetes service.

### Things to consider when choosing Azure compute services

As you begin to compare Azure compute services to choose your infrastructure solution for Tailwind Traders, there are several implementation points to think about.

- Architecture and infrastructure requirements.
- Support for new workload scenarios, like HPC applications.
- Required hosting options, including platform, infrastructure, and functions.
- Support for migrations, such as cloud-optimized or lift and shift.

#### Workloads and architecture

When you plan for new instances of Azure services and new workloads, consider the following scenarios.

- **Control**: Determine if you require full control over installed software and applications.
   
- **Workloads**: Consider the workloads you need to support, such as **HPC workloads** or **event-driven workloads**.

- **Architecture**: Think about what architecture best supports your infrastructure, including **microservice**, **full-fledged orchestration**, and **serverless**.

#### Migrations

An important consideration for your compute service involves analyzing the migration capabilities.

- **Cloud optimized**: To migrate to the cloud and refactor applications to access cloud-native features, consider compute services that are cloud-optimized.

- **Lift and shift**: For lift and shift workload migrations, consider compute services that don't require application redesigns or code changes.

- **Containerized**: In your migration planning, consider whether your compute service needs to support containerized applications, or commercial off the shelf (COTS) apps.

#### Hosting

The [hosting option](/azure/security/fundamentals/shared-responsibility) of your compute solution determines the developer and cloud provider responsibilities. Azure offers three hosting options across the compute services.

:::image type="content" source="../media/host-infrastructures.png" alt-text="Diagram that highlights the developer and cloud provider responsibilities for infrastructure and platform services." border="false":::

- **[Software-as-a-Service (SaaS)](https://azure.microsoft.com/resources/cloud-computing-dictionary/what-is-saas)** delivers software applications over the internet, on a subscription basis. Users can access these applications via a web browser without needing to manage the underlying infrastructure or application software. Microsoft 365 is an example of a SaaS solution, providing cloud-based productivity tools like Word, Excel, Outlook, and Teams.

- **[Platform-as-a-Service (PaaS)](https://azure.microsoft.com/resources/cloud-computing-dictionary/what-is-paas)** provides a managed hosting environment where developers can build, deploy, and manage applications without worrying about the underlying infrastructure. Azure handles the infrastructure, maintenance, and scalability, allowing developers to focus on writing code. Examples of Azure PaaS offerings include Azure App Services, Azure Functions, and Azure SQL Database.

- **[Infrastructure-as-a-Service (IaaS)](https://azure.microsoft.com/overview/what-is-iaas/)** provides virtualized computing resources over the internet. It allows users to rent virtual machines, storage, and networking resources on-demand, without the need for physical hardware. Azure Virtual Machines is a prime example of an IaaS offering, where users can deploy and manage VMs inside an Azure virtual network.

- **On-premises hosting** involves deploying and managing applications on local servers within an organization's own data center. This option provides the highest level of control over the infrastructure but requires significant investment in hardware, maintenance, and IT staff. Azure also supports hybrid cloud solutions, allowing integration between on-premises infrastructure and Azure services.

> [!TIP]
> You can extend your study of Azure AI-ready compute solutions with the [Describe Azure compute and networking services](/training/modules/describe-azure-compute-networking-services/) module.