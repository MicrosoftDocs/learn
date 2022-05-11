Whether you are developing a new application or attempting to modernize an existing one, it is critical to decide in advance, the most suitable option for hosting your application. 

Historically, applications were deployed on web servers (such as Internet Information Services (IIS), Apache or NGINX) on physical or virtualized on-premises hardware. While this option has the advantage that the infrastructure team has full control of the environment, it has multiple drawbacks in terms of management overhead, upfront costs, availability, scalability, resiliency, security and compliance.

Deploying your application on the cloud overcomes these drawbacks. It reduces over-all set up costs, provides enhanced availability and reliability with Business Continuity and Disaster Recovery (BCDR) options, allows you to scale your application resources on demand and provides advanced security.

Microsoft Azure provides a wide range of options for application hosting based on your application's use case and architecture. And many of these Azure services integrate seamlessly with Azure Database for MySQL - Flexible Server. In this unit, let us explore some common MySQL application architectures and Azure services to determine the most suitable hosting option for your application workload.

:::image type="content" source="../media/application-hosting-options.png" alt-text="Diagram showing types of MySQL applications and corresponding Azure services.":::

## Web applications

MySQL is one of the most popular databases for developing web and mobile applications due to its portability, speed, scalability and reliability at low costs. With Azure Database for MySQL - Flexible Server in the backend, you can build lightweight or mission-critical LAMP stack (Linux-Apache-MySQL-PHP) internet-scale applications. You can also develop using popular content management systems like WordPress, Drupal or Joomla, learning management systems like Moodle, and e-commerce platforms like Magento, all of which are compatible with Azure Database for MySQL - Flexible Server.

Developers can deploy these MySQL-backed web and mobile applications on a Windows or Linux environment using **Azure App Service**. Azure App Service is an HTTP-based PaaS service for hosting web applications, REST APIs, and mobile back ends. With Azure App Service, you can reduce management overhead, develop in your favorite languages, automate application deployment, scale in and out quickly and even dockerize your application and host custom Windows or Linux containers.

## Containerized applications (microservices architecture)

Recently, applications with microservices architectures have been increasingly popular for their efficiency, resiliency, scalability, and ease of deployment. Unlike traditional monolithic apps, each microservice or container operates independently and can be updated without redeploying the entire app.

On Azure, you can deploy these microservices to **Azure Kubernetes Service (AKS)**, a fully managed Kubernetes service that helps you quickly and easily define, deploy, debug, and upgrade even the most complex containerized applications.

## Event-driven serverless applications

Serverless applications accelerate development by using an event-driven model, with triggers that automatically execute code to respond to events and bindings to seamlessly integrate additional services. You are only charged for the time and resources taken to execute the code.

Azure Functions and Azure Logic Apps are serverless solutions on Azure that help you build systems to react to a series of critical events. 

- **Azure Functions** is a serverless compute service which runs individual functions that execute in response to a trigger, like a cron job or an HTTP request. These functions can also interact with other Azure resources.
- **Azure Logic Apps** provides serverless workflows which orchestrate a collection of functions or steps called *actions* that are executed to accomplish a complex task, like processing batch orders and aggregating results.

Azure also provides services like **Azure Event Grid**, **Azure Service Bus** and **Azure Event Hubs** to relay and manage events and messages. 

## Monolithic legacy applications

Few organizations may have legacy applications with monolithic architectures which are hard to or too tightly coupled with business to be modernized. These applications can be simply migrated to Azure using a lift-and-shift model and hosted on **Azure Virtual Machines** which is an IaaS (Infrastructure as a Service) service.

While the advantages of Azure bring in the ability to enable backup and restore services, disk encryption, and scaling options that require no upfront costs, you will still be required to invest manual efforts to deploy, maintain, and manage applications on Azure VMs.
