The mailbox investigation confirmed which patient messages the physician opened. It didn't answer whether the same patient records were reached through Copilot or a connected AI app. To close that gap, the healthcare compliance team runs an audit search for AI activity. The flow is the same one that works for any Microsoft 365 workload. What changes is the set of record types, operations, and properties you filter on.

Microsoft Purview Audit captures metadata for Copilot and AI application activity: who was involved, when and where the activity occurred, and which Microsoft 365 resources were referenced. This metadata answers questions like "Which user prompted Copilot?", "Which files did Copilot access to answer?", and "Did the prompt attempt a jailbreak?" Audit doesn't capture the actual prompt or response text. To review that content, pair audit data with Microsoft Purview Data Security Posture Management (DSPM), Communication Compliance, or eDiscovery.

## What to filter on

Copilot and AI interactions map to three record types. Filter by these when you search:

| Record type | Workload | Covers |
| ----- | ----- | ----- |
| `CopilotInteraction` | `Copilot` | First-party Microsoft Copilot experiences, such as Microsoft 365 Copilot, Copilot Chat, Security Copilot, and Copilot in Fabric. |
| `ConnectedAIAppInteraction` | `ConnectedAIApp` | Custom Copilots built with Microsoft Copilot Studio and non-Microsoft AI apps registered in your tenant. |
| `AIAppInteraction` | `AIApp` | Non-Microsoft AI apps used outside your tenant, captured through browser or network data loss prevention (DLP). |

### What each record type depends on

Not every record type appears in audit search on the strength of auditing alone. `CopilotInteraction` records show up as soon as auditing is enabled for the user. The other two rely on tools outside audit itself:

- **`ConnectedAIAppInteraction`** relies on Microsoft Entra registration and onboarding through DSPM. Copilot Studio agents and other Entra-registered AI apps only produce these records once they're onboarded. If a search for a known agent returns nothing, check whether it was onboarded before you dig into the search itself.
- **`AIAppInteraction`** relies on the Microsoft Purview Browser Extension on user devices plus DLP policies that inspect AI app traffic. Prompts a user sends to a non-Microsoft AI website in a browser don't reach audit search unless that pipeline is deployed.

> [!NOTE]
> `AIAppInteraction` records, and the non-Microsoft Entra-registered app scenarios under `ConnectedAIAppInteraction`, are billed through Microsoft Purview [pay-as-you-go billing](/purview/purview-billing-models?azure-portal=true). The tenant needs to be linked to an active Azure subscription and pay-as-you-go features have to be enabled before those records start ingesting. Copilot Studio agents are excluded.

For the setup steps, see [Use Microsoft Purview to manage data security and compliance for Entra-registered AI apps](/purview/ai-entra-registered?azure-portal=true) and [Use Microsoft Purview to manage data security and compliance for other AI apps](/purview/ai-other-apps?azure-portal=true).

### If a Copilot search returns nothing

Start with the standard empty-result checklist that covers auditing state, retention window, latency, role scope, and UTC dates. If those all check-out, two AI-specific dependencies are usually the cause:

1. **For `ConnectedAIAppInteraction`**: the agent or AI app is onboarded through DSPM. Records don't appear until onboarding completes, so a search for a known agent returns nothing if you're searching a window before onboarding, or if onboarding never happened.
1. **The user needs a Copilot license** covering the interaction, and the record type has to match what they actually did. First-party Copilot use produces `CopilotInteraction`. A Copilot Studio agent or Entra-registered AI app produces `ConnectedAIAppInteraction`. A non-Microsoft AI website in a browser produces `AIAppInteraction`, and that one also requires the Microsoft Purview Browser Extension on the device plus a DLP policy inspecting AI app traffic.

### Admin operations to watch for

User interactions map to those three record types. Admin activity around Copilot shows up under separate operations, including `UpdateTenantSettings`, `CreatePlugin`, `DeletePlugin`, and `EnablePromptBook`. Filter on these when the question is who changed a Copilot setting or managed a plugin or agent, not who used Copilot.

### Questions an AI investigation asks

Each investigation question maps to a specific property in the audit record. When you have search results and need to narrow down what happened, use the property listed with the question you're trying to answer.

**Questions you'll ask on most investigations:**

- **Which app was the user interacting with?** `AppIdentity`. Format is `workloadName.appGroup.appName`, for example `Copilot.MicrosoftCopilot.Microsoft365Copilot` or `Copilot.Security.SecurityCopilot`.
- **Which files or sites did Copilot look at to answer?** `AccessedResources`. Each entry includes `SiteUrl`, `Name`, `Type`, and `SensitivityLabelId`, so you can also see whether Copilot touched sensitivity-labeled content.
- **Did a prompt try to jailbreak?** Look for the `JailbreakDetected` flag inside `Messages`. Prompt and response pairs live in `Messages` too.

**Questions for specific scenarios:**

- **Where was the user when they interacted?** `AppHost`:

  | `AppHost` value | Where the user was |
  | --- | --- |
  | `BizChat` | Microsoft 365 Copilot Chat, Teams, or `microsoft365.com/copilot` |
  | `Bing` | Microsoft Edge browser or Office mobile |
  | `Office` | `office.com` or `microsoft365.com` |
  | `Word`, `Excel`, `PowerPoint`, `Stream` | The named app |

- **What was the user doing during the interaction?** `Contexts`, such as the document they had open at the time.
- **Was a Copilot Studio agent involved?** `AgentName` and `AgentVersion`.

## Run a search for AI app activities

The portal flow is the same as any audit search: **Solutions** > **Audit** > configure > **Search**. Two fields carry the Copilot-specific picks:

- **Activities - friendly names**: expand **Copilot activities**, or type _Copilot_ in the search box.

   :::image type="content" source="../media/audit-copilot-new-search-activities.png" alt-text="Screenshot showing Interacted with Copilot selected under Activities - friendly names." lightbox="../media/audit-copilot-new-search-activities.png":::

- **Record types**: select `CopilotInteraction`, `ConnectedAIAppInteraction`, or `AIAppInteraction`. Type _Copilot_ or _AI_ in the search box to filter the list.

   :::image type="content" source="../media/audit-copilot-new-search-record-type.png" alt-text="Screenshot showing CopilotInteraction selected under Record types." lightbox="../media/audit-copilot-new-search-record-type.png":::

> [!NOTE]
> Copilot audit records take the same 60 to 90 minutes to appear as records from core Microsoft 365 services. If you searched right after prompting Copilot, wait and try again.

> [!TIP]
> To find all activity for a specific `AppIdentity`, first search and export the Copilot audit records by operation name, then filter the exported results on `AppIdentity` in Excel or Power Query.

## Scenario: Extend the healthcare investigation to Copilot activity

With the mailbox thread wrapped up, the healthcare compliance team turns to Copilot activity. The question now is whether Copilot or a connected AI app referenced any of the same patient records the physician had accessed. To answer, the team:

- Filters on the `CopilotInteraction` and `ConnectedAIAppInteraction` record types, scoped to the same users and date range as the mailbox investigation.
- Reviews the `AccessedResources` property on returned records to identify patient files Copilot read to answer prompts, and checks each file's `SensitivityLabelId`.
- Scans the `Messages` property for `JailbreakDetected` flags, which mark prompts that tried to bypass safeguards.
- Exports the results so they can be joined with the mailbox findings by user, resource, and time window.
