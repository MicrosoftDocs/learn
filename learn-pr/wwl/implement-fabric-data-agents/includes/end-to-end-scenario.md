This learn unit guides you through the process of creating, configuring, and consuming a Fabric data agent to enable conversational AI experiences for querying enterprise data.

> [!div class="mx-imgBorder"]
> [![Diagram that shows an overview of data agent.](../media/data-agent-overview.png)](../media/data-agent-overview.png#lightbox)

## 1. Create a Data Agent

To begin, navigate to your workspace in Microsoft Fabric:
- Select the **"+ New Item"** button.
- Choose **"Fabric data agent"** from the list of options.
- Provide a meaningful name for your data agent and proceed to configure it.

## 2. Select data sources

Fabric data agents support the following data sources:

- Lakehouses
- Warehouses
- Eventhouses
- Semantic models

Use the **OneLake catalog** to locate and connect the appropriate data sources:

- Add each data source individually.
- Use filters to narrow down the data source types for easier selection.

## 3. Configure the Data Agent

Tailor the data agent to meet your organization's needs:

- **Add Instructions**: Provide clear guidance to the AI on how to handle queries. Any predefined examples (for example, sample questions and answers) or specific instructions help refine the AI's understanding of the question, and guide how the AI interacts with the data. You can write up to 15,000 characters in plain English-language text.

- **Provide Example Queries**: Enhance accuracy by including sample queries and expected outputs. This helps the AI generate more precise responses. This approach, known as **Few-Shot Learning** in generative AI, helps guide the Fabric data agent to generate responses that better align with your expectations.

## 4. Publish the Data Agent

Once the data agent is configured, test its performance by asking sample questions to ensure it meets your requirements. When you're satisfied with its functionality, select **Publish** to make it accessible. Provide a detailed description of the data agent to help others understand its purpose and functionality.

After you publish the Fabric data agent, you'll have two versions of it. One version is the current draft version, which you can continue to refine and improve. The second version is the published version, which you can share with your colleagues who want to query the Fabric data agent to get answers to their questions. 

## 5. Consume the Data Agent

The published data agent can be consumed in various platforms, including:

- **Fabric**
- **Copilot Studio**
- **Microsoft Teams**
- **Power BI Copilot**
- **Azure AI Foundry**
- **Custom applications via API**

These integrations enable conversational AI experiences, allowing users to query data in natural language and retrieve actionable insights.

By following these steps, you can create a robust Fabric data agent that transforms enterprise data into a conversational Q&A system.

## Best pactices

**Use Clear Instructions**: Ensure that the instructions provided to the AI are clear and concise. This helps in generating accurate responses. If your AI resource consistently misinterprets certain words, acronyms, or terms, you can try to provide clear definitions in this section, to ensure that the AI understands and processes them correctly. This becomes especially useful for domain-specific terminology or unique business jargon.