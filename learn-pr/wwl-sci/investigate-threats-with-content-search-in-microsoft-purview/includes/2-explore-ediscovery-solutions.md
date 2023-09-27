Electronic discovery, or eDiscovery, is the process of identifying and delivering electronic information that can be used as evidence in legal cases. Organizations can use eDiscovery tools in Microsoft Purview to search for content in:

 -  Exchange Online
 -  OneDrive for Business
 -  SharePoint Online
 -  Microsoft Teams
 -  Microsoft 365 Groups
 -  Yammer teams.

An organization can search mailboxes and sites in the same eDiscovery search. It can then export the search results. Microsoft Purview eDiscovery (Standard) cases can identify, hold, and export content found in mailboxes and sites. If an organization has an Office 365 E5 or Microsoft 365 E5 subscription (or related E5 add-on subscriptions), it can further manage custodians and analyze content by using the feature-rich Microsoft Purview eDiscovery (Premium) solution in Microsoft 365.

> [!NOTE]
> In an Exchange hybrid deployment, you can't use the Content search tool to search emails in on-premises mailboxes. You can only use the tool to search cloud-based mailboxes. In an Exchange hybrid deployment, you can search for Teams chat data in on-premises mailboxes.

### eDiscovery solutions

Microsoft Purview provides three eDiscovery solutions: Content search, eDiscovery (Standard), and eDiscovery (Premium). This module is focused on Content Search, but knowing the differences between solutions provides an overall context. A SOC analyst can then assist the compliance managers doing case management.

:::image type="content" source="../media/microsoft-purview-ediscovery-solutions-545d62bd.png" alt-text="Diagram showing the three eDiscovery solutions in Microsoft Purview.":::


 -  **Content search**. The Content search tool can be used to search for content across Microsoft 365 data sources. It can then export the search results to a local computer.
 -  **eDiscovery (Standard)**. eDiscovery (Standard) builds on the basic search and export functionality of Content search. It does so by enabling organizations to create eDiscovery cases and assign eDiscovery managers to specific cases. eDiscovery managers can only access the cases of which they're members. eDiscovery (Standard) also lets an organization associate searches and exports with a case. It also lets an organization place an eDiscovery holds on content locations relevant to cases.
 -  **eDiscovery (Premium)**. The eDiscovery (Premium) tool builds on the existing case management, preservation, search, and export capabilities in eDiscovery (Standard). eDiscovery (Premium) provides an end-to-end workflow to identify, preserve, collect, review, analyze, and export content that's responsive to an organization's internal and external investigations. It lets legal teams manage custodians and the legal hold notification workflow to communicate with custodians involved in a case. It also enables an organization to collect and copy data from the live service into review sets. From there, the organization can filter, search, and tag content to cull non-relevant content from further review. By doing so, an organization's workflow can identify and focus on content that's most relevant. eDiscovery (Premium) provides analytics and machine learning-based predictive coding models. These features enable an organization to further narrow the scope of an investigation to the most relevant content.

### Comparison of key capabilities

The following table compares the key capabilities available in Content search, eDiscovery (Standard), and eDiscovery (Premium).

| **Capability**                                        | **Content search** | **eDiscovery (Standard)** | **eDiscovery (Premium)** |
|:----------------------------------------------------- |:------------------:|:-------------------------:|:------------------------:|
| Search for content                                    |         X          |             X             |            X             |
| Keyword queries and search conditions                 |         X          |             X             |            X             |
| Search statistics                                     |         X          |             X             |            X             |
| Export search results                                 |         X          |             X             |            X             |
| Role-based permissions                                |         X          |             X             |            X             |
| Case management                                       |                    |             X             |            X             |
| Place content locations on legal hold                 |                    |             X             |            X             |
| Custodian management                                  |                    |                           |            X             |
| Legal hold notifications                              |                    |                           |            X             |
| Advanced indexing                                     |                    |                           |            X             |
| Error remediation                                     |                    |                           |            X             |
| Review sets                                           |                    |                           |            X             |
| Support for cloud attachments and SharePoint versions |                    |                           |            X             |
| Optical character recognition                         |                    |                           |            X             |
| Conversation threading                                |                    |                           |            X             |
| Collection statistics and reports                     |                    |                           |            X             |
| Review set filtering                                  |                    |                           |            X             |
| Tagging                                               |                    |                           |            X             |
| Analytics                                             |                    |                           |            X             |
| Predictive coding models                              |                    |                           |            X             |
| Computed document metadata                            |                    |                           |            X             |
| Transparency of long-running jobs                     |                    |                           |            X             |
| Export to customer-owned Azure Storage location       |                    |                           |            X             |

