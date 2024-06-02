Azure Migrate: App Containerization is a standalone utility that you can download and install on any Windows 10 or Windows Server 2016 (or later) machine. The machine needs network access to your application servers running the ASP.NET web app to be containerized and migrated. The tool works by using the running state of the applications on a server to determine the application components and helps you package them in a container image. The containerized application can then be deployed on Azure Kubernetes Service (AKS) or Azure App Service containers. The containerization process doesn’t require access to your codebase and provides an easy way to containerize existing applications.

The tool currently supports containerization and migration of the following ASP.NET applications:

- ASP.NET applications using Microsoft .NET Framework 3.5 or later.
- Application servers running Windows Server 2012 R2 or later (application servers should be running PowerShell version 5.1).
- Applications running on Internet Information Services (IIS) 7.5 or later.

Azure Migrate: App Containerization helps you to:

- **Discover your application**: The tool remotely connects to the application servers running your ASP.NET web application and discovers the application components. The tool creates a Dockerfile that can be used to create a container image for the application.
- **Build the container image**: You can inspect and further customize the Dockerfile as per your application requirements and use that to build your application container image. The application container image is pushed to an Azure Container Registry you specify.
- **Deploy to Azure Kubernetes Service**: The tool then generates the Kubernetes resource definition YAML files needed to deploy the containerized application to your Azure Kubernetes Service cluster. You can customize the YAML files and use them to deploy the application on AKS.

![App Containerization process overview](../media/process-overview.png)

In the next sections of this module, you set up a sample two-tier ASP.NET web application and use Azure Migrate: App Containerization to containerize and migrate the application to App Service. 