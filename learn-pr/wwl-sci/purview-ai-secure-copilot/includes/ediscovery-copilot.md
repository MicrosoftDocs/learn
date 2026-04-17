Microsoft Purview eDiscovery helps your organization investigate Microsoft 365 Copilot activity and take action when needed. You can search for interactions involving Copilot and other AI tools, review the details, and delete sensitive or inappropriate data if necessary.

This gives your organization visibility into how AI is used and a way to respond to issues like data leaks or policy violations.

## What to know before you begin

- You'll need to be a member of the **eDiscovery Manager** role group to create and manage cases.
- To delete content, you must be assigned the **Search And Purge** role, included in the **Data Investigator** and **Organization Management** role groups.
- A maximum of 10 items per mailbox can be deleted at once. This is intended to support targeted cleanup during investigations.

## Step 1: Create an eDiscovery case

Start by creating a case in the Microsoft Purview portal:

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) and select **Solutions** > **eDiscovery** > **Cases**.
1. Select **Create case** and provide a unique name and optional description.
1. After the case is created, you're automatically added as a member.

The case helps you group related search, review, and deletion actions.

## Step 2: Search for Copilot activity

After you create a case, create a search to find Copilot interactions. For example, if an investigation requires you to confirm whether a sensitive report was used in Copilot prompts, you can create a search scoped to Copilot interactions. This lets you find those items across mailboxes and determine whether they should be preserved or deleted.

1. In the case, select **Create search**.
1. Give your search a name and a description.
1. In the **Query** tab on the **Search** page, add the relevant data sources under **Data sources**.
1. In the **Condition builder**, set **Type** to **Copilot activity**.
1. Add filters such as keywords or date ranges.
1. Once your condition is built, select **Run query**.

   :::image type="content" source="../media/ediscovery-copilot-activity.png" alt-text="Screenshot showing the Searches page in eDiscovery." lightbox=" ../media/ediscovery-copilot-activity.png":::

Each Copilot prompt or response is stored in the user's mailbox and identified by an item class. Some examples include:

| Tool or experience | Item class |
|-----|-----|
| Microsoft 365 Copilot | `IPM.SkypeTeams.Message.Copilot.*` |
| Copilot in Word | `IPM.SkypeTeams.Message.Copilot.Word` |
| BizChat | `IPM.SkypeTeams.Message.Copilot.BizChat` |
| Security Copilot | `IPM.SkypeTeams.Message.Copilot.Security.SecurityCopilot` |
| Teams AI Notes | `IPM.SkypeTeams.Message.TeamCopilot.AiNotes.Teams` |
| Non-Microsoft browser-based AI | `IPM.SkypeTeams.Message.CloudAIApp.SaaS.<AppID>` |

Use the **search preview** to confirm that results look accurate.

> [!TIP]
> To identify if Copilot accessed the public web during an interaction, export the message and look for the `WebSearchQuery` string in the HTML file.

## Step 3: Review results and identify data sources

Before taking action, review the content returned by your search:

1. After the search completes, select the search result and choose Add to review set.
1. Create a new review set or select an existing one to use.
1. Once the content is added to the review set, you can take these actions:
   1. Search and filter the content to focus on relevant items
   1. Tag items to support organization and review decisions
   1. Run analytics to help identify what content to retain or remove

This helps you decide if any content needs to be deleted and which sources are affected.

## Step 4: Check for holds or retention policies

If your investigation requires deletion, you'll need to remove any retention settings that might prevent it:

1. Identify which mailboxes contain the content you want to delete.
1. Check if those mailboxes are subject to a **hold** or **retention policy**.
1. Remove those holds or policies temporarily, and make a note so you can reapply them later.

   > [!NOTE]
   > Content under a hold or retention policy can't be deleted until those policies are removed.

## Step 5: Delete Copilot data with Microsoft Graph Explorer

You can delete Copilot data by using Microsoft Graph Explorer or PowerShell. Make sure you have the **Search And Purge** role assigned in Microsoft Purview with the user performing the deletion. Deletion is needed when investigators determine that Copilot interactions contain sensitive data that shouldn’t remain in mailboxes.

### Option 1: Graph Explorer

1. Go to [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer?azure-portal=true) and sign in with an account that has the necessary permissions.
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

### Option 2: Use PowerShell (for government tenants)

If your organization is in a US Government cloud where Graph Explorer isn't supported, connect to Microsoft Graph and submit a request using PowerShell:

```powershell
Connect-MgGraph -Scopes "ediscovery.ReadWrite.All" -Environment USGov
Invoke-MgGraphRequest -Method POST -Uri '/v1.0/security/cases/ediscoveryCases/{caseId}/searches/{searchId}/purgeData'
```

This PowerShell method uses the Microsoft Graph API to delete Copilot data, just like Graph Explorer.

## Step 6: Confirm deletion and reapply holds

After deletion:

- Copilot content is moved to the **SubstrateHolds** folder in the user's mailbox.
- It's retained there for at least one day, then permanently deleted.
- There's no visible change for the user.

Once you're confident the data is gone, reapply any holds or retention policies you removed earlier.
