Contoso Manufacturing eliminated public RDP and SSH exposure from factory virtual machines by implementing Azure Bastion as a centralized secure gateway. The deployment transformed the security posture from VMs with internet-facing management ports to a zero-public-IP architecture where all remote access flows through a hardened platform service.

## What you accomplished

You planned an Azure Bastion deployment by selecting the appropriate SKU based on scale, feature, and cost requirements. The SKU comparison showed that Developer provides no-cost individual access, Basic supports small teams with browser-only connectivity, Standard adds native client support and scaling for enterprise deployments, and Premium includes session recording for compliance requirements.

You deployed and configured Azure Bastion by creating the required AzureBastionSubnet with a minimum /26 prefix, associating a Standard static public IP, and enabling advanced features. Native client support preserved existing RDP tooling workflows for operational engineers. Host unit scaling configured capacity for concurrent session requirements. Network security group rules permitted the specific traffic flows required for Bastion operations.

You connected to virtual machines through Azure Bastion using browser-based sessions for quick access and native client tunneling for full RDP client features. The browser method works across all platforms without software installation. Native client tunneling through Azure CLI enables drive redirection, clipboard synchronization, and custom display configurations. Shareable links provided time-limited access for contractors without Azure portal credentials.

## Key decisions for Azure Bastion

Azure Bastion eliminates the need for public IP addresses on virtual machines and removes the requirement for open RDP and SSH ports in network security groups. This architectural shift transforms the attack surface by removing direct internet exposure while preserving operational access through a managed platform service.

SKU selection balances capability requirements against cost:
- **Developer**: Individual use, no host unit charges, browser-only
- **Basic**: Small teams, fixed two host units, browser-only, no native client
- **Standard**: Enterprise scale, configurable host units, native client support, IP-based connections
- **Premium**: Compliance environments add session recording and private-only mode

The AzureBastionSubnet must be named exactly **AzureBastionSubnet** (case-sensitive) and sized with a minimum /26 prefix. This dedicated subnet hosts the Bastion infrastructure and requires specific network security group rules for Azure management operations and user connectivity.

Native client tunneling preserves existing workflows for users who depend on RDP client features or specific SSH tools. The Azure CLI establishes a localhost tunnel, and users connect their standard clients to the local port. This approach delivers browser-based security with native client functionality.

## Learn more

- [Azure Bastion overview](/azure/bastion/bastion-overview)
- [Azure Bastion configuration settings](/azure/bastion/configuration-settings)
- [Connect to VMs using native client](/azure/bastion/native-client)
- [Session recording](/azure/bastion/session-recording)
