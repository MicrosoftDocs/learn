
An organization can use the audit log search tool in the Microsoft Purview compliance portal to search the unified audit log. By doing so, the organization can view user and administrator activity. For example, an organization may need to determine if a user viewed a specific document or purged an item from their mailbox.

### Microsoft 365 services that support auditing

Microsoft 365 supports an audit log so that organizations can search it for activities performed in different Microsoft 365 services. The following table lists the Microsoft 365 services and features (in alphabetical order) that are supported by the unified audit log.

| **Microsoft 365 service or feature**    | **Record types**                                                                                                     |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Microsoft Entra ID                  | AzureActiveDirectory, AzureActiveDirectoryAccountLogon, AzureActiveDirectoryStsLogon                                 |
| Azure Information Protection            | AipDiscover, AipSensitivityLabelAction, AipProtectionAction, AipFileDeleted, AipHeartBeat                            |
| Communication compliance                | ComplianceSuperVisionExchange                                                                                        |
| Content explorer                        | LabelContentExplorer                                                                                                 |
| Data connectors                         | ComplianceConnector                                                                                                  |
| Data loss prevention (DLP)              | ComplianceDLPSharePoint, ComplianceDLPExchange, DLPEndpoint                                                          |
| Dynamics 365                            | CRM                                                                                                                  |
| eDiscovery                              | Discovery, AeD                                                                                                       |
| Exact Data Match                        | MipExactDataMatch                                                                                                    |
| Exchange Online                         | ExchangeAdmin, ExchangeItem, ExchangeItemAggregated                                                                  |
| Forms                                   | MicrosoftForms                                                                                                       |
| Information barriers                    | InformationBarrierPolicyApplication                                                                                  |
| Microsoft Defender XDR                  | AirInvestigation, AirManualInvestigation, AirAdminActionInvestigation, MS365DCustomDetection                         |
| Microsoft Teams                         | MicrosoftTeams                                                                                                       |
| MyAnalytics                             | MyAnalyticsSettings                                                                                                  |
| OneDrive for Business                   | OneDrive                                                                                                             |
| Power Apps                              | PowerAppsApp, PowerAppsPlan                                                                                          |
| Power Automate                          | MicrosoftFlow                                                                                                        |
| Power BI                                | PowerBIAudit                                                                                                         |
| Quarantine                              | Quarantine                                                                                                           |
| Retention policies and retention labels | MIPLabel, MipAutoLabelExchangeItem, MipAutoLabelSharePointItem, MipAutoLabelSharePointPolicyLocation                 |
| Sensitive information types             | DlpSensitiveInformationType                                                                                          |
| Sensitivity labels                      | MIPLabel, SensitivityLabelAction, SensitivityLabeledFileAction, SensitivityLabelPolicyMatch                          |
| Encrypted message portal                | OMEPortal                                                                                                            |
| SharePoint Online                       | SharePoint, SharePointFileOperation, SharePointSharingOperation, SharePointListOperation, SharePointCommentOperation |
| Stream                                  | MicrosoftStream                                                                                                      |
| Threat Intelligence                     | ThreatIntelligence, ThreatIntelligenceUrl, ThreatFinder, ThreatIntelligenceAtpContent                                |
| Workplace Analytics                     | WorkplaceAnalytics                                                                                                   |
| Yammer                                  | Yammer                                                                                                               |
| SystemSync                              | DataShareCreated, DataShareDeleted, GenerateCopyOfLakeData, DownloadCopyOfLakeData                                   |

