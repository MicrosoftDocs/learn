
Knowledge base (KB) connections, a feature of Microsoft Copilot for Security currently in preview, allows you to integrate your organization’s knowledge base as an additional source of information. The inclusion of knowledge bases gives Copilot more context, resulting in responses that are more relevant, specific, and customized to your organization.

There are two ways to integrate KBs into Copilot:

- Azure AI Search plugin (BYO index)
- File upload

### Azure AI Search plugin (BYO index)

Azure AI Search is a service that enables you to effectively search, retrieve information, and extract insights from your content, securely and at scale. Common scenarios for leveraging this type of service include document search, data exploration, and chat-style Copilot apps over proprietary data. These use cases are enabled through indexing and querying.

- Indexing in Azure AI Search is the process of loading content into your search service and making it searchable. The index is the searchable result of the indexing process.

- Querying can happen once an index is populated with searchable content. Your client app sends query requests to a search service and handles responses. All query execution is over a search index that you control.

Through the Azure AI Search plugin you can bring own index as a searchable source that you can query using prompts in the Copilot promptbar.  

To configure the plugin settings and create the connection to a your Azure AI Search index. The steps that follow assume that a search instance has already been create

1. Select the sources icon in the promptbar.
1. Select plugins.
1. From the manage plugins windows, select the Azure AI Search setup button.

   :::image type="content" source="../media/azure-ai-search-plugin-v2.png" lightbox="../media/azure-ai-search-plugin-v2.png" alt-text="Screen capture of the Azure AI Search plugin.":::

1. The parameters that you configure for the plugin map to information for the Azure AI Search instance, the index within search instance that will be searhced, and the fields associated with the index.

    1. Azure AI Search instance – the name of your search instance.
    1. Index – the name of the index, within your Azure AI search instance, that will be searched.
    1. Vector – the name of the field in the index containing the vector of embeddings
    1. Text – the name of the field in the index containing the text to search
    1. Title – the title of each document to display as a source (optional)
    1. URL – the URL of each document to display as a source (optional)
    1. Value – the access identifier for API authentication.

   :::image type="content" source="../media/azure-ai-search-plugin-settings.png" lightbox="../media/azure-ai-search-plugin-settings.png" alt-text="Screen capture of the Azure AI Search plugin parameters.":::

1. To obtain the information that you will use for the plugin settings, you need to go to the Azure portal. Open a new browser tab to go to the Azure portal (https://portal.azure.com).

1. From the Azure portal, search for and navigate to Azure AI Search.

1. The AI Search page lists the search instances.  From here you select the search instance you want the plugin to connect to.  Before you select it, copy the name and enter it in Azure AI Search instance field for the plugin. Copy the name and enter it in the plugin field select the search instance.

   :::image type="content" source="../media/azure-ai-search-instance-setting.png" lightbox="../media/azure-ai-search-instance-setting.png" alt-text="Screen capture that highlights the search instance whose name you will copy in Azure AI search instance field for the plugin.":::  

1. Select the search instance whose name you entered in plugin settings page.

1. From the left navigation pane, select Indexes.

    :::image type="content" source="../media/azure-ai-search-index-v2.png" lightbox="../media/azure-ai-search-index-v2.png" alt-text="Screen capture highlighting the indexes option on the Azure AI search instance page.":::  

1. The indexes page will list the available indexes for a given Azure AI Search instance. From the indexes page, copy the name of the index you want to Copilot to search and enter it into the index name field for the plugin.

    :::image type="content" source="../media/index-setting-name.png" lightbox="../media/index-setting-name.png" alt-text="Screen capture of the Azure AI Search plugin parameters.":::  

1. Select the index whose name you entered in plugin settings page.  this opens the index page.  From here, select the fields tab.

1. The fields tab shows the field names for the index.  What is listed here are the default names for the fields. Admin can choose different names for fields in the index, so the names shown here may not be the same for your index.

  :::image type="content" source="../media/chunk-vector-title-settings.png" lightbox="../media/chunk-vector-title-settings.png" alt-text="Screen capture of the Azure AI Search plugin parameters.":::

1. Close the index fields page. Then From the left navigation pane, select Keys.

1. Copy the manage query key value for API authentication and enter it in the value field for the plugin, then select save.

  :::image type="content" source="../media/key-mapping.png" lightbox="../media/key-mapping.png" alt-text="Screen capture of the Azure AI Search key that gets copied into hte value field of the plugin.":::

Once connected, prompt Copilot to look for information related to the KB you uploaded. Make sure to mention “Azure AI Search” in the prompt. For example:

- New SOC analysts can test their knowledge by asking Copilot about the organization’s processes. This can speed up the onboarding process. Sample prompt: Summarize my organization’s multifactor authentication policies in Azure AI Search.

- SOC analysts can ask Copilot to provide information that helps investigate phishing incidents across large volumes of suspicious emails or files ingested by the index. Sample prompt: What are the most common email subject headings in my Azure AI Search index that were used in suspected business email compromise (BEC) emails?

For the Azure AI Search plugin, directly mentioning the file name or title of the uploaded content is less effective than describing your intent in initiating the prompt. This is because Azure AI Search plugin performs a semantic keyword search across the index’s contents and is well-suited to returning relevant content in this way.

### File upload
