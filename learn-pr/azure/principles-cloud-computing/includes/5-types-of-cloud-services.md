When talking about cloud computing, there are three major categories. It's important to understand them because they are used in conversation, documentation, and training.

## Explore the three categories of cloud computing

#### IaaS versus PaaS versus SaaS

[//]: # (Video temporarily removed until confusing graphics can be updated.)
[//]: # (> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEbs])

:::row:::
  :::column:::
    :::image type="icon" border="false" source="../media/5-iaas.png":::
  :::column-end:::
  :::column span="3":::

### Infrastructure as a service (IaaS)

Infrastructure as a Service is the most flexible category of cloud services. It aims to give you the most control over the provided hardware that runs your application (IT infrastructure servers and virtual machines (VMs), storage, and operating systems). Instead of buying hardware, with IaaS, you rent it. It's an instant computing infrastructure, provisioned and managed over the internet.
  :::column-end:::
:::row-end:::

> [!NOTE]
> When using IaaS, ensuring that a service is up and running is a shared responsibility: the cloud provider is responsible for ensuring the cloud infrastructure is functioning correctly; the cloud customer is responsible for ensuring the service they are using is configured correctly, is up to date, and is available to their customers. This is referred to as the **shared responsibility model**.

IaaS is commonly used in the following scenarios:

- **Migrating workloads.** Typically, IaaS facilities are managed in a similar way as on-premises infrastructure and provide an easy migration path for moving existing applications to the cloud.

- **Test and development.** Teams can quickly set up and dismantle test and development environments, bringing new applications to market faster. IaaS makes scaling development and testing environments, fast and economical.

- **Storage, backup, and recovery.** Organizations avoid the capital outlay and complexity of storage management, which typically requires skilled staff to manage data and meet legal and compliance requirements. IaaS is useful for managing unpredictable demand and steadily growing storage needs. IaaS can also simplify the planning and management of backup and recovery systems.

:::row:::
  :::column:::
    :::image type="icon" border="false" source="../media/5-paas.png":::
  :::column-end:::
  :::column span="3":::

### Platform as a service (PaaS)

PaaS provides an environment for building, testing, and deploying software applications. The goal of PaaS is to help you create an application  quickly without managing the underlying infrastructure. For example, when deploying a web application using PaaS, you don't have to install an operating system, web server, or even system updates.
  :::column-end:::
:::row-end:::

PaaS is a complete development and deployment environment in the cloud, with resources that enable organizations to deliver everything from simple cloud-based apps to sophisticated cloud-enabled enterprise applications. Resources are purchased from a cloud service provider on a pay-as-you-go basis and accessed over a secure Internet connection.

PaaS is commonly used in the following scenarios:

- **Development framework.** PaaS provides a framework that developers can build upon to develop or customize cloud-based applications. Just like Microsoft Excel macro, PaaS lets developers create applications using built-in software components. Cloud features such as scalability, high-availability, and multi-tenant capability are included, reducing the amount of coding that developers must do.

- **Analytics or business intelligence.** Tools provided as a service with PaaS allow organizations to analyze and mine their data. They can find insights and patterns, and predict outcomes to improve business decisions such as forecasting, product design, and investment returns.

:::row:::
  :::column:::
    :::image type="icon" border="false" source="../media/5-saas.png":::
  :::column-end:::
  :::column span="3":::

### Software as a service (SaaS)

SaaS is software that is centrally hosted and managed for the end customer. It is usually based on an architecture where one version of the application is used for all customers, and licensed through a monthly or annual subscription. Microsoft 365, Skype, and Dynamics CRM Online are perfect examples of SaaS software.
  :::column-end:::
:::row-end:::

## Cost and Ownership

> [!div class="mx-tableFixed"]
> | | IaaS | PaaS | SaaS |
> |-|------|------|------|
> | Upfront costs | There are no upfront costs. Users pay only for what they consume. | There are no upfront costs. Users pay only for what they consume. | Users have no upfront costs; they pay a subscription, typically on a monthly or annual basis. |
> | User ownership | The user is responsible for the purchase, installation, configuration, and management of their own software, operating systems, middleware, and applications. | The user is responsible for the development of their own applications. However, they are not responsible for managing the server or infrastructure. This allows the user to focus on the application or workload they want to run. | Users just use the application software; they are not responsible for any maintenance or management of that software. | 
> | Cloud provider ownership | The cloud provider is responsible for ensuring that the underlying cloud infrastructure (such as virtual machines, storage, and networking) is available for the user. | The cloud provider is responsible for operating system management, network, and service configuration. Cloud providers are typically responsible for everything apart from the application that a user wants to run. They provide a complete managed platform on which to run the application. | The cloud provider is responsible for the provision, management, and maintenance of the application software. |

## Management responsibilities

One thing to understand is that these categories are layers on top of each other. For example, PaaS adds a layer on top of IaaS by providing a level of abstraction. The abstraction has the benefit of hiding the details that you may not care about, so that you can get to coding quicker. However, one aspect of the abstraction is that you have less control over the underlying hardware. The following illustration shows a list of resources that you manage and that your service provider manages in each cloud service category.

:::image type="complex" source="../media/5-layer-diagram.png" alt-text="Illustration showing the level of abstraction in each category of cloud service.":::
    First column, on-premises, shows all elements managed by you. Second, infrastructure as a service, moves virtualization, servers, storage, and networking to the cloud provider. Third, platform as a service, moves runtime, middleware, and OS to the cloud provider. And fourth, software as a service, moves all elements to the cloud provider, with applications and data being the last elements moving.
:::image-end:::

- IaaS requires the most user management of all the cloud services. The user is responsible for managing the operating systems, data, and applications.
- PaaS requires less user management. The cloud provider manages the operating systems, and the user is responsible for the applications and data they run and store.
- SaaS requires the least amount of management. The cloud provider is responsible for managing everything, and the end user just uses the software.

## Combine cloud services to fit your needs

IaaS, PaaS, and SaaS each contain different levels of managed services. You may easily use a combination of these types of infrastructure. You could use Microsoft 365 on your company's computers (SaaS), and in Azure, you could host your VMs (IaaS) and use Azure SQL Database (PaaS) to store your data. With the cloud's flexibility, you can use any combination that provides you with the maximum result.
