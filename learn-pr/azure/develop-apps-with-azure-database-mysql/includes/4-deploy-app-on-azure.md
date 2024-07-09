Now that you know about different app hosting options on Azure, you want to explore how to deploy Azure Database for MySQL - Flexible Server apps on these services.

In this unit, you explore two of the most used services: Azure App Service and AKS. Then you review options for automating CI/CD tasks using Azure DevOps and GitHub.

## Azure App Service + Azure Database for MySQL - Flexible Server

To deploy your app on Azure App Service and integrate with Azure Database for MySQL - Flexible Server, use one of the following options:

- Use **Web App + Database** from the Azure Marketplace to create a Web App and a MySQL flexible server isolated in a virtual network (VNet). The flexible server's connection information is automatically added to the App Service app's Configuration Settings using a Connection String.
- Create an Azure Database for MySQL flexible server and an App Service app individually, and then, in the App Service app, in **Application Settings** under **Configuration Settings**, add the MySQL flexible server's connection information.

After setting up your App Service app and MySQL flexible server, you can deploy your app code to Azure using various deployment methods supported by Azure App Service. These methods include deploying from a ZIP package, Local Git repositories, Azure Container Registry, GitHub Actions, or Azure Pipelines, each option offering flexibility based on your development and operational workflows.

In the next unit, you build a sample PHP app and deploy it to Azure App Service, going through each step involved in the deployment process, and leverage Azure's powerful platform features to optimize your app's performance and scalability.

## Azure Kubernetes Service (AKS) + MySQL - Flexible Server

A powerful platform for deploying containerized apps, integrating AKS with Azure Database for MySQL - Flexible Server can streamline database management as well as enhance app scalability and resilience. To effectively deploy and manage your apps on AKS with a backend MySQL flexible server, consider the following information. 

The following diagram illustrates three common ways to integrate MySQL with your AKS app:

:::image type="content" source="../media/kubernetes-and-mysql.png" alt-text="Diagram showing the three options to use a MySQL database in AKS application.":::

- **Use Azure Database for MySQL - Flexible Server** which reduces the operational overhead of managing the MySQL server thereby enhancing developer productivity.
- **Use MySQL on Azure VM**, an infrastructure as a service offering, which requires that you take responsibility for managing and maintaining the MySQL server.
- **Run MySQL on Kubernetes**, which offers automation benefits but demands developer efforts to ensure stability, high availability, data persistence, and compliance. In addition, given the transient nature of Kubernetes pods, there is a higher likelihood of failovers and restarts, which can impact application availability and business continuity.

To deploy an app on AKS that integrates with Azure Database for MySQL - Flexible Server, use the following five-step process:

1. **Create an Azure Database for MySQL - Flexible Server** using the Azure Portal, the Azure CLI, an ARM/Bicep template, or other Azure tools. Along with choosing the right compute, storage, backup, and high availability options, it’s important to decide the suitable networking option while creating the MySQL flexible server.

    **Important**: Unless your scenario only involves small projects or demos, it's highly recommended to create your server with private access, which will help secure access to your server via VNet integration.

2. **Prepare your app** by making the following changes to your app code:

    - To have the app use MySQL flexible server, modify the corresponding configuration file or app properties file to add code indicating the host server URL, database name, username, and password, which will be read from the environment variables (as defined in and passed down from the Kubernetes manifest file).
    - [Create a Dockerfile](https://docs.docker.com/guides/docker-concepts/building-images/writing-a-dockerfile/) to build the app Docker image.

3. **Create an Azure container registry** and push the app to the registry as a Docker image.
4. **Create an AKS cluster** and attach the Azure container registry account to the cluster.
5. **Deploy the app to the cluster** and then test the deployment. To deploy the app to the AKS cluster, you first need to create a Kubernetes manifest file that defines a desired state for the cluster, such as what container images to run.

    In the Kubernetes manifest YAML file, key things to define include:

    - The container image name: replace it with your own in the format [registryname].azurecr.io/[image-name]:[tag]
    - Environment variables for MySQL flexible server host URL, database name, admin username and password.
    - A service resource to access the app in the cluster. For example, a service of the type “LoadBalancer” will create an external load balancer providing an externally accessible IP address to the app.

    After the YAML file is ready, deploy it with either `kubectl apply` or within the Kubernetes resource view in the Azure portal.

## Automate database CI/CD tasks with Azure DevOps, GitHub, and Azure Service Operator

Manually deploying apps can be inefficient and error-prone, necessitating frequent testing and adjustments. To streamline this process, automation through Continuous Integration (CI) and Continuous Delivery/Deployment (CD) is highly recommended. CI/CD enables development teams to regularly and reliably release smaller updates and features, significantly reducing the risk and effort involved compared to larger, less frequent updates.

For automating the deployment of apps and Azure Database for MySQL - Flexible Server, consider utilizing the following CI/CD tools:

### Azure Pipelines

Azure Pipelines, part of Azure DevOps, provides robust CI/CD capabilities, facilitating automated code deployments to various targets including Azure PaaS services, VMs, and container registries. This platform also supports deployments across different environments, such as other cloud platforms or on-premises systems.

Specifically for database deployments, you can use Azure Pipelines to automate updates to Azure Database for MySQL - Flexible Server by incorporating tasks in the pipeline that execute Azure CLI commands. These tasks can apply updates directly from SQL files or execute inline SQL scripts, ensuring that database schemas and data are up to date following each successful build.

### GitHub Actions

GitHub Actions enable automation of workflows in response to repository events, such as push, pull requests, or issue creation. This integration allows for a seamless CI/CD pipeline within the GitHub ecosystem, handling everything from build and test workflows for new pull requests to deployment workflows upon release creation.

For databases, you can configure GitHub Actions to connect directly to Azure Database for MySQL - Flexible Server to deploy or update databases whenever changes are merged or pushed. This ensures continuous synchronization between app updates and database schema changes.

### Azure Service Operator

Azure Service Operator integrates Azure resource management within the Kubernetes environment, allowing you to manage Azure resources like Azure Database for MySQL - Flexible Server directly through Kubernetes tooling. This operator makes it possible to incorporate infrastructure updates into Kubernetes deployment workflows, enabling a unified approach to managing both apps and their dependent Azure services.

### Other tools

Beyond these specific tools, you can use other technologies to enhance CI/CD workflows:

- **App Service Deployment Slots**: Useful for staging new releases before they go live, allowing for final validations and hot swapping to production with minimal downtime.
- **App Service Deployment Center**: Streamlines CI/CD setups with Azure App Services, integrating with source control and build services.
- **Jenkins**: An open-source automation server that supports building, deploying, and automating any project, Jenkins can be particularly effective in complex environments that require custom scripting and extensive integration.

By leveraging these tools, you can ensure that both your app and its underlying database infrastructure are always aligned with the latest changes in code, minimizing downtime and accelerating the delivery of new features and fixes.
