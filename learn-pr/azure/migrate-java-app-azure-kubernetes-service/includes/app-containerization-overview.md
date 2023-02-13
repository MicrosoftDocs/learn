Azure Migrate App Containerization is a standalone utility that you can download and install on any Windows 10 or Windows Server 2016 (or later) machine with network access to your application servers running the Java web app to be containerized and migrated. The tool works by using the running state of the applications on a server to determine the application components and helps you package them in a container image. The containerized application can then be deployed on Azure Kubernetes Service (AKS) or Azure App Service containers. The containerization process doesn’t require access to your codebase and provides an easy way to containerize existing applications.

The tool currently supports containerization and migration of following Java web applications:

- Applications running on Tomcat 8 or later.
- Application servers on Ubuntu Linux 16.04/18.04/20.04, Debian 7/8, CentOS 6/7, Red Hat Enterprise Linux 5/6/7.
- Applications using Java version 7 or later.

Azure Migrate: App Containerization helps you:

- **Discover your application**: The tool remotely connects to the application servers running your Java web application (running on Apache Tomcat) and discovers the application components. The tool creates a Dockerfile that can be used to create a container image for the application.
- **Build the container image**: You can inspect and further customize the Dockerfile as per your application requirements and use that to build your application container image. The application container image is pushed to an Azure Container Registry you specify.
- **Deploy to Azure Kubernetes Service**: The tool then generates the Kubernetes resource definition YAML files needed to deploy the containerized application to your Azure Kubernetes Service cluster. You can customize the YAML files and use them to deploy the application on AKS.

![App Containerization process overview](../media/process-overview.png)

In the next sections of this module, you'll setup a sample two-tier Java web application and use Azure Migrate App Containerization to containerize and migrate the application to AKS. 