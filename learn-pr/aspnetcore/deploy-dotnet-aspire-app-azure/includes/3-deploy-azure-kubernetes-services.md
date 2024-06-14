If you want the most granular control of your containers in an Azure-deployed .NET Aspire solution, or you have a team with expertise in Kubernetes, you should consider using Aure Kubernetes Service.

In your outdoor equipment retailer, you want to deploy the completed eShop for production. Your team has worked with Kubernetes clusters before and some members want the ability to customize ingress and traffic management. You want to understand the deployment process for Kubernetes clusters.

In this unit, you'll learn how to deploy a .NET Aspire cloud-native app to Kubernetes clusters including Azure Kuberbetes Service.

## What is Kubernetes?

Kubernetes is a orchestration system that runs and manages containers to create scalable and flexible hosting systems for software. Each container provides a repeatable and predictable environment for the software component that it runs. Kubernetes can scale the system by deploying new containers and distribute requests amongst all the instances of that image. Since cloud-native applications, such as those built with .NET Aspire, are composed of microservices that run in containers, Kubernetes is a popular choice to host them, even in production environments with high potential user demand.

Kubernetes runs on a cluster of **nodes**. Each node is a computer that can host containers. Each node must run certain Kubernetes components such as the **container runtime**, which launches containers, and **kubelet**, which monitors the health of the node. At least one node is designated the **master node**, and runs the Kubernetes **control plane**. The control plane manages communication, encryption, and scheduling.

The control plane schedule **pods** to run on nodes. Each pod consists of one or more containers, which will always run on the same node and can reference each other. Pods can include **volumes** that provide persistent storage for the lifetime of the pod. The data stored on volumes is not lost when any individual container stops.

Features of Kubernetes include:

- **Load balancing**: When load is high, Kubernetes can automatically spin up more pods and distribute requests to them.
- **Self-healing**: When containers fail, Kubernetes can automatically replace them.
- **Secret management**: Kubernetes can store passwords, tokens, and keys securely.
- **Configuration management**: Kubernetes can update configuration values without rebuilding your container images and redeploying them.

> [!NOTE]
> In Kubernetes, you can specify the desired state of the cluster, including its containers, pods, and services, by using a manifest file. This file is a text file written in JSON or YAML.

## What is Azure Kubernetes Service?

Azure Kubernetes Service (AKS) is a managed implementation of Kubernetes that runs in the Azure cloud. AKS makes it simpler to create and run a Kubernetes cluster because it manages much of the infrastructure for you. You don't have to implement nodes or manage the control plane and critical operations such as health monitoring and maintenance and you pay only for the nodes that run your containers. However you do have full control over aspects of the cluster that you can't achieve with Azure Container Apps.

AKS is a good choice when you want to run a .NET Aspire solution in the cloud in the most flexible and scalable system.

## Translating .NET Aspire manifest files to Kubernetes

In the previous unit, you learned that the Azure Developer CLI creates a .NET Aspire manifest file when you run the `azd init` command. This file is in JSON format and describes the content and configuration of the app, including its microservices and backing services.

> [!IMPORTANT]
> The .NET Aspire manifest is not the same as a Kubernetes manifest file, even though both can be JSON files. The schema used is different.

A key task when you deploy a .NET Aspire solution to any Kubernetes cluster is the translation of the .NET Aspire manifest into a Kubernetes manifest. It's possible to complete this task manually, but it requires a deep understanding of both formats and can be time consuming. If you want help with this translation, you can use the **Aspir8** tool.

## Using Aspir8 to deploy

You can obtain Aspir8 from NuGet by running this command

```dotnetcli
dotnet tool install -g aspirate --prerelease
```

After installation, run the intialization command in your .NET Aspire project. This command configures settings for the deployment, such as the container registry to use and tags for the containers.

```cmd
aspirate init
```

Next, use this command to translate the .NET Aspire manifest into a Kubernetes manifest:

```cmd
aspirate generate
```

Finally, you can deploy the app by using the `apply` command:

```cmd
aspirate apply
```

## Learn more

- [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)
- [What is Azure Kubernetes Service (AKS)?](/azure/aks/what-is-aks)
- [Aspir8](https://prom3theu5.github.io/aspirational-manifests/getting-started.html)
