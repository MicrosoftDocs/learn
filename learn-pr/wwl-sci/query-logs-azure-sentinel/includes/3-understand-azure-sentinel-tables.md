Microsoft Sentinel has Analytic Rules that generate Alerts and Incidents based on querying the tables within Log Analytics. The primary tables to manage alerts and incidents are SecurityAlert and SecurityIncident. Microsoft Sentinel provides tables to be a repository of indicators and watchlists.

> [!NOTE]
> Some of the Sentinel Data Connectors ingest alerts directly.  

The table below is the Microsoft Sentinel feature related tables.

| Table| Description|
| :--- | :--- |
| `SecurityAlert`| Contains Alerts Generated from Sentinel Analytical Rules. Also, it could include Alerts created directly from a Sentinel Data Connector|
| `SecurityIncident`| Alerts can generate Incidents. Incidents are related to Alert(s).|
| `ThreatIntelligenceIndicator`| Contains user-created or data connector ingested Indicators such as File Hashes, IP Addresses, Domains|
| `Watchlist`| A Microsoft Sentinel watchlist contains imported data.|
