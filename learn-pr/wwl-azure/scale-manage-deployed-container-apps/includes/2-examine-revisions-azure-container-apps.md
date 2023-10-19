Container Apps revisions help you manage the release of updates to your container app by creating a new revision each time you make a revision-scope change to your app. You can control which revisions are active, and the external traffic that is routed to each active revision.

You can use revisions to:

- Release a new version of your app.
- Quickly revert to an earlier version of your app.
- Split traffic between revisions for A/B testing.
- Gradually phase in a new revision in blue-green deployments.

## Revision modes

The revision mode controls whether only a single revision or multiple revisions of your container app can be simultaneously active. You can set your app's revision mode from your container app's Revision management page in the Azure portal, using Azure CLI commands, or in the ARM template.

### Single revision mode

By default, a container app is in single revision mode. In this mode, when a new revision is created, the latest revision replaces the active revision.

### Multiple revision mode

You can also set the revision mode to `Multiple`. The `Multiple` revision mode enables you to run multiple revisions of your app simultaneously. While in this mode, new revisions are activated alongside current active revisions.

For apps that implement external HTTP ingress, you can control the percentage of traffic that goes to each active revision. Configure traffic control from your container app's Revision management page in the Azure portal, using Azure CLI commands, or in an ARM template.

## Revision Labels

For container apps with external HTTP traffic, labels are a portable means to direct traffic to specific revisions. A label provides a unique URL that you can use to route traffic to the revision that the label is assigned. To switch traffic between revisions, you can move the label from one revision to another.

- Labels keep the same URL when moved from one revision to another.
- A label can be applied to only one revision at a time.
- Allocation for traffic splitting isn't required for revisions with labels.
- Labels are most useful when the revision mode is set to `Multiple`.
- You can enable labels, traffic splitting or both.
- Labels are useful for testing new revisions. For example, when you want to give access to a set of test users, you can give them the label's URL. Then when you want to move your users to a different revision, you can move the label to that revision.

Labels work independently of traffic splitting. Traffic splitting distributes traffic going to the container app's application URL to revisions based on the percentage of traffic. When traffic is directed to a label's URL, the traffic is routed to one specific revision.

A label name must:

- consist of lower case alphanumeric characters or dashes ('-')
- start with an alphabetic character
- end with an alphanumeric character
- not have two consecutive dashes (--)
- not be more than 64 characters
