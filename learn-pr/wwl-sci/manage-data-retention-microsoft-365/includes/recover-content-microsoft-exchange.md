In Exchange Online, managing and recovering deleted email messages is a critical component of maintaining compliance and effective data retention policies. The new Exchange Admin Center (EAC) offers a streamlined approach to quickly retrieve messages. Organizations rely on these recovery capabilities to maintain data integrity, comply with retention schedules, and promptly address recovery needs. These capabilities are crucial for regulatory compliance and operational continuity.

As the Data Protection Officer at the bank, you now need to focus on managing and recovering deleted email messages in Exchange Online. Ensuring that deleted emails can be recovered quickly is crucial for maintaining compliance with data retention policies and regulatory requirements. Your role involves understanding how to use the Exchange Admin Center (EAC) and eDiscovery tools to efficiently recover messages, maintain data integrity, and support legal and audit needs.

Here you learn to:

- Use the Exchange Admin Center (EAC) to recover deleted email messages.
- Perform complex recoveries using eDiscovery tools within the Microsoft Purview compliance portal.
- Apply search criteria to locate and recover specific email content.
- Use PowerShell commands for advanced recovery operations.

## Use the Exchange Admin Center (EAC) for recovering deleted messages

The EAC offers a streamlined process to recover deleted items directly from the user's mailbox. Here's how to use this feature:

1. Navigate to the Exchange Admin Center at [https://admin.exchange.microsoft.com]( https://admin.exchange.microsoft.com?azure-portal=true) and sign in as Exchange administrator.
1. Navigate to **Recipients > Mailboxes** and select the mailbox from which you need to recover messages.
1. Select the display name of the mailbox to open its properties. Under **More actions**, select **Recover deleted items**.
1. Specify the criteria for the items you wish to recover. You can filter by date, sender, recipient, or keywords.
1. After applying the necessary filters, review the items and select those you want to restore. Confirm the recovery, and the items are restored to the mailbox.

## Advantages of using the EAC

- **Simplicity**: The new EAC simplifies the process, allowing recoveries to be done directly without setting up complex searches.
- **Speed**: Recovery actions can be performed quickly, essential for time-sensitive recoveries.
- **Direct access**: Administrators can directly access recovery options without navigating through multiple settings or configurations.

## Use eDiscovery for complex recovery needs

For situations involving detailed audits or legal considerations, the eDiscovery tools within Microsoft Purview offer robust search and hold functionalities. These tools are essential for compliance and legal scenarios, where a comprehensive approach is required.

### Steps to use eDiscovery for recovering deleted messages

To perform recoveries for eDiscovery investigations:

1. Navigate to the **Microsoft Purview compliance portal**.
1. Select **eDiscovery** > **Standard** in the left navigation pane, and select **+ Create a case**.
1. Enter a **Case name** and a meaningful **Case description** that helps you identify it later and select **Save**.
1. Select the newly created case, then the **Searches** tab, **+ New search**.
1. Define the search by entering a **Name** and **Description**, then select the content **Locations** to search and set the search parameters with specific keywords and conditions.
1. Review and submit the search, then go to the **Searches** tab, select your search, and select **Actions** > **Export** results. Select your output options and start the export.
1. After the export is prepared, download the results by accessing the **Exports** tab, selecting your export, and using the provided **Export key** in the **Export Tool**.

You can also use the Exchange PowerShell and the New-ComplianceSearch cmdlet to create a search:

```powershell
New-ComplianceSearch -Name <case name> -ExchangeLocation <username> -ContentMatchQuery "'Patent' AND 'Project X'"
```

After you create a new search, you can use the Start-ComplianceSearch cmdlet to start it:

```powershell
Start-ComplianceSearch -Identity <case name>
```

When the search is completed, you can use the New-ComplianceSearchAction to create an export:

```powershell
New-ComplianceSearchAction -SearchName <case name> -Export
```

To access to the PST-Files, you need to visit the Microsoft Purview compliance portal and download them using the ClickOnce application.

1. In the **Microsoft Purview portal**, under Solutions select **Content search**.
1. Go to the **Exports** tab and select the Export you generated.
1. Copy the **Export key** to the clipboard and select download results.
1. Fill out the information in the **Export Tool** and select **Start**.
