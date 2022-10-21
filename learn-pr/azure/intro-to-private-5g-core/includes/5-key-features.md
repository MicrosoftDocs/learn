Azure Private 5G Core provides 5G and 4G network functions for enterprise private mobile network. It allows you to manage the network functions centrally from the Azure portal. While providing the convenience of central management through the cloud, the private MEC solution powered by Azure Private 5G Core can ensure data security and low latency levels with local data processing.

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
- Employ Log Analytics and other observability services to view the health of your network and take corrective action through Azure.
- Use Azure role-based access control (RBAC) to allow granular access to the private mobile network.
- Access the large ecosystem of Microsoft independent software vendor (ISV) partners for applications and network functions.

## Flexible integration with Azure private MEC partners

Each packet core instance is standards-compliant and compatible with several RAN partners in the Azure private MEC ecosystem.

Azure Private 5G Core exposes an N2 and N3 interface for the 5G control plane and user plane respectively. It complies with the relevant 3GPP Technical Specifications, allowing you to integrate with a wide range of RAN models. For 4G, it exposes S1-MME and S1-U interfaces to interoperate with 4G RAN models.

Azure Private 5G Core also employs a simple, scalable provisioning model to allow you to bring the SIM partner of your choice to Azure.

## UE authentication and security context management

Azure Private 5G Core supports authentication methods like:

- Authentication using Subscription Permanent Identifiers (SUPI) and 5G Globally Unique Temporary Identities (5G-GUTI) for 5G user equipment (UEs).
- Authentication using International Mobile Subscriber Identities (IMSI) and Globally Unique Temporary Identities (GUTI) for 4G UEs.
- 5G Authentication and Key Agreement (5G-AKA) for mutual authentication between 5G UEs and the network.
- Evolved Packet System based Authentication and Key Agreement (EPS-AKA) for mutual authentication between 4G UEs and the network.

The packet core instance performs ciphering and integrity protection of 5G non-access stratum (NAS). During UE registration, the UE includes its security capabilities for 5G NAS with 128-bit keys.

## UE-to-UE traffic

Azure Private 5G Core supports traffic flow from UE to UE through the user plane, allowing machine-to-machine (M2M) communication between 5G devices for a range of applications including robot control.

An external router is responsible for hairpinning traffic from UE to UE over the N6 interface. This means that traffic leaving the UPF destined to a UE IP address will be routed back to the UPF’s N6 IP address.

## Index to RAT/Frequency Selection Priority (RFSP)

The packet core instance can provide a RAN with an RFSP Index. The RAN can match the RFSP Index to its local configuration to apply specific radio resource management (RRM) policies, such as cell reselection or frequency layer redirection.

## Multi-Operator Core Network (MOCN)

Multi-operator Core Network (MOCN) aims to maximize resource usage by sharing a RAN between multiple core networks. Azure Private 5G Core supports MOCN, allowing multiple public land mobile networks (PLMNs) to be shared by a gNodeB (for 5G deployments) or eNodeB (for 4G deployments). In the context of private mobile networks, a single RAN can connect to both a private and a standard macro network, with traffic automatically routed to the appropriate core network based on the PLMN ID.
