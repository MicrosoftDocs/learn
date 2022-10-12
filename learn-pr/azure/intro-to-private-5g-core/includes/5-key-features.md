Intro

## Supported 5G network functions

- Access and Mobility Management Function (AMF)
- Session Management Function (SMF)
- User Plane Function (UPF)
- Policy Control Function (PCF)
- Authentication Server Function (AUSF)
- Unified Data Management (UDM)
- Unified Data Repository (UDR)

## Supported 4G network functions

Azure Private 5G Core uses the following network functions when supporting 4G UEs, in addition to the 5G network functions listed above.

- Mobile Management Entity (MME)
- MME-Proxy - The MME-Proxy works to allow 4G UEs to be served by 5G network functions.

The following 5G network functions perform specific roles when supporting 4G UEs.

- The UDR operates as a Home Subscriber Store (HSS).
- The UPF operates as a System Architecture Evolution Gateway (SAEGW-U).

## Supported 5G and 4G procedures

TBD

## User equipment (UE) authentication and security context management

Azure Private 5G Core supports the following authentication methods:

- Authentication using Subscription Permanent Identifiers (SUPI) and 5G Globally Unique Temporary Identities (5G-GUTI) for 5G user equipment (UEs).
- Authentication using International Mobile Subscriber Identities (IMSI) and Globally Unique Temporary Identities (GUTI) for 4G UEs.
- 5G Authentication and Key Agreement (5G-AKA) for mutual authentication between 5G UEs and the network.
- Evolved Packet System based Authentication and Key Agreement (EPS-AKA) for mutual authentication between 4G UEs and the network.

The packet core instance performs ciphering and integrity protection of 5G non-access stratum (NAS). During UE registration, the UE includes its security capabilities for 5G NAS with 128-bit keys.

Azure Private 5G Core supports the following algorithms for ciphering and integrity protection:

- 5GS null encryption algorithm
- 128-bit Snow3G
- 128-bit Advanced Encryption System (AES) encryption

## UE-to-UE traffic

Azure Private 5G Core supports traffic flow from UE to UE through the user plane, allowing machine-to-machine (M2M) communication between 5G devices for a range of applications including robot control.

An external router is responsible for hairpinning traffic from UE to UE over the N6 interface. This means that traffic leaving the UPF destined to a UE IP address will be routed back to the UPF’s N6 IP address.

## Index to RAT/Frequency Selection Priority (RFSP)

The packet core instance can provide a RAN with an RFSP Index. The RAN can match the RFSP Index to its local configuration to apply specific radio resource management (RRM) policies, such as cell reselection or frequency layer redirection.

## Multi-Operator Core Network (MOCN)

Multi-operator Core Network (MOCN) aims to maximize resource usage by sharing a RAN between multiple core networks. Azure Private 5G Core supports MOCN, allowing multiple public land mobile networks (PLMNs) to be shared by a gNodeB (for 5G deployments) or eNodeB (for 4G deployments).

In the context of private mobile networks, a single RAN can connect to both a private and a standard macro network, with traffic automatically routed to the appropriate core network based on the PLMN ID.

## Flexible integration with Azure private multi-access edge compute (MEC) partners

Each packet core instance is standards-compliant and compatible with several radio access network (RAN) partners in the Azure private MEC ecosystem.

Azure Private 5G Core exposes an N2 and N3 interface for the 5G control plane and user plane respectively. It complies with the following 3GPP Technical Specifications, allowing you to integrate with a wide range of RAN models:

- [TS 38.413](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3223) for the N2 interface.
- [TS 29.281](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1699) for the N3 interface.

For 4G, it exposes S1-MME and S1-U interfaces to interoperate with 4G RAN models.

It also employs a simple, scalable provisioning model to allow you to bring the SIM partner of your choice to Azure.

## Azure centralized service management

Azure Private 5G Core is available as a native Azure service, offering the same levels of reliability, security, and availability for deployment and management that are key tenets of all Azure services. This allows you to use Azure as a central access point to manage individual instances of private mobile networks across multiple enterprise sites. You can use the Azure portal (accessible from a choice of any Azure region in the world) or Azure Resource Manager (ARM) APIs to do any of the following tasks:

- Deploy and configure a packet core instance on your Azure Stack Edge device in minutes.
- Create a virtual representation of your physical mobile network through Azure using mobile network and site resources.
- Provision SIM resources to authenticate devices in the network, while also supporting redundancy.
- Employ Log Analytics and other observability services to view the health of your network and take corrective action through Azure.
- Use Azure role-based access control (RBAC) to allow granular access to the private mobile network to different personnel or teams within your organization, or even a managed service provider.
- Use an Azure Stack Edge device's compute capabilities to run applications that can benefit from low-latency networks.
- Seamlessly connect your existing Azure deployments to your new private mobile network using Azure hybrid compute, networking, and IoT services.
- Access the large ecosystem of Microsoft independent software vendor (ISV) partners for applications and network functions.
- Utilize Azure Lighthouse and the Azure Expert Managed Services Provider (MSP) program to simplify the end-to-end deployment of a private mobile network through Azure.

## Azure centralized monitoring

Azure Private 5G Core is integrated with Log Analytics in Azure Monitor. You can write queries to retrieve records or visualize data in charts. This lets you monitor and analyze activity in your private mobile network directly from the Azure portal.
