Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading operational work to Azure. Azure manages the Kubernetes control plane and critical tasks such as health monitoring and maintenance. AKS clusters use one of three cluster management pricing tiers: **Free**, **Standard**, or **Premium**. The Free tier has no cluster management charge but provides only best-effort uptime (no financial SLA). The Standard tier includes a 99.9% Uptime SLA (99.95% when the cluster uses Availability Zones). The Premium tier provides the same Uptime SLA as Standard (99.9%, or 99.95% with Availability Zones) and is the required pricing tier for enabling Long Term Support (LTS). When you use Premium, you also explicitly select the LTS support plan (`--k8s-support-plan AKSLongTermSupport`), which extends Kubernetes version support to two years from GA (one year of community support plus one additional year of long-term support).

AKS nodes run on Azure virtual machines (VMs). With AKS nodes, you can connect storage to nodes and pods, upgrade cluster components, and use GPUs. AKS supports Kubernetes clusters that run multiple node pools to support mixed operating systems and Windows Server containers.

When you deploy an AKS cluster, you choose settings such as node count, VM size, region, networking, monitoring, and integrations. AKS deploys and configures the Kubernetes control plane and nodes.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

> [!NOTE]
> This exercise creates a standard, custom-configured AKS cluster. It doesn't use AKS Automatic.

1. Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
2. Select **Create a resource**.
3. Search the marketplace for **Azure Kubernetes Service (AKS)**, or browse **Categories** > **Infrastructure Services** (or **Containers**, depending on the portal version) > **Azure Kubernetes Service (AKS)**, and then select **Create**.
4. Configure **Basics**:
   - Under **Project details**, select an Azure **Subscription**, and create or select the resource group **myResourceGroup**. For testing or evaluation, use a separate resource group so you can remove the lab resources without affecting production or development workloads.
   - Under **Cluster details**, set **Cluster preset configuration** to **Dev/Test**, enter **myAKSCluster** for **Kubernetes cluster name**, choose a **Region**, set **Fleet manager** to **None**, set **Availability zones** to **None** (this evaluation lab uses **None** to keep deployment simple and avoid regional SKU constraints; production node pools should use Availability Zones in supported regions), explicitly set **AKS pricing tier** to **Free** (the Dev/Test preset doesn't change the pricing tier, so you must select Free yourself), and leave **Kubernetes version** at the default N-1 latest patch version.
   - Under **Authentication and Authorization**, set the option to **Local accounts with Kubernetes RBAC** for this evaluation lab to keep the steps minimal and avoid an extra Azure RBAC role assignment. For production clusters, choose **Microsoft Entra ID authentication with Azure RBAC** instead, and grant your account both the **Azure Kubernetes Service Cluster User Role** (which allows `az aks get-credentials` to download the kubeconfig) and an additional Kubernetes-API role (for example, **Azure Kubernetes Service RBAC Reader**) so `kubectl` calls succeed. On Microsoft Entra ID-integrated clusters, the Cluster User Role alone only enables kubeconfig download and triggers a sign-in prompt — Kubernetes API permissions are then governed by the user's Microsoft Entra group membership and the assigned Azure RBAC for Kubernetes role. On clusters that don't use Microsoft Entra ID (such as the local-accounts cluster created in this lab), the Cluster User Role grants admin-equivalent access. For Microsoft Entra ID-integrated clusters running Kubernetes 1.24 or later, the `kubelogin` exec-plugin format is configured in the kubeconfig automatically for interactive Azure CLI sign-in, so no extra conversion is required. The lab cluster created here uses local accounts, so `kubelogin` isn't involved in the lab connection step. After the lab, you can enforce Microsoft Entra ID authentication by first enabling Microsoft Entra integration on the cluster and then disabling local accounts. **Do not disable local accounts on this lab cluster as configured** — it uses local accounts only, and disabling them without first enabling Microsoft Entra integration locks every user out of the cluster. The correct sequence is to first enable Microsoft Entra ID authentication: `az aks update --resource-group myResourceGroup --name myAKSCluster --enable-aad --aad-admin-group-object-ids <entra-group-object-id>`. If you also want to use Azure RBAC for Kubernetes Authorization, then enable it: `az aks update --resource-group myResourceGroup --name myAKSCluster --enable-azure-rbac` and assign AKS RBAC roles to the appropriate Microsoft Entra users or groups. Only after Microsoft Entra integration is in place should you run `az aks update --resource-group myResourceGroup --name myAKSCluster --disable-local-accounts`.
   - Select **Next: Node pools**.
5. Configure **Node pools**:
   - Accept the Dev/Test preset defaults for the system node pool. If you change **Node size**, choose a supported D-series SKU such as **Standard_D4ds_v5**; B-series VMs aren't supported for system node pools.
   - Leave virtual nodes disabled for this exercise.

   > [!NOTE]
   > Virtual nodes require Azure CNI in flat-networking mode (the documented examples use Azure CNI Node Subnet) with a delegated virtual-node subnet, because Azure Container Instances need direct VNet-routable pod IPs. As a result, virtual nodes aren't compatible with **Azure CNI Overlay** and are out of scope for this lab — see the virtual nodes documentation.

   - Select **Next: Networking**.
6. Configure **Networking**:
   - Set the network configuration option (labeled **Container networking** or **Network configuration** depending on the portal version) to **Azure CNI Overlay**. Use kubenet only for legacy clusters; kubenet retires on March 31, 2028.
   - Set **Network dataplane** to **Cilium (Azure CNI Powered by Cilium)**.
   - Set **Network policy** to **Cilium** (recommended).

     > [!NOTE]
     > This **Network policy** selection overrides the Dev/Test preset default of **None**.

   - Accept the default **DNS name prefix**, virtual network, and subnet values for this lab.
   - Select **Next: Integrations**.
7. Configure **Integrations**:
   - Optionally attach an existing **Azure Container Registry** under **Azure Container Registry** (skip if you don't have one — you can attach an ACR later with `az aks update --name myAKSCluster --resource-group myResourceGroup --attach-acr <acr-name>`). The command creates an `AcrPull` role assignment for the kubelet managed identity, so the caller needs permission to create role assignments on the registry. The command isn't supported for ABAC-enabled ACR registries (RBAC Registry + ABAC Repository Permissions); for those, manually assign the `Container Registry Repository Reader` role to the kubelet managed identity instead.
   - Enable **Container insights** (Azure Monitor) for cluster observability.
   - For this lab, leave **Managed Prometheus**, **Azure Managed Grafana**, **Azure Policy**, and **Defender for Containers** disabled to minimize cost. Enable each in production for managed metrics, governance, and runtime threat protection.
   - Select **Next: Monitoring**.
8. Review **Monitoring**:
   - Review **Container insights** and alert rules, and confirm the lab settings are selected.
   - Select **Next: Advanced**.
9. Review **Advanced**:
   - Accept the defaults for this lab.
   - Select **Next: Tags**.
10. Review **Tags**:
   - Accept the defaults and select **Next: Review + create**.
11. Validate and create the cluster:
   - Review the settings. If validation fails, update the settings identified by the validation message.
   - Select **Create**.
12. Open the deployed cluster:
   - When the deployment completes, select **Go to resource**, or open **myResourceGroup** and select **myAKSCluster**.
13. Connect to the cluster from Azure Cloud Shell:
   - Select **Connect**.
   - Start **Cloud Shell**.
   - Run the following command to download the cluster credentials:

     ```bash
     az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
     ```

14. Verify the connection:
   - Run the following command to verify that `kubectl` can connect to the cluster:

     ```bash
     kubectl get nodes
     ```

   - Optionally, list deployments across all namespaces (you can use the `-A` shorthand for `--all-namespaces`):

     ```bash
     kubectl get deployments --all-namespaces
     ```

15. Clean up:
   - When you're finished with the lab, delete **myResourceGroup**. Deleting this resource group deletes the AKS resource and its managed node resource group, including cluster infrastructure such as nodes, the Standard Load Balancer, and public IP addresses. The Free tier removes only the cluster management charge, not the cost of consumed resources.

     ```bash
     az group delete --name myResourceGroup --yes --no-wait
     ```

   - Container insights uses a Log Analytics workspace for logs. It might create a Log Analytics workspace outside **myResourceGroup** (for example, a `DefaultWorkspace-<GUID>-<Region>` workspace), or it might use an existing workspace. Check for any Log Analytics workspace created or selected only for this lab outside **myResourceGroup** and delete that lab-created workspace too. If you enabled Managed Prometheus or Azure Managed Grafana, also remove any Azure Monitor workspace or Grafana resource created only for this lab. Don't delete workspaces or Grafana resources that predate the lab or are used by other resources.
