Whether you're developing a new application or modernizing an existing one, it is critical to determine the most suitable option for hosting your application in advance.

Historically, applications were deployed on web servers (such as Internet Information Services [IIS], Apache or NGINX) on physical or virtualized on-premises hardware. While this option offers the advantage of providing the infrastructure team full control of the environment, it has multiple drawbacks in terms of management overhead, upfront costs, availability, scalability, resiliency, security and compliance.

By deploying your application to the cloud, you can overcome these drawbacks. Hosting an application on the cloud reduces overall set-up costs, provides enhanced availability and reliability with Business Continuity and Disaster Recovery (BCDR) options, allows you to scale your application resources on demand and provides advanced security.

Microsoft Azure provides a wide range of options for application hosting based on the specific needs of your application's use case and architecture.

:::image type="content" source="../media/application-hosting-options.png" alt-text="Diagram showing types of MySQL applications and corresponding Azure services.":::

Many of these Azure services integrate seamlessly with Azure Database for MySQL - Flexible Server. In this unit, we'll explore some common MySQL application architectures and Azure services to determine the most suitable hosting option for your application workload.

## Web applications

As a result of its portability, speed, scalability, and reliability at low costs, MySQL is one of the most popular databases for developing web and mobile applications. With Azure Database for MySQL - Flexible Server in the back end, you can build lightweight or mission-critical LAMP (Linux-Apache-MySQL-PHP) stack internet-scale applications. You can also develop using popular content management systems like WordPress, Drupal or Joomla, learning management systems like Moodle, and e-commerce platforms like Magento, all of which are compatible with Azure Database for MySQL - Flexible Server.

Developers can deploy these MySQL-backed web and mobile applications on a Windows or Linux environment by using **Azure App Service**, which is an HTTP-based Platform-as-a-Service (PaaS) solution for hosting web applications, REST APIs, and mobile back ends. With Azure App Service, you can reduce management overhead, develop in your favorite languages, automate application deployment, scale in and out quickly and even "dockerize" your application to host custom Windows or Linux containers.

## Containerized applications (microservices architecture)

Recently, applications with microservices architectures have been increasingly popular for their efficiency, resiliency, scalability, and ease of deployment. Unlike traditional monolithic apps, each microservice or container operates independently and can be updated without redeploying the entire app.

On Azure, you can deploy these microservices to **Azure Kubernetes Service (AKS)**, a fully managed Kubernetes service that helps you quickly and easily define, deploy, debug, and upgrade even the most complex containerized applications.

## Event-driven serverless applications

Serverless applications accelerate development by using an event-driven model, with triggers that automatically execute code to respond to events and bindings to seamlessly integrate additional services. You're only charged for the time and resources taken to execute the code.

Azure Functions and Azure Logic Apps are serverless solutions on Azure that help you build systems to react to a series of critical events.

- **Azure Functions** is a serverless compute service which runs individual functions that execute in response to a trigger, like a cron job or an HTTP request. These functions can also interact with other Azure resources.
- **Azure Logic Apps** provides serverless workflows which orchestrate a collection of functions or steps called *actions* that are executed to accomplish a complex task, like processing batch orders and aggregating results.

Azure also provides services like **Azure Event Grid**, **Azure Service Bus** and **Azure Event Hubs** to relay and manage events and messages.

## Monolithic legacy applications

A few organizations may have legacy applications with monolithic architectures that are too tightly coupled with business and hard to modernize. You can migrate these applications to Azure using a lift-and-shift model and host them on **Azure Virtual Machines**, which is an Infrastructure-as-a-Service (IaaS) service.

While the advantages of Azure include the ability to enable backup and restore services, disk encryption, and scaling options that require no upfront costs, you'll still need to invest manual efforts to deploy, maintain, and manage applications on Azure VMs.
