The Microsoft Security Compliance Toolkit (SCT) is a set of tools provided by Microsoft that you can use to download and implement security configuration baselines, typically referred to as simply security baselines, for Windows Server and other Microsoft products, including Windows 10, Microsoft 365 Apps for enterprise, and Microsoft Edge. You implement the security configuration baselines by using the toolkit to manage your Group Policy Objects (GPOs).

You can also use the SCT to compare your current GPOs to the recommended GPO security baselines. You can then edit the recommended GPOs and apply them to devices in your organization.

In addition to security baselines for Windows Server, the SCT also includes the Policy Analyzer and Local Group Policy Object (LGPO) tools, which also help you manage your GPO settings.

## Policy Analyzer tool

The Policy Analyzer tool helps you to compare sets of GPOs. The Policy Analyzer:

- Highlights redundant or inconsistent settings.

- Highlights differences between sets of GPOs.

- Compares GPOs to local policy and registry settings.

- Exports results to Microsoft Excel.

Additional reading: For more information about the Policy Analyzer tool, see the following Docs article [New tool: Policy Analyzer](/archive/blogs/secguide/new-tool-policy-analyzer).

## LGPO tool

The LGPO tool (LGPO.exe) helps you verify the effects of GPO settings on a local host. You can also use it to help manage systems that are not domain joined. The LGPO tool can export and import Registry Policy settings files, security templates, Advanced Auditing backup files, and from LGPO files, text files with a special formatting.

Additional reading: For more information about the LGPO tool, see the following docs article [LGPO.exe - Local Group Policy Object Utility](/archive/blogs/secguide/lgpo-exe-local-group-policy-object-utility-v1-0)

