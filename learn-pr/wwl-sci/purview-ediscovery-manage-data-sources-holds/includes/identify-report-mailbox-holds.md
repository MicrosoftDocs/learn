When responding to investigations or audits, it's important to confirm whether mailbox content is being preserved and why. Microsoft Purview supports several types of holds that prevent mailbox content from being permanently deleted. This includes holds applied through eDiscovery cases, retention policies, retention labels, and litigation holds.

## Identify mailbox hold types

You can use Exchange Online PowerShell to identify the types of holds placed on a mailbox.

Before you check hold status, it helps to understand what types of holds you might see:

- **Litigation Hold** keeps mailbox content for legal reasons, even if the user deletes it.
- **eDiscovery holds** are tied to eDiscovery cases and preserve content relevant to investigations.
- **Retention policies** apply to entire mailboxes or groups of mailboxes based on organizational rules.
- **Retention labels** apply to specific items or folders and can trigger preservation even without a policy.
- **Delay holds** apply after a hold is removed, giving time before content is purged.

You might see one or more of these on the same mailbox, depending on how your environment is configured.

To check for Litigation Hold and unified holds (eDiscovery holds and retention policies):

```powershell
Get-Mailbox <username> | FL LitigationHoldEnabled,InPlaceHolds
```

- **LitigationHoldEnabled** indicates whether a mailbox is on Litigation Hold.
- **InPlaceHolds** contains GUIDs for other hold types.

Hold GUIDs use different prefixes to indicate the type:

- `UniH` = eDiscovery hold
- `mbx`, `skp`, or `grp` = retention policy
- `-mbx` = explicitly excluded from a retention policy

If a GUID starts with `-mbx`, it means the mailbox has been explicitly excluded from an organization-wide policy. This can be used to prevent retention from applying to specific mailboxes, even when the policy is scoped broadly.

If **InPlaceHolds** is empty, check for organization-wide retention policies:

```powershell
Get-OrganizationConfig | FL InPlaceHolds
```

To check if content is preserved due to retention labels:

```powershell
Get-Mailbox <username> | FL ComplianceTagHoldApplied
```

- If **ComplianceTagHoldApplied** is `True`, the mailbox is treated as on hold because a retention label that retains content has been applied to at least one item.

To view delay hold status after a hold is removed:

```powershell
Get-Mailbox <username> | FL DelayHoldApplied,DelayReleaseHoldApplied
```

These properties show whether a delay hold is in place, temporarily extending retention after the original hold is removed.

## Match hold GUIDs to specific cases and policies

After identifying hold GUIDs on a mailbox, you might need to trace those values back to a specific case, policy, or content location.

### For eDiscovery holds

eDiscovery hold GUIDs start with `UniH`. To match a GUID to a specific case and hold:

1. Remove the `UniH` prefix.
1. In Security & Compliance PowerShell, run:

   ```powershell
   $CaseHold = Get-CaseHoldPolicy <GUID without UniH>
   Get-ComplianceCase $CaseHold.CaseId | FL Name
   $CaseHold | FL Name,ExchangeLocation
   ```

These commands reveal the name of the eDiscovery case, the hold name, and the mailboxes under hold.

### For retention policies

Retention policy GUIDs often start with `mbx`, `skp`, or `grp`. To match a GUID to a Microsoft Purview retention policy:

1. Remove the prefix and suffix (such as `:1`, `:2`, or `:3`).
1. Run:

   ```powershell
   Get-RetentionCompliancePolicy <GUID without prefix or suffix> -DistributionDetail | FL Name,*Location
   ```

This shows the name of the retention policy and the content locations it's scoped to.

Matching GUIDs to holds can help verify why a mailbox is preserved, confirm scope, and support defensible investigations.

## Use a script to report on eDiscovery holds

While PowerShell can help you check individual mailbox holds, Microsoft also provides a sample script to generate a report of all eDiscovery case holds across your organization.

Use this script during audits or investigations to:

- Show which cases have active holds
- See who created or modified the holds
- List the content locations in scope
- Identify cases that don’t include any holds

It also creates a separate report listing eDiscovery cases that have **no holds**.

### What the script collects

When you run the script, it generates two CSV files:

- `CaseHoldsReport_<timestamp>.csv` with details about each hold, including:

  - Case name, type, and status
  - Hold name and whether it's enabled
  - Hold creator and last modifier
  - Query-based syntax, if applicable
  - Mailboxes and SharePoint sites in scope
  - Hold creation and modification timestamps
- `CasesWithNoHolds_<timestamp>.csv`, which lists any eDiscovery cases that don't have associated holds

### How to run the script

1. Connect to [Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

1. Create a new `.ps1` script file in a text editor and paste in the script provided in the [official documentation](/purview/edisc-hold-report-script#step-2-run-the-script-to-report-on-holds-associated-with-ediscovery-cases). Save the file as `CaseHoldsReport.ps1`.

1. In your PowerShell session, run the script:

   ```powershell
   .\CaseHoldsReport.ps1
   ```

1. When prompted, enter a folder path where the reports will be saved.

> [!TIP]
> To save the report in the same folder as the script, type a period (`.`) when prompted. To use a subfolder, type the subfolder name.

Once the script completes, you'll see confirmation in the PowerShell window and can open the CSV files from the path you specified.

Using this report can help you quickly validate whether content is under legal hold and identify any gaps, especially during time-sensitive investigations.
