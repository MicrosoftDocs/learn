Now that you know the basics of Azure Kubernetes Service, let's see what information you need to set up a basic AKS cluster. We'll also look at some of the tools you can use to develop and deploy your workloads. This information should help you decide how much additional configuration AKS may require integrating with existing development and deployment processes in your company.

## Creating an AKS cluster

At its core, an AKS is a cloud hosted Kubernetes cluster. Unlike a custom Kubernetes installation, AKS streamlines the installation process and takes care of most of the underlying cluster management tasks.

You have two options when you create an AKS cluster. You either use the Azure portal or Azure CLI. Both of these options require you to configure basic information about the cluster. For example:

- The Kubernetes cluster name
- The version of Kubernetes to install
- A DNS prefix to make the master node publicly accessible
- The initial node pool size

The initial node pool size defaults to two nodes, however it's recommended that at least three nodes are used for a production environment.

> [!NOTE]
> The master node in your cluster is free. You only pay for node VMs, storage and networking resources consumed in your cluster.

Unless specified, the Azure service creation workflow creates a Kubernetes cluster using default configuration for scaling, authentication, networking and monitoring. Creating an AKS cluster typically takes a few minutes. Once complete, you can change any of the default AKS cluster properties. Access and management of your cluster is done through the Azure portal or from the command line. You have two command-line options available:

- The Azure CLI `az aks` command
- The standard Kubernetes `kubectl` command-line tool

Both `az aks` and `kubectl` are available as defaults when using Cloud Shell. It's possible to use these two commands on a local machine. Keep in mind that `kubectl` is installed separately and requires additional configuration to access a remote cluster.

## How workloads are developed and deployed to AKS

![Image to accelerate development and deployment](../media/3-development-accelerate.png)

AKS supports the Docker image format. The compatibility with Docker means that you can use any development environment to create a workload, package the workload as a container and deploy the container as a Kubernetes pod.

Here you use the standard Kubernetes command-line tools or the Azure CLI to manage your deployments. The support for the standard Kubernetes tools ensures that you don't need to change your current workflow to support an existing Kubernetes migration to AKS.

AKS also supports all the popular development and management tools such as Helm, Draft, Kubernetes extension for Visual Studio Code and Visual Studio Kubernetes Tools.

### Deployment Tools

**Helm** is a package manager for Kubernetes. Helm packages are called Charts and help you define, install, and upgrade Kubernetes applications.

Suppose your application uses the open-source message broker RabbitMQ as a middleware queueing service. You now decide to run RabbitMQ on your AKS cluster. The Helm command you'll run, is `helm install stable/rabbitmq`.

Here's another example, you want to install the open-source database MySQL to a Kubernetes cluster. To install the application, you'll run the command `helm install stable/mysql`.

**Draft** makes it easy to build applications that run on Kubernetes. Draft streamlines the development workflow to easily initialize a container build and push the build to Kubernetes.

You'll use Draft to create the deployment scaffolding for the application you want to deploy to your AKS cluster. Draft creates a Dockerfile, a Helm chart, and a Draft configuration file that describes the project. For example, if the project is Python-based then the configuration file will include Python dependencies. If the project is NodeJS based then the configuration file includes Node dependencies and so on.

Both the Helm and Draft command-line tools are available in Cloud Shell.

AKS offers two additional features that will enhance both your development and deployment workflows.

### Development Tools

The **Visual Studio Kubernetes Tools** help streamline the development of containerized applications targeting Kubernetes. With Visual Studio you can:

- Automatically create Dockerfiles and Helm charts to support Kubernetes deployment
- Debug your code in a live AKS cluster using Azure Dev Spaces
- Publish your code directly to an AKS cluster from inside Visual Studio

The **Kubernetes extension for Visual Studio Code** allows you to:

- View the contents of your cluster
- See the state of pods at a glance
- Get access to a terminal in a Pod or port-forward network traffic
- Easily filter your way through logs to identify problems.

### Azure Dev Spaces

Setting up a local Kubernetes cluster on a developer machine can be complex and most solutions offers a single node configuration. It's also common to mock or replicate dependencies between developer teams when working on microservices projects.

Azure Dev Spaces helps your development teams be more productive on Kubernetes and allows you to:

- Minimize the local dev machine setup for each team member as developers can work directly in AKS
- Rapidly iterate and debug code directly in Kubernetes using Visual Studio or Visual Studio Code
- Generate Docker and Kubernetes configuration-as-code assets to use from development through to production
- Develop your code in isolation, and do end-to-end testing with other components without replicating or mocking up dependencies

> [!IMPORTANT]
> Azure Dev Spaces is supported only by AKS clusters in specific regions.

### Deployment Center

Deployment center simplifies setting up a DevOps pipeline for your application. You can use this configured DevOps pipeline to set up a continuous integration (CI) and continuous delivery (CD) pipeline to your AKS Kubernetes cluster.

With Azure DevOps Projects you can:

- Automatically create Azure resources, such as an AKS cluster
- Create an Azure Application Insights resource for monitoring an AKS cluster
- Enable Azure Monitor for containers to monitor performance for the container workloads on an AKS cluster

You can add richer DevOps capabilities by extend the default configured DevOps pipeline. For example, you can add approvals before deploying, provision additional Azure resources, run scripts or upgrade workloads.

## Azure Service Integration

AKS allows us to integrate any Azure service offering and use it as part of an AKS cluster solution.

For example, remember that Kubernetes doesn't provide middleware and storage systems. Suppose you need to add a processing queue to the fleet management data processing service. You can easily integrate Storage queues using Azure Storage to extend the capacity of the data processing service.
