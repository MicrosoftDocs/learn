Microsoft Purview Data Loss Prevention (DLP) helps protect sensitive data at rest across cloud and on-premises environments. For on-premises files stored in file shares or SharePoint Server, DLP enforcement depends on the Microsoft Purview Information Protection scanner.

Once the scanner is deployed and content scan jobs are configured, you can enable DLP rules to detect risky content. These rules can automatically apply access restrictions or move files based on your policy configuration.

## Requirements for using DLP with the scanner

Before using DLP with on-premises repositories, make sure:

- The Microsoft Purview Information Protection scanner is fully installed and operational.
- At least one content scan job is created and assigned to a scanner cluster.
- **Enable DLP rules** is turned **on** in the scan job settings.
- You've published at least one label and policy in Microsoft Purview (even if you're only using sensitive information types for DLP detection).

## DLP policy triggers for on-premises files

The scanner evaluates each file in the configured repositories and can trigger a DLP policy based on:

- **Sensitive information types** (for example credit card numbers, health data)
- **Sensitivity labels** already applied to the file
- **File extensions**
- **Custom document properties** (Office files only)

## Available DLP actions

When a file matches a DLP policy, the following actions can be applied:

- **Block all access**: Remove NTFS or SharePoint permissions for all users except the file owner, repository owner, last modifier (SharePoint only), and administrators.
- **Block broad access**: Remove built-in groups such as _Everyone_, _Authenticated Users_, and _Domain Users_ from the file's access list.
- **Force inheritance from parent folder**: Apply permissions from the parent folder. You can optionally override and enforce this even if the parent permissions are less restrictive.
- **Quarantine the file**: Replace the original file with a stub `.txt` file and move the file to a designated quarantine folder.

These actions are enforced at the file level during scanning and help reduce accidental or malicious data exposure.

## How to deploy and test DLP enforcement

To enforce DLP with the scanner:

1. Make sure **Enable DLP rules** is turned on in your scan job settings.
1. Create a DLP policy that includes the **On-premises repositories** location.
1. Scope the policy to specific file paths if needed using inclusion or exclusion lists. Wildcards are supported in limited patterns.
1. Run the policy in simulation mode first to validate its behavior before switching to enforcement.
1. Monitor results in **Activity explorer**, the **Audit log**, or directly from scan reports on the scanner server.

> [!TIP]
> To apply updated DLP settings across all scanned content, use the **Rescan all files** option in the Microsoft Purview portal or run `Start-Scan -Reset` in PowerShell.

### Where to view DLP activity

DLP detection and enforcement for on-premises files is visible in:

- **Activity explorer**: View matches by file name, type, rule name, and applied actions.
- **Audit log**: Track when DLP actions are taken on files.
- **Local scan reports**: Stored in `%localappdata%\Microsoft\MSIP\Scanner\Reports`, including `.csv` logs with DLP-specific columns like `DLP Rule Name`, `DLP Status`, and applied permissions.

## Limitations

- **Policy tips** aren't available for on-premises DLP enforcement.
- The scanner doesn't support OneDrive locations or WebDAV paths.
- DLP actions can't be previewed. Test in simulation mode before enforcing.
