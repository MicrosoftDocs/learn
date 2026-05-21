Contoso Financial Services' Microsoft Sentinel environment now has a complete data lifecycle architecture. The proprietary trading system has a dedicated custom log table—events land in a properly typed schema that KQL queries can use without workarounds. Per-table retention is configured at 90 days interactive for all compliance-relevant tables, with Archive tier extending total retention to seven years across the in-scope dataset, satisfying both PCI-DSS and SOX requirements at a sustainable storage cost. And Purview Audit is connected as a Microsoft Sentinel data source, with audit events queryable from the Microsoft Defender portal using either the guided Audit search experience or Advanced Hunting KQL—giving the compliance and security teams a unified investigation surface they no longer have to leave to conduct a compliance inquiry.

In this module, you:

- Created a custom log table in the Microsoft Sentinel workspace and configured DCR-based ingestion via the Logs Ingestion API for a nonstandard data source
- Configured Analytics and Archive retention tiers and set per-table retention periods via the Defender portal table management experience
- Connected Microsoft Purview Audit as a data source in Microsoft Sentinel and verified log ingestion
- Queried Purview Audit logs in the Microsoft Defender XDR portal using both the Audit search tool and Advanced Hunting KQL to investigate a compliance scenario

## What's next

With the full collection-to-retention architecture in place and compliance audit access unified in the Defender portal, Contoso's Microsoft Sentinel implementation is ready for the next phase of the SC-500 learning path: building detection capabilities through analytics rules, behavioral analytics, and threat hunting. For a deeper exploration of the data management patterns covered in this module, see the Microsoft Sentinel data transformation and retention documentation.

> [!TIP]
> To explore the full range of data tier and retention options, see [Manage data tiers and retention in Microsoft Sentinel](/azure/sentinel/manage-data-overview).
