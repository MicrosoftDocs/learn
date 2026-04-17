
 Learners can find the full list of labs and launch each exercise directly by visiting the [Secure AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2349700) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.

## Exercise 1: Implement Microsoft Foundry standard agent setup

### Scenario
Your company is building a centralized AI platform on Microsoft Foundry to support enterprise knowledge management and decision support across multiple business units, with a strong emphasis on network isolation and compliance-driven security controls. The platform enables intelligent document retrieval, automated analysis of internal reports, and conversational insights for employees, while ensuring that all traffic remains within approved network boundaries. To meet these requirements, the team deploys a Standard agent environment with private networking, integrating the Foundry account and project into an existing customer-managed virtual network that will host agents and private endpoints connecting services associated with the Microsoft Foundry resources. These services include customer-owned Azure Storage, Azure Cosmos DB, and Azure AI Search instances to be used for storing documents, conversation history, and search indexes without public exposure. The environment is deployed by using template-based automation.

:::image type="content" source="../media/company-building-centralized-ai-platform.png" alt-text="Diagram showing a company building a centralized AI platform on Microsoft Foundry.":::

>[!Important]
> The exercise involves provisioning a virtual network with two subnets and reviewing the process of a template-based deployment of a Microsoft Foundry standard agent environment with private networking, without the actual implementation of such environment. This is intentional in order to minimize the duration and cost of the exercise. There are more considerations associated with the deprovisioning process, which would further increase the cost and complexity of the implementation tasks. 

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2349800)

### Estimated duration
15 minutes

## Exercise 2: Configure Microsoft Foundry hub network connectivity by using a managed network

### Background information
Securing network connectivity for Microsoft Foundry hubs is essential for maintaining data confidentiality, preventing unauthorized access, and complying with enterprise security policies. Microsoft Foundry provides built-in support for network isolation, enabling you to control both inbound and outbound traffic to the hub and its associated resources. This isolation ensures that compute instances, managed endpoints, and other AI workloads operate within a tightly controlled network boundary while maintaining connectivity to approved Azure services.


### Scenario
Your company operates in the financial services industry, where strict regulatory requirements and data protection policies govern how sensitive information is accessed and processed. The organization plans to build a centralized AI platform on Microsoft Foundry to support the development of machine learning models used for fraud detection, credit risk assessment, and transaction analysis. Because these workloads involve highly confidential customer and financial data, ensuring network isolation and controlled data movement is a top priority.

To meet internal security policies and industry compliance standards (such as ISO 27001 and SOC 2), the company plans to deploy the Microsoft Foundry hub within a managed virtual network. This managed network isolates all AI resources from the public internet and enforces strict outbound connectivity rules to prevent accidental data exposure. Private endpoints are used to connect securely to dependent Azure services, including Storage accounts, Key Vault, and the Azure Container Registry, while private DNS zones ensure reliable name resolution within the isolated environment.

:::image type="content" source="../media/financial-services-industry-strict-regulatory.png" alt-text="Diagram showing a company operating in the financial services industry with strict regulatory requirements.":::

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2349900)


### Estimated duration
25 minutes

## Exercise 3: Implement customer-managed keys (CMK) for Microsoft Foundry

### Background information
All Microsoft Foundry resources are encrypted at rest by default with Microsoft-managed keys. Organizations that must control the lifecycle of their encryption keys can instead enable customer-managed keys (CMKs). With CMKs, encryption and decryption operations use a key stored in Azure Key Vault, allowing the organization to define its own key-creation, rotation, and deletion policies and to satisfy compliance frameworks such as ISO 27001 or SOC 2.


### Scenario
Your company is a financial services firm that handles highly sensitive customer and transactional data, including banking records, payment histories, credit assessments, and fraud detection metrics. It provides services such as credit risk evaluation, fraud monitoring, transaction analysis, and personalized financial recommendations. Given the sensitive nature of its operations, maintaining strict control over data encryption is essential for compliance with internal security policies and external regulatory requirements.

Your company plans to build a centralized AI platform on Microsoft Foundry to support these operations. To ensure full control over encryption, the organization intends to use customer-managed keys, allowing it to enforce key rotation policies and maintain auditability of key usage. System-assigned managed identities will be used for the Microsoft Foundry resources to securely access the Key Vault storing the CMKs, reducing administrative overhead and minimizing the risk of accidental key exposure. This approach allows the company to protect sensitive data while applying AI workloads without modifying application code.

:::image type="content" source="../media/company-building-centralized-ai-platform.png" alt-text="Diagram showing a company building a centralized AI platform on Microsoft Foundry.":::

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2349901)

### Estimated duration
25 minutes
