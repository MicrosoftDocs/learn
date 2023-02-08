Organizations use AKS to deploy applications on Kubernetes without needing to manage the underlying infrastructure. For Tailwind Traders, deploying an AKS cluster to run Elastic allows the company to get started quickly and provides integrated capabilities that create efficiencies.

Here, we'll review the steps involved with creating a cluster in Azure Kubernetes Service and installing Elastic Cloud on Kubernetes (ECK) to your cluster, which will function as the Kubernetes operator.

## Create a cluster on AKS in the Azure portal

You can start AKS from the Azure portal. Azure portal lets you build, manage, and monitor cloud applications in a single, unified console. From this portal, you can set up a cluster for your Elastic Cloud on Kubernetes deployment.

The size you select for your AKS cluster depends on your planned usage of Elastic. If you don't know required capacity yet, a best practice is to start with at least a three node AKS cluster, spread across Azure Availability Zones to ensure high availability (HA) for any production deployment. Similarly, AKS supports different several versions of Kubernetes, but the default works fine for most applications.

## Install Elastic Cloud on Kubernetes on your AKS cluster  

Once your AKS cluster is created, you can use the Connect button in the Azure portal to generate Azure Cloud Shell commands that will let you open your cluster. Azure Cloud Shell is an interactive, authenticated, browser-accessible shell for managing Azure resources. It provides the flexibility of choosing the shell experience that best suits the way you work, either Bash or PowerShell.  

Copy and paste the scripts in Azure Cloud Shell CLI. Then, use the kubectl apply -f command and the yaml file provided by Elastic to install Elastic Cloud on Kubernetes (ECK) to your AKS cluster. ECK includes a Kubernetes operator and custom resource definitions with role-based access control (RBAC) rules that make it easier to manage your Elastic deployment on AKS.

A Kubernetes operator is a method of packaging, deploying, and managing a Kubernetes application that is especially useful for complex applications. The custom resource definitions for RBAC enable you to authorize users by assigning privileges to roles and assigning roles to users or groups.

Built on the Kubernetes Operator pattern, Elastic Cloud on Kubernetes (ECK) extends the basic Kubernetes orchestration capabilities to support the setup and management of Elasticsearch, Kibana, APM Server, Enterprise Search, and Beats on Kubernetes.

From here on out, you can use kubectl commands in Azure Cloud Shell to configure your deployment. If you want to view the Kubernetes operator logs to troubleshoot issues, you can do so by using the following kubectl command:

```bash
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
```

:::image type="content" source="../media/infrastructure-diagram.png" alt-text="A diagram depicting custom resource definitions for role-based access control.":::
