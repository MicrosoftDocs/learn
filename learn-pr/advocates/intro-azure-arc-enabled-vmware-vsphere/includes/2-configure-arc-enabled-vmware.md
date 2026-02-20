Connecting your VMware vCenter Server instance to Azure Arc enables you to start using the Azure Arc-enabled VMware vSphere features. You make this connection with a helper script that deploys the Azure Arc resource bridge virtual appliance in your vCenter environment. Once deployed, the script then installs a VMware cluster extension to provide a continuous connection between vCenter Server and Azure Arc.

Prior to performing these steps, you need access to a Microsoft Entra account that has the Owner, Contributor, or Azure Arc VMware Private Clouds Onboarding role to a resource group in the target subscription. The vCenter server you want to connect also needs to meet the following requirements:

- vCenter Server version 7 or 8.
- A virtual network that can provide internet access, directly or through a proxy. It must also be possible for VMs on this network to communicate with the vCenter server on TCP port (usually 443).
- At least three free static IP addresses on the above network.
- A resource pool or a cluster with a minimum capacity of 16 GB of RAM and 4 vCPUs.
- A datastore with a minimum of 200 GB of free disk space or 400 GB for High Availability deployment, available through the resource pool or cluster.

The vSphere account used for this operation must have the following permissions:

- Read all inventory permission.
- Permission to deploy and update VMs to all the resource pools (or clusters), networks, and VM templates that you want to use with Azure Arc.

The details of this account will be stored locally within the Azure Arc resource bridge VM and encrypted as a Kubernetes secret at rest. The vSphere account allows Azure Arc-enabled VMware to interact with VMware vSphere. If your organization practices routine credential rotation, you'll need to update the credentials in Azure Arc-enabled VMware to maintain the connection between Azure Arc-enabled VMware and VMware vSphere.

To obtain the onboarding script:

1. In the Azure portal, search and select **Azure Arc**.
1. In the **Overview** page, select **Add resources** under **Manage resources across environments**.
1. In the **Host environments** section, in **VMware vSphere** select **Add**.
1. Select Create a new resource bridge and select Next: Basics.
1. Provide a name for Azure Arc resource bridge. For example: contoso-syd-resourcebridge.
1. Select a subscription and resource group where you want to create the resource bridge.
1. Under Region, select an Azure location where you want to store the resource metadata.
1. Provide a name for Custom location. This is the name that you'll see when you deploy virtual machines. Name it for the datacenter or the physical location of your datacenter. For example: contoso-syd-dc.
1. Leave the option Use the same subscription and resource group as your resource bridge selected.
1. Provide a name for your vCenter Server instance in Azure. For example: contoso-syd-vcenter.
1. You can choose to Enable Kubernetes Service on VMware. If you choose to do so, ensure you update the namespace of your custom location to "default" in the onboarding script: $customLocationNamespace = ("default".ToLower() -replace '[^a-z0-9-]', ''). 
1. Select Next: Tags and assign Azure tags to your resources in Value under Physical location tags. You can add additional tags to help you organize your resources to facilitate administrative tasks using custom tags.
1. Select Next: Download and run script and download and run the script.

If your subscription isn't registered with all the required resource providers, a Register button appears. A typical onboarding that uses the script takes between 30 and 60 minutes. During the process, you're prompted for the following details:

| **Requirement** | **Details** |
|---|---|
| **Azure login** | When you're prompted, go to the device sign-in page, enter the authorization code shown in the terminal, and sign in to Azure. |
| **vCenter FQDN/Address** | Enter the fully qualified domain name for the vCenter Server instance (or an IP address). For example: **10.160.0.1** or **syd-vcenter.contoso.com**. |
| **vCenter Username** | Enter the username for the vSphere account. |
| **vCenter password** | Enter the password for the vSphere account. |
| **Data center selection** | Select the name of the datacenter (as shown in the vSphere client) where the Azure Arc resource bridge VM should be deployed. |
| **Network selection** | Select the name of the virtual network or segment to which the Azure Arc resource bridge VM must be connected. This network should allow the appliance to communicate with vCenter Server and the Azure endpoints (or internet). |
| **Static IP** | Arc Resource Bridge requires static IP address assignment and DHCP isn't supported.<br>1. **Static IP address prefix**: Network address in CIDR notation. For example: **192.168.0.0/24**.<br>2. **Static gateway**: Gateway address. For example: **192.168.0.0**.<br>3. **DNS servers**: IP address(es) of DNS server(s) used by Azure Arc resource bridge VM for DNS resolution. Azure Arc resource bridge VM must be able to resolve external sites, like mcr.microsoft.com and the vCenter server.<br>4. **Start range IP**: Minimum size of two available IP addresses is required. One IP address is for the Azure Arc resource bridge VM, and the other is reserved for upgrade scenarios. Provide the starting IP address of that range. Ensure the Start range IP has internet access.<br>5. **End range IP**: Last IP address of the IP range requested in the previous field. Ensure the End range IP has internet access. |
| **Control Plane IP address** | Azure Arc resource bridge runs a Kubernetes cluster, and its control plane always requires a static IP address. Provide an IP address that meets the following requirements:<br>- The IP address must have internet access.<br>- The IP address must be within the subnet defined by IP address prefix.<br>- If you're using static IP address option for resource bridge VM IP address, the control plane IP address must be outside of the IP address range provided for the VM (Start range IP - End range IP). |
| **Resource pool** | Select the name of the resource pool to which the Azure Arc resource bridge VM will be deployed. |
| **Data store** | Select the name of the datastore to be used for the Azure Arc resource bridge VM. |
| **Folder** | Select the name of the vSphere VM and the template folder where the Azure Arc resource bridge's VM will be deployed. |
| **Appliance proxy settings** | Enter **y** if there's a proxy in your appliance network. Otherwise, enter **n**.<br>You need to populate the following boxes when you have a proxy set up:<br>1. **Http**: Address of the HTTP proxy server.<br>2. **Https**: Address of the HTTPS proxy server.<br>3. **NoProxy**: Addresses to be excluded from the proxy.<br>4. **CertificateFilePath**: For SSL-based proxies, the path to the certificate to be used. |

