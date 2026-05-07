Knowledge base connections, a feature of Microsoft Security Copilot currently in preview, allow you to integrate your organization's knowledge base as an additional source of information. By including knowledge bases, you give Copilot more context, which results in responses that are more relevant, specific, and customized to your organization.

An organization's knowledge base might include proprietary information such as wikis, policy and compliance documents, investigation and response procedures, templates, historical data, KQL (Kusto Query Language) libraries, or even information from public repositories like prescriptive guidelines and frameworks.

There are two ways to integrate a knowledge base into Copilot:

- File upload
- Azure AI Search plugin

### File upload

You can upload files in Microsoft Security Copilot to allow Copilot to refer to the contents of the files when you prompt Copilot and mention your "uploaded files." Examples of files you can upload include your organization's policy and compliance documents, investigation and response procedures, and templates.

> [!NOTE]
> The file upload feature in Copilot doesn't support use cases such as evaluation or detonation of malicious files.

To upload a file:

1. Check that the file is a common text file type like DOCX, MD, PDF, or TXT format, and that each file doesn't exceed 3 MB. You can upload files up to 20 MB in total.

1. In the Copilot home page, select the sources icon ![Screenshot of sources icon](../media/sources-icon-from-docs.png) in the prompt bar to open the **Manage sources** page.

1. Select **Files** to open the file upload section.

      :::image type="content" source="../media/manage-sources-files-new-v2.png" lightbox="../media/manage-sources-files-new-v2.png" alt-text="Screen capture of the files upload page.":::

1. Select **Upload file** to browse for your file.

1. Wait for the file to appear in **Uploads**. If an error message appears, correct the problem and try again.

1. To include the file as a source in your current session, toggle the button beside the file to the on position (lit up). If you aren't going to use the file yet, or want to exclude it as a source in your current session, keep the toggle off (greyed out).

To prompt using the uploaded file, you need to mention "uploaded files" if you want Copilot to reason over your available files. You can also include the file name to guide Copilot to reason over a specific file. For example:

*Based on the Contoso Data Handling Policy file, list any actions taken by user Preston-123 that might be a violation of the data handling policies. Include a verdict to the action and level of confidence of the verdict. Cite the policy name and section applicable to the verdict*.

#### Storage and availability

Uploaded files are always stored in the home Geo of the tenant. Uploaded files are stored in the Security Copilot service, not inside your Microsoft tenant boundary. Uploaded files are only available to the user account that uploaded them and aren't available to other users within or outside the tenant.

#### Delete a file

To delete a file, select the trash icon next to the file name in **Manage sources > Files > Uploads**.

#### Restrict file upload (for owners)

Users assigned the Owner role can choose who are allowed to upload files in owner settings. The options are:

- No one can upload files
- Contributors and Owners can upload files

By default, file upload is available for all users (Contributors and Owners).

### Azure AI Search plugin

Azure AI Search is a service that allows you to search, retrieve information, and extract insights from your content at scale and securely. It's commonly used for document search, data exploration, and chat-style Copilot apps over proprietary data. There are two primary workloads in Azure AI Search:

- **Indexing** loads your content into the search service and makes it searchable.
- **Querying** allows you to search the content from your index once it's populated with searchable content.

The Microsoft Security Copilot integration for Azure AI Search is enabled via a plugin that must be configured to connect to one of your Azure AI Search indexes. The integration enables you to reference your content to generate contextualized, relevant, and specific responses.

# [Azure AI Search plugin](#tab/azure-ai-search-plugin)
:::image type="content" source="../media/azure-ai-search-plugin-v2.png" lightbox="../media/azure-ai-search-plugin-v2.png" alt-text="Screen capture of the Azure AI Search plugin.":::

# [Plugin set up](#tab/plugin-set-up)
:::image type="content" source="../media/ai-search-plugin-settings.png" lightbox="../media/ai-search-plugin-settings.png" alt-text="Screen capture of the Azure AI Search plugin parameters.":::

---

You can find the required information for the plugin setup in your Azure AI Search page in the Azure portal.

> [!IMPORTANT]
> Currently, Copilot doesn't validate your credentials when you save your settings. If they aren't correct, you see an error later when Copilot attempts to run the Azure AI Search plugin.

#### Requirements

To use the Azure AI Search plugin in Copilot, make sure that the Azure AI Search index is configured as follows:

- The text field must be searchable.
- The title field must be filterable.
- The vector field must use **text-embedding-ada-002**.

One way to get started with setting up an index with these requirements is to use integrated vectorization. Refer to [Quickstart: Integrated vectorization (preview)](/azure/search/search-get-started-portal-import-vectors).

#### Prompting with Azure AI Search

Once connected, prompt Copilot to look for information in the Azure AI Search index. Make sure to mention "Azure AI Search" in the prompt. For example:

- New staff can ask Copilot about the organization's processes within their Copilot workflows. This can speed up the onboarding process.

   *Sample prompt: Summarize my organization's multifactor authentication policies in Azure AI Search.*

- While performing an incident investigation, SOC analysts can ask Copilot for investigation steps from their organization's processes and procedures.

   *Sample prompt: Search my Azure AI Search index for investigation steps that I should follow for this incident involving multiple failed sign-in attempts by a user.*

The Azure AI Search plugin performs a semantic and keyword search across the index's contents to find the relevant information, so it's advisable to be as specific as you can in your prompts.

### Known limitations

For both the Azure AI Search plugin and file upload methods of connecting knowledge bases:

- Copilot reasons over text content only, not other data or media types.
- Searches over structured content like tables aren't well-supported yet.

For the Azure AI Search plugin specifically:

- Only one index at a time can be connected using the plugin. To query a different index, you need to update the plugin settings.
- To invoke the plugin, you need to explicitly mention "Azure AI Search" in the prompt.
- Copilot displays the titles of the referenced documents from the index, but they aren't hyperlinked.
