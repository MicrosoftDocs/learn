Now that you've learned about the different application hosting options on Azure and are able to determine the best option for your application, let's try to understand how to deploy your MySQL - Flexible Server applications on these services.

In this unit, we will only explore two of the services: Azure App Service and Azure Kubernetes Service (AKS). We will then discuss the options for automating CI/CD tasks using Azure DevOps and GitHub.

## Azure App Service + MySQL - Flexible Server

To deploy your application on Azure App Service integrating with MySQL - Flexible Server, you can follow one of the below two options:

1. Create a MySQL flexible server and an App Service app individually. Then add the MySQL flexible server's connection information to *Application Settings* under *Configuration Settings* in the App Service app.
1. Use **Web App + Database** from Azure Marketplace. This option creates a Web App and a MySQL flexible server isolated in a VNet. MySQL flexible server's connection information is automatically added to the App Service app's *Configuration Settings*, through a *Connection String*.

Once the App Service app and database is created, push your application on to Azure from one of the many App Service deployment options such as from a ZIP package, Local Git, Azure Container Registry, Github Actions, Azure Pipelines, etc.

We'll explore this in detail by building and deploying a sample PHP application on to Azure App Service in the next unit.

## Azure Kubernetes Service (AKS) + MySQL - Flexible Server

In general, if you want to use a MySQL database in your Azure Kubernetes application, there are three options:

:::image type="content" source="../media/aks-and-mysql.png" alt-text="Diagram showing the three options to use a MySQL database in AKS application.":::

- **Use MySQL on Azure VM** – Azure VMs are considered an infrastructure as a service offering. This option requires that the user take responsibility for managing and maintaining the MySQL server.
- **Run it on Kubernetes** – Provision a MySQL database in a container running on a Kubernetes pod. This option has the benefits that Kubernetes provides in terms of automation, but it demands developer efforts to keep the database running together. In addition, given the transient nature of Kubernetes pods, there is a higher likelihood of failovers and restarts which impacts application availability and business continuity.
- **Use Azure Database for MySQL - Flexible Server** – Take advantage of this fully managed MySQL service on Azure. This option enhances developer productivity by reducing the operational overhead of managing the MySQL server.

To deploy an application on AKS that integrates Azure Database for MySQL - Flexible Server in the backend, follow the below five simple steps:

1. **Create a MySQL flexible server** using the Azure Portal, the Azure CLI, an ARM/Bicep template, or other Azure tools. 
    Along with choosing the right compute, storage, backup, and high availability options, it’s important to decide the suitable networking option while creating the MySQL flexible server. Based on how you’d like AKS to reach the MySQL flexible server, you can choose either of the following options:

    - Public Access (allowed IP addresses)
    - Private Access (VNet integration)

    Unless your scenario involves only small projects or demos, it’s highly recommended to create your server with private access, which will help secure access to your server via VNet Integration.

1. **Prepare your application**

    Update your application code with the following changes:

    - To have the application use MySQL flexible server, modify the corresponding configuration file or application properties file to add code indicating the host server URL, database name, username, and password, which will be read from the environment variables (as defined in and passed down from the Kubernetes manifest file).
    - Create a DockerFile to build the application docker image.

1. **Create an Azure container registry** and push the application to the registry as a Docker image.
1. **Create an AKS cluster** and attach the Azure container registry account to the cluster.
1. **Deploy the application to the cluster** and then test.

    To deploy the application to the AKS cluster, you first need to create a Kubernetes manifest file that defines a desired state for the cluster, such as what container images to run.

    Key things to define in the Kubernetes manifest YAML file include:

    - Container image name: replace it with your own in the format [registryname].azurecr.io/[image-name]:[tag]
    - Environment variables for MySQL flexible server host URL, database name, admin username and password.
    - A Service resource to access the application in the cluster. For example, a service of the type “LoadBalancer” will create an external load balancer providing an externally accessible IP address to the application.

    After the YAML file is ready, deploy it with kubectl apply or with the Kubernetes resource view via the Azure portal.

## Automate database CI/CD tasks with Azure DevOps, GitHub and Azure Service Operator

Manually deploying an application is inefficient and changes to the environment need to be tested. It is recommended to automate build and deployment processes to minimize application errors and the time to release new features. This practice is often termed CI/CD - Continuous Integration (CI) and Continuous Delivery/Deployment (CD). Implementing build and deployment automation means that development teams can rapidly serve small features and fixes in production, rather than waiting for one large, error-prone manual deployment.

Below are three CI/CD tools which you can use to automate both application and MySQL flexible server database deployments:

### Azure Pipelines

Azure Pipelines is a CI/CD pipeline platform on Azure. It supports code deployments to PaaS services, virtual machines, and container registries in Azure, other cloud platforms, and on-premises.

Azure Pipelines can also be used to automatically deploy your database updates to Azure Database for MySQL - Flexible Server after every successful build. You can use an Azure CLI task to update the database either with a SQL file or by executing an inline SQL script against the database.

### GitHub Actions

GitHub Actions runs automated pipelines after an event occurs, such as when a developer pushes to a repository branch or opens a PR. For example, you can have one workflow to build and test pull requests, another workflow to deploy your application every time a release is created, and still another workflow that adds a label every time someone opens a new issue. You can also configure workflow actions to connect to your MySQL flexible server and deploy databases or database updates.

### Azure Service Operator

Azure Service Operator (ASO) helps provision and manage Azure resources from within Kubernetes, integrating infrastructure management into existing Kubernetes release pipelines. With ASO, you can automate deployment and updates to services like Azure Database for MySQL - Flexible Server without having to leave the Kubernetes control plane.

### Other tools

To automate CI/CD tasks for your application, you can also use App Service Deployment Slots, App Service Deployment Center, open-source tools like Jenkins, etc.
