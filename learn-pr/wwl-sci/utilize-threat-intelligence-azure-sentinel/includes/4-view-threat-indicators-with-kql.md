The indicators reside in the *ThreatIntelligenceIndicator* table. This table is the basis for queries performed by other Microsoft Sentinel features such as Analytics and Workbooks. Here's how to find and view your threat indicators in the ThreatIntelligenceIndicator table.

To view your threat indicators with KQL. Select **Logs** from the General section of the Microsoft Sentinel menu. Then run a query on the ThreatIntelligenceIndicator table.

```kusto
`ThreatIntelligenceIndicator`

```

> [!IMPORTANT]
> On April 3, 2025, we publicly previewed two new tables to support STIX indicator and object schemas: `ThreatIntelIndicators` and `ThreatIntelObjects`. Microsoft Sentinel will ingest all threat intelligence into these new tables, while continuing to ingest the same data into the legacy `ThreatIntelligenceIndicator` table until July 31, 2025.
> **Be sure to update your custom queries, analytics and detection rules, workbooks, and automation to use the new tables by July 31, 2025.** After this date, Microsoft Sentinel will stop ingesting data to the legacy `ThreatIntelligenceIndicator` table. We're updating all out-of-the-box threat intelligence solutions in Content hub to leverage the new tables. For more information about the new table schemas, see [ThreatIntelIndicators](/azure/azure-monitor/reference/tables/threatintelindicators) and [ThreatIntelObjects](/azure/azure-monitor/reference/tables/threatintelobjects).
