Contoso might utilize Kubernetes clusters connected to Azure-Arc. As a  Windows Server administrator, you need to determine the requirements for this process, and understand how to accomplish it. Step through the following process to better understand the requirements and the process of connecting a Kubernetes cluster to Azure-Arc.

## Connect an Azure Arc-enabled Kubernetes cluster to Azure-Arc

The following steps provide a high-level overview of the process for connecting an Azure Arc-enabled Kubernetes cluster to Azure-Arc:

1. Set up and run a Kubernetes cluster.

1. Prepare a *kubeconfig* file. The *kubeconfig* file is used to access your cluster.

    - *Kubeconfig* files are configuration files that are used to organize information about Kubernetes clusters such as users, namespaces, authentication.
    - There can be multiple *kubeconfig files* in a cluster.
    - You can use the `kubectl config` command to manage and manipulate them.

1. Add the **cluster-admin** role on the cluster. The **cluster-admin** role allows you to deploy the required Azure Arc-enabled Kubernetes agents.

1. Enable **Read** and **Write** permissions on the `Microsoft.Kubernetes/connectedclusters` resource type.

    - These permissions should be enabled for whatever user account or service principal you use with `az login` and `az connectedk8s connect` commands.

1. Install **Helm 3**. **Helm** allows you to use the **connectedk8s** extension for onboarding and managing your cluster.

    > [!NOTE]
    > *Helm* is an open-source package management tool that helps you to install and manage Kubernetes applications. Helm is used to manage Kubernetes packages of pre-configured Kubernetes resources called *charts*.

1. Install the **Azure command-line interface** (Azure CLI) or update your existing Azure CLI installation to the latest version.

    > [!NOTE]
    > *Azure CLI* is a set of commands used to create and manage Azure resources including the Kubernetes clusters you connect to Azure. Azure CLI needs to be version 2.3 or greater.

1. Install the following Azure Arc-enabled Kubernetes extensions:

    - **connectedk8s**. Connects Kubernetes clusters to Azure.
    - **k8sconfiguration**. Provides tools for managing your Kubernetes configuration in Azure.

1. Configure networking to allow the Azure Arc agents to use the required networking protocols, ports, and outbound URLs. For example, Azure Arc agents require network access to the following:

    - For Hypertext Transfer Protocol Secure (HTTPS): **Transmission Control Protocol (TCP)** on port **443**.
    - For Git: **TCP** on port **9418**.

1. Register the resource providers `Microsoft.Kubernetes` and `Microsoft.KubernetesConfiguration`. The providers have Azure Arc resources for connecting and managing your Kubernetes clusters.

1. Create a new Azure resource group to store the metadata for your cluster.

    > [!TIP]
    > Keeping your clusters in a dedicated Azure resource group helps you manage the clusters more effectively.

1. Connect the Kubernetes cluster to Azure by using the Azure CLI command `az connectedk8s connect`.

1. Deploy Azure Arc Agents for Kubernetes into the `azure-arc` namespace by using **Helm 3**.

1. Configure your cluster by using the Azure CLI command `az k8sconfiguration`

    > [!NOTE]
    > You can also review and manage your Kubernetes cluster as a resource in Azure portal. Azure portal provides a feature-rich GUI for managing your clusters.
