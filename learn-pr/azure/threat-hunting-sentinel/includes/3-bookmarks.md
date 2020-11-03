Threat hunting typically requires reviewing mountains of log data looking for evidence of malicious behavior. During this process, investigators find events that they want to remember, revisit, and analyze as part of validating potential hypotheses and understanding the full story of a compromise.

Hunting bookmarks in Azure Sentinel help you do this, by preserving the queries you ran in Azure Sentinel - Logs, along with the query results that you deem relevant. You can also record your contextual observations and reference your findings by adding notes and tags. Bookmarked data is visible to you and your teammates for easy collaboration.

You can revisit your bookmarked data at any time on the Bookmarks tab of the Hunting pane. You can use filtering and search options to quickly find specific data for your current investigation. Alternatively, you can view your bookmarked data directly in the HuntingBookmark table in your Log Analytics workspace.

Bookmarked events contain standard event information, but can be used in different ways throughout the Azure Sentinel interface.

## Create or add to incidents using bookmarks

You can use bookmarks to create a new incident or add bookmarked query results to existing incidents. The **Incident actions** button on the toolbar enables you perform either of these tasks when a bookmark is selected.

:::image type="content" source="../media/3-Incident-actions.png" alt-text="The Incident actions interface in Azure Sentinel" :::

Incidents created from bookmarks can be managed from the Incidents page alongside other incidents created in Azure Sentinel.

## Use the investigation graph to explore bookmarks

You can investigate bookmarks in the same way you would investigate incidents in Azure Sentinel. From the Hunting page, select Investigate to open the investigation graph for the incident.
