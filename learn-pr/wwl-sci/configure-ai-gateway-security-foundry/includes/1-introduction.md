Contoso Financial Services is expanding its AI capabilities with Microsoft Foundry, deploying language models for document analysis and regulatory research. Multiple applications share the same model deployments, and the security team identified a gap: there's no access control layer between the applications and the models. Any application that knows the endpoint can call the model. There's no visibility into token consumption, no audit trail for model calls, and no mechanism to detect or prevent misuse.

Adding a control layer between callers and AI models is the role of AI Gateway. In Microsoft Foundry, AI Gateway is powered by **Azure API Management (APIM)** and sits between your applications and model deployments, enforcing authentication, rate limits, routing policies, and logging—before any request reaches the model.

> [!NOTE]
> AI Gateway in Microsoft Foundry is currently in **Preview**. Before following the configuration steps in this module, verify that preview features are available in your Azure subscription and Foundry environment.

This module covers how AI Gateway works, how to create and configure a gateway instance. Then you explore how to apply security controls and monitoring to protect your AI model traffic.

## Learning objectives

In this module, you learn how to:

- Examine the AI Gateway architecture and explain how it secures AI model traffic
- Create and configure an AI Gateway instance in Microsoft Foundry
- Apply access controls and monitoring to secure and audit AI Gateway usage

## Prerequisites

Before you begin, you should have:

- Experience working with Microsoft Azure AI Foundry
- Familiarity with API management and gateway concepts
- Understanding of AI workload security requirements
- **Contributor** or **Owner** role on an Azure resource group (to create a new API Management instance), or **API Management Service Contributor** role on an existing AI Policy Manager (APIM) instance
- **Azure AI Account Owner** or **Azure AI Owner** role on the Foundry resource
