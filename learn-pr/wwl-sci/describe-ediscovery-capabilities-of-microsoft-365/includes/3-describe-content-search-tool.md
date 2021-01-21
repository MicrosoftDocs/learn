The Content Search eDiscovery tool, accessible from the compliance center in Office 365 or Microsoft 365, enables search for in-place items such as email, documents, and instant messaging conversations in your organization. Search for items is supported in the following services:

- Exchange Online mailboxes and public folders
- SharePoint Online sites and OneDrive for Business accounts
- Skype for Business conversations
- Microsoft Teams
- Microsoft 365 Groups
- Yammer Groups

To have access to the Content search page to run searches and preview and export search results, an administrator, compliance officer, or eDiscovery manager must be a member of the eDiscovery Manager role group in the Security & Compliance Center. For more information, visit [Assign eDiscovery permissions](https://docs.microsoft.com/microsoft-365/compliance/assign-ediscovery-permissions?view=o365-worldwide).

## Run a search

To start using the Content Search tool, the user must choose content locations to search and configure a keyword query to find specific items. Alternatively, the user can just leave the query blank and return all items in the target locations.
Examples of some of the capabilities for running a search include:

- **Build search queries and use conditions** to narrow your search
- **Configure search permissions filtering** so that an eDiscovery manager can only search for a subset of mailboxes or sites in your organization
- **Run an ID list search** to search for specific mailbox email messages and other mailbox items using a list of Exchange IDs
- **Search for Teams chat data** across on-premises users
- **View keyword statistics** for the results of a search and then refine the query if necessary
- **Search for third-party data** that your organization has imported to Microsoft 365
- **Preserve Bcc recipients** to comply with regulatory compliance and eDiscovery requirements that may require organizations to preserve mailbox content, including the ability to search for and reproduce details about all recipients of a message, not just those on the to and cc list.

## Perform actions on content

After you run a search and refine it as necessary, the next step is to do something with the results returned by the search. You can export and download the results to your local computer or in the case of an email-based attack, you can delete the results of a search from user mailboxes.
You can also use scripts for advanced scenarios. Sometimes you have to perform more advanced, complex, and repetitive content search tasks. To help make this easier, Microsoft has created a number of Security & Compliance Center PowerShell scripts to help complete complex content search-related tasks. Some of these scripts include:

- **Search-specific mailbox and site folders** (called a targeted collection) when you're confident that items responsive to a case are located in that folder
- **Search the mailbox and OneDrive location** for a list of users
- **Create, report on, and delete multiple searches** to quickly and efficiently identify, and cull search data
- **Clone a content search** and quickly compare the results of different keyword search queries run on the same content locations; or use the script to save time by not having to reenter a large number of content locations when you create a new search

Content Search is easy to use, but it's also a powerful tool. To learn more, visit the [content search overview](https://docs.microsoft.com/microsoft-365/compliance/search-for-content?view=o365-worldwide).

