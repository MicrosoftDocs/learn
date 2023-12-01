
Microsoft Sentinel uses various sources of security information to create incidents. You need to understand these sources to best utilize incident management in Microsoft Sentinel.

## Incident evidence

Incident *evidence* consists of the security event information and related Microsoft Sentinel assets that identify threats in the Microsoft Sentinel environment. Evidence shows how Microsoft Sentinel has identified a threat, and links back to specific resources that can increase your awareness of incident details.

### Events

Events link you back to one or more specific events from the Log Analytics workspace associated with Microsoft Sentinel. On their own, these workspaces typically contain thousands of events that are too numerous to manually parse.

If a query attached to a Microsoft Sentinel analytics rule returns events, it attaches the events to the generated incident for potential further review. You can use these events to understand the scope and frequency of the incident before you investigate further.

### Alerts

Most incidents are generated because of an analytics rule alert. Examples of alerts include:

- Detection of suspicious files.
- Detection of suspicious user activities.
- Attempted elevation of privilege.

Analytics rules generate alerts based either on Kusto Query Language (KQL) queries or direct connection to Microsoft Security solutions like Microsoft Defender for Cloud or Microsoft 365 Defender. If you enable alert grouping, Microsoft Sentinel includes any related alert evidence for the incident.

### Bookmarks

While investigating an incident, you might identify events that you want to track or mark for later investigation. You can preserve the queries run in Log Analytics by choosing one or more events and designating them as bookmarks. You can also record notes and tags to better inform future threat-hunting processes. Bookmarks are available to you and your teammates.

## Incident entities

An incident *entity* refers to a network or user resource that's involved with an event. You can use entities as entry points to explore all alerts and correlations associated with that entity.

Entity relationships are useful when you're investigating incidents. Instead of analyzing the identity alerts, network alerts, and data access alerts individually, you can use entities to observe any alerts associated with a particular user, host, or address in your environment.

Some entity types include:

- Account
- Host
- IP
- URL
- FileHash

For instance, entities could help you identify all the alerts associated with a specific user at Contoso, the user's host machine, and other hosts that the user has connected to. You can determine which IP addresses are associated with that user, exposing which events and alerts could be part of the same attack.