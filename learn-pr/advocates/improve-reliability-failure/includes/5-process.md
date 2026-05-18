A key part of a post-incident review is the construction of a shared,
accurate chronology that reflects the nonlinear nature of an incident.

By nonlinear, we mean that incidents are almost never just "this thing
happens, and then that happened, then we noticed, then we did something,
and then we're done." People come in and out, different people notice and
try different things; some work, some don't. And if multiple people are
working at the same time, these things can happen at the same time, too, so
it's a bit more complicated.

To create a timeline like this, even a complex one, there's always an
important first step: gather the data.

## Gather the data

Before you can conduct a post-incident review, you first need to gather
data. Specifically, you need to collect as much of the conversation and
context (both technical and nontechnical) surrounding the event as you can
so you can use all of the crucial data contained in it. The conversation
among team members that happened during the outage or incident will be one
of your richest sources of information.

You also should gather data from your monitoring system and other places
the people involved in the incident drew context. What information were
they getting from your systems when the incident was going on?

And finally, if possible, it would be helpful for you to get a better
picture of what changed prior to and during the incident, because
changes are often contributing factors when an incident occurs.

We can look at this process as three separate parts:

- **Collect the conversation**: In other modules in this learning path, we've
    mentioned that it's important to carve out a specific place for people
    to communicate during an incident. During the incident, ideally people
    are sharing what worked and what failed, what they're hesitant to try,
    what they've tried in the past. This conversation among people as
    they work through and solve the issue is your best source of learning.
- **Determine the context**: The people in an incident are receiving signals
    from various places. One primary place is your monitoring system. We've
    discussed the importance of having a solid monitoring system in a
    previous module in this learning path. Ideally, we should be able to
    look at the monitoring system to build a point-in-time snapshot for the
    time period around or related to the incident.
- **Find the changes**: You can do this through activity and audit logs.

## Azure tools to help gather the data

Azure offers a number of tools that can assist with this process:

### Azure DevOps for holding metadata about the incident

In a previous module in this learning path, we discussed using Azure Boards
in the Azure DevOps suite as one place to collect all of the information
about an incident starting from the initial response. It helps us with
questions about when an incident was first declared, who was on call, who
was assigned to the incident, and so forth. You can also use the Azure
DevOps Wiki as a centralized way to pull in some of the pieces of
information about both the incident itself and the conversation that
happened during the incident.

### Microsoft Graph API for extracting the conversation

Microsoft Graph API provides a programmatic way to retrieve the
conversation that was collected inside the Teams channel devoted to this
specific incident. The data retrieved includes timestamps, authorship,
edits, replies, and some system messages, all of which can help when
constructing a chronology.

One easy way to get started with Microsoft Graph API is to use the
Microsoft Graph Explorer. Microsoft Graph Explorer is a web-based API
browser that lets you choose API calls from a **Sample queries** panel and
try them interactively.

Before you run the queries, make sure the user or app you're using has the
permissions and consent required for the access mode you've chosen. In
delegated scenarios, listing joined teams
uses `Team.ReadBasic.All`, listing channels uses `Channel.ReadBasic.All`,
and reading channel messages requires `ChannelMessage.Read.All`. If you
later automate the workflow with app-only access, use
`GET /users/{id | user-principal-name}/joinedTeams` instead of the
delegated-only `/me/joinedTeams` alias, using the `Team.ReadBasic.All`
application permission. For the channel-specific read steps, the
least-privileged app-only options are `ChannelSettings.Read.Group` for
listing channels and `ChannelMessage.Read.Group` for reading messages,
both with resource-specific consent.

We'll step through a set of Microsoft Graph v1.0 "Microsoft Teams" API
calls to retrieve the conversation. (Channel messages moved from beta to
v1.0 several years ago, so the beta endpoints are no longer required for
this scenario.) Each step of the way, we'll choose a query, run the query,
and then select the info from the response that helps us with the next step. We then use this info to
construct the next request. For example, first we query a list of team IDs
to show the teams we're a part of. We choose the one we need from the
response and insert this ID into the next query URL to get a list of
channels in that team.

