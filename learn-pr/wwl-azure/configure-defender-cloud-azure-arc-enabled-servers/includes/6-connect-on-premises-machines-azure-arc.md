When you connect a machine through [Azure Arc-enabled servers](/azure/azure-arc/servers/overview), Azure represents it as a resource. The Azure Connected Machine agent maintains the resource connection and enables Azure management capabilities for Windows and Linux servers outside Azure.

## Enable Defender for Servers

Enable Defender for Servers on the subscription where you'll create the Azure Arc-enabled server resources:

1. In the [Azure portal](https://portal.azure.com/), search for and select **Microsoft Defender for Cloud**.
2. On the Defender for Cloud menu, select **Environment settings**.
3. Select the Azure subscription where you'll create the Azure Arc-enabled server resources.
4. On the Defender plans page, set **Servers** to **On**. This action selects Plan 2 by default.
5. To use Plan 1, select **Change plans**, select **Plan 1**, and then select **Confirm**.
6. Select **Save**.

Enabling a plan starts a 30-day trial. Defender for Servers automatically provisions the Defender for Endpoint extension on supported machines connected to Defender for Cloud. Plan 2 also enables its supported default capabilities, including Defender Vulnerability Management and, for eligible cloud-hosted machines, agentless scanning.

> [!IMPORTANT]
> Agentless machine scanning doesn't support on-premises Azure Arc-enabled servers. These servers use the Defender for Endpoint integration for vulnerability assessment and endpoint detection and response. On supported Arc-enabled servers, Plan 2 also provides file integrity monitoring, update assessment, and operating-system baseline assessment.

Defender for Servers no longer uses the retired Log Analytics agent or Azure Monitor Agent for most plan features. Azure Monitor Agent remains a supported collection method for specific monitoring scenarios and the Plan 2 data-ingestion benefit.

## Choose an Azure Arc deployment method

Choose a deployment method based on the number of machines you need to connect:

- For one machine, follow [Quickstart: Connect a machine to Arc-enabled servers](/azure/azure-arc/servers/quick-enable-hybrid-vm).
- For multiple machines, follow [Connect hybrid machines to Azure at scale](/azure/azure-arc/servers/onboard-service-principal).

For production deployments, review Azure Arc deployment options and use a service principal with the **Azure Connected Machine Onboarding** role. Protect and rotate the onboarding credential, and limit its scope to the required resource groups or subscriptions.