The following list provides a description of each eDiscovery capability:

 -  **Search for content**. Search for content that's stored in Exchange mailboxes, OneDrive for Business accounts, SharePoint sites, Microsoft Teams, Microsoft 365 Groups, and Yammer Teams. Searches can also include content generated by other Microsoft 365 apps that store data in mailboxes and sites.
 -  **Keyword queries and search conditions**. Create KQL keyword search queries to search for content that matches query criteria. Conditions can also be included to narrow the scope of the search.
 -  **Search statistics**. After an organization runs a search, it can view statistics of the estimated search results. For example, the number and total size of items matching the search criteria. Other statistics include the top content locations that contain search results and the number of items that match different parts of the search query.
 -  **Export search results**. Export search results to a local computer in an organization in a two-step process. When an organization exports search results, items are copied from their original content location in Microsoft 365 to a Microsoft-provided Azure Storage location. The items can then be download to a local computer.
 -  **Role-based permissions**. Use role-based access control permissions to control what eDiscovery-related tasks that different users can complete. An organization can use a built-in eDiscovery-related role group or create custom role groups that assign specific eDiscovery permissions.
 -  **Case management**. eDiscovery cases in eDiscovery (Standard) and eDiscovery (Premium) let an organization associate specific searches and exports with a specific investigation. Members can also be assigned to a case to control who can access the case and view the contents of the case.
 -  **Place content locations on legal hold**. Preserve content relevant to an investigation by placing a legal hold on the content locations in a case. This feature lets organizations secure electronically stored information from inadvertent (or intentional) deletion during the investigation.
 -  **Custodian management**. Manage the people who have been identified as people of interest in a case (called **custodians**). An organization can also manage other data sources that may not be associated with a custodian. When an organization adds custodians and non-custodial data sources to a case, it can:
     -  place a legal hold on these data sources.
     -  communicate with custodians by using the legal hold notification process.
     -  search custodian and non-custodial data sources to collect content relevant to the case.
 -  **Legal hold notifications**. Manage the process of communicating with case custodians. A legal hold notification instructs custodians to preserve content that's relevant to the case. An organization can track the notices that were received, read, and acknowledged by custodians. The communications workflow in eDiscovery (Premium) enables organizations to create and send initial notifications, reminders, and escalations if custodians fail to acknowledge a hold notification.
 -  **Advanced indexing**. This process reindexes the current locations associated with a case. It occurs when an organization adds custodial and non-custodian data sources to a case. As such, any content deemed as partially indexed is reprocessed to make it fully searchable when the organization collects data for an investigation.
 -  **Error remediation**. This process is used to fix processing errors. It enables an organization to rectify data issues that prevent eDiscovery (Premium) from properly processing the content during Advanced indexing. For example, files that are password protected can't be processed since the files are locked or encrypted. An organization can use error remediation to:
     -  download files with errors.
     -  remove the password protection.
     -  upload the remediated files.
 -  **Review sets**. Add relevant data to a review set. A review set is a secure, Microsoft-provided Azure Storage location in the Microsoft cloud. When an organization adds data to a review set, the collected items are copied from their original content location to the review set. Review sets:
     -  provide a static, known set of content that can be searched, filtered, tagged, and analyzed.
     -  enable organizations to predict relevancy using predictive coding models.
     -  enable organizations to track and report on what content gets added to the set.
 -  **Support for cloud attachments and SharePoint versions**. When an organization adds content to a review set, it can include cloud attachments or linked files. By doing so, the target file of a cloud attachment or linked file is added to the review set. An organization can also add all versions of a SharePoint document to a review set.
 -  **Optical character recognition (OCR)**. When content is added to a review set, OCR functionality extracts text from images. It then includes the image text with the content that's added to a review set. This process enables an organization to search for image text when it queries the content in the review set.
 -  **Conversation threading**. When chat messages from Teams and Yammer conversations are added to a review set, an organization can collect the entire conversation thread. As a result, the entire chat conversation that contains items that match the collection criteria is added to the review set. This process lets the organization review chat items in the context of the back-and-forth conversation.
 -  **Collection statistics and reports**. After an organization creates a draft collection or commits a collection to a review set, it can view a rich set of statistics on the retrieved items, such as the content locations that contain the most items that matched the search criteria and the number of items returned by the search query. The organization can also preview a subset of the results.
 -  **Review set filtering**. After content is added to a review set, an organization can apply filters to display only the set of items that match its filtering criteria. It can then save the filter sets as a query, which lets it quickly reapply the saved filters. Review set filtering and saved queries help an organization quickly cull content to the items that are most relevant to its investigation.
 -  **Tagging**. Tags also help organizations cull non-relevant content and identify the most relevant content. When experts, attorneys, or other users review content in a review set, their opinions related to the content can be captured by using tags. For example, if the intent is to cull unnecessary content, a user can tag documents with a tag such as "non-responsive". After content has been reviewed and tagged, a review set query can be created to exclude any content tagged as "non-responsive". This process eliminates the non-responsive content from subsequent steps in the eDiscovery workflow.
 -  **Analytics**. eDiscovery (Premium) provides tools to analyze review set documents to help an organization organize the documents in a coherent manner and reduce the volume of documents to be reviewed. The following analytics features help make an organization's review process more efficient so that reviewers can review a fraction of collected documents:
     -  **Near duplicate detection**. Groups textually similar documents together to help an organization make its review process more efficient.
     -  **Email threading**. Identifies specific email messages that give a complete context of the conversation in an email thread.
     -  **Themes**. Analyzes documents in a review set to identify possible themes. If a theme is identified, it assigns the theme to the documents. This process enables an organization to filter documents with a related theme.
 -  **Predictive coding models**. Use predictive coding models to reduce and cull large volumes of case content to a relevant set of items that can be prioritized for review. This process is accomplished when an organization creates and trains its own predictive coding models that help it prioritize the review of the most relevant items in a review set. The system uses the training to apply prediction scores to every item in the review set. As a result, an organization can filter items based on the prediction score, which enables it to review the most relevant (or non-relevant) items first.
 -  **Computed document metadata**. Many of the eDiscovery (Premium) features, such as Advanced indexing, conversation threading, analytics, and predictive coding add metadata properties to review set documents. This metadata contains information related to the function performed by a specific feature. When an organization reviews documents, it can filter on metadata properties to display documents that match its filter criteria. This metadata can be imported into third-party review applications after review set documents are exported.
 -  **Transparency of long-running jobs**. Jobs in eDiscovery (Premium) are typically long-running processes that are triggered by user actions. An organization can track the status of these jobs and get support information if it must escalate issues to Microsoft Support. Examples include:
     -  adding custodians to a case.
     -  adding content to a review set.
     -  running analytics.
     -  training predictive coding models.
 -  **Export to customer-owned Azure Storage location**. When an organization exports documents from a review set, it can export them to an Azure Storage account the organization manages. Additionally, eDiscovery (Premium) lets an organization customize what data is exported. This data includes:
     -  file metadata
     -  native files
     -  text files
     -  tags
     -  redacted documents saved to a PDF file

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”