Here are our steps, shown as Microsoft Graph v1.0 endpoints:

1. `GET /me/joinedTeams` (to find the team ID of the team we use in a delegated scenario) or `GET /users/{id | user-principal-name}/joinedTeams` (to do the same in an app-only scenario).
2. `GET /teams/{team-id}/channels` (to find the channel ID of the channel we used for that incident).
3. `GET /teams/{team-id}/channels/{channel-id}/messages?$expand=replies` (to retrieve the threaded conversation).
4. Follow `@odata.nextLink` and `replies@odata.nextLink` as needed, or call `GET /teams/{team-id}/channels/{channel-id}/messages/{message-id}/replies` to page through larger threads.

If you used a shared channel, note the `joinedTeams` API doesn't
return the host team for a shared channel that the user is a direct member
of. This caveat applies whether you call `GET /me/joinedTeams` or
`GET /users/{id | user-principal-name}/joinedTeams`. In that case, start
from the known team and channel identifiers or use the associated team APIs
to locate the host team.

In Graph Explorer, you can either enter these URLs directly or pick the equivalent entries from the built-in **Sample queries** panel under **Microsoft Teams**.

If we later wanted to construct a program to perform each of those steps
(and indeed we do), there's a **code snippets** option in the request window
that presents sample code for that query in a number of different
programming languages.

Depending on how your team uses Teams, the message history can also contain
system messages that help explain when members were added or removed.
However, if you need an authoritative audit trail of channel membership or
access changes, complement this data with Microsoft 365 audit logs.

### Dashboards and workbooks for context display

Azure dashboards and Azure Monitor workbooks can both help reconstruct the
context that operators saw during an incident. Dashboards are useful for
at-a-glance operational overview across Azure services. Workbooks are
usually the better fit for incident analysis because they support richer
queries, parameters, drilldowns, and narrative text alongside charts.

If you already have a dashboard or workbook that captures the right
signals, set its time range to the period around the incident and use it to
reconstruct what people saw at the time. This can be especially helpful
when correlating metrics, logs, and alerts across several resources.

Shared dashboards are Azure resources and can still be exported as JSON
from the portal. That export/import path is useful when you want to version
or templatize a dashboard. However, for most post-incident investigation
scenarios, workbooks are the more flexible tool because they let you
combine visualizations, KQL queries, and explanatory text in a single
artifact.

### Activity logs, resource logs, and Log Analytics for change exploration

A Log Analytics workspace can take in data from many sources, including
Azure Activity log, Azure resource logs, and service-specific diagnostics.
First, create a new Log Analytics workspace. Then, in the Azure portal,
open **Monitor → Activity log** and select **Export Activity Logs** at the
top of the pane. This opens a diagnostic setting that lets you send the
activity log for an Azure subscription to your workspace.

In a short time, you're able to use Kusto Query Language (KQL) to
retrieve detailed information about changes that have taken place in that
subscription since you connected the data source.

For example, the following query shows information about resources that
changed or were deleted. We can set the range of time in the Logs
experience to more precisely hone in on the period shortly before the
incident.

```Kusto
AzureActivity
| where CategoryValue == 'Administrative'
| where OperationNameValue endswith "write" or OperationNameValue endswith "delete"
| project TimeGenerated, Level, ResourceGroup, ResourceId, OperationName, OperationNameValue, ActivityStatusValue, Caller
| order by TimeGenerated desc
```

This query is useful for management-plane changes, but remember what it
doesn't show. `AzureActivity` captures control-plane operations such as
create, update, delete, and policy actions. It doesn't capture data-plane
or application-level changes inside a service. To investigate those, pair
this query with Azure resource logs, service-specific audit logs,
deployment history, and CI/CD or source-control records.

One quick note: when you export the Azure activity log, the information
starts to flow into the Log Analytics workspace from that point in time
forward. You won't be able to query that workspace retroactively for events
that took place before you made the connection.

These tools should be able to give you a good start on collecting
information necessary for a chronology to use in a post-incident review.
Before you dive right into a post-incident review, we'd like to warn you
about some common traps. That's the subject of our next unit.
