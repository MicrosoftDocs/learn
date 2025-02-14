This unit walks through the steps to apply the principles of Zero Trust across the Azure Virtual Desktop reference architecture.

## Step 1: Secure your identities with Zero Trust

To apply Zero Trust principles to the identities used in Azure Virtual Desktop:

 -  Azure Virtual Desktop supports different types of [identities](/azure/virtual-desktop/prerequisites#supported-identity-scenarios). Use the information in [Securing identity with Zero Trust](/security/zero-trust/deploy/identity) to ensure that your chosen identity types adhere to Zero Trust principles.
 -  Create a dedicated user account with least privileges to join session hosts to a Microsoft Entra Domain Services or AD DS domain during session host [deployment](/azure/virtual-desktop/prerequisites#deployment-parameters).

## Step 2: Secure your endpoints with Zero Trust

Endpoints are the devices through which users access the Azure Virtual Desktop environment and session host virtual machines. Use the instructions in the [Endpoint integration overview](/security/zero-trust/integrate/endpoints) and use Microsoft Defender for Endpoint and Microsoft Endpoint Manager to ensure that your endpoints adhere to your security and compliance requirements.

## Step 3: Apply Zero Trust principles to Azure Virtual Desktop storage resources

Implement the steps in [Apply Zero Trust principles to Storage in Azure](/security/zero-trust/azure-infrastructure-storage) for the storage resources being used in your Azure Virtual Desktop deployment. These steps ensure that you:

 -  Secure your Azure Virtual Desktop data at rest, in transit, and in use.
 -  Verify users and control access to storage data with the least privileges.
 -  Implement private endpoints for storage accounts.
 -  Logically separate critical data with network controls. Such as separate storage accounts for different host pools and other purposes such as with MSIX app attach file shares.
 -  Use Defender for Storage for automated threat protection.

## Step 4: Apply Zero Trust principles to hub and spoke Azure Virtual Desktop VNets

A hub VNet is a central point of connectivity for multiple spoke virtual networks. Implement the steps in [Apply Zero Trust principles to a hub virtual network in Azure](/security/zero-trust/azure-infrastructure-networking) for the hub VNet being used to filter outbound traffic from your session hosts.

A spoke VNet isolates the Azure Virtual Desktop workload and contains the session host virtual machines. Implement the steps in [Apply Zero Trust principles to spoke virtual network in Azure](/security/zero-trust/azure-infrastructure-iaas) for the spoke VNet that contains the session host/virtual machines.

Isolate different host pools on separate VNets using [NSG](/azure/virtual-network/network-security-groups-overview) with the required URL necessary for Azure Virtual Desktop for each subnet. When deploying the private endpoints place them in the appropriate subnet in the VNet based on their role.

Azure Firewall or a network virtual appliance (NVA) firewall can be used to control and restrict outbound traffic Azure Virtual Desktop session hosts. Use the instructions [here](/azure/firewall/protect-azure-virtual-desktop?tabs=azure) for Azure Firewall to protect session hosts. Force the traffic through the firewall with [User-Defined Routes (UDRs)](/azure/virtual-network/virtual-networks-udr-overview#user-defined) linked to the host pool subnet. Review the full list of required [Azure Virtual Desktop URLs](/azure/virtual-desktop/safe-url-list?tabs=azure) to configure your firewall. Azure Firewall provides an Azure Virtual Desktop [FQDN Tag](/azure/firewall/fqdn-tags#current-fqdn-tags) to simplify this configuration.

## Step 5: Apply Zero Trust principles to Azure Virtual Desktop session hosts

Session hosts are virtual machines that run inside a spoke VNet. Implement the steps in [Apply Zero Trust principles to virtual machines in Azure](/security/zero-trust/azure-infrastructure-virtual-machines) for the virtual machines being created for your session hosts.

[Host pools](/azure/virtual-desktop/environment-setup#host-pools) should have separated organizational units (OUs) if managed by [group policies](/windows-server/remote/remote-desktop-services/clients/rdp-files?context=%2Fazure%2Fvirtual-desktop%2Fcontext%2Fcontext) on [Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview).

Microsoft Defender for Endpoint is an enterprise endpoint security platform designed to help enterprise networks prevent, detect, investigate, and respond to advanced threats. You can use Microsoft Defender for Endpoint for session hosts. For more information, see [virtual desktop infrastructure (VDI) devices](/windows/security/threat-protection/microsoft-defender-atp/configure-endpoints-vdi).

## Step 6: Deploy security, governance, and compliance with Azure Virtual Desktop

Azure Virtual Desktop service allows you to use [Azure Private Link](/azure/virtual-desktop/private-link-overview) to privately connect to your resources by [creating private endpoints](/azure/virtual-desktop/private-link-setup).

Azure Virtual Desktop has built-in advanced security features to protect session hosts. However, see the following articles to improve the security defenses of your Azure Virtual Desktop environment and session hosts:

 -  [Azure Virtual Desktop security best practices](/azure/virtual-desktop/security-guide)
 -  [Azure security baseline for Azure Virtual Desktop](/security/benchmark/azure/baselines/azure-virtual-desktop-security-baseline?context=%2Fazure%2Fvirtual-desktop%2Fcontext%2Fcontext)

In addition, see the key design considerations and recommendations for [security, governance, and compliance](/azure/cloud-adoption-framework/scenarios/wvd/eslz-security-governance-and-compliance) in Azure Virtual Desktop landing zones in accordance with Microsoft's Cloud Adoption Framework.

## Step 7: Deploy secure management and monitoring to Azure Virtual Desktop

Management and continuous monitoring are important to ensure that your Azure Virtual Desktop environment is not engaging in malicious behavior. Use [Azure Virtual Desktop Insights](/azure/virtual-desktop/insights) to log data and report diagnostic and usage data.

See these additional articles:

 -  Review recommendations from [Azure Advisor for Azure Virtual Desktop](/azure/virtual-desktop/azure-advisor-recommendations).
 -  Use [Microsoft Intune](/azure/virtual-desktop/management#microsoft-intune) for granular policy management.
 -  Review and set [RDP Properties](/azure/virtual-desktop/rdp-properties) for granular settings on a host pool level.
