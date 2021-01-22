The indicators reside in the *ThreatIntelligenceIndicator* table.  This table is the basis for queries performed by other Azure Sentinel features such as Analytics and Workbooks. Here's how to find and view your threat indicators in the ThreatIntelligenceIndicator table.

To view your threat indicators with KQL.  Select **Logs** from the General section of the Azure Sentinel menu. Then run a query on the ThreatIntelligenceIndicator table.

```kusto
ThreatIntelligenceIndicator

```

