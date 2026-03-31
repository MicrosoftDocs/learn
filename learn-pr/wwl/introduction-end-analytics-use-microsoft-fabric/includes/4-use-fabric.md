Before you can explore the end-to-end capabilities of Microsoft Fabric, it must be enabled for your organization. You might need to work with your IT department to enable Fabric for your organization, including one of the following roles:

- _Fabric administrator_: Manages Fabric settings and configurations.
- _Power Platform administrator_: Oversees Power Platform services, including Fabric.
- _Global administrator_: Has implicit Fabric admin rights through organization-wide permissions.

## Enable Microsoft Fabric

Admins can enable Fabric in the **Admin portal > Tenant settings** in the Power BI service. Fabric can be enabled for the entire organization or for specific Microsoft 365 or Microsoft Entra security groups. Admins can also delegate this ability to other users at the capacity level.

> [!NOTE]
> If your organization isn't using Fabric or Power BI today, you can sign up for a [free Fabric trial](/fabric/get-started/fabric-trial) to explore its features.

## Create workspaces

Workspaces are collaborative environments where you can create and manage items like lakehouses, warehouses, and reports. All data is stored in OneLake and accessed through workspaces. Workspaces also support data lineage view, providing a visual view of data flow and dependencies to enhance transparency and decision-making.

In _Workspace settings_, you can configure:

- License type to use Fabric features.
- OneDrive access for the workspace.
- Azure Data Lake Gen2 Storage connection.
- Git integration for version control.
- Spark workload settings for performance optimization.

You can manage workspace access through four roles: _admin_, _contributor_, _member_, and _viewer_. These roles apply to all items in a workspace and should be reserved for collaboration. For more granular access control, use item-level permissions based on business needs.

> [!NOTE]
> Learn more about workspaces in the [Fabric documentation](/fabric/get-started/workspaces).

## Discover data with OneLake catalog

The OneLake catalog in Microsoft Fabric helps you find and access data sources within your organization. You can explore and connect to data sources, ensuring you have the right data for your needs. You only see items that have been shared with you. Here are some considerations when using OneLake catalog:

- Narrow results by workspaces or domains (if implemented).
- Explore default categories to quickly locate relevant data.
- Filter by keyword or item type.

:::image type="content" source="../media/onelake-catalog.png" alt-text="Screenshot of the OneLake catalog." lightbox="../media/onelake-catalog.png":::

## Create items with Fabric workloads

After you create your Fabric enabled workspace, you can start creating items in Fabric. Each workload in Fabric offers different item types for storing, processing, and analyzing data. Fabric workloads include:

- **Data Engineering**: Create lakehouses and operationalize workflows to build, transform, and share your data estate.
- **Data Factory**: Ingest, transform, and orchestrate data.
- **Data Warehouse**: Combine multiple sources in a traditional warehouse for analytics.
- **Real-Time Intelligence**: Process, monitor, and analyze streaming data.
- **Industry Solutions**: Use out-of-the-box industry data solutions.
- **Data Science**: Detect trends, identify outliers, and predict values using machine learning.
- **Databases**: Create and manage databases with tools to insert, query, and extract data.
- **IQ (preview)**: Unify data across OneLake and organize it according to the language of your business using ontologies, graphs, and semantic models.
- **Power BI**: Create reports and dashboards to make data-driven decisions.

Fabric integrates capabilities from existing Microsoft tools like Power BI, Azure Synapse Analytics, and Azure Data Factory into a unified platform. Fabric also supports a data mesh architecture, allowing decentralized data ownership while maintaining centralized governance. This design eliminates the need for direct Azure resource access, simplifying data workflows.

## AI capabilities in Microsoft Fabric

Fabric includes features that support AI development as well as AI-powered productivity across workloads.

**Fabric IQ** (preview) is a Fabric workload for unifying data across OneLake and organizing it according to the language of your business. Its core item is the **ontology**, which defines your business concepts, relationships, and rules so that AI agents can reason across domains using consistent business language rather than raw table schemas.

Fabric IQ is one of three IQ workloads that Microsoft provides to give agents access to different aspects of your organization:

- **Fabric IQ** models business data (ontologies, semantic models, and graphs) so agents can reason over analytics in OneLake and Power BI.
- **Foundry IQ** connects structured and unstructured data across Azure, SharePoint, OneLake, and the web so agents can access permission-aware enterprise knowledge.
- **Work IQ** captures collaboration signals from documents, meetings, chats, and workflows, providing agents with insight into how your organization operates.

Each IQ workload is standalone, but you can use them together to provide comprehensive organizational context for agents.

**Fabric data agents** let you build conversational interfaces where users ask questions about organizational data in natural language. Agents translate those questions into structured queries across your lakehouses, warehouses, and semantic models.

In the Fabric IQ workload, data agents can connect to your ontology as a source, enabling them to understand and use your business concepts when answering questions.

### Copilot across workloads

Microsoft Copilot in Fabric is a generative AI assistant available across all Fabric workloads. Copilot helps data professionals and business users complete common tasks more efficiently. Key capabilities include:

- **Code completion and generation**: Copilot provides intelligent code suggestions in notebooks, generates SQL queries from natural language descriptions, and translates questions into Kusto Query Language (KQL) for real-time analysis.
- **Data transformation guidance**: In Data Factory, Copilot supports both citizen and professional data wranglers with code generation for data transformation and plain-language explanations of complex logic.
- **Report and insight generation**: In Power BI, Copilot generates reports automatically, creates page summaries, and lets business users ask questions about their data in natural language.

> [!NOTE]
> Copilot in Microsoft Fabric is enabled by default. Administrators can disable Copilot from the **Admin portal > Tenant settings** or control access for specific security groups or at the capacity level.
