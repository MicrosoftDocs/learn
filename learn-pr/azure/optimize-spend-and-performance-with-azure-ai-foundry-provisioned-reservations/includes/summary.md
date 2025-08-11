In this module, you learned how to efficiently allocate and use resources needed for Azure AI Foundry deployment. You examined the available Azure AI Foundry deployment models and decided to use the provisioned deployment model for Contoso. You learned how to estimate the required throughput for Contoso's requirements using the Azure AI Foundry capacity calculator. You then checked the PTU quota for your region, created an Azure AI Foundry resource in US West, and then created a provisioned deployment in the region where quota was available. Finally, you purchased the appropriate Azure AI Foundry Provisioned Throughout reservation based on your organization's requirements.

#### Resolution of module problem

You implemented the following process to resolve Contoso's requirements:

1. Choose to use [standard or provisioned deployments](/azure/ai-foundry/foundry-models/concepts/deployment-types): Contoso decides to use provisioned.

1. Choose to use [global, data zone, or regional deployments](/azure/ai-foundry/foundry-models/concepts/deployment-types): Contoso decides to use data zone.

1. Use [capacity calculator to forecast PTU](/azure/ai-foundry/openai/how-to/provisioned-get-started) usage based off estimated configuration and usage in specific region: Contoso estimates they'll need 100 PTUs: GPT -4os in US West.

1. [Check PTU quota](/azure/ai-foundry/openai/how-to/provisioned-get-started) based on chosen region in Azure AI Foundry: Contoso confirms 100 PTUs of PGT -4os are available in US West.

1. Create an [Azure AI Foundry resource](/azure/ai-foundry/openai/how-to/provisioned-get-started) in chosen region: Contoso creates an Azure AI Foundry resource in US West.

1. [Create provisioned deployment](/azure/ai-foundry/openai/how-to/provisioned-get-started) in region where quota is available: Contoso creates a deployment in US West using PTU hourly.

1. [Purchase provisioned reservations to](/azure/cost-management-billing/reservations/azure-ai-foundry#buy-a-microsoft-azure-openai-service-reservation) cover PTU hourly usage in specific region: Contoso purchases 100 PTU reservations (monthly or yearly) in US west to get savings on 100 PTU hourly deployments.

#### Learn more

- [Understanding deployment types in Azure AI Foundry Models](/azure/ai-foundry/foundry-models/concepts/deployment-types)
- [Provisioned throughput for Azure AI Foundry Models](/azure/ai-foundry/openai/concepts/provisioned-throughput)
- [Quickstart - Get started using Provisioned Deployments with Azure OpenAI in Azure AI Foundry Models](/azure/ai-foundry/openai/how-to/provisioned-get-started)
- [Understanding costs associated with provisioned throughput units (PTU)](/azure/ai-foundry/openai/how-to/provisioned-throughput-onboarding)
- [Save costs with Microsoft Azure AI Foundry Provisioned Throughput reservations](/azure/cost-management-billing/reservations/azure-ai-foundry#buy-a-microsoft-azure-openai-service-reservation)
