Microsoft Defender for Identity (formerly Azure Advanced Threat Protection, also known as Azure ATP) is a cloud-based security solution. Defender for identity uses your on-premises Active Directory signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at your organization. Defender for Identity enables SecOp analysts and security professionals struggling to detect advanced attacks in hybrid environments to:<br>

 -  Monitor users, entity behavior, and activities with learning-based analytics
 -  Protect user identities and credentials stored in Active Directory
 -  Identify and investigate suspicious user activities and advanced attacks throughout the kill chain
 -  Provide clear incident information on a simple timeline for fast triage

### Process flow for Defender for Identity

:::image type="content" source="../media/defender-identity-topology-5744bbde.png" alt-text="Diagram of the data flow for protecting identities using Microsoft Defender for Identity.":::


Defender for Identity consists of the following components:

 -  **Defender for Identity portal** \- The Defender for Identity portal allows the creation of your Defender for Identity instance, displays the data received from Defender for Identity sensors, and enables you to monitor, manage, and investigate threats in your network environment.
 -  **Defender for Identity sensor** \- Defender for Identity sensors can be directly installed on the following servers:
    
    
     -  Domain controllers: The sensor directly monitors domain controller traffic, without the need for a dedicated server, or configuration of port mirroring.
     -  Active Directory Federated Services (AD FS): The sensor directly monitors network traffic and authentication events.
 -  **Defender for Identity cloud service** \- Defender for Identity cloud service runs on Azure infrastructure and is currently deployed in the US, Europe, and Asia. Defender for Identity cloud service is connected to Microsoft's intelligent security graph.
