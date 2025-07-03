Microsoft Purview eDiscovery helps organizations identify, investigate, and take action on electronically stored information (ESI). When Microsoft 365 Copilot is in use, eDiscovery can support internal investigations and compliance reviews involving user prompts and AI-generated responses. You can search for Copilot interactions, review findings, and delete content when necessary, for example, in cases involving inappropriate use or data exposure.

## When to use eDiscovery for Copilot data

Use Microsoft Purview eDiscovery when:

- Sensitive data is disclosed in a Copilot prompt or response
- Generated content violates organizational policy
- An investigation requires locating or removing specific Copilot activity

This approach supports responsible AI use and aligns with organizational data governance practices.

### Prerequisites

| Step | Description | Learn more |
|------|-------------|------------|
| Understand how Copilot data is stored | Copilot interactions are stored in a hidden folder within each user's Exchange mailbox.  | [Content stored in Exchange Online mailboxes for eDiscovery](/purview/ediscovery-what-is-stored-in-a-mailbox?azure-portal=true) |
| Assign eDiscovery roles | To create a case, assign the **eDiscovery Manager** role. To delete Copilot data, assign the **Search And Purge** role.  | [Assign eDiscovery permissions in the Microsoft Purview portal](/purview/ediscovery-assign-permissions?azure-portal=true) |
| Confirm license requirements | A Microsoft 365 E5 license is required for both Microsoft Purview eDiscovery (Premium) and Microsoft 365 Copilot.  | [eDiscovery service description](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-purview-service-description?azure-portal=true#microsoft-purview-ediscovery) |
| Review deletion limits | A maximum of 100 items per mailbox can be removed at a time. This action is intended for targeted incident response. | [Search for and delete Copilot data](/purview/ediscovery-search-and-delete-copilot-data?azure-portal=true) |

## Where Copilot data is stored

Copilot interaction data is stored in Exchange Online mailboxes. This includes:

- User prompts
- Copilot-generated responses

Each supported application uses a distinct item class. Examples include:

| Application | Item class |
|-----|-----|
| Teams (Chat, Channel, Meeting) | `IPM.SkypeTeams.Message.Copilot.Teams` |
| Word | `IPM.SkypeTeams.Message.Copilot.Word` |
| Outlook | `IPM.SkypeTeams.Message.Copilot.Outlook` |
| Copilot Chat | `IPM.SkypeTeams.Message.Copilot.BizChat` |

For more information, see [Data sources for Copilot data](/purview/ediscovery-search-and-delete-copilot-data?azure-portal=true#data-sources-for-copilot-data)

## Steps to delete Microsoft 365 Copilot data

### Step 1: Create a case in Microsoft Purview

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) and select **Solutions** > **eDiscovery** > **Cases**.
1. Select **Create case** and provide a unique name and optional description.
1. After the case is created, you're automatically added as a member.

### Step 2: Add data sources and build a search query

1. In the case, select **Create search**.
1. Give your search a name and a description.
1. In the **Query** tab on the **Search** page, add the relevant data sources under **Data sources**.
1. In the **Condition builder**, set **Type** to **Copilot activity**.
1. Add filters such as keywords or date ranges.
1. Once your condition is built, select **Run query**.

:::image type="content" source="../media/ediscovery-copilot-activity.png" alt-text="Screenshot showing the Searches page in eDiscovery." lightbox=" ../media/ediscovery-copilot-activity.png":::

### Step 3: Add to a review set (optional but recommended)

1. After the search completes, select the search result and choose Add to review set.
1. Create a new review set or select an existing one to use.
1. Once the content is added to the review set, you can take these actions:
   - Search and filter the content to focus on relevant items
   - Tag items to support organization and review decisions
   - Run analytics to help identify what content to retain or remove

### Step 4: Check for active holds or policies

Before deletion, confirm that the content isn't under hold or retention:

1. In the case, go to **Holds**.
1. Remove any policies applied to the user mailboxes.
1. Keep a record of policies for reapplication.

Now you're ready to delete Copilot data from user mailboxes.

### Step 5: Delete Copilot content

You can delete Copilot data by using Microsoft Graph Explorer or PowerShell. Make sure you have the **Search And Purge** role assigned in Microsoft Purview with the user performing the deletion.

#### Option 1: Graph Explorer

1. Go to [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer?azure-portal=true) and sign in with an account that has the necessary permissions.
1. Enter this GET request to view the list of eDiscovery cases in your organization:

   ```bash
   https://graph.microsoft.com/v1.0/security/cases/ediscoveryCases
   ```

   Find the case you're using and copy the case ID.

1. Use the case ID in this GET request to list all searches in the case:

   ```bash
   https://graph.microsoft.com/v1.0/security/cases/ediscoveryCases/{ediscoveryCaseID}/searches
   ```

   Locate the search that returned Copilot content and copy its search ID.

1. Submit this POST request to delete the items found in the search:

   ```post
   https://graph.microsoft.com/v1.0/security/cases/ediscoveryCases/{ediscoveryCaseID}/searches/{ediscoverySearchID}/purgeData
   ```

   When successful, a confirmation appears in a green banner with the HTTP response code.

#### Option 2: Use PowerShell (for government tenants)

If your organization is in a US Government cloud where Graph Explorer isn't supported, connect to Microsoft Graph and submit a request using PowerShell:

```powershell
Connect-MgGraph -Scopes "ediscovery.ReadWrite.All" -Environment USGov
Invoke-MgGraphRequest -Method POST -Uri '/v1.0/security/cases/ediscoveryCases/{caseId}/searches/{searchId}/purgeData'
```

This PowerShell method uses the Microsoft Graph API to delete Copilot data, just like Graph Explorer.

### Step 6: Verify deletion

Deleted content moves to the hidden **SubstrateHolds** folder and is permanently deleted within 1–7 days by the Exchange timer job. There's no user-facing confirmation.

To verify:

- Check the review set or rerun the search with narrow criteria.
- Confirm expected items no longer appear.

### Step 7: Reapply policies

After deletion:

1. Reapply any removed holds or retention policies.
1. Document your actions in the case notes or export reports.
