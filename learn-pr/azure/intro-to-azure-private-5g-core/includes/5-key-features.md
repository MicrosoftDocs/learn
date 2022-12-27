Azure Private 5G Core provides 5G and 4G network functions for enterprise private mobile networks. It allows you to manage the network functions centrally from the Azure portal. While providing the convenience of central management through the cloud, the private MEC solution powered by Azure Private 5G Core can ensure data security and low latency levels with local data processing.

This unit introduces the key features of Azure Private 5G Core.

## Supported 5G network functions

- Access and Mobility Management Function (AMF)
- Session Management Function (SMF)
- User Plane Function (UPF)
- Policy Control Function (PCF)
- Authentication Server Function (AUSF)
- Unified Data Management (UDM)
- Unified Data Repository (UDR)

## Supported 4G network functions

Azure Private 5G Core uses the following network functions when supporting 4G UEs.

- Mobile Management Entity (MME)
- MME-Proxy - The MME-Proxy works to allow 4G UEs to be served by 5G network functions.

To support 4G UEs, the 5G UDR operates as a Home Subscriber Store (HSS), and the 5G UPF operates as a System Architecture Evolution Gateway (SAEGW-U).

## Azure centralized service management

Azure Private 5G Core is available as a native Azure service, offering the same levels of reliability, security, and availability for deployment and management as all Azure services. This allows you to use Azure as a central access point to manage individual instances of private mobile networks across multiple enterprise sites.

You can use the Azure portal or Azure Resource Manager (ARM) APIs to perform tasks like:

- Deploy and configure a packet core instance on your Azure Stack Edge device.
- Provision SIM resources to authenticate devices in the network.
- Employ platform metrics or other observability services to view the health of your network and take corrective action through Azure.
- Use Azure role-based access control (RBAC) to allow granular access to the private mobile network.
- Access the large ecosystem of Microsoft independent software vendor (ISV) partners for applications and network functions.

## Flexible integration with Azure private MEC partners

Each packet core instance is standards-compliant and compatible with several RAN partners in the Azure private MEC ecosystem.

Azure Private 5G Core respectively exposes the N1 and N2 interfaces for the 5G control plane, and the N3 and N6 interfaces for the 5G user plane. It complies with the relevant 3GPP Technical Specifications, allowing you to integrate with a wide range of RAN models. For 4G, it exposes S1-MME and S1-U interfaces to interoperate with 4G RAN models.

Azure Private 5G Core also employs a simple, scalable provisioning model to allow you to bring the SIM partner of your choice to Azure.

## UE authentication and security context management

Azure Private 5G Core supports authentication methods like:

- Authentication using Subscription Permanent Identifiers (SUPI) and 5G Globally Unique Temporary Identities (5G-GUTI) for 5G user equipment (UEs).
- Authentication using International Mobile Subscriber Identities (IMSI) and Globally Unique Temporary Identities (GUTI) for 4G UEs.
- 5G Authentication and Key Agreement (5G-AKA) for mutual authentication between 5G UEs and the network.
- Evolved Packet System based Authentication and Key Agreement (EPS-AKA) for mutual authentication between 4G UEs and the network.

The packet core instance performs ciphering and integrity protection of 5G non-access stratum (NAS). During UE registration, the UE includes its security capabilities for 5G NAS with 128-bit keys.

## Network slicing and multiple data networks (DNs) support

Azure Private 5G Core allows you to divide a private mobile network into multiple network slices. Each slice is a logical end-to-end network. To support different requirements of different UEs in the network, you can configure SIM policies with different slices available, and then assign the SIM policies to relevant SIMs representing the UEs.

Additionally, the packet core instance at each site can connect to multiple DNs. You can use different DNs for different applications. Each UE can connect to multiple DNs simultaneously. Both 4G and 5G network functions in Azure Private 5G Core support multiple DNs.

Azure Private 5G Core supports up to three DNs and eight network slices per site. You can configure UEs in a network slice to connect to different DNs.
