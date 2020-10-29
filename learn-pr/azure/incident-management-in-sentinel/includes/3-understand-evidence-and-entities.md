Incidents in Azure Sentinel are created from other sources of security information in Azure. How you manage and understand the contents of an incident will help you better understand and use incident management in Sentinel.

## Incident evidence

Incident evidence consists of the security event information and related Sentinel assets that identify threats in the Sentinel environment. Evidence shows you how a threat has been identified in Sentinel and it links you back to the specific resources that you can use to increase you awareness of incident details.

### Events

Events link you back to one or more events from the Log Analytics workspaces associated with Sentinel. On their own, these workspaces typically contain thousands of events that are too numerous to manually parse. If a query attached to a Sentinel analytics rule returns events, these events are attached to the generated incident for potential further review. You can use events to understand the scope and frequency of the incident before investigating further.

### Alerts

Most incidents are generated as a result of an analytics rule alert. Examples of alerts include detection of suspicious files, detection of
suspicious user activities, or attempted elevation of privilege. Analytics rules generate alerts, either based on KQL queries or direct connection to Microsoft Security solutions such as Azure Security Center or Azure Advanced Threat Protection. If you enable alert grouping Azure Sentinel includes any related alerts evidence for the incident.

### Bookmarks

During the course of investigating an incident, you might identify events that you want to track or mark for later investigation. You can preserve the queries ran in Log Analytics by choosing one or more events and designating them as bookmarks. You can also record notes and tags to better inform later threat hunting processes. Bookmarks are available to you and your teammates.

## Incident entities

An entity refers to a network or user resource involved with an event. You can use entities as entry points to explore all alerts and correlations associated with that entity. Entity relationships are useful when investigating incidents. Instead of analyzing the identity alerts, network alerts, and data access alerts individually, you can use entities to view any alerts associated with a particular user, host, or address in your environment. Incidents can contain any of these four entity types:

- User
- Host machine
- IP address
- Network connection

For instance, entities would help you identify all of the alerts associated with a specific user at Contoso, the user's host machine, and other hosts the user has connected to. You can determine which IP addresses are associated with the user in question, exposing which events and alerts could be part of the same attack.
