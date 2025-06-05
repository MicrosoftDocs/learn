Fabric Data Agents are designed to revolutionize how organizations interact with their data by using generative AI. Below are the key capabilities that make Fabric Data Agents a powerful tool for enhancing data accessibility and usability:

## Chat with your data

The data agent enables natural interaction with your data by allowing you to ask questions in plain English and receive structured, human-readable responses. It analyzes your input, determines the most appropriate data source—such as a Lakehouse, Warehouse, Power BI dataset, or KQL database—and automatically selects the right tool to generate, validate, and execute the corresponding queries.

By eliminating the need to understand query languages like SQL (Structured Query Language), DAX (Data Analysis Expressions), or KQL (Kusto Query Language), the data agent makes data insights accessible across the organization, regardless of technical skill level.

It’s important to note that the data agent only supports **read** operations — it doesn't create, update, or delete data. It ensures secure and accurate access by enforcing the same data permissions assigned to the user interacting with it.

## Fabric data agent configuration

Fabric Data Agents include configuration options that allow creators to test and evaluate how the agent interprets and responds to questions. This helps refine responses by iterating on queries and adjusting the configuration to ensure accurate, relevant answers.

You can provide organization-specific instructions, example queries, and guidance to fine-tune the Fabric data agent. This ensures that the agent’s responses align with your organization’s unique needs and objectives. 

## Seamless reasoning across multiple data sources

Fabric Data Agents can reason over multiple data sources, including:

- Power BI semantic models.
- Eventhouse KQL Databases.
- Lakehouses and Warehouses.

The Fabric data agent can only access data that you provide, with up to five data sources. For example, a configured Fabric data agent could include a mix of two Power BI semantic models, one lakehouse, and one KQL database. Within those data sources, you can select the relevant tables. 

> [!IMPORTANT]
> 
> The Fabric data agent works best with 25 or fewer tables selected across all data sources. 
> 
> You can't use the Fabric data agent to access unstructured data resources like .pdf, .docx, or .txt files.

## Integration inside and outside of Fabric

Your Data Agent can be consumed both within and outside of Microsoft Fabric. Integrations include:

- **Copilot Studio**: Extend the agent's functionality to custom workflows.
- **Microsoft Teams**: Enable collaborative data-driven discussions.
- **Azure AI Foundry**: Use advanced AI capabilities for broader applications.
- **Custom Applications**: Embed the agent into your own tools and platforms.

While both Fabric data agents and Fabric copilots use generative AI to process and reason over data, there are key differences in their functionality and use cases:

| **Aspect** | **Fabric Data Agents** | **Fabric Copilots** |
|------------|------------------------|---------------------|
| **Flexibility** | Customizable with instructions and examples. | Preconfigured, limited customization. |
| **Use Case** | Broader scope; integrates with external tools (e.g., Copilot Studio, Teams, ...).| Focused on in-Fabric tasks like notebooks and warehouse queries. |

These integrations ensure that Fabric Data Agents can seamlessly fit into your organization's existing ecosystem, enhancing collaboration and decision-making.