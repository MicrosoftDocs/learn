
Thousands of user and admin activities performed in Microsoft 365 services and solutions are captured, recorded, and retained in the Unified Audit Log (UAL). Audit records for these events are searchable using the Microsoft Purview or Microsoft Defender portal Audit Search, or by using the Microsoft Exchange policy-and-compliance-audit PowerShell cmdlets.

Microsoft Purview provides two auditing solutions: Audit (Standard) and Audit (Premium). This module explores Microsoft Purview Audit (Standard). The next module focuses on Microsoft Purview Audit (Premium).

This module examines how to search for audited activities using the Audit (Standard) solution. You'll begin by learning how to set up Audit (Standard). This workflow includes verifying your subscription and assigning the necessary permissions.

Once Audit (Standard) is configured, you'll learn how to search for audited activities using the audit search tool in the Microsoft Purview compliance portal. You'll also learn how to search for audited activities using the **Search-UnifiedAuditLog** cmdlet in Exchange Online PowerShell. This cmdlet is the underlying cmdlet for the search tool.

The module then examines how to view the search results. You'll also learn how to export the search results to a CSV file that can be searched, sorted, and filtered using Microsoft Excel. You'll then examine how to export, configure, and view the audit log records that were retrieved as a result of an audit log search. This process includes formatting the exported audit log using the Power Query Editor in Excel.

The module concludes by examining how to use audit log searching to investigate common support issues reported to Microsoft Support. The module provides suggestions on how to troubleshoot these scenarios by using the audit log search tool in the Microsoft Purview compliance portal. Each scenario explains how to configure an audit log search query for the corresponding issue. It also describes what to look for in the detailed information in the audit records that match the search criteria.

You're a Security Operations Analyst working at a company that is implementing Microsoft Purview and Microsoft Defender XDR solutions.  You need to understand how to search the Unified Audit Log (UAL) to find and investigate threats, and to conduct forensic investigations. After completing this module, you'll be able to:

- Describe the differences between Audit (Standard) and Audit (Premium).
- Start recording user and admin activity in the Unified Audit Log (UAL).
- Identify the core features of the Audit (Standard) solution.
- Set up and implement audit log searching using the Audit (Standard) solution.
- Export, configure, and view audit log records.
- Use audit log searching to troubleshoot common support issues.
