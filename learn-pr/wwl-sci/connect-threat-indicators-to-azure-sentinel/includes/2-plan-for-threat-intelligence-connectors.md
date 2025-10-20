Microsoft Sentinel provides you with data connectors that enable you to import Indicators of Compromise (IOCs) from Microsoft Defender Threat Intelligence (MDTI). The Content hub solutions include the data connectors and the following Microsoft Sentinel components:

- Analytic rules include a set of scheduled rule templates, and you can enable rules to generate alerts and incidents based on matches of log events from your threat indicators.

- Workbooks provide summarized information about the threat indicators imported into Microsoft Sentinel and any alerts generated from analytics rules that match your threat indicators.

- Hunting queries allow security investigators to use threat indicators within the context of common hunting scenarios.

- Playbooks run preconfigured sets of remediation actions to help automate and orchestrate your threat response.

You can stream threat indicators to Microsoft Sentinel by using an MDTI based connector, one of the integrated Threat Intelligence Platform (TIP) products, connecting to TAXII servers, or direct integration with the Microsoft Graph Security Indicators API.

There are five Threat Intelligence Data Connectors:

- Threat intelligence - TAXII
- Microsoft Defender Threat Intelligence
- Premium Microsoft Defender Threat Intelligence
- Threat Intelligence Platforms
- Threat Intelligence Upload API (Preview)

All the data connectors write to the *ThreatIntelligenceIndicator* table, and the data connectors all have different configuration procedures.