After the command finishes running, your setup is complete, and you can use the capabilities of Azure Arc-enabled VMware vSphere.

## Deploy Arc-enabled VMware vSphere for Azure VMware Solution private cloud

Arc-enabled VMware vSphere for Azure VMware Solution private cloud functions in a manner similar to Arc-enabled VMware vSphere, except that with Azure VMware Solution, your VMware deployment is already hosted in Azure rather than an on-premises datacenter. 

Arc-enabled Azure VMware Solution allows you to do the following actions:

- Identify your VMware vSphere resources (VMs, templates, networks, datastores, clusters/hosts/resource pools) and register them with Arc at scale.
- Perform different virtual machine (VM) operations directly from Azure like; create, resize, delete, and power cycle operations (start/stop/restart) on VMware VMs consistently with Azure.
- Permit developers and application teams to use VM operations on-demand with Role-based access control.
- Install the Arc-connected machine agent to govern, protect, configure, and monitor them.
- Browse your VMware vSphere resources (vms, templates, networks, and storage) in Azure

To deploy Arc for Azure VMware Solution, you need to ensure that you have registered the following providers in your subscription:

- Microsoft.ConnectedVMwarevSphere
- Microsoft.ExtendedLocation  
- Microsoft.KubernetesConfiguration
- Microsoft.ResourceConnector
- Microsoft.AVS

You can do this using Azure CLI or by navigating to Resource providers and registering each provider in the target subscription. You also need a resource group in the target subscription where you have owner or contributor role.

To onboard Azure Arc for Azure VMware Solution:

1. Sign into the Management VM and extract the contents of the deployment files and scripts you've downloaded from <https://github.com/Azure/ArcOnAVS/releases/latest>. 
1. Edit the config_avs.json file and configure all of the necessary variables.

```json
{
  "subscriptionId": "",
  "resourceGroup": "",
  "applianceControlPlaneIpAddress": "",
  "privateCloud": "",
  "isStatic": true,
  "staticIpNetworkDetails": {
   "networkForApplianceVM": "",
   "networkCIDRForApplianceVM": "",
   "k8sNodeIPPoolStart": "",
   "k8sNodeIPPoolEnd": "",
   "gatewayIPAddress": ""
  }
}
```

1. Run the installation scripts.

To verify that the script has completed successfully, perform the following steps:

1. In the left navigation, locate Operations.
1. Choose Azure Arc.
1. Azure Arc state shows as Configured.

When Arc appliance is successfully deployed on your private cloud, you can perform the following actions.

- View the status from within the private cloud left navigation under **Operations > Azure Arc**.
- View the VMware vSphere infrastructure resources from the private cloud left navigation under **Private cloud** then select **Azure Arc vCenter Server resources**.
- Discover your VMware vSphere infrastructure resources and project them to Azure by navigating, **Private cloud > Arc vCenter Server resources > Virtual Machines**.
- Enable networks, templates, resource pools, and data-stores in Azure.

To make resources in your Azure VMware Solution private cloud enabled for Azure, perform the following steps:

1. On your Azure VMware Solution private cloud, in the left navigation, locate **vCenter Server Inventory**.
1. Select the resources you want to enable, then select **Enable in Azure**.
1. Select your Azure **Subscription** and **Resource Group**, then select **Enable**.

The enable action starts a deployment and creates a resource in Azure, creating representative objects in Azure for your VMware vSphere resources. It allows you to manage who can access those resources through Role-based access control granularly.

## Roles and permissions

You assign permissions to resources in Azure by adding security principals to role based access control roles. The Built-in Roles for Azure Arc-enabled VMware vSphere include

- Azure Arc VMware Administrator role. Members of this role have permissions to perform all connected VMware vSphere actions (full administrative access to all Arc-enabled VMware vSphere resources).
- Azure Arc VMware Private Cloud User. Members of this role have permissions to use the VMware cloud resources (resource pools, clusters/hosts, networks, datastores, templates) to deploy VMs.
- Azure Arc VMware Private Clouds Onboarding. Members of this role have permissions to provision all required resources to onboard or offboard (deboard) VMware vCenter instances to Azure Arc.
- Azure Arc VMware VM Contributor. Members of this role have permissions to perform all virtual machine (VM) operations, that is, create, modify, delete, and manage VMs in Arc-enabled vSphere

You should always assign the minimum required permissions to security principals. The following table lists the minimum role required to perform common Arc-enabled VMware vSphere related administrative tasks:

| **Operation** | **Minimum role required** | **Scope** |
|---|---|---|
| **Onboarding your vCenter Server to Arc** | Azure Arc VMware Private Clouds Onboarding | On the subscription or resource group into which you want to onboard |
| **Administering Arc-enabled VMware vSphere** | Azure Arc VMware Administrator | On the subscription or resource group where vCenter server resource is created |
| **VM Provisioning** | Azure Arc VMware Private Cloud User | On the subscription or resource group that contains the resource pool/cluster/host, datastore, and virtual network resources, or on the resources themselves |
| **VM Provisioning** | Azure Arc VMware VM Contributor | On the subscription or resource group where you want to provision VMs |
| **VM Operations** | Azure Arc VMware VM Contributor | On the subscription or resource group that contains the VM, or on the VM itself |
