
Your knowledge base is only as good as the data it contains. Foundry IQ lets you connect to multiple data sources, enabling your AI agent to access the information it needs to answer questions accurately. You configure these sources when you set up your knowledge base, ensuring your agent has the right context for your specific use case.

Understanding which data source to use depends on where your data lives and how you need to access it. Foundry IQ supports six primary data source types:

| Data Source | Access Type | Best For |
|-------------|-------------|----------|
| Azure AI Search Index | Indexed | Enterprise search with custom pipelines |
| Azure Blob Storage | Direct | Document files in Azure Storage |
| Web | Real-time | Current, public information via Bing |
| SharePoint (Remote) | Real-time | Live SharePoint content with Microsoft 365 governance |
| SharePoint (Indexed) | Indexed | Advanced search on SharePoint with custom pipelines |
| OneLake | Direct | Unstructured data in Microsoft Fabric |

With real-time sources, you get current information. With internal data sources like SharePoint or OneLake, you maintain security and governance while giving your agent access to proprietary knowledge.

## Azure AI Search Index

Azure AI Search Index provides enterprise-scale search capabilities for your Foundry IQ knowledge base. This option is ideal when you already invested in Azure AI Search and want to use existing search indexes.

With this source, you connect directly to your Azure AI Search index, which can contain data from multiple origins that you've already processed and indexed. This becomes especially important when you need sophisticated search capabilities like semantic ranking, filters, or custom scoring profiles that Azure AI Search provides.

> [!TIP]
> Learn more about [Azure AI Search](/azure/search/search-what-is-azure-search) and how to create and manage search indexes for your knowledge bases.

Your agent can query this index to retrieve relevant information based on user questions. Key benefits include:

- **Semantic ranking** - Finds contextually relevant results, not just keyword matches
- **Custom scoring** - Prioritizes results based on your business logic
- **Faceted navigation** - Filters results by categories or attributes
- **Multi-language support** - Handles content in different languages

## Azure Blob Storage

Azure Blob Storage lets you retrieve documents and files directly from your blob containers. You select specific containers or blobs, and Foundry IQ processes the content to make it available to your agent.

This source works well when you store documents in Azure Blob Storage. Common file types include:

- PDF documents
- Microsoft Word files (.docx)
- Text files (.txt)
- Markdown files (.md)
- HTML files

> [!NOTE]
> Unlike Azure AI Search, which requires you to build and maintain an index, Blob Storage provides a more direct path from your files to your knowledge base.

Building on this concept, you can organize your blobs into containers based on topics or access levels, making it easier to manage what information your agent can access. This organization helps maintain data governance while keeping your knowledge base current.

## Web

Web access grounds your agent with real-time content from the internet via Bing. Instead of relying only on static, internal data, your agent can search for current information when answering questions.

This becomes especially important when users ask about:

- Recent events or news
- Current pricing or availability
- Frequently changing information
- Topics outside your internal knowledge base

> [!IMPORTANT]
> With web grounding, you're relying on Bing's search results, which means less control over the specific sources your agent references. When accuracy and source verification are critical, consider using indexed, controlled data sources instead.

> [!TIP]
> You can combine web grounding with internal data sources, using web access as a supplementary source when internal knowledge doesn't provide an answer.

## Microsoft SharePoint options

Foundry IQ provides two ways to connect to SharePoint, each with distinct advantages. The following table compares these approaches:

| Feature | Remote | Indexed |
|---------|--------|----------|
| **Access method** | Real-time queries | Preprocessed index |
| **Response time** | Depends on SharePoint | Faster |
| **Maintenance** | No index to maintain | Requires index updates |
| **Advanced search** | Limited | Full Azure AI Search capabilities |
| **Data freshness** | Always current | Depends on indexing schedule |
| **Permission handling** | Respects SharePoint permissions | Configured during indexing |

### SharePoint Remote

SharePoint Remote provides search capabilities with Microsoft 365 governance, retrieving content directly from SharePoint without preindexing. Your agent searches SharePoint sites and libraries in real-time when users ask questions.

Key benefits of remote access:

- No index maintenance required
- Always accesses current SharePoint content
- Automatically respects existing SharePoint permissions
- Simpler setup and configuration

> [!TIP]
> Use SharePoint Remote when you need the simplest path to SharePoint data and don't require advanced search features.

### SharePoint Indexed

SharePoint Indexed takes a different approach by indexing SharePoint content into Azure AI Search for custom pipelines. Unlike remote access, which queries SharePoint in real-time, indexing processes your SharePoint content in advance.

This preprocessing means faster response times and more sophisticated search capabilities. With indexed content, you can:

1. Apply custom analyzers for specialized terminology
2. Build enrichment pipelines with AI services
3. Combine SharePoint data with other sources
4. Create specialized search experiences

> [!NOTE]
> Indexed SharePoint works best when you need advanced search features or when you're integrating SharePoint data with other sources in your Azure AI Search index.

## Microsoft OneLake

Microsoft OneLake provides access to unstructured data stored in your Microsoft Fabric data lakehouse. You connect to OneLake to retrieve files and documents stored in your lakehouse, making this data available to your knowledge base.

> [!TIP]
> Learn more about [Microsoft Fabric OneLake](/fabric/onelake/onelake-overview) and how it serves as a unified data lake for your organization.

This option matters when your organization uses Microsoft Fabric for data analytics and storage. Common use cases include:

- **Business intelligence reports** - Reference analytical findings in agent responses
- **Data documentation** - Provide context about datasets and metrics
- **Analytical findings** - Share insights from data science work
- **Research outputs** - Make research accessible through conversational AI

With this connection, your agent can reference this information when answering business questions, providing data-driven responses grounded in your organization's analytical work.

## Choose the right data source

Selecting the appropriate data source depends on several factors. Use this decision guide:

| If your data is... | And you need... | Choose... |
|--------------------|-----------------|----------|
| In SharePoint | Simple setup, always current | SharePoint Remote |
| In SharePoint | Advanced search, custom pipelines | SharePoint Indexed |
| Files in Azure | Direct file access | Azure Blob Storage |
| In Microsoft Fabric | Data lakehouse content | OneLake |
| Already indexed | Existing Azure AI Search investment | Azure AI Search Index |
| Public, current information | Real-time web content | Web |

> [!IMPORTANT]
> You can combine multiple sources in a single knowledge base. For example, use internal SharePoint data as the primary knowledge base while enabling web grounding for current events or supplementary information.
