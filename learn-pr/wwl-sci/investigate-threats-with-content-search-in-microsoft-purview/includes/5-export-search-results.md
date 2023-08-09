After an organization successfully runs a Content search, it can export the search results to a local computer. When you export email results, they're downloaded to your computer as PST files. When you export content from SharePoint and OneDrive for Business sites, copies of native Office documents are exported. There are other documents and reports included with the exported search results.

### Export Content search results

Exporting the results of a Content search involves preparing the results, and then downloading them to a local computer. These steps for exporting search results also apply to exporting the results of a search that's associated with Microsoft Purview eDiscovery (Standard) cases.

#### Prerequisites to exporting search results

 -  For a user to export search results, they must be assigned the **Export management** role in Microsoft Purview compliance portal. This role is assigned to the built-in **eDiscovery Manager** role group. It isn't assigned by default to the Organization Management role group. For more information, see [Assign eDiscovery permissions](/microsoft-365/compliance/assign-ediscovery-permissions?azure-portal=true).
 -  The computer that's used to export the search results has to meet the following system requirements:
     -  Latest version of Windows (32-bit or 64-bit)
     -  Microsoft .NET Framework 4.7 or higher
 -  Microsoft Edge must be used to run the eDiscovery Export Tool. Using Internet Explorer 11 to export search results is no longer supported.
    
    > [!WARNING]
    > As a result of recent changes to Microsoft Edge, ClickOnce support is no longer enabled by default. For instructions on enabling ClickOnce support in Microsoft Edge, see [Use the eDiscovery Export Tool in Microsoft Edge](/microsoft-365/compliance/configure-edge-to-export-search-results?azure-portal=true). Also, Microsoft doesn't manufacture third-party extensions or add-ons for ClickOnce applications. Exporting search results using an unsupported browser with third-party extensions or add-ons isn't supported.
 -  When an organization exports search results, the data is temporarily stored in a Microsoft-provided Azure Storage location in the Microsoft cloud before it's downloaded to a local computer. Organizations should ensure they can connect to the endpoint in Azure, which is **\*.blob.core.windows.net** (the wildcard represents a unique identifier for the export). The search results data is deleted from the Azure Storage location two weeks after it's created.
 -  If an organization uses a proxy server to communicate with the Internet, it must define the proxy server settings on the computer that it used to export the search results (so the export tool can be authenticated by the proxy server). To complete this step, open the **machine.config** file in the location that matches the computer's version of Windows.
     -  **32-bit**. %windir%\\Microsoft.NET\\Framework\\\[version\]\\Config\\machine.config
     -  **64-bit**. %windir%\\Microsoft.NET\\Framework64\\\[version\]\\Config\\machine.config
        
        Add the following lines to the **machine.config** file somewhere between the &lt;configuration&gt; and &lt;/configuration&gt; tags. Be sure to replace **ProxyServer** and **Port** with the correct values for the organization. For example, proxy01.contoso.com:80.
        
        ```
        <system.net>
            <defaultProxy enabled="true" useDefaultCredentials="true">
                <proxy proxyaddress="https://ProxyServer :Port "
                    usesystemdefault="False"
                    bypassonlocal="True"
                    autoDetect="False" />
            </defaultProxy>
        </system.net>
        ```

#### Other export considerations