The previous table identifies the record type value to use to search the audit log for activities in the corresponding service. Searches can be conducted using the **Search-UnifiedAuditLog** cmdlet in Exchange Online PowerShell or by using a PowerShell script. Some services have multiple record types for different types of activities within the same service. For a more complete list of auditing record types, see [Office 365 Management Activity API schema](/office/office-365-management-api/office-365-management-activity-api-schema#auditlogrecordtype?azure-portal=true).

**Additional reading**. For more information about using PowerShell to search the audit log, see:

 -  [Search-UnifiedAuditLog](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true)
 -  [Use a PowerShell script to search the audit log](/microsoft-365/compliance/audit-log-search-script?azure-portal=true).

### Search the audit log

The process of searching the audit log within the Microsoft Purview compliance portal includes the following steps:

1.  Run an audit log search.
2.  View the search results.
3.  Export the search results to a file.

Each of these steps is examined in greater detail in the following sections.

#### Step 1: Run an audit log search

1.  Sign in to the **Microsoft Purview compliance** portal.
    
    > [!TIP]
    > Use a private browsing session (not a regular session) to access the compliance portal. By doing so, the credential that you're currently logged on with will be prevented from being used. Press **CTRL+SHIFT+N** to open an **InPrivate Browsing session** in Microsoft Edge or a private browsing session in Google Chrome (called an incognito window).
2.  In the **Microsoft Purview compliance** portal, in the left-hand navigation pane, select **Audit**.
    
    > [!NOTE]
    > If the **Start recording user and admin activity** link is displayed, select it to turn on auditing. If you don't see this link, auditing is already turned on for your organization.
3.  On the **Audit** page, the **New Search** tab is displayed by default. Configure the following search criteria in this tab:
    
    :::image type="content" source="../media/audit-log-search-tool-callouts-db4d2a76.png" alt-text="Screenshot of the Audit page in the Microsoft Purview compliance portal showing the various settings that can be configured.":::
    
    
    
     -  **A. Start date and End date**. The last seven days are selected by default. Select a date and time range to display the events that occurred within that period. The date and time are presented in local time. The maximum date range that you can specify is 180 days. An error is displayed if the selected date range is greater than 180 days.
        
        If you're using the maximum date range of 180 days, select the current time for the **Start date**. Otherwise, you'll receive an error saying the start date is earlier than the end date. If you've implemented auditing within the last 180 days, the maximum date range can't start before the date that auditing was implemented.
     -  **B. Activities**. Select the drop-down list to display the activities that you can search for. User and administrator activities are organized into groups of related activities. You can select specific activities or you can select the activity group name to select all activities in the group. You can also select a selected activity to clear the selection. After you run the search, only the audit log entries for the selected activities are displayed. Selecting **Show results for all activities** displays results for all activities performed by the selected user or group of users. Over 100 user and administrator activities are logged in the audit log.
     -  **C. Users**. Select in this box and then select one or more users to display search results for. The audit log entries for the selected activity performed by the users you select in this box are displayed in the list of results. Leave this box blank to return entries for all users (and service accounts) in the organization.
     -  **D. File**, **folder**, **or site**. Type some or all of a file or folder name to search for activity related to the file of folder that contains the specified keyword. You can also specify a URL of a file or folder. If you use a URL, be sure the type the full URL path or if you type a portion of the URL, don't include any special characters or spaces. However, using the wildcard character (\*) is supported.
        
        Leave this box blank to return entries for all files and folders in your organization.
        
        
         -  If you're looking for all activities related to a site, add the wildcard character (\*) after the URL to return all entries for that site. For example: **`https://contoso-my.sharepoint.com/personal*`**
         -  If you're looking for all activities related to a file, add the wildcard character (\*) before the file name to return all entries for that file. For example: **\*Customer\_Profitability\_Sample.csv**
4.  Select **Search** to run the search using your search criteria.

#### Step 2: View the search results

Once you've started a search, the results are Queued. After the search is Completed the Search time and the Total results are displayed below the search form. Select the Search name to display the results on a new page. 

A maximum of 50,000 events is displayed in increments of 150 events. If more than 50,000 events meet the search criteria, only the 50,000 unsorted events returned is displayed.

:::image type="content" source="../media/audit-export-audit-search-results-4523.png" alt-text="Screenshot showing the number of results that are displayed after the search is finished." lightbox="../media/audit-export-audit-search-results-4523.png":::


The results of an audit log search are displayed under **Results** on the **Audit log search** page. As previously stated, a maximum of 50,000 (newest) events are displayed in increments of 150 events. Use the scroll bar or press **Shift + End** to display the next 150 events.

The results contain the following information about each event returned by the search:

 -  **Date**. The date and time (in your local time) when the event occurred.
 -  **IP address**. The IP address of the device that was used when the activity was logged. The IP address is displayed in either an IPv4 or IPv6 address format.
    
    > [!NOTE]
    > For some services, the value displayed in this field may be the IP address for a trusted application (for example, Office on the web apps) calling into the service on behalf of a user and not the IP address of the device used by the person who performed the activity. Also, for administrator activity (or activity performed by a system account) for Microsoft Entra ID-related events, the IP address isn't logged. As a result, the value displayed in this field is null.
 -  **User**. The user (or service account) who performed the action that triggered the event.
 -  **Activity**. The activity performed by the user. This value corresponds to the activities that were selected in the **Activities** drop down list. For an event from the Exchange admin audit log, the value in this column is an Exchange cmdlet.
 -  **Item**. The object that was created or modified as a result of the corresponding activity. For example, the file that was viewed or modified or the user account that was updated. Not all activities have a value in this column.
 -  **Detail**. Additional information about an activity. Again, not all activities have a value.

> [!TIP]
> Select a column header under **Results** to sort the results. You can sort the results from A to Z or Z to A. Select the **Date** header to sort the results from oldest to newest or newest to oldest.

You can view more details about an event by selecting the event record in the list of search results. A flyout page is displayed that contains the detailed properties from the event record. The properties that are displayed depend on the service in which the event occurs.

#### Step 3: Export the search results to a file

Organizations can export the results of an audit log search. The results are exported to a comma-separated value (CSV) file on a local computer. This file can be opened in Microsoft Excel. You can use features such as search, sorting, filtering, and splitting a single column (that contains multiple properties) into multiple columns.

1.  Run an audit log search, and then revise the search criteria until you have the desired results.
2.  On the **Search results** page, select **Export**, and then select **Download all results**.
    
    All entries from the audit log that meet the search criteria are exported to a CSV file. The raw data from the audit log is saved to a CSV file. Other information from the audit log entry is included in a column named **AuditData** in the CSV file.
    
    > [!IMPORTANT]
    > You can download a maximum of 50,000 entries to a CSV file from a single audit log search. If 50,000 entries are downloaded to the CSV file, you can probably assume there are more than 50,000 events that met the search criteria. To export more than this limit, try using a date range to reduce the number of audit log entries. You may have to run multiple searches with smaller date ranges to export more than 50,000 entries.
3.  After the export process is complete, a message is displayed at the top of the window that prompts you to open the CSV file and save it to your local computer. You can also access the CSV file in the **Downloads** folder in **File Explorer**.

### Tips for searching the audit log

Organizations should keep in mind the following considerations when searching the audit log:

 -  There are multiple ways to select activities:
     -  You can select specific activities to search for by selecting the activity name.
     -  You can search for all activities in a group (such as File and folder activities) by selecting the group name.
     -  If an activity is selected, you can select it to cancel the selection.
     -  You can use the search box to display the activities that contain the keyword that you type.
        
        :::image type="content" source="../media/tips-for-run-audit-log-search-db8a937e.png" alt-text="Screenshot showing the Audit Log search window with callout boxes displaying various search tips.":::
        
 -  You have to select **Show results for all activities** in the **Activities** list to display events from the Exchange admin audit log. Events from this audit log display a cmdlet name (for example, Set-Mailbox) in the **Activity** column in the results.
    
    Similarly, there are some auditing activities that don't have a corresponding item in the **Activities** list. If you know the name of the operation for these activities, you can search for all activities, then filter the operations after you export the search results to a CSV file.
 -  Select **Clear** to clear the current search criteria. The date range returns to the default of the last seven days. To cancel all selected activities, select **Clear all to show results for all activities**.
 -  If 50,000 results are found, you can probably assume there are more than 50,000 events that met the search criteria. You can either:
     -  Refine the search criteria and rerun the search to return fewer results.
     -  Export all of the search results by selecting **Export results**, and then selecting **Download all results**.

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”
