[PaaS options](/azure/architecture/guide/design-principles/managed-services) provide a framework for developing and running apps. As with IaaS, the PaaS provider hosts and maintains the platform's servers, networks, storage, and other computing resources. But PaaS also includes tools, services, and systems that support and accelerate the web application lifecycle. Developers use the platform to build apps without having to manage backups, security solutions, upgrades, and other administrative tasks. 

IaaS is like having a box of parts. You can build anything, but you must assemble it yourself. PaaS options are easier to configure and administer. You don't need to set up virtual machines or virtual networks. You also don't have to handle maintenance tasks, such as installing patches and updates. PaaS enables managed services platforms where you can deploy applications to the cloud without managing infrastructure. You lose some of the flexibility of customizing your infrastructure, but you gain a preconfigured environment and can focus more on building applications.

Azure managed platforms allow you to take advantage of the benefits of PaaS while retaining the Linux-based technology foundation you're already familiar with. Some of the popular managed platforms for Linux include:

- **Azure App Service** is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. You can develop in your favorite language, be it .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python. Applications run and scale with ease on both Windows and Linux-based environments. App Service automatically patches and maintains the OS and language frameworks for you, giving you more time to write apps.

- **Azure Functions** allows you to implement your system's logic into readily available blocks of code called functions. Functions can run anytime you need to respond to critical events. Azure Functions automatically provides as many or as few compute resources as needed to meet the demands of workloads that use them.

- **Azure Red Hat OpenShift** simplifies the often-complex tasks related to integrating containers with other services and running containers in production. Azure Red Hat OpenShift is jointly engineered, operated, and supported by Red Hat and Microsoft to provide an integrated support experience.

- **Azure Kubernetes Service (AKS)** simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance.

- **Azure Container Instances** offers a fast, simple way to run a container in Azure, without having to manage any virtual machines and without having to adopt a higher-level service. It's a great solution for any scenario that can operate in isolated containers, including simple applications, task automation, and build jobs. For more complex applications, Microsoft recommends using AKS.

- **JBoss EAP on Azure** provides a complete environment to build, run, deploy, and manage enterprise Java applications. Choose among three Azure hosting options: Azure App Service, Azure Red Hat OpenShift (ARO), and Azure Virtual Machines/VM Scale Sets. All three solutions are jointly developed and supported by Red Hat and Microsoft.

- **Azure Spring Apps** enable developers to deploy Spring Boot applications to Azure without any code changes. The service manages the infrastructure of Spring applications so developers can focus on their code. Azure Spring Apps provides lifecycle management, including comprehensive monitoring and diagnostics, configuration management, service discovery, CI/CD integration, and blue-green deployments.

Azure service platforms are managed with the common Azure Resource Manager accessed via the Azure portal, the Azure CLI, PowerShell, and management libraries available for multiple languages. Each service platform defines its own pricing and support model.

## When to use Azure PaaS resources for Linux deployments

If your goal is to create new applications and services quickly, use PaaS to gain greater agility and reusability by adopting modern development tools and advanced application architectures. Integrate cutting-edge capabilities such as AI and advanced analytics via prebuilt solutions found in Azure Marketplace. 

Typical scenarios include:

- **App development** &mdash; PaaS provides a framework that developers can build upon to develop or customize cloud-based applications. PaaS lets developers create applications by using built-in software components. Cloud features such as scalability, high-availability, and multitenant capability are included, reducing the amount of coding that developers must do.

- **Analytics or business intelligence** &mdash; Tools provided as a service with PaaS allow organizations to analyze and mine their data, finding insights and patterns and predicting outcomes to improve forecasting, product design decisions, investment returns, and other business decisions.

- **Additional services** &mdash; PaaS providers might offer other services that enhance applications, such as workflow, directory, security, and scheduling.
