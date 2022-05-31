Now that you're familiar with the sample application that you'll be migrating to Azure, you need to review the various compute options for hosting the application.

The three primary options to consider are Azure App Service, Azure Kubernetes Service, and Azure Spring Apps.

## Azure App Service

Azure App Service is an Azure's Platform-as-a-Service (PaaS) offering that provides a platform for developers to build software applications on top of. Azure App Service provides cloud-based services for building, deploying and managing web, mobile and API apps for any device on Azure's platform.

Azure App Service includes components for mobile apps, web apps and API apps. In short, that means that you can use Azure App Service to host web applications, REST APIs, and mobile back ends. In this course, we'll focus specifically on Azure App Service for Mobile Apps.

Azure App Service includes the following services:

 -  **Web Apps**: The Web App feature of App Service allows you to host websites and web apps on Azure's platform. Web Apps includes support for various languages and frameworks.
 -  **Mobile Apps**: The Mobile App feature of App Service allows you to build and deploy a mobile app backend on Azure's platform, with support for push notifications, user authentication, and offline data storage. This feature supports various platforms, including iOS, Android, Xamarin and more. Customized SDKs for each platform allow you to easily connect your client application with your mobile backend hosted on Azure. Learn more about Mobile Apps here.
 -  **API Apps**: The API App feature of App Service allows you to build and host APIs written in multiple languages on Azure's platform, with support for API authentication and more.

:::image type="content" source="../media/app-service-overview-019843b5.png" alt-text="Diagram showing Azure App Service components.":::


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

You'll need to consider other steps to migrate the Spring Petclinic application to the target service.

Use the table below to organize your thoughts around what is appropriate for using Azure App Service, Azure Kubernetes Service, and Azure Spring Apps:

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
    **Public endpoint available**
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
    **Auto-upgrade underlying hardware**
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
    **Run microservices**
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
    **Other advantages**
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

Below are suggestions for reviewing which are the most appropriate service to be deployed for the Spring Petclinic application.

 -  Azure App Service, Azure Kubernetes Service, and Azure Spring Apps each support a public endpoint that can be accessed anonymously.
 -  Azure App Service, Azure Kubernetes Service, and Azure Spring Apps each support automatic upgrades and eliminates the need to manage the underlying infrastructure.
     -  With Azure App Service, upgrades are automatic. All underlying infrastructure is managed by the platform.
     -  Using Azure Kubernetes Service, you can enable automatic upgrades based on the channel of your choice (patch, stable, rapid, node-image). The underlying infrastructure consists of virtual machines that you provide as part of agent pools, however you don't manage them directly.
     -  With Azure Spring Apps, all tasks related to upgrading and managing the underlying infrastructure are taken care of by the platform. While Azure Spring Apps is built on top of an Azure Kubernetes Service cluster, that cluster is fully managed.
 -  Both Azure Kubernetes Service and Azure Spring Apps offer a convenient approach to implementing the microservices architecture. Additionally, they provide support for Spring Boot applications.
     -  If you choose Azure App Service, you'll need to create a new web app instance for each microservice. Both Azure Kubernetes Service and Azure Cloud Spring require only a single instance. Additionally, Azure Kubernetes Service facilitates controlling traffic flow between microservices by using network policies.
 -  Azure Spring Apps Service offers an easy migration path for existing spring boot applications, which is an advantage for your existing application.
 -  Azure Spring Apps Service eliminates any administrative overhead required to run a Kubernetes cluster, which simplifies the operational model.
 -  Azure Kubernetes Service requires an extra migration step that involves containerizing all components.
     -  You'll also need to implement Azure Container Registry to store and deploy your container images from.
 -  Running and operating an Azure Kubernetes Service cluster introduces more involvement.
 -  Azure App Service scalability is more limited than Azure Kubernetes Service or Azure Spring Apps Service.

## Conclusion

Given all the constraints and features listed above, the most beneficial services for supporting the Spring Petclinic application are Azure Spring Apps or Azure Kubernetes Service.

For this exercise, you'll be using Azure Spring Apps as the service to be deployed for the Spring Petclinic application.

For full implementation details, see our fork of [PetClinic](https://github.com/Azure-Samples/spring-petclinic-microservices). The samples reference the source code as needed.
