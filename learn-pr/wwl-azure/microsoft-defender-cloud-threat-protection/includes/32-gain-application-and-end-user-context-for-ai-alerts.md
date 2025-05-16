Microsoft Defender for Cloud's threat protection for AI workloads allows you to enhance the actionability and security value of the generated AI alerts by providing both end-user and application context.

In most cases, scenarios leveraging AI services are built as part of an application, so the API calls to the AI service originate from a web application, compute instance, or an AI gateway. This architecture setup introduces complexity due to a lack of context when investigating AI requests to determine the business application or the end-user involved.

Defender for Cloud, together with Azure AI, enables adding parameters to your Azure AI API calls to propagate critical end-user, or application context to Defender for Cloud's AI alerts. This, in turn, leads to more effective triaging and results. For example, when adding end-user IP or identity, you can block that user or correlate incidents and alerts by that user. When adding application context, you can prioritize or determine whether suspicious behavior could be considered standard for that application in the organization.

**Example: A jailbreak attempt on your Azure Open AI model deployment was blocked by Prompt Shields.**

## Add security parameters to your Azure OpenAI call

To receive AI security alerts with more context, you can add any or all of the following sample UserSecurityContext parameters to your [Azure OpenAI API](/azure/ai-services/openai/reference) calls.

All of the fields in the UserSecurityContext are optional.

For end-user context, we recommend passing the EndUserId and SourceIP fields at a minimum. The EndUserId and SourceIP fields provide Security Operations Center (SOC) analysts the ability to investigate security incidents that involve AI resources and generative AI applications.

For application context, simply pass the applicationName field, as a simple string.

If a field’s name is misspelled, the Azure OpenAI API call will still succeed. The UserSecurityContext schema doesn't require validation to pass through the Azure OpenAI user field. Application developers should ensure that a valid JSON is passed in every request made by the application to Azure OpenAI.

## UserSecurityContext schema

The exact schema can be found in Azure OpenAI [REST API reference documentation](/azure/ai-services/openai/reference-preview).

The [user security context object](/azure/ai-services/openai/reference-preview#usersecuritycontext) is part of the [request body](/azure/ai-services/openai/reference-preview#createchatcompletionrequest) of the chat completion API.

This feature is currently not supported when leveraging models deployed through the [Azure AI model inference API](/azure/ai-studio/ai-services/model-inference).

## Availability

Expand table

| **Source**            | **Version support**                                                                                                                                          | **Comments**                                                 |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------ |
| Azure OpenAI REST API | [2025-01-01 version](/azure/ai-services/openai/reference-preview)                                                                 | -                                                            |
| Azure .NET SDK        | [v2.2.0-beta.1 (2025-02-07) or higher](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.OpenAI_2.2.0-beta.1/sdk/openai/Azure.AI.OpenAI/CHANGELOG.md) | -                                                            |
| Azure Python SDK      | [v1.61.1 or higher](https://github.com/openai/openai-python/releases/tag/v1.61.1)                                                                            | The support is provided by appending to "extra\_body" object |
| Azure JS/Node SDK     | [v4.83.0 or higher](https://github.com/openai/openai-node/releases/tag/v4.83.0)                                                                              | The support is provided by appending to "extra\_body" object |
| Azure Go SDK          | [v0.7.2 or higher](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/ai/azopenai@v0.7.2#UserSecurityContext)                                          | -                                                            |
