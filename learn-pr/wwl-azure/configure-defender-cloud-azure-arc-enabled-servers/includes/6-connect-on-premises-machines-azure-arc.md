A machine that has [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) becomes an Azure resource. When you install the Log Analytics agent on it, it appears in Defender for Cloud with recommendations, like your other Azure resources.

Azure Arc-enabled servers provide enhanced capabilities, such as enabling guest configuration policies on the machine and simplifying deployment with other Azure services.

To deploy Azure Arc on one machine, follow the instructions in [Quickstart: Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

To deploy Azure Arc on multiple machines at scale, follow the instructions in [Connect hybrid machines to Azure at scale](/azure/azure-arc/servers/onboard-service-principal).

Defender for Cloud tools for automatically deploying the Log Analytics agent work with machines running Azure Arc. However, this capability is currently in preview. When you connect your machines by using Azure Arc, use the relevant Defender for Cloud recommendation to deploy the agent and benefit from the full range of protections that Defender for Cloud offers:

 -  [Log Analytics agent should be installed on your Linux-based Azure Arc machines](https://portal.azure.com/#blade/Microsoft_Azure_Security/RecommendationsBlade/assessmentKey/720a3e77-0b9a-4fa9-98b6-ddf0fd7e32c1)
 -  [Log Analytics agent should be installed on your Windows-based Azure Arc machines](https://portal.azure.com/#blade/Microsoft_Azure_Security/RecommendationsBlade/assessmentKey/27ac71b1-75c5-41c2-adc2-858f5db45b08)
