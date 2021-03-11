Recovering content in Exchange Online, that is stored in the folder structure of mailboxes, can be done via compliance searches and eDiscovery cases. To perform the steps, administrators can use the Microsoft 365 Compliance Center and the Security & Compliance Center PowerShell module.

Perform the following steps to create an eDiscovery case and export data from mailboxes:

1. Navigate to the **Microsoft 365 Compliance Center**.

1. Select **... Show all** to display all settings.

1. Select **eDiscovery** > **Core** in the left navigation pane.

1. Select **+ Create a case**.

1. Enter a **Case name** and a meaningful **Case description** that helps you identify it later and select **Save**.

1. Select the check mark left from the case an **Open case** from the top pane.

1. On the **Searches** tab, select **+ New search** to associate a search with the case.

1. Input the keywords, conditions, and locations for the search and select **Save & run**.

1. Enter a **Name** and **Description** for the search and select **Save**.

1. Select the **Searches** tab and select the search.

1. Select **Export results**, review the **Output options** and select **Generate**.

1. Go to the **Exports** tab and select the Export you generated.

1. Copy the **Export key** to the clipboard and select **download results**.

1. Fill out the information in the **Export Tool** and select **Start**.

1. You will find the exported information in the form of one or more PST-files in the path you specified.

You can also use the Exchange PowerShell and the New-ComplianceSearch cmdlet to create a Search:

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

To gain access to the PST-Files, you need to visit the Security & Compliance Center and download them using the ClickOnce application.

1. In the **Security & Compliance Center**, select **Search** > **Content Search**.

1. Go to the **Exports** tab and select the Export you generated.

1. Copy the Export key to the clipboard and select download results.

1. Fill out the information in the Export Tool and select Start.

