Azure Language in Foundry Tools provides a set of natural language processing (NLP) capabilities that you can use to analyze text. These capabilities include language detection, named entity recognition, and personally identifiable information (PII) extraction.

While you can call these capabilities individually through REST APIs or SDKs, you can also make them available to an AI agent through the **Azure Language Model Context Protocol (MCP) server**. This approach lets the agent dynamically select and call the appropriate language tool based on a user's request, without you needing to write specific code for each capability.

For example, suppose you work for a company that needs to analyze customer feedback. Customers submit reviews in multiple languages, and your team needs to determine which language was used, identify the people and places mentioned, and redact any personal details in the reviews. Rather than building separate integrations for each of these tasks, you can create an AI agent that uses the Azure Language MCP server to perform all of them through a single tool connection.

In this module, you learn how the Azure Language MCP server works, how to connect it to an AI agent in Microsoft Foundry, and how to build a client application that interacts with the agent programmatically.

> [!NOTE]
> The Azure Language MCP server is currently in public preview. Details described in this module are subject to change.
