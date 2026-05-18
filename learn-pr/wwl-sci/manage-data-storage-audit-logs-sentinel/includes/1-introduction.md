With event collection, enrichment, and automated response now in place, Contoso Financial Services' Microsoft Sentinel environment is ingesting security data from across their hybrid infrastructure. But the security engineering team is facing three new challenges that expose gaps in the deployment.

First, the trading platform engineering team deployed a proprietary risk management system that generates security-relevant events in a custom JSON format. None of Contoso's existing Microsoft Sentinel tables accept this format cleanly—forcing the team to either discard the events or shoehorn them into an ill-fitting table schema that breaks every query written against it.

Second, the compliance team escalated. PCI-DSS requires one year of log retention for in-scope systems, and SOX requires seven years of audit records for financial controls. Contoso's current workspace default of 30 days satisfies neither, and the team has no cost model for extending retention across all tables—some of which generate hundreds of gigabytes per day.

Third, the internal audit team needs to investigate a suspicious SharePoint file download event from three months ago. The trail lives in Microsoft Purview Audit, not in the Microsoft Sentinel workspace. The audit team wants to search and correlate that activity alongside Microsoft Sentinel incidents from the same timeframe, but currently has to use a separate Microsoft Purview portal, export results to a spreadsheet, and correlate manually.

This module resolves all three challenges. You create a custom log table for the trading system's nonstandard events, configure per-table Analytics & Archive retention tiers that meet compliance requirements without over-spending on hot storage, connect Microsoft Purview Audit as a Microsoft Sentinel data source, and query Purview Audit events directly from the Microsoft Defender portal—giving Contoso a unified investigation surface for both security and compliance scenarios.

## Learning objectives

After completing this module, you'll be able to:

- Create custom log tables in a Microsoft Sentinel workspace to store nonstandard ingested data.
- Configure data retention tiers and archive policies for Microsoft Sentinel tables.
- Connect Microsoft Purview Audit as a data source in Microsoft Sentinel.
- Query Purview Audit logs in the Microsoft Defender XDR portal.

