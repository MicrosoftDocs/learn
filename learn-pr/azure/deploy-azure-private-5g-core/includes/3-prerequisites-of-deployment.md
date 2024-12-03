Before you create a private mobile network, complete the following tasks:

- **Order and set up your Azure Stack Edge Pro devices:** Follow the [checklist](/azure/databox-online/azure-stack-edge-gpu-deploy-checklist?pivots=single-node) to order and register your ASE device in the Azure cloud.
For ASE configuration, see [Prepare to deploy a private mobile network - Azure Private 5G Core Preview](/azure/private-5g-core/complete-private-mobile-network-prerequisites).
- **Create subscription**: You must follow the standard Azure procedure to [create a subscription](/azure/cost-management-billing/manage/create-subscription). Ensure you have owner or contributor-level access to this Azure subscription by navigating to **Home > Subscriptions > Your-subscription > Resource providers** in the Azure portal.
Register the Mobile Network resource provider (Microsoft.MobileNetwork) for your subscription, as described in [Azure resource providers and types](/azure/azure-resource-manager/management/resource-providers-and-types).

  > [!NOTE]
  > A single subscription can be used for multiple mobile networks, for example, each in their own resource group.

- **Choose the packet core type**:  Each site in the private mobile network should provide coverage for 5G or 4G user equipment (UEs).

  > [!Note]
  >  Azure Private 5G Core connects with any standard 5G standalone radios over standard N1/N2/N3 interfaces. The 5G core network functions comply with 3GPP specifications.

- **Allocate subnet and IP addresses**: Azure Private 5G Core requires a management network, an access network, and one or more data network. These networks might be part of the same larger network, or they can be separate. The approach you use depends on your traffic separation requirements.
For each of these networks, allocate a subnet and then identify the listed IP addresses. If you're deploying multiple sites, you need to collect this information for each site.
- **Allocate user equipment (UE) IP address pools**:  Azure Private 5G Core supports the following IP address allocation methods for UEs:
  - **Dynamic**: Dynamic IP address allocation automatically assigns a new IP address to the UE each time it connects to the private mobile network.
  - **Static**: Static IP address allocation ensures that the UE receives the same IP address every time it connects to the private mobile network. This configuration is useful when you want Internet of Things (IoT) applications to consistently connect to the same device. For example, you can configure a video analysis application with the IP addresses of the cameras providing video streams. If these cameras have static IP addresses, you don't need to reconfigure the video analysis application with new IP addresses each time the cameras restart. You allocate static IP addresses to the  UE as part of [provisioning its SIM](/azure/private-5g-core/provision-sims-azure-portal).
- **Configure Domain Name System (DNS) servers**:  DNS allows the translation between human-readable domain names and their associated machine-readable IP addresses.  

  > [!Note]
  > If you don't configure DNS servers for a data network, all UEs using that network will be unable to resolve domain names.

Depending on your requirements, you have the following options for configuring a DNS server for your data network:

- If you need the UEs connected to this data network to resolve domain names, you must configure one or more DNS servers. You must use a private DNS server if you need DNS resolution of internal hostnames. If you're only providing internet access to public DNS names, you can use a public or private DNS server.
- If you don't need the UEs to perform DNS resolution, you can omit this configuration. Also omit it if all UEs in the network use their own locally configured DNS servers instead of the DNS servers signaled to them by the packet core.
- **Set up the ports required for local access**: Set up the ports required to open for Azure Private 5G Core local access, including local management access and control plane signaling. Make sure to open the relevant ports to allow the inbound traffic from the remote access VM to the ASE local UI, Azure Kubernetes Service (AKS) cluster, and Grafana dashboard.

To ensure successful connectivity of all the ASE and Azure Private 5G Core infrastructure to Azure services, we recommend configuring a firewall to allow all outbound traffic.

If you don't want to allow all outbound traffic, configure the firewall with Azure services specific IP addresses and the URLs. Contact Microsoft Support to obtain the list of Azure services specific IP address and URL details.

You should set up these ports in addition to the [ports required for Azure Stack Edge (ASE)](/azure/databox-online/azure-stack-edge-gpu-system-requirements).

In addition to the 5G core software, you need to purchase the following to complete your solution:

- **SIMs and RANs**: The ecosystem of trusted Private 5G Core partners can provide you with these components.
- **Azure Stack Edge Pro SKU**: You need to purchase this Microsoft hardware through Azure.

Now that you're ready for the deployment, you can use the Azure portal to complete the following deployment tasks:

1. Create a mobile network.
1. Create a site.
1. Configure services and SIM policies.
