When developing a new app or modernizing an existing one, choosing the right hosting option is crucial to optimize performance, security, and cost-efficiency.

Traditionally, apps have been hosted on web servers like Internet Information Services (IIS), Apache, or on NGINX on physical or virtualized on-premises hardware. While this option offers the advantage of providing the infrastructure team full control of the environment, it requires additional effort to manage overhead, upfront costs, availability, scalability, resiliency, security, and compliance.

When you deploy your app to the cloud, you eliminate the need to manage these areas. Hosting an app on the cloud reduces overall set-up costs, provides enhanced availability and reliability with Business Continuity and Disaster Recovery (BCDR) options; allows you to scale your app resources on demand; and provides advanced security.

Microsoft Azure offers a diverse range of app hosting options customized to address your app's architectural requirements and use cases.

:::image type="content" source="../media/application-hosting-options.png" alt-text="Diagram showing types of MySQL applications and corresponding Azure services.":::

Many of these app hosting options integrate seamlessly with Azure Database for MySQL - Flexible Server, a particularly effective service for backend databases due to its scalability, performance, and manageability. In this unit, we'll explore some common MySQL app architectures and Azure services to help you determine the most suitable hosting option for your app workload.

## Web apps on Azure App Service

MySQL is one of the most popular databases for developing web and mobile apps because of its portability, speed, scalability, and reliability, all at low costs. By using Azure Database for MySQL - Flexible Server in the back end, you can more easily build lightweight or mission-critical LAMP (Linux-Apache-MySQL-PHP) stack internet-scale apps. You can also develop using popular CMSs like WordPress, Drupal, or Joomla, learning management systems like Moodle, and e-commerce platforms like Magento, which are all compatible with Azure Database for MySQL - Flexible Server.

Developers can deploy these MySQL-backed web and mobile apps on a Windows or Linux environment by using Azure App Service, an HTTP-based Platform-as-a-Service (PaaS) solution for hosting web apps, REST APIs, and mobile back ends. With Azure App Service, you can reduce management overhead, develop in your favorite languages, automate app deployment, scale up and down quickly, and even "dockerize" your app to host custom Windows or Linux Docker containers.

## Containerized apps on Azure Kubernetes Service or Azure Container Apps (microservices architecture)

Recently, apps with microservices architecture have been increasingly popular for their efficiency, resiliency, scalability, and ease of deployment. Unlike traditional monolithic apps, each microservice, or container, operates independently and can be updated without redeploying the entire app.

On Azure, you can deploy these microservices to Azure Kubernetes Service (AKS), a fully managed Kubernetes service that helps you quickly and easily define, deploy, debug, and upgrade even the most complex containerized apps.

In addition to AKS, Azure Container Apps (ACA) offers a serverless container hosting service ideal for modern apps built from microservices. ACA simplifies the deployment and scaling of containers without managing underlying infrastructure such as virtual machines or Kubernetes clusters. It integrates well with Azure Logic Apps and Azure Functions for event-driven architecture, supporting rapid scaling and management of app components. ACA is particularly beneficial for app requiring agile operations and quick iterations, providing dynamic scaling options based on HTTP traffic or event-driven triggers. This service supports both Windows and Linux containers, allowing you to deploy microservices developed in various programming environments seamlessly.

By leveraging ACA alongside traditional Kubernetes deployments through AKS, you can enjoy more flexibility in how they orchestrate, scale, and manage their containerized apps. This approach not only maximizes operational efficiency but also enhances the ability to respond swiftly to market changes and customer demands.

## Event-driven serverless apps with Azure Functions and Azure Logic Apps

Serverless apps accelerate development by using an event-driven model, with triggers that automatically execute code to respond to events and bindings to seamlessly integrate additional services. You're only charged for the time and resources taken to execute the code.

Azure Functions and Azure Logic Apps are serverless solutions on Azure that help you build systems to react to a series of critical events.

- **Azure Functions** Azure Functions is a highly versatile serverless compute service that executes code in response to a variety of triggers such as HTTP requests, timer events (cron jobs), or Azure service events (like messages from Azure Storage Queues or Service Bus). This flexibility allows you to build apps that respond in real-time to changes without managing server infrastructure. Azure Functions supports a broad array of programming languages, including C#, Java, JavaScript, Python, and PowerShell, making it accessible to a diverse developer base. These functions can also interact with other Azure resources.
- **Azure Logic Apps** provides a serverless design experience that helps automate and orchestrate tasks, processes, and workflows between apps and across enterprises. Using a visual designer either in the Azure portal or in Visual Studio, you can set up workflows to automate complex business scenarios with minimal coding. These workflows orchestrate a collection of functions or steps called *actions* that are executed to accomplish a complex task, like processing batch orders and aggregating results.

Azure also provides services like **Azure Event Grid**, **Azure Service Bus**, and **Azure Event Hubs** to relay and manage events and messages that can trigger serverless apps in event-driven workflows.

## Monolithic legacy applications on Azure VMs

Some organizations may have legacy apps with monolithic architectures that are tightly coupled with business processes and hard to modernize. You can migrate these apps to Azure using a lift-and-shift model and host them on Azure Virtual Machines, which is an Infrastructure-as-a-Service (IaaS) service.

While the advantages of Azure include the ability to enable backup and restore services, disk encryption, and scaling options that require no upfront costs, you'll still need to invest manual effort to deploy, maintain, and manage apps on Azure VMs.
