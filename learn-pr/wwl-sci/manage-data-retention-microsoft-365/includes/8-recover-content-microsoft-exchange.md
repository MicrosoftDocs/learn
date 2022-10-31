Recovering content in Exchange Online that is stored in the folder structure of mailboxes, can be done via compliance searches and eDiscovery cases. To perform the steps, administrators can use the Microsoft Purview portal and the Security & Compliance Center PowerShell module.

Perform the following steps to create an eDiscovery case and export data from mailboxes:

1. Navigate to the **Microsoft Purview portal**.

1. Select **eDiscovery** > **Standard** in the left navigation pane.

1. Select **+ Create a case**.

1. Enter a **Case name** and a meaningful **Case description** that helps you identify it later and select **Save**.

1. Select the case.

1. On the **Searches** tab, select **+ New search** to associate a search with the case.

1. Enter a **Name** and **Description** for the search and select **Next**.

1. On the **Locations** page, choose the content locations you want to search and select **Next**.

1. Input the keywords and conditions for the search and select **Next**.

1. On the **Review your search and create it** page review the search and select **Submit** and then **Done**.


1. Select the **Searches** tab and select the search.

1. Select **Actions** and then **Export results**, review the **Output options** and select **Export**.

1. Go to the **Exports** tab and select the Export you generated.

1. Copy the **Export key** to the clipboard and select **download results**.

1. Fill out the information in the **Export Tool** and select **Start**.

1. You'll find the exported information in the form of one or more PST-files in the path you specified.

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

To gain access to the PST-Files, you need to visit the Microsoft Purview compliance portal and download them using the ClickOnce application.

1. In the **Microsoft Purview portal**, under Solutions select **Content search**.

1. Go to the **Exports** tab and select the Export you generated.

1. Copy the Export key to the clipboard and select download results.

1. Fill out the information in the Export Tool and select Start.

