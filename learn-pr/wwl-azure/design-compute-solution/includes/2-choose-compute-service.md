Azure offers several compute services. _Compute_ refers to the hosting model for the computing resources that your applications run on. 

### Things to consider when choosing Azure compute services

As you compare Azure compute services to find the best solution for your infrastructure, there are several factors to consider.

- Architecture and infrastructure requirements
- Support for new workload scenarios
- Required hosting options, including PaaS, IaaS, and FaaS
- Support for migrations, such as cloud-optimized or lift and shift

#### Workloads and architecture

When you plan for new instances of Azure services and new workloads, consider the following points.

- **Control**: Determine if you require full control over installed software and applications.
   
- **Workloads**: Consider the workloads you need to support, such as **HPC workloads** or **event-driven workloads**.

- **Architecture**: Think about what architecture best supports your infrastructure, including **microservice**, **full-fledged orchestration**, and **serverless**.

#### Migrations

An important consideration for your compute service involves analysing the migration capabilities.

- **Cloud optimized**: To migrate to the cloud and refactor applications to access cloud-native features, consider compute services that are cloud-optimized.

- **Lift and shift**: For lift and shift workload migrations, consider compute services that don't require application redesigns or code changes.

- **Containerized**: In your migration planning, consider whether your compute service needs to support containerized applications, or commercial off the shelf (COTS) apps.

#### Hosting

The [hosting option](/azure/security/fundamentals/shared-responsibility) of your compute solution determines the developer and cloud provider responsibilities. Azure offers three hosting options across the compute services.

:::image type="content" source="../media/host-infrastructures.png" alt-text="Diagram that highlights the developer and cloud provider responsibilities for infrastructure and platform services." border="false":::

- **Infrastructure-as-a-Service (IaaS)** lets you create individual virtual machines (VMs) along with the associated networking and storage components. Then you deploy the software and applications you want onto those VMs. This model is the closest to a traditional on-premises environment, except that Microsoft manages the infrastructure. You still manage the individual VMs. Azure Virtual Machines is an IaaS compute service.

- **Platform-as-a-Service (PaaS)** provides a managed hosting environment, where you can deploy your application without needing to manage VMs or networking resources. Azure App Service is a PaaS compute service.

- **Function-as-a-Service (FaaS)** goes further in removing the need to worry about the hosting environment. In a FaaS model, you deploy your code, and the service automatically runs it. Azure Functions offers support for FaaS.

### Compare Azure compute services

The following table briefly describes the Azure compute services we review in this module:

| Compute service | Description | Hosting |
| --- | --- | --- |
| **Azure Virtual Machines** | Deploy and manage VMs inside an Azure virtual network. | IaaS |
| **Azure Batch** | A managed service for running large-scale parallel and high-performance computing (HPC) applications. | PaaS |
| **Azure App Service** | A managed service for hosting web apps, mobile app back ends, RESTful APIs, or automated business processes. | PaaS | 
| **Azure Functions** | A managed service for running code in the cloud, without worrying about the infrastructure. | FaaS |
| **Azure Logic Apps** | A cloud-based _platform_ with features similar to Azure Functions for creating and running automated workflows. | PaaS | 
| **Azure Container Instances** | A fast and simple way to run a container in Azure. You don't create any virtual machines and don't need a higher-level service. | PaaS | 
| **Azure Kubernetes Service** | A managed Kubernetes service for running containerized applications. | PaaS | 

### Azure compute service decision flowchart 

Azure provides a decision [flowchart](/azure/architecture/guide/technology-choices/compute-decision-tree) with high-level guidance for how to select the appropriate Azure compute service for your scenario. 

> [!NOTE]
> The following diagram has been edited to show only the Azure services described in this module. 

The output from this decision flowchart is a **starting point** for your planning. You'll need to do a detailed evaluation of the services to determine exactly which solution meets your requirements. As you work through this module, refer to this diagram to become familiar with the considerations and options. 

:::image type="content" source="../media/compute-flowchart.png" alt-text="Flowchat that shows considerations and options for Azure compute solutions." border="false":::