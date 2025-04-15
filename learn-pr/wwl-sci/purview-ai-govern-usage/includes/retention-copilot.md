Microsoft Purview Data Lifecycle Management plays a key role in managing content retention and deletion in Microsoft 365. It helps organizations meet regulatory requirements and reduce risk by deleting data that's no longer needed. Retention policies let you control how long to keep content in services like Exchange, SharePoint, OneDrive, Teams, and Viva Engage. You can retain content indefinitely, keep it for a set period, or delete it after a defined time.

Retention management is especially important for content generated through AI interactions, including Microsoft 365 Copilot. These policies help ensure compliance while supporting responsible data practices.

## Retention in Microsoft 365 Copilot

### What's included for retention and deletion

Retention policies created for the **Teams chats and Copilot interactions** location automatically cover both Microsoft Teams chats and Copilot interactions. These policies apply whether or not users are actively using Teams. They help ensure that prompts and responses from Microsoft 365 Copilot are retained and deleted in accordance with organizational compliance requirements.

These types of content are covered:

- **User prompts**, which include typed input and selected prompts.
- **Copilot responses**, which include generated text, links, and references. Messages that only indicate a response is in progress aren't retained.

Retention policies for Copilot are changing. Previously, Copilot messages were retained using the Teams chats and Copilot interactions location. This worked because Teams and Copilot used the same storage and policy mechanisms.

#### Updates to retention policy locations

New retention policy locations are now available to manage Copilot and AI data separately from Teams. These locations provide more control over Copilot-specific content. In tenants that support the updated model, you might see these retention locations:

- **Microsoft Copilot Experiences**
  - Microsoft 365 Copilots
  - Copilot Studio

- **Enterprise AI apps**
  - ChatGPT Enterprise

These locations apply to both user prompts and Copilot or AI-generated responses. Availability varies across tenants. When configuring a policy, you can't currently select specific apps within these categories. If you select a parent location, all supported apps under that category are included.

## How Copilot messages are retained

Retention for Copilot relies on the Exchange Online mailbox of the user who initiates the Copilot interaction. Messages are copied to a hidden folder within that mailbox. This folder isn't visible to users but is accessible to compliance administrators using eDiscovery.

Retention behavior is governed by the policy type and the Exchange timer job, which runs every 1–7 days. If the message reaches the end of its retention period:

- It's moved to the hidden SubstrateHolds folder.
- It's retained there for at least one day.
- It's permanently deleted unless another retention policy, eDiscovery hold, or Litigation Hold applies.

Messages are still searchable in eDiscovery until permanent deletion occurs. In some cases, there might be a delay between deletion on the backend and the message no longer appearing in the Copilot interface.

### Retention lifecycle

The retention behavior depends on the policy configuration:

**Retain and delete**:

- Messages are kept for the retention period.
- Once expired, they're moved to the SubstrateHolds folder and then permanently deleted.

**Retain only**:

- Messages remain in place unless removed by the user.
- Removed messages are held in SubstrateHolds temporarily.

**Delete only**:

- Messages are deleted when they reach the threshold and held briefly in SubstrateHolds before permanent deletion.

In most cases, Copilot messages persist unless users delete them or submit a [request to delete Copilot interaction history](/copilot/microsoft-365/microsoft-365-copilot-privacy?azure-portal=true).

## Configure retention for Copilot

Retention for Copilot data is managed through the Microsoft Purview portal.

### Prerequisites

| **Step** | **Description** | **Learn more** |
|------|-------------|------------|
| Understand Copilot and Teams retention | Learn how policies apply to both Copilot and Teams messages. | - [Teams retention](/purview/retention-policies-teams?azure-portal=true) <br> - [Copilot retention](/purview/retention-policies-copilot?azure-portal=true) |
| Enable mailbox archiving | Required for managing content stored in hidden folders like _SubstrateHolds_. | [Enable archive mailboxes](/purview/enable-archive-mailboxes?azure-portal=true) |
| Manage inactive mailboxes | Ensure data from departed employees is retained. | [Inactive mailboxes](/purview/inactive-mailboxes-in-office-365?azure-portal=true) |
| Check licensing | Confirm you have the required Microsoft 365 E3/E5 and Purview licenses. | [Licensing guide](/office365/servicedescriptions/microsoft-purview-data-lifecycle-records-management?azure-portal=true) |
| Confirm permissions | You need the _Compliance Administrator_ or equivalent role. | [Permissions](/purview/microsoft-365-compliance-center-permissions?azure-portal=true) |

### Create a retention policy

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Select **Solutions** > **Data Lifecycle Management** > **Policies** > **Retention policies**.
1. Select **New retention policy**.
1. Name and describe your retention policy.
1. Assign admin units if applicable.
1. On the **Choose the type of retention policy to create** page, select **Adaptive** or **Static** depending on the policy scope you plan to use.
   - If you select **Adaptive**: On the **Choose adaptive policy scopes and locations** page, select **Add scopes**, then choose one or more adaptive scopes that are already defined. After that, select the **Copilot-related locations** available in your tenant, such as **Microsoft Copilot Experiences** or **Microsoft 365 Copilots**.
   - If you select **Static**: On the **Choose locations to apply the policy** page, choose either **Teams chats and Copilot interactions** or one of the updated **Copilot-specific retention locations**, depending on what's available in your tenant.
1. For **Decide if you want to retain content, delete it, or both** page, specify the configuration options for retaining and deleting content.
1. Complete the configuration and save your settings.

## Legacy Copilot retention policies

If your organization used the combined **Teams chats and Copilot interactions** location and wants to separate it:

- To make it a Teams chat only policy, use:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy1>" -Applications "User:TeamsChatUserInteractions"
   ```

- To add Microsoft 365 Copilot interactions to a new policy alongside an existing retention policy for Teams private channel messages or Viva Engage, use:

   ```powershell
   Set-AppRetentionCompliancePolicy -Identity “<policy2>” -Applications "User:M365Copilot"
   ```
