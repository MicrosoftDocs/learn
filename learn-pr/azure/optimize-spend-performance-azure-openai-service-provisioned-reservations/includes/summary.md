In this module, you learned how to efficiently allocate and use resources needed for Azure OpenAI Service deployment. You examined the available Azure OpenAI deployment models and decided to use the provisioned deployment model for Contoso. You learned how to estimate the required throughput for Contoso's requirements using the Azure OpenAI capacity calculator. You then checked the PTU quota for your region, created an Azure OpenAI resource in US West, and then created a provisioned deployment in the region where quota was available. Finally, you purchased the appropriate Azure OpenAI Service provisioned reservation based on your organization's requirements.

#### Resolution of module problem

You implemented the following process to resolve Contoso's requirements:

1. Choose to use [standard or provisioned deployments](/azure/ai-services/openai/how-to/deployment-types): Contoso decides to use provisioned.

2. Choose to use [global, data zone, or regional deployments](/azure/ai-services/openai/how-to/deployment-types): Contoso decides to use data zone.

3. Use [capacity calculator to forecast PTU](/azure/ai-services/openai/how-to/provisioned-throughput-onboarding) usage based off estimated configuration and usage in specific region: Contoso estimates they'll need 100 PTUs: GPT -4os in US West.

4. [Check PTU quota](/azure/ai-services/openai/how-to/provisioned-get-started) based on chosen region in Azure OpenAI Foundry: Contoso confirms 100 PTUs of PGT -4os are available in US West.

5. Create an [Azure OpenAI resource](/azure/ai-services/openai/how-to/provisioned-get-started) in chosen region: Contoso creates an Azure OpenAI resource in US West.

6. [Create provisioned deployment](/azure/ai-services/openai/how-to/provisioned-get-started) in region where quota is available: Contoso creates a deployment in US West using PTU hourly.

7. [Purchase provisioned reservations to](/azure/cost-management-billing/reservations/azure-openai) cover PTU hourly usage in specific region: Contoso purchases 100 PTU reservations (monthly or yearly) in US west to get savings on 100 PTU hourly deployments.

#### Learn more

- [Azure OpenAI Service deployment types](/azure/ai-services/openai/how-to/deployment-types)
- [What is provisioned throughput?](/azure/ai-services/openai/concepts/provisioned-throughput)
- [Provisioned throughput units (PTU) onboarding](/azure/ai-services/openai/how-to/provisioned-throughput-onboarding)
- [Get started using Provisioned Deployments on the Azure OpenAI Service](/azure/ai-services/openai/how-to/provisioned-get-started)
- [Monitor Azure OpenAI](/azure/ai-services/openai/how-to/monitor-openai)
- [Manage Azure OpenAI Service quota](/azure/ai-services/openai/how-to/quota?tabs=rest)
- [Save costs with Microsoft Azure OpenAI Service Provisioned Reservations](/azure/cost-management-billing/reservations/azure-openai)