Organizations should also consider the following items when planning to export search results:

 -  The eDiscovery Export Tool that's used in Step 2 to download search results doesn't support automation by using a script or running PowerShell cmdlets. It's highly recommended that organizations don't automate the preparation process in Step 1 or the download process in Step 2. If an organization automates either of these processes, Microsoft Support won't provide assistance if it runs into issues.
 -  It's recommended that organizations download search results to a local computer. To eliminate a company's firewall or proxy infrastructure from causing issues when downloading search results, organizations should consider downloading search results to a virtual desktop outside of their networks. This process may also decrease timeouts that occur in Azure data connections when exporting a large number of files. For more information about virtual desktops, see [Windows Virtual Desktop](https://azure.microsoft.com/services/virtual-desktop?azure-portal=true).
 -  To improve performance when downloading search results, consider dividing searches that return a large set of results into smaller searches. For example, date ranges can be used in search queries to return a smaller set of results that can be downloaded faster.
 -  If the results of a search are older than seven days and you submit an export job, an error message is displayed prompting you to rerun the search to update the search results. If this situation occurs, cancel the export, rerun the search, and then start the export again.

#### Step 1: Prepare search results for export

The first step is to prepare the search results for exporting. When you prepare results, they're uploaded to a Microsoft-provided Azure Storage location in the Microsoft cloud. Content from mailboxes and sites is uploaded at a maximum rate of 2 GB per hour.

1. In the **Microsoft Purview compliance** portal, select **Content search** in the navigation pane.
1. On the **Content search** page, select the content search that you want to export results from.
1. On the **Actions** menu at the bottom of the flyout page, select **Export results**. The **Export results** flyout page is displayed. The export options available to export content depend on whether search results are located in mailboxes or sites or a combination of both.
    
    :::image type="content" source="../media/action-menu-export-results-693fdd85.png" alt-text="Screenshot of the Actions menu at the bottom of the flyout page.":::
    
1. Under **Output** options, choose one of the following options:
    
    :::image type="content" source="../media/export-output-options-8d94b2f6.png" alt-text="Screenshot showing the options for exporting the search results.":::
    
    
    
     -  **All items, excluding ones that have unrecognized format, are encrypted, or weren't indexed for other reasons.** This option exports only indexed items.
     -  **All items, including ones that have unrecognized format, are encrypted, or weren't indexed for other reasons.** This option exports indexed and unindexed items.
     -  **Only items that have an unrecognized format, are encrypted, or weren't indexed for other reasons.** This option exports only unindexed items.
1. Under **Export Exchange content as**, choose one of the following options:
    
    :::image type="content" source="../media/exchange-export-options-88d887af.png" alt-text="Screenshot showing the options for exporting the Exchange content search results.":::
    
    
    
     -  **One PST file for each mailbox.** Exports one PST file for each user mailbox that contains search results. Any results from the user's archive mailbox are included in the same PST file. This option reproduces the mailbox folder structure from the source mailbox.
     -  **One PST file containing all messages.** Exports a single PST file (named **Exchange.pst**) that contains the search results from all source mailboxes included in the search. This option reproduces the mailbox folder structure for each message.
     -  **One PST file containing all messages in a single folder.** Exports search results to a single PST file where all messages are located in a single, top-level folder. This option lets reviewers review items in chronological order (items are sorted by sent date) without having to navigate the original mailbox folder structure for each item.
     -  **Individual messages.** Exports search results as individual email messages, using the .msg format. If you select this option, email search results are exported to a folder in the file system. The folder path for individual messages is the same as the one used if you exported the results to a PST file.
1. Configure the remaining options:
    
    :::image type="content" source="../media/other-export-options-3d93d52c.png" alt-text="Screenshot showing the remaining export options for the content search results.":::
    
    
    
     -  **Enable de-duplication for Exchange content.** Select this checkbox to exclude duplicate messages. If you select this option, only one copy of a message will be exported, even if multiple copies of the same message are found in the mailboxes that were searched. The export results report (which is a file named Results.csv) contains a row for every copy of a duplicate message so that you can identify the mailboxes (or public folders) that contain a copy of the duplicate message. For more information about de-duplication and how duplicate items are identified, see [De-duplication in eDiscovery search results](/microsoft-365/compliance/de-duplication-in-ediscovery-search-results?azure-portal=true).
     -  **Include versions for SharePoint files.** Select this checkbox to export all versions of SharePoint documents. This option appears only if the content sources of the search include SharePoint or OneDrive for Business sites.
     -  **Export files in a compressed (zipped) folder. Includes only individual messages and SharePoint documents checkbox to export search results to compressed folders.** This option appears only when you choose to export Exchange items as individual messages and when the search results include SharePoint or OneDrive documents. This option is primarily used to work around the 260 character limit in Windows file path names when items are exported.
1. Select **Export** to start the export process. The export process collects the search results from the original content locations. It then uploads them to an Azure Storage location in the Microsoft cloud. The export process may take several minutes to complete.

See the next section for instructions to download the exported search results.

#### Step 2: Download the search results

The next step is to download the search results from the Azure Storage location to your local computer.

1. In the **Microsoft Purview compliance** portal, select **Content search** in the navigation pane.
1. On the **Content search** page, select the **Exports** tab.
1. You may have to select **Refresh** to update the list of export jobs so that it shows the export job you created. Export jobs have the same name as the corresponding search with **\_Export** appended to the search name.
1. Select the export job that you created in **Step 1-Prepare search results for export**.
1. On the flyout page under **Export key**, select **Copy to clipboard**. This key is used in step 6 to download the search results.
    
    > [!WARNING]
    > Anyone can install and start the eDiscovery Export tool and then use this key to download the search results. As such, organizations should take precautions to protect this key just like they would protect passwords or other security-related information.
1. At the top of the flyout page, select **Download results**.
1. If you're prompted to install the **eDiscovery Export Tool**, select **Install**.
1. In the **eDiscovery Export Tool**, complete the following steps:
     -  Paste the export key that you copied in step 3 in the appropriate box.
     -  Select **Browse** to specify the location where you want to download the search result files.
    
    :::image type="content" source="../media/ediscovery-export-tool-4851035a.png" alt-text="Screenshot showing the eDiscovery export tool window and the field for pasting in the export key.":::
    
    
    > [!CAUTION]
    > Because of high network activity during download, you should download search results only to a location on an internal drive on your local computer. For the best download experience, follow these guidelines:
    
    
     -  Don't download search results to a UNC path, a mapped network drive, an external USB drive, or a synched OneDrive for Business account.
     -  Disable anti-virus scanning for the folder that you download the search result to.
     -  Download search results to different folders for concurrent download jobs.
1. Select **Start** to download the search results to your computer.
    
    The eDiscovery Export Tool displays status information about the export process, including an estimate of the number (and size) of the remaining items to be downloaded. When the export process is complete, you can access the files in the location where they were downloaded.

#### Export reports

When you export search results, the following reports are included in addition to the search results:

 -  **Export Summary**. An Excel document that contains a summary of the export. This spreadsheet includes information such as:
     -  The number of content sources that were searched.
     -  The estimated and downloaded sizes of the search results.
     -  The estimated and downloaded number of items that were exported.
 -  **Manifest**. A manifest file (in XML format) that contains information about each item included in the search results.
 -  **Results**. An Excel document that contains information about each item that's download as a search result. For email, the result log contains information about each message, including:
     -  The location of the message in the source mailbox (including whether the message is in the primary or archive mailbox).
     -  The date the message was sent or received.
     -  The Subject line from the message.
     -  The sender and recipients of the message.
     -  Whether the message is a duplicate message if you enabled the de-duplication option when exporting the search results. Duplicate messages have a value in the **Duplicate to Item** column that identifies the message as a duplicate. The value in the **Duplicate to Item** column contains the item identity of the message that was exported. For more information, see [De-duplication in eDiscovery search result](/microsoft-365/compliance/de-duplication-in-ediscovery-search-results?azure-portal=true).
        
        For documents from SharePoint and OneDrive for Business sites, the result log contains information about each document, including:
        
        
         -  The URL for the document.
         -  The URL for the site collection where the document's located.
         -  The date the document was last modified.
         -  The name of the document (which is located in the **Subject** column in the result log).
 -  **Unindexed Items**. An Excel document that contains information about any partially indexed items that would be included in the search results. If you don't include partially indexed items when you generate the search results report, this report is downloaded, but it's empty.
 -  **Errors and Warnings**. Contains errors and warnings for files encountered during the export. See the **Error Details** column for information specific to each individual error or warning.
 -  **Skipped Items**. When an organization exports search results from SharePoint and OneDrive for Business sites, the export usually includes a skipped items report (**SkippedItems.csv**). The items cited in this report are typically items that won't be downloaded, such as a folder or a document set. Not exporting these types of items is by design. For other items that were skipped, the **Error Type** and **Error Details** field in the skipped items report show the reason the item was skipped and wasn't downloaded with the other search results.
 -  **Trace.log**. Contains detailed logging information about the export process. It can help uncover issues during export. If you open a ticket with Microsoft Support about an issue related to exporting search results, you may be asked to provide this trace log.

> [!NOTE]
> Organizations can export these documents without having to export the actual search results. See [Export a Content search report](/microsoft-365/compliance/export-a-content-search-report?azure-portal=true).

### Export a Content search report

The previous sections examined how an organization can export the full set of search results from a Content search in the Microsoft Purview compliance portal (or from a search that's associated with a Microsoft Purview eDiscovery (Standard) case). Alternatively, organizations can export the same reports that are generated when they export the actual search results.

When an organization exports a report, the report files are downloaded to a folder on a local computer that has the same name as the Content Search, but that's appended with *\_***ReportsOnly**. For example, if the Content Search is named **ContosoCase0815**, the report is downloaded to a folder named **ContosoCase0815\_ReportsOnly**. For a list of documents that are included in the report, see [What's included in the report](/microsoft-365/compliance/export-a-content-search-report?azure-portal=true).

#### Prerequisites to exporting search results

 -  To export a search report, you have to be assigned the **Compliance Search management** role in compliance portal. This role is assigned by default to the built-in **eDiscovery Manager** and **Organization Management** role groups. For more information, see [Assign eDiscovery permissions](/microsoft-365/compliance/assign-ediscovery-permissions?azure-portal=true).
 -  The computer that's used to export the search results has to meet the following system requirements:
     -  Latest version of Windows (32-bit or 64-bit)
     -  Microsoft .NET Framework 4.7 or higher
 -  Microsoft Edge must be used to run the eDiscovery Export Tool. Using Internet Explorer 11 to export search results is no longer supported.
    
    > [!NOTE]
    > As a result of recent changes to Microsoft Edge, ClickOnce support is no longer enabled by default. For instructions on enabling ClickOnce support in Microsoft Edge, see [Use the eDiscovery Export Tool in Microsoft Edge](/microsoft-365/compliance/configure-edge-to-export-search-results?azure-portal=true). Also, Microsoft doesn't manufacture third-party extensions or add-ons for ClickOnce applications. Exporting search results using an unsupported browser with third-party extensions or add-ons isn't supported.
 -  If the estimated total size of the results returned by search exceeds 2 TB, exporting the reports fails. To successfully export the reports, try to narrow the scope. That way, when you rerun the search, the estimated size of the results is less than 2 TB.
 -  If the results of a search are older than seven days and you submit an export report job, an error message is displayed prompting you to rerun the search to update the search results. If this situation occurs, cancel the export, rerun the search, and then start the export again.
 -  Exporting search reports counts against the maximum number of exports running at the same time. It also counts against the maximum number of exports that a single user can run. For more information about export limits, see [Export Content search results](/microsoft-365/compliance/export-search-results?azure-portal=true).

#### Step 1: Generate the report for export

The first step is to prepare the report for downloading to your computer. When you export the report, the report documents are uploaded to an Azure Storage area in the Microsoft cloud. The steps in this process are fairly similar to the steps in the prior section titled **Prepare search results for export**. As such, screenshots aren't displayed to streamline the instruction.

1. In the **Microsoft Purview compliance** portal, select **Content search** in the navigation pane.
1. On the **Content search** page, select the content search that you want to export results from.
1. On the **Actions** menu at the bottom of the flyout page, select **Export report**. The **Export report** flyout page is displayed. The export options available to export content depend on whether search results are located in mailboxes or sites or a combination of both.
1. The **Export report** flyout page is displayed. The export report options available to export information about the search depend on whether search results are located in mailboxes or sites or a combination of both.
1. Under **Output options**, choose one of the following options:
     -  **All items, excluding ones that have unrecognized format, are encrypted, or weren't indexed for other reasons.** This option only exports information about indexed items.
     -  **All items, including ones that have unrecognized format, are encrypted, or weren't indexed for other reasons.** This option exports information about indexed and unindexed items.
     -  **Only items that have an unrecognized format, are encrypted, or weren't indexed for other reasons.** This option only exports information about unindexed items.
1. Configure the **Enable de-duplication for Exchange content** option.
     -  If you select this option, the count of duplicate messages (before de-duplication and after de-duplication) is included in the export summary report. Also, only one copy of a message is included in the manifest.xml file. But the export results report contains a row for every copy of a duplicate message. By doing so, you can identify the mailboxes that contain a copy of the duplicate message. For more information about the exported reports, see [What's included in the report](/microsoft-365/compliance/export-a-content-search-report?azure-portal=true).
     -  If you don't select this option, the export reports contain information about all messages returned by the search, including duplicates.
        
        For more information about de-duplication and how duplicate items are identified, see [De-duplication in eDiscovery search results](/microsoft-365/compliance/de-duplication-in-ediscovery-search-results?azure-portal=true).
1. Select **Generate report**.
    
    The search reports are prepared for downloading. As a result, the report documents are uploaded to an Azure Storage location in the Microsoft cloud. This process may take several minutes.

See the next section for instructions to download the exported search reports.

#### Step 2: Download the report

The next step is to download the report from the Azure Storage area to your local computer.

> [!IMPORTANT]
> The exported search report must be downloaded within 14 days after it was generated in Step 1.

1. In the **Microsoft Purview compliance** portal, select **Content search** in the navigation pane.
1. On the **Content search** page, select the **Exports** tab.
    
    > [!NOTE]
    > You may have to select **Refresh** to update the list of export jobs so that it shows the export job you created. Export report jobs have the same name as the corresponding search with **\_ReportsOnly** appended to the search name.
1. Select the export job that you created in Step 1.
1. On the **Export report** flyout page, under **Export key**, select **Copy to clipboard**. You use this key in step 6 to download the search results.
    
    > [!IMPORTANT]
    > Anyone can install and start the eDiscovery Export tool and then use this key to download the search report. As a result, take precautions to protect this key just like you would protect passwords or other security-related information.
1. At the top of the flyout page, select **Download results**.
1. If you're prompted to install the eDiscovery Export Tool, select **Install**.
1. In the **eDiscovery Export Tool**, complete the following steps:
    
    :::image type="content" source="../media/ediscovery-export-tool-4851035a.png" alt-text="Screenshot of the eDiscovery Export Tool dialog box and the fields for entering the export key and the location for downloading the files.":::
    
    
    
    1. Paste the export key that you copied in step 3 in the appropriate box.
    1. Select **Browse** to specify the location where you want to download the search report files.
1. Select **Start** to download the search results to your computer.
    
    The eDiscovery Export Tool displays status information about the export process, including an estimate of the number (and size) of the remaining items to be downloaded. When the export process is complete, you can access the files in the location where they were downloaded.

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”
