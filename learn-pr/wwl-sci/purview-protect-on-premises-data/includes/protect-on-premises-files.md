Not all sensitive data lives in the cloud. Many organizations still rely on file shares and on-premises SharePoint Server environments to store and manage data. To protect this data, Microsoft Purview offers an on-premises scanner that brings classification, labeling, and encryption capabilities to local repositories.

## What is the Microsoft Purview Information Protection scanner?

The **Microsoft Purview Information Protection scanner** is a Windows Server-based service that can scan, classify, and optionally label or protect files stored in:

- UNC paths (SMB or NFS, preview)
- SharePoint Server document libraries (2013 through 2019)

The scanner is part of the broader Microsoft Purview Information Protection solution and uses your existing sensitivity labels to apply classification and encryption policies across on-premises data.

You can use the information protection scanner to:

- **Apply sensitivity labels and encryption** to files in supported locations, based on your configured label policies.
- Use **data loss prevention (DLP) rules** to detect potential data exposure and automatically restrict access to sensitive files.
- **Scan in discovery mode** to identify sensitive data without labeling or protecting files, allowing you to assess results before taking action.
- **Scale scanning across large environments** by deploying multiple scanner nodes as part of a cluster.

The scanner uses the Microsoft Purview Information Protection client to classify and protect files, applying the same classification and protection features available in cloud and endpoint scenarios.

## Why use the scanner?

The scanner helps close security and compliance gaps by extending Microsoft Purview protection to on-premises content:

- **Unified classification**: Apply the same sensitivity labels used across Microsoft 365 to file shares and SharePoint Server libraries.
- **Consistent protection**: Ensure that files are labeled and protected the same way, whether they're stored in the cloud or on-premises.
- **DLP policy enforcement**: Apply DLP rules to detect and act on potential data leaks, including automatically restricting access to sensitive files.
- **Discovery and reporting**: Identify sensitive content on legacy infrastructure to support data governance, audits, and compliance programs.
- **Scalability**: Deploy as a single node or a multi-node cluster to scale scanning across larger file repositories.

## How does the scanner work?

Each time the scanner runs, it performs a series of steps to identify, label, and protect sensitive content:

1. **Determine which files to scan**: File inclusion and exclusion rules are set through configuration. System and unsupported file types are automatically skipped.
1. **Inspect and label files**: The scanner uses Windows indexing filters (IFilters) to read file contents and identify sensitive data based on sensitive information types or regex patterns.
1. **Apply labels and protection**: If a file matches the conditions defined in a sensitivity label, the label is applied. If encryption is part of the label policy and supported by the file type, encryption is applied.
1. **Fallback behavior**: For files that can't be inspected, a default label might be applied based on your label policy configuration.

## What about data loss prevention (DLP)?

Beyond labeling and encryption, the scanner can also enforce Microsoft Purview DLP policies on on-premises files. When enabled, DLP rules can detect files that match specific conditions, such as containing credit card numbers or health records. When a match is found, the scanner can automatically take action to reduce risk.

Depending on your DLP policy configuration, the scanner can:

- Restrict access to sensitive files so only file owners or specific users can view them
- Flag files for further investigation or review
- Generate detailed reports showing potential data exposure

This functionality helps organizations apply the same data loss prevention strategies across hybrid environments, not just the cloud.

> [!NOTE]
> DLP must be explicitly enabled on each scan job. DLP enforcement only applies if matching policies exist in your Microsoft Purview configuration.

## Deployment considerations

- The scanner isn't real-time. It systematically crawls through specified data stores on a schedule.
- Use **discovery mode** to evaluate the potential effect of label application before making changes.
- For large SharePoint farms, you might need to adjust the list view threshold and network port settings to avoid performance issues.
- Default protection applies only to Office files and PDFs. Other file types must be manually configured for encryption or DLP actions if needed.
