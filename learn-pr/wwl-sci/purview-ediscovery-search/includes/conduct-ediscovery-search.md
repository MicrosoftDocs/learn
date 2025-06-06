As an information security administrator, one of your responsibilities might be to investigate activity that could indicate a data leak or misuse of sensitive information. eDiscovery searches in Microsoft Purview help you locate potentially relevant content across Microsoft 365 services, such as email, files, and Teams messages.

For example, you might need to identify messages and documents shared externally by members of the Sales department during a specific time period. To do that, you'll create a search in an eDiscovery case, define the locations to search, and configure your query to find the relevant content.

## Supported Microsoft 365 workloads

When you conduct a search, the results might include content from the following workloads, depending on the locations you choose:

- **Exchange Online**: Email messages and calendar items
- **SharePoint Online and OneDrive for Business**: Files and document metadata
- **Microsoft Teams**:
  - **Chat messages** (1:1 and group chats)
  - **Channel messages**
  - **Files shared in chat and channels**
- **Microsoft 365 Groups and Viva Engage**: Group conversations and shared documents

## Conduct an eDiscovery search

eDiscovery searches in Microsoft Purview are typically conducted in phases. Each phase helps narrow the focus of the investigation and ensures that the results are accurate and relevant.

The phases include:

1. Define the scope of your search
1. Identify data sources
1. Build the query
1. Run and review the results

You might return to earlier phases to adjust sources or refine your query based on the results. Once you're confident in the results, you can move on to the next steps in the investigation, such as exporting data or adding it to a review set.

### Phase 1: Define search criteria

When configuring a search, you'll specify:

- A **search name** and optional description
- One or more **data sources**, such as users, groups, or sites
- A **query** using conditions, keywords, or Keyword Query Language (KQL)

You can use the **Conditions** tab to apply filters like date range or sender, and the Keywords tab to build your query using text or KQL.

### Phase 2: Identify data sources

Before you can run a search, you need to specify the sources where content should be collected. In Microsoft Purview eDiscovery, this includes users, groups, SharePoint sites, OneDrive accounts, and Teams.

To add sources:

1. In the **Data sources** section, select **Add sources** or choose **Add tenant-wide sources** if you want to search across the entire organization.
1. In the **Search for sources** pane, you can filter by:
   - All people and groups (default)
   - People only
   - Groups only

1. Enter the name, email address, or URL of the source. For SharePoint and OneDrive, enter a full site or account URL.
1. Optionally, select **Exclude inactive users** to limit the results.
1. Choose your sources, then select **Save and close**.

   :::image type="content" source="../media/select-data-sources.png" alt-text="Screenshot showing where to select data sources in eDiscovery." lightbox=" ../media/select-data-sources.png":::

You can select individual sources or include all active users and groups in the tenant. For most investigations, narrowing the scope of your data sources helps return more relevant results and improves performance.

### Phase 3: Build the query

The **Condition builder** lets you define filters to narrow the results returned by your search. You can use simple matching logic or combine conditions to focus on specific types of content.

To add conditions:

1. In the **Query** tab, under **Condition builder**, select **Add conditions**.
1. Choose from the available options:
   - **KeyQL**: Write advanced queries using Keyword Query Language.
   - **Date**: Filter content based on sent, received, or modified dates.
   - **Subject/Title**: Match specific terms in email subjects or document titles.
   - **Participants**: Filter by sender, recipient, or other participants.
   - **Type**: Filter by message kind, such as Email, Chat, or Teams.

Each condition supports different operators, such as **equals**, **contains**, or **starts with**. Conditions are combined using **AND**, meaning content must meet all specified criteria to be included.

   :::image type="content" source="../media/condition-builder.png" alt-text="Screenshot showing an example query in the condition builder in eDiscovery." lightbox=" ../media/condition-builder.png":::

You can add multiple conditions and adjust or remove them as needed. When using both the condition builder and a keyword query, the system will apply both sets of criteria to your results.

#### Use Copilot to generate queries (preview)

If available, Microsoft Security Copilot can help build a query from a natural language prompt. For example:

_Find Teams messages sent by Alex Wilber between March 1 and March 15 that contain attachments related to budget planning._

:::image type="content" source="../media/generate-keyql-copilot.png" alt-text="Screenshot showing Copilot generating KeyQL code with Copilot." lightbox=" ../media/generate-keyql-copilot.png":::

Copilot generates a suggested KeyQL query that you can review and edit.

#### Search by file (preview)

If you're working with evidence like chat logs, documents, or audit exports, you can use the Search by file option to find related content. This preview feature lets you upload sample data and use it as the basis for your search instead of writing manual queries.

To use Search by file:

1. Select the **Search by file (preview)** tab.
1. Choose **Attach files**, then select one of the following:
   - **Find similar content (.txt file)**: Upload a plain text file containing sample content to match against.
   - **Find reference content (.csv file)**: Upload a CSV file, such as one generated from audit logs, to identify messages or files tied to specific users and actions.
1. After uploading, your file appears in the table with its details.

Each file must be 10 MB or smaller and in `.txt` or `.csv` format. When using this method, KQL and condition builder options are disabled. Instead, Microsoft Purview analyzes the uploaded content to find matches.

This feature is especially useful when you're investigating suspicious behavior and already have sample evidence to work from.

### Phase 4: Run and review the results

After you've configured your search criteria, you're ready to run the query and review the results.

1. Select **Run query**.
1. Choose your preferred result type:

   - **Statistics**: View summary data about the search, including the number of items found, size of the results, and breakdown by location.
   - **Sample**: View a random sample of the search results to validate your query before proceeding.

Results appear in the **Query** and **Statistics** tabs. If the results don't match what you expected, you can update your conditions or data sources and run the query again.

After confirming that the results are accurate, you can export the content or add it to a review set, depending on what your investigation requires.
