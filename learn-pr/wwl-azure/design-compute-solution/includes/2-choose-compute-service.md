Compute refers to the hosting model for the computing resources that your applications run on. Azure offers several compute services, which we will cover in this module. Here’s a short summary. 

- **Virtual machines (IaaS)**. Deploy and manage VMs inside an Azure virtual network.

- **Azure Batch (PaaS)**. A managed service for running large-scale parallel and high-performance computing (HPC) applications.

- **Azure Functions (FaaS)**. A managed service for running code in the cloud, without worrying about the infrastructure.

- **Azure Logic Apps (PaaS)**.  A cloud-based platform for creating and running automated workflows.

- **Container Instances (PaaS)**. A fast and simple way to run a container in Azure. You don’t provision any virtual machines and don’t need a higher-level service.

- **App Service (PaaS)**. A managed service for hosting web apps, mobile app back ends, RESTful APIs, or automated business processes.

- **Azure Kubernetes Service (PaaS).** A managed Kubernetes service for running containerized applications.

- **Azure Service Fabric.**  A distributed systems platform that makes it easy to package, deploy, and manage scalable and reliable microservices and containers.

This [flowchart](/azure/architecture/guide/technology-choices/compute-decision-tree) provides high-level guidance on when to select each compute option. You’ll want to refer to this diagram as we go through the choices. 

:::image type="content" source="../media/compute-flowchart.png" alt-text="A detailed flowchart to show compute solutions.":::

 


On the diagram, **Cloud optimized** is a strategy for migrating to the cloud. Cloud optimized refactors an application to take advantage of cloud-native features and capabilities. A **lift and shift** strategy migrates workloads without redesigning the application or making code changes. Lift-and-shift lets organizations keep running their applications with minimal changes and disruption.

> [!TIP]
> The output from this flowchart is a **starting point** for consideration. You’ll need to do a more detailed evaluation of the service to determine if it meets your needs. The next sections will help with this analysis.

**Review the compute hosting options**

The compute solution has three hosting options: Infrastructure as a Service, Platform as a Service, and Function as a Service? There’s also Software-as-a-Service which isn’t a compute solution. The [hosting option](/azure/security/fundamentals/shared-responsibility) determines the developer and cloud provider responsibilities. This hosting decision will influence your design. 

:::image type="content" source="../media/host-infrastructures.png" alt-text="Responsibilities for IaaS, PaaS, and FaaS.":::


- **Infrastructure-as-a-Service** (IaaS) lets you create individual VMs along with the associated networking and storage components. Then you deploy whatever software and applications you want onto those VMs. This model is the closest to a traditional on-premises environment, except that Microsoft manages the infrastructure. You still manage the individual VMs.

- **Platform-as-a-Service** (PaaS) provides a managed hosting environment, where you can deploy your application without needing to manage VMs or networking resources. Azure App Service is a PaaS service.

- **Functions-as-a-Service** (FaaS) goes even further in removing the need to worry about the hosting environment. In a FaaS model, you deploy your code, and the service automatically runs it. Azure Functions is a FaaS service.