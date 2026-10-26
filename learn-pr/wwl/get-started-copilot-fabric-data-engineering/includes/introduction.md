Microsoft Fabric is an integrated platform for data integration, engineering, and analytics. Copilot is an AI-powered assistant that helps you create, transform, and analyze data through natural language prompts in experiences such as Data Factory and Data Engineering.

In this module, you explore how Contoso Health, a multispecialty hospital network, can use Microsoft Fabric and Copilot to prepare data. The examples use synthetic patient records and public population projections, not real patient information.

## Choose a data preparation experience

- With **Dataflow Gen2**, you can transform data and write the results to supported destinations with a visual user interface. You explore how Copilot assists with creating transformations.
  
- The copy activity in a **Fabric Data Pipeline** is a low-code and no-code option to move large quantities of data to lakehouses and warehouses from various sources, either ad-hoc or on a schedule. Copilot can help you create a pipeline using natural language. 
  
- Develop the code to extract and transform data with a **Spark Notebook**. Spark provides a distributed computing platform that can process large amounts of data in parallel. Code is typically written in Python, Scala, or R. Copilot can assist you with writing the code.

## Check access and responsible use

For the exercises, use a workspace assigned to a paid Fabric capacity (F2 or higher) or Power BI Premium capacity (P1 or higher), in a [supported region](/fabric/admin/region-availability). Fabric trial capacities don't support these Copilot exercises. A Power BI Pro or Premium Per User license alone isn't sufficient.

Ask your administrator to verify the **Users can use Copilot and other features powered by Azure OpenAI** tenant setting and any delegated capacity settings. Outside the US or EU data boundary, the administrator also needs to allow cross-geographic data processing. For notebooks, cross-geographic storage of conversation history also requires the corresponding storage setting. Follow your organization's data residency policies rather than enabling these settings without approval. See [Enable and configure Copilot](/fabric/fundamentals/copilot-enable-fabric) and [Copilot tenant settings](/fabric/admin/service-admin-portal-copilot).

Some Copilot features or models also depend on the **Users can use Copilot, AI Agents, and other AI experiences powered by OpenAI as a Microsoft Subprocessor** setting. OpenAI-operated models have separate access and cross-geographic processing controls from Azure OpenAI. Ask your administrator to review these settings for the experience you use. Don't enable a model provider or cross-geographic processing without organizational approval. See [OpenAI as a subprocessor in Microsoft Fabric](/fabric/fundamentals/copilot-openai-subprocessor).

Copilot can produce incorrect code and explanations. Review generated steps, code, permissions, and results before applying them. Use only data you're authorized to process with Copilot, and don't include credentials or real patient records in prompts. Dataflow Gen2 grounds responses in data imported into the current Power Query preview; notebook context can include code, cell outputs, schemas, and sample data accessible to the notebook. Notebook conversation history persists across sessions and, unless you clear it, is stored for 28 days. For details, see [Data Factory privacy](/fabric/fundamentals/copilot-data-factory-privacy-security) and [notebook privacy](/fabric/fundamentals/copilot-data-science-privacy-security).