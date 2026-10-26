Imagine that you want to create an Azure Kubernetes Service (AKS) cluster for a new video game your team is working on. You'd like to try out using Azure Policy to govern this cluster. Based on your research, you decide to start with the following policies:

- Allow images only from trusted registries into the cluster
- Kubernetes cluster pod security restricted standards for Linux-based workloads initiative

The first step would be to create an AKS cluster that has Azure Policy enabled.

## Create an AKS cluster with the Azure Policy add-on

Before creating the lab resources, check registration of `Microsoft.ContainerService` for AKS, `Microsoft.ContainerRegistry` for ACR, and `Microsoft.PolicyInsights` for Azure Policy in the selected subscription. Confirm that you have the permissions described in the introduction, including policy-assignment permissions and permission to grant registry pull access. Subscription access or Contributor access alone doesn't cover every step in this module.

Use **Bash in Azure Cloud Shell**, which includes Azure CLI and `kubectl`. The examples use Bash variables and here-documents and aren't PowerShell or Command Prompt scripts. If running locally, install a current Azure CLI and use a Bash environment. Run `az login`, and install `kubectl` with `az aks install-cli` if it isn't already available. Run `az --version` to check your CLI version.

Use an AKS version currently supported in your deployment region. This exercise creates a new cluster without pinning an older Kubernetes release. See AKS supported Kubernetes versions.

Azure Policy compliance reporting doesn't require enabling Azure Monitor container-log collection. This module uses Azure Policy compliance views and Kubernetes events. Collecting policy component logs in Azure Monitor is a separate configuration; see Enable monitoring for AKS.

### Setting up the environment

Set up Cloud Shell for the lab:

1. Sign in to the Azure portal.
1. If **Microsoft.CloudShell** isn't registered for the subscription, open **Subscriptions**, select the subscription, open **Resource providers**, find **Microsoft.CloudShell**, and select **Register**. Ask an administrator if you don't have permission.
1. Open **Cloud Shell** from the portal's top navigation.
1. On first use, select **Bash**.
1. In **Getting started**, select **No storage account required**, choose the lab subscription, and select **Apply**. If Cloud Shell is already configured, open Bash in the existing environment instead; don't reset or delete existing storage merely to follow this lab.

For details of this setup flow, see Cloud Shell ephemeral sessions.

Select the subscription intended for the lab before creating resources. Replace `<subscription-id>` with its actual value, without the angle brackets.

```azurecli
az account set --subscription "<subscription-id>"
az account show --query "{name:name,id:id}" --output table
```

After selecting the lab subscription, check the registration state of the resource providers used in this module.

```azurecli
az provider show --namespace Microsoft.ContainerService --query registrationState --output tsv
az provider show --namespace Microsoft.ContainerRegistry --query registrationState --output tsv
az provider show --namespace Microsoft.PolicyInsights --query registrationState --output tsv
```

> [!NOTE]
> Azure can register resource providers automatically in some deployment paths, so these providers might already be registered. Register only providers required by this exercise. Registration requires the provider's `/register/action` permission at the subscription scope; being Contributor on only the lab resource group doesn't grant that subscription-level permission. For a `MissingSubscriptionRegistration` error, check the namespace named in the error and follow Resolve resource provider registration errors.

If a provider is already `Registered`, no registration step is needed for that provider. For a provider that isn't registered, run its corresponding command below. The `--wait` option waits for registration to finish.

```azurecli
az provider register --namespace Microsoft.ContainerService --wait
az provider register --namespace Microsoft.ContainerRegistry --wait
az provider register --namespace Microsoft.PolicyInsights --wait
```

Run only the registration commands needed for your subscription, and confirm that each succeeds. If you receive a permission error, ask an administrator to perform the registration rather than continuing with an unregistered provider. Rerun the status commands to inspect the result.

> [!NOTE]
> This temporary exercise can use an ephemeral session. Files and Kubernetes credentials in an ephemeral session are lost when it ends. Shell variables are also lost when the shell restarts, even when persistent file storage is used. If you reconnect, select the subscription again, rerun `az aks get-credentials`, confirm the Kubernetes context and namespace, and restore any variables before continuing. For persistent files, follow Cloud Shell with persistent storage; storage charges and separate cleanup can apply.

### Create an AKS cluster and enable the Azure Policy add-on

Now that the required providers are registered, create a dedicated resource group and an AKS cluster within that group. If `videogamerg` already contains unrelated resources, choose a different group name and use it consistently throughout the module.

> [!NOTE]
> The `az aks create` command below doesn't specify a node count, so it creates three worker nodes. It also leaves the VM size unspecified; AKS selects a default using available capacity and quota. Before deploying in `eastus`, review available AKS managed-cluster quota and the regional and VM-family vCPU quotas for your subscription. See AKS quotas, SKUs, and regions. If quota is insufficient, follow the quota-request guidance where your subscription permits increases, or use another approved lab configuration. If you choose another approved region, change the resource-group creation command before creating the lab resources. Available quota doesn't guarantee regional VM capacity.

Create the cluster and enable Azure Policy:

1. Create a resource group.

   ```azurecli
   az group create --location eastus --name videogamerg
   ```

1. Create an AKS cluster using the default settings.

    > [!NOTE]
    > For production workloads, you'd want to further customize the creation of your cluster to ensure it meets your security and governance requirements. We're using a simple cluster purely for training purposes.
    
    ```azurecli
    az aks create --name videogamecluster --resource-group videogamerg 
    ```

    Confirm that the cluster was provisioned successfully.

    ```azurecli
    az aks show \
      --name videogamecluster \
      --resource-group videogamerg \
      --query provisioningState \
      --output tsv
    ```

    Continue to add-on enablement only after the cluster's provisioning state is `Succeeded`. If creation reports a quota, SKU, or capacity error, resolve the reported problem before continuing. Follow the AKS quotas, SKUs, and regions guidance. A supported Kubernetes version and successful provider registration don't establish that enough deployment capacity is available.

1. Enable Azure Policy for the cluster.

    ```azurecli
    az aks enable-addons --addons azure-policy --name videogamecluster --resource-group videogamerg
    ```

### Verify the Azure Policy add-on

Inspect the add-on profile and retrieve the lab cluster's credentials.

```azurecli
az aks show \
  --name videogamecluster \
  --resource-group videogamerg \
  --query addonProfiles.azurepolicy
az aks get-credentials \
  --name videogamecluster \
  --resource-group videogamerg
```

Confirm the Kubernetes context and inspect the Azure Policy and Gatekeeper Pods.

```bash
kubectl config current-context
kubectl get pods --namespace kube-system
kubectl get pods --namespace gatekeeper-system
```

Confirm that the profile contains `enabled: true`, that the context is the lab cluster, and that the Azure Policy and Gatekeeper Pods are Running with their containers ready. Enabling an add-on and completing component startup are separate stages. Resolve installation problems before assigning policy.

See Install the Azure Policy add-on for AKS in the summary unit's **More info** section for installation and troubleshooting guidance, including required outbound connectivity. Don't install a separate unmanaged Gatekeeper alongside the Azure Policy add-on.
