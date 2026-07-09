IT staff at Contoso want to use Microsoft Defender for Cloud to help secure their VM workloads and their on-premises servers. To onboard their VMs and on-premises servers to Microsoft Defender for Cloud, they must complete the following tasks:

- Enable a Defender for Servers plan.
- Verify Defender for Endpoint integration and agentless scanning settings.
- Onboard non-Azure servers with Azure Arc.

> [!NOTE]
> Defender for Servers no longer supports the Log Analytics agent or Azure Monitor Agent for most server protection features. Defender for Endpoint integration and agentless machine scanning replace those agents for most Defender for Servers capabilities.

## Enable a Defender for Servers plan

To use Microsoft Defender for Cloud advanced server protection capabilities or to protect on-premises servers, enable Defender for Servers on the subscription that contains your Azure VMs or Azure Arc-enabled servers. Defender for Servers has two plans:

- **Defender for Servers Plan 1 (P1)** provides core server EDR capabilities through Microsoft Defender for Endpoint.
- **Defender for Servers Plan 2 (P2)** includes Plan 1 capabilities and adds features such as agentless machine scanning, just-in-time VM access, file integrity monitoring, and other advanced protections.

To enable Defender for Servers, use the following procedure:

1. In the Azure portal, select **Microsoft Defender for Cloud**.
2. In the navigation pane, select **Environment settings**.
3. Select the subscription that contains the servers you want to protect.
4. Select **Defender plans**.
5. For **Servers**, select **Plan 1** or **Plan 2**, and then select **Save**.

## Verify Defender for Endpoint and agentless scanning settings

After you enable Defender for Servers, Microsoft Defender for Endpoint is automatically provisioned for supported machines connected to Microsoft Defender for Cloud unless automatic provisioning is disabled. Defender for Servers uses Defender for Endpoint to provide EDR, threat detection, and integrated vulnerability scanning with Microsoft Defender Vulnerability Management.

If you choose Defender for Servers Plan 2, agentless machine scanning is enabled by default. Agentless scanning lets Defender for Cloud scan supported machines for software inventory, vulnerabilities, secrets, and malware without deploying another agent to the endpoint.

To review these settings, use the following procedure:

1. In the Azure portal, select **Microsoft Defender for Cloud**.
2. In the navigation pane, select **Environment settings**.
3. Select the subscription that contains the servers you want to protect.
4. Select **Settings & monitoring**.
5. Verify the settings for Microsoft Defender for Endpoint integration and agentless scanning, and then save any changes.

## Onboard your on-premises servers and computers

After enabling Defender for Servers for your subscription, onboard on-premises servers and computers by connecting them to Azure Arc. Azure Arc-enabled servers appear as Azure resources and can be protected by Defender for Servers.

Use the following high-level procedure to onboard on-premises Windows Server computers:

1. In the Azure portal, search for and select **Azure Arc**.
2. Under **Azure Arc resources**, select **Machines**.
3. Select **Add/Create**, and then choose the option that matches your deployment approach.
4. Generate the onboarding script for your subscription, resource group, region, and connectivity requirements.
5. Run the onboarding script on each on-premises Windows Server computer. The script installs the Azure Connected Machine agent and connects the server to Azure Arc.
6. In Microsoft Defender for Cloud, verify that the Azure Arc-enabled server is in a subscription with Defender for Servers enabled.

## Verify Windows Server protection in Microsoft Defender for Endpoint

Threat protection in Microsoft Defender for Cloud is provided by its integration with Microsoft Defender for Endpoint. Combined with Microsoft Defender for Cloud, they provide a complete Endpoint Detection and Response (EDR) solution. For machines that aren't protected through Defender for Servers, you can onboard supported Windows Server and Windows client computers to Microsoft Defender for Endpoint by using:

- A local script
- Group Policy
- Microsoft Endpoint Configuration Manager
- Virtual desktop infrastructure onboarding scripts for non-persistent machines

For servers protected by Defender for Servers, use the built-in Defender for Endpoint integration wherever possible. After onboarding, verify that the machine appears in Microsoft Defender for Cloud inventory and in the Microsoft Defender portal device inventory.
