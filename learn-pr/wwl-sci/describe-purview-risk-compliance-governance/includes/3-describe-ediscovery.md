
Electronic discovery, or eDiscovery, is the process of identifying and delivering electronic information that can be used as evidence in legal cases. 

eDiscovery is one of the solutions available through the Microsoft Purview portal, under the Risk & Compliance set of solutions. 

The Microsoft Purview portal presents a unified eDiscovery experience. All eDiscovery capabilities are available through a single interface, and depending on your organization's licensing and subscriptions, you can access premium features for managing cases, analyzing content, and conducting advanced investigations.

To access any of the eDiscovery-related tools, a user must be assigned the appropriate permissions.

# [Microsoft Purview portal](#tab/purview-portal)
:::image type="content" source="../media/purview-portal-risk-compliance.png" lightbox="../media/purview-portal-risk-compliance.png" alt-text="A screen capture of the Microsoft Purview portal that highlights eDiscovery in the risk and compliance set of solutions.":::

# [eDiscovery](#tab/ediscovery)
:::image type="content" source="../media/ediscovery-overview.png" lightbox="../media/ediscovery-overview.png" alt-text="A screen capture of the eDiscovery overview page in the Microsoft Purview portal.":::

---

You can use Microsoft Purview eDiscovery to identify, review, and manage content in Microsoft 365 services to support your investigations. Supported Microsoft 365 services include:

- Exchange Online
- Microsoft Teams
- Microsoft 365 Groups
- OneDrive
- SharePoint
- Viva Engage

### eDiscovery workflow

The eDiscovery workflow helps you more quickly identify, investigate, and take action on electronic stored information (ESI) in your organization. Identifying and taking action on ESI items with eDiscovery uses the following workflow:

:::image type="content" source="../media/ediscovery-workflow.png" lightbox="../media/ediscovery-workflow.png" alt-text="A diagram showing the eDiscovery workflow.":::

**Step 1: Escalate from trigger event**: Trigger events are activities that are escalated in your organization and prompt the creation of a new case in eDiscovery.

**Step 2: Create and manage case**: A case in eDiscovery contains all searches, holds, and review sets related to a specific investigation.

**Step 3: Search, evaluate results, and refine**: After you create a case, use the built-in search tools to search content locations in your organization.

**Step 4a: Actions include**:
  - Export search results
  - Create review sets from the search results: A review set is a secure, Microsoft-provided Azure Storage location in the Microsoft cloud. When you add data to a review set, the collected items are copied from their original content location to the review set. Review sets provide a static, known set of content that you can search, filter, tag, and analyze.
  - Create holds: You can create holds to preserve content that might be relevant to an eDiscovery case.

**Step 5: Review and take action from review sets**: There are many different actions you can take. Some of the actions include:
  - Run analytics: eDiscovery provides integrated analytics tool that helps you further cull data from the review set that you determine isn't relevant to the investigation. 
  - Tag items - When experts, attorneys, or other users review content in a review set, their opinions related to the content can be captured by using tags.
  - Export items - After you search for and find data that's relevant to your investigation, you can export it out of your Microsoft 365 organization for review by people outside of the investigation team.

### eDiscovery features and capabilities

The list that follows is a small subset of the capabilities available with eDiscovery. For a complete listing, refer to the features and capabilities section of the article titled, "Learn about eDiscovery (preview)" linked in the summary and resources unit of this module.

- **Search for content**: Search for content that's stored in Exchange mailboxes, OneDrive accounts, SharePoint sites, Microsoft Teams, Microsoft 365 Groups, and Viva Engage Teams.
- **Export search results**: Export search results to a local computer in your organization. When you export search results, items are copied from their original content location and packaged. Then you can download those items in the export package to a local computer.
- **Place content locations on hold**: Preserve content relevant to your investigation by placing a hold on the content locations in a case. Holds let you secure electronically stored information from inadvertent (or intentional) deletion during your investigation.
- **Search and delete data**: Search for and delete potentially harmful or high-risk content, including email messages and Teams chat messages, across your organization.
- **Review sets** (premium feature) -  A review set is a secure, Microsoft-provided Azure Storage location in the Microsoft cloud. When you add data to a review set, the collected items are copied from their original content location to the review set. Review sets provide a static, known set of content that you can search, filter, tag, analyze, and predict relevancy using predictive coding models.
- **Optical character recognition (OCR)** (premium feature) - When content is added to a review set, OCR functionality extracts text from images, and includes the image text with the content that's added to a review set. This lets you search for image text when you query the content in the review set.
- **Conversation threading** (premium feature): When chat messages from Teams and Viva Engage conversations are added to a review set, you can collect the entire conversation thread. This lets you review chat items in the context of the back-and-forth conversation.
- **Decryption** (premium feature): eDiscovery supports decryption of content protected with Microsoft encryption technologies. Email messages and attachments encrypted with Microsoft Purview Message Encryption, and documents protected with sensitivity labels, are automatically decrypted when added to a review set.

### Integration with Microsoft Security Copilot

Microsoft Purview eDiscovery supports integration with Microsoft Security Copilot, through the embedded experience. Users whose organization has been onboarded to Copilot, have enabled Copilot to access data from Microsoft 365 services, and have the appropriate role permissions can experience Copilot integration through the following supported capabilities:

- Gain contextual summary of evidence collected in eDiscovery review sets.
- Natural language to Keyword Query Language (KeyQL) queries.

#### Gain contextual summary of evidence collected in eDiscovery review sets

eDiscovery admins and managers often spend significant time reviewing evidence collected in review sets. You can use Security Copilot in Microsoft Purview to provide a contextual summary of most items in a review set.

The summary provided is in the context of text included in a selected item. This summary can save time for reviewers by quickly identifying information helpful when tagging or exporting items.

Security Copilot summarizes the entire item, including documents, meetings transcripts, or attachments. You can also ask follow-up contextual questions about the summary.

:::image type="content" source="../media/purview-ediscovery-context-v2.png" lightbox="../media/purview-ediscovery-context-v2.png" alt-text="Screen capture of the context generated by Copilot for an item in a review set of Microsoft Purview eDiscovery (Premium).":::

#### Natural language to KeyQL queries

With Copilot integration in eDiscovery, eDiscovery managers can use natural language prompts to generate KeyQL queries. With the query generated, you can save it or run the query. Copilot also provides prompt suggestions that can be generated into a query.

:::image type="content" source="../media/ediscovery-copilot-keyword-query.png" lightbox="../media/ediscovery-copilot-keyword-query.png" alt-text="Screen capture showing the user interface for drafting a query with Copilot, using natural language. The option to use available prompts to generate the query is also shown.":::

### Integration with Microsoft Purview Insider Risk Management

Microsoft Purview eDiscovery integrates with Microsoft Purview Insider Risk Management. When an insider risk case requires legal review for potentially risky user activity, it can be quickly escalated to a new case in eDiscovery. This integration helps risk and legal teams work together more efficiently and provides a complete view of user activities under review.
