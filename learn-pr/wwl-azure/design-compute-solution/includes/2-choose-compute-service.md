Azure offers several compute services. _Compute_ refers to the hosting model for the computing resources that your applications run on. 

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

- Architecture and infrastructure requirements
- Support for new workload scenarios, like HPC applications
- Required hosting options, including platform, infrastructure, and functions
- Support for migrations, such as cloud-optimized or lift and shift

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

- **[Infrastructure-as-a-Service (IaaS)](https://azure.microsoft.com/overview/what-is-iaas/)** lets you create individual virtual machines along with the associated networking and storage components. Then you deploy the software and applications you want onto those virtual machines. This model is the closest to a traditional on-premises environment, except that Microsoft manages the infrastructure. You still manage the individual virtual machines. Azure Virtual Machines offers IaaS hosting.

- **Platform-as-a-Service (PaaS)** provides a managed hosting environment, where you can deploy your application without needing to manage virtual machines or networking resources. Azure compute services that offer PaaS hosting include Azure Batch, App Service, Container Instances, and Azure Kubernetes Service.

- **Function-as-a-Service (FaaS)** goes further in removing the need to worry about the hosting environment. In a FaaS model, you deploy your code, and the service automatically runs it. Azure Functions and Logic Apps offer FaaS hosting.

### Azure compute service decision flowchart 

Azure provides a decision [flowchart](/azure/architecture/guide/technology-choices/compute-decision-tree) with high-level guidance for how to select the appropriate Azure compute service for your scenario. 

> [!NOTE]
> The following diagram has been edited to show only the Azure services described in this module. 

The output from this decision flowchart is a **starting point** for your planning. You'll need to do a detailed evaluation of the services to determine exactly which solution meets your requirements. As you work through this module, refer to this diagram to become familiar with the considerations and options. 

:::image type="content" source="../media/compute-flowchart.png" alt-text="Flowchat that shows considerations and options for Azure compute solutions." border="false":::