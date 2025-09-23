Tailwind Traders has onboarded its machines to Azure Arc-enabled servers, and now wants to onboard those servers to Microsoft Defender for Cloud. In this unit, you learn how to onboard your Azure Arc-enabled servers to Defender for Cloud.

## Enable Microsoft Defender for Cloud

To enable Microsoft Defender for Cloud in your Azure subscription, search for **Microsoft Defender for Cloud** in the Azure portal. Select **Microsoft Defender for Cloud** to open the overview page.

After a few minutes, Defender for Cloud is now enabled, and you have access to the basic features provided by Defender for Cloud.

To enable the enhanced security features of Defender for Cloud for your machines, you need to enable the Defender for Servers plan. To do this, follow these steps:

1. In the Defender for Cloud menu, under **Management**, select **Environment settings**.
1. Select the subscription that you want to protect.
1. Under **Cloud Workload Protection (CWPP)**, find **Servers** and toggle the switch to **On**.
1. Select **Save**.

When you enable the Defender for Servers plan in Defender for Cloud, Defender for Endpoint integration is enabled by default. This integration provides advanced capabilities such as real-time threat detection, automated response capabilities, vulnerability assessments, and software inventory.

## Add non-Azure machines with Azure Arc

Next, you need to connect your non-Azure machines to Azure using Azure Arc by deploying the Azure Connected Machine agent. This connection can be accomplished using different methods, depending on your requirements and the tools you prefer to use. For more information, see [Azure Connected Machine agent deployment options](s/azure/azure-arc/servers/deployment-options).

Connecting a machine to Azure through Azure Arc-enabled servers creates an Azure resource for the hybrid machine. If the Azure subscription with your Arc-enabled servers has Defender for Servers enabled, the Azure resource appears in Defender for Cloud. Just like your other Azure resources, the Arc-enabled server can also have security recommendations, surface alerts, and be captured in your secure score.

## Verify your deployment

Now you can view your Azure and non-Azure machines together in one place. Within Microsoft Defender for Cloud, select **Inventory** to open the asset inventory page and filter to the relevant resource types.

The asset inventory page of Defender for Cloud provides a single area to view your connected resources and their security postures. Defender for Cloud periodically analyzes the security state of resources connected to your subscriptions to identify potential security vulnerabilities. It then provides you with recommendations on how to remediate those vulnerabilities.
