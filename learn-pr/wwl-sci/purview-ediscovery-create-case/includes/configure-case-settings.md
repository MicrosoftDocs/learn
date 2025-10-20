Each eDiscovery case in Microsoft Purview includes configurable settings that affect how searches, analytics, and review sets behave. These settings help tailor investigations to your organization’s needs and control how reviewers interact with case data.

You can configure case settings in several categories:

- Data sources
- Search and analytics
- Review sets

These settings are applied at the case level and affect all review sets within the case.

## Configure data source settings

Data source settings control which people and groups are included during organization-wide searches. By default, only licensed users are included. You can expand this scope to include other types of users, depending on your investigative needs.

From the **Case settings** page, select **Data sources**, then choose one or more of the following options:

- All people and groups including unlicensed, on-premises, and guest users
- All people and groups including shared Teams channels
- All people and groups including departed users

Adding more data sources can increase search time. Only use these settings when they support the scope of your investigation. To reset to the default configuration, select **Restore defaults**.

## Configure search and analytics settings

The **Search and analytics** settings apply to all review sets in a case. These settings control how data is grouped, how search results are processed, and whether advanced analytics features are used.

To access these settings, go to **Case settings** > **Search and analytics**.

Available options include:

- **Near duplicate and email threading analysis**: Groups similar documents and emails together to improve review efficiency. Set the similarity threshold and word count ranges for inclusion.
- **Themes**: Automatically groups documents by dominant ideas to help identify patterns across large datasets. You can set a maximum number of themes and enable dynamic adjustment if the document count is low.
- **Auto-generated review set query**: Automatically creates a saved search called **For Review** that filters out duplicates after analytics is run.
- **Ignore text**: Exclude known irrelevant content, such as boilerplate email disclaimers, from analytics processing using specific text or regular expressions.
- **Optical character recognition (OCR)**: Enables OCR during advanced indexing so that text in image files becomes searchable and reviewable.

   :::image type="content" source="../media/search-analytics-settings.png" alt-text="Screenshot showing the options for search and analytics settings in an eDiscovery case." lightbox="../media/search-analytics-settings.png":::

These settings help streamline case review and reduce time spent on redundant content.

## Configure review set grouping

Review sets can be grouped to make it easier for reviewers to see related content. Grouping settings vary based on when the case was created:

- **For cases created after March 15, 2023**: Items are grouped by **Group ID** and **Thread ID**
- **For cases created before that date**: Items are grouped by **Family ID** and **Conversation ID**

You can view or change the grouping method in **Case settings** > **Review sets** by toggling **Allow grouping**. This setting affects how related items are organized within the review set and can affect review speed and clarity.
