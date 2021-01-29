Azure Sentinel lets you import the threat indicators your organization uses, which can enhance your security analysts' ability to detect and prioritize known threats. Several features from Azure Sentinel then become available or are enhanced:

- Analytics includes a set of scheduled rule templates you can enable to generate alerts and incidents based on matches of log events from your threat indicators.

- Workbooks provide summarized information about the threat indicators imported into Azure Sentinel and any alerts generated from analytics rules that match your threat indicators.

- Hunting queries allow security investigators to use threat indicators within the context of common hunting scenarios.

- Notebooks can use threat indicators when you investigate anomalies and hunt for malicious behaviors.

You can stream threat indicators to Azure Sentinel by using one of the integrated threat intelligence platform (TIP) products, connecting to TAXII servers, or direct integration with the Microsoft Graph Security tiIndicators API.

There are two Threat Intelligence Connectors.  The TAXII Connector and the Threat Intelligence Platforms Connector.  Both connectors write to the ThreatIntelligenceIndicator table.  The two connectors have different configuration procedures.

