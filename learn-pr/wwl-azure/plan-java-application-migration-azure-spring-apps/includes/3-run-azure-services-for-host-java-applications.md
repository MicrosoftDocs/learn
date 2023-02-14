Now that you're familiar with the sample application that you'll be migrating to Azure, you need to review the various compute options for hosting the application.

The three primary options to consider are Azure App Service, Azure Kubernetes Service, and Azure Spring Apps.

## Azure App Service

Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. You can develop in your favorite language, be it .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python. Applications run and scale with ease on both Windows and Linux-based environments.

App Service not only adds the benefits of Microsoft Azure to your application, such as security, load balancing, autoscaling, and automated management. DevOps capabilities, such as continuous deployment from Azure DevOps, GitHub, Docker Hub can package management, staging environments, custom domain, and TLS/SSL certificates.

Azure App Service is a fully managed platform as a service (PaaS) offering for developers. Here are some key features of App Service:

 -  **Multiple languages and frameworks** \- App Service has first-class support for ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, or Python. You can also run PowerShell and other scripts or executables as background services.
 -  **Managed production environment** \- App Service automatically patches and maintains the OS and language frameworks for you.
 -  **Containerization and Docker** \- Contain your app and host a custom Windows or Linux container in App Service. Run multi-container apps with Docker Compose. Migrate your Docker skills directly to App Service.
 -  **Global scale with high availability** \- Scale up or out manually or automatically. Host your apps anywhere at Microsoft's global datacenter infrastructure, and the App Service SLA provides high availability.
 -  **Visual Studio and Visual Studio Code integration** \- Dedicated tools in Visual Studio and Visual Studio Code streamline the work of creating, deploying, and debugging.

## Azure Kubernetes Service

Azure Kubernetes Service simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance. Since Kubernetes masters are managed by Azure, you only manage and maintain the agent nodes. Thus, AKS is free; you only pay for the agent nodes within your clusters, not for the masters.

You can create an Azure Kubernetes Service cluster using:

 -  [The Azure CLI](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/aks/learn/quick-kubernetes-deploy-cli.md)
 -  [The Azure portal](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/aks/learn/quick-kubernetes-deploy-portal.md)
 -  [Azure PowerShell](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/aks/learn/quick-kubernetes-deploy-powershell.md)
 -  Using template-driven deployment options, like [Azure Resource Manager templates](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/aks/learn/quick-kubernetes-deploy-rm-template.md), [Bicep](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/azure-resource-manager/bicep/overview.md) and Terraform.

When you deploy an Azure Kubernetes Service cluster, the Kubernetes master and all nodes are deployed and configured for you. Advanced networking, Azure Active Directory integration, monitoring, and other features can be configured during the deployment process.

## Azure Spring Apps

As part of the Azure ecosystem, Azure Spring Apps allows easy binding to other Azure services including storage, databases, and monitoring.

 -  Azure Spring Apps is a fully managed service for Spring Boot apps that lets you focus on building and running apps without managing infrastructure.
 -  Deploy your JARs or code for your Spring Boot app or Zip for your Steeltoe app, and Azure Spring Apps will automatically wire your apps with Spring service runtime and built-in app lifecycle.
 -  After deployment you can monitor app performance, fix errors, and rapidly improve applications.
 -  Full integration to Azure's ecosystems and services.
 -  Azure Spring Apps is enterprise ready with fully managed infrastructure, built-in lifecycle management, and ease of monitoring.

Because the Spring Petclinic application consists of multiple interactive microservices, what would you consider to be the most suitable option? Before you answer this question, review the following requirements:

 -  The Spring Petclinic application should be accessible via a public endpoint to any user (anonymously).
 -  The new implementation of Spring Petclinic should eliminate the need to manually upgrade and manage the underlying infrastructure. Instead, the application should use the platform-as-a-service (PaaS) model.
 -  Spring Petclinic implementation adheres to the principles of the microservices architecture. Each component of the application runs as a microservice and granular control over cross-component communication. The application will evolve into a solution that will provide automatic and independent scaling of each component and extend to include more microservices.

You'll need to consider other steps to migrate the [labstarter branch of the GitHub repo](https://github.com/Azure-Samples/spring-petclinic-microservices/tree/labstarter) hosting the Spring Petclinic application code to the target service.

Use the table to organize your thoughts around what is appropriate for using Azure App Service, Azure Kubernetes Service, and Azure Spring Apps:

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **Azure App Service**
  :::column-end:::
  :::column:::
    **Azure Kubernetes Service**
  :::column-end:::
  :::column:::
    **Azure Spring Apps**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Public endpoint available.**
  :::column-end:::
  :::column:::
    *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Auto-upgrade underlying hardware.**
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Run microservices.**
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Other advantages.**
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
  :::column:::
     *Applicable?*
  :::column-end:::
:::row-end:::


## Considerations for choosing a service

Suggestions for reviewing which are the most appropriate service to be deployed for the Spring Petclinic application.

 -  Azure App Service, Azure Kubernetes Service, and Azure Spring Apps each support a public endpoint that can be accessed anonymously.
 -  Azure App Service, Azure Kubernetes Service, and Azure Spring Apps each support automatic upgrades and eliminates the need to manage the underlying infrastructure.
     -  With Azure App Service, upgrades are automatic. All underlying infrastructure is managed by the platform.
     -  Using Azure Kubernetes Service, you can enable automatic upgrades based on the channel of your choice (patch, stable, rapid, node-image). The underlying infrastructure consists of virtual machines that you provide as part of agent pools, however you don't manage them directly.
     -  With Azure Spring Apps, all tasks related to upgrading and managing the underlying infrastructure are taken care of by the platform. While Azure Spring Apps is built on top of an Azure Kubernetes Service cluster, that cluster is fully managed.
 -  Both Azure Kubernetes Service and Azure Spring Apps offer a convenient approach to implementing the microservices architecture. Additionally, they provide support for Spring Boot applications.
     -  If you choose Azure App Service, you'll need to create a new web app instance for each microservice. Both Azure Kubernetes Service and Azure Spring Apps require only a single instance. Additionally, Azure Kubernetes Service facilitates controlling traffic flow between microservices by using network policies.
 -  Azure Spring Apps Service offers an easy migration path for existing spring boot applications, which is an advantage for your existing application.
 -  Azure Spring Apps Service eliminates any administrative overhead required to run a Kubernetes cluster, which simplifies the operational model.
 -  Azure Kubernetes Service requires an extra migration step that involves containerizing all components.
     -  You'll also need to implement Azure Container Registry to store and deploy your container images from.
 -  Running and operating an Azure Kubernetes Service cluster introduces more involvement.
 -  Azure App Service scalability is more limited than Azure Kubernetes Service or Azure Spring Apps Service.

## Conclusion

Given all the constraints and features, the most beneficial services for supporting the Spring Petclinic application are Azure Spring Apps or Azure Kubernetes Service.

For this exercise, you'll be using Azure Spring Apps as the service to be deployed for the Spring Petclinic application. In this learning path, you'll be using a subset of resources from the PetClinic sample application located on the [lab starter branch of the GitHub repo](https://github.com/Azure-Samples/spring-petclinic-microservices/tree/labstarter) hosting the Spring Petclinic application code repository.
