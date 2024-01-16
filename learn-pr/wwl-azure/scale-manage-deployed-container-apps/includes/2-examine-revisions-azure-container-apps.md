Container Apps revisions help you manage the release of updates to your container app by creating a new revision each time you make a revision-scope change to your app. You can control which revisions are active, and the external traffic that is routed to each active revision.

You can use revisions to:

- Release a new version of your app.
- Quickly revert to an earlier version of your app.
- Split traffic between revisions for A/B testing.
- Gradually phase in a new revision in blue-green deployments.

## Revision modes

The revision mode controls whether only a single revision or multiple revisions of your container app can be simultaneously active. You can set your app's revision mode from your container app's Revision management page in the Azure portal, using Azure CLI commands, or in the Azure Resource Manager template.

### Revision mode: single

By default, a container app is in single revision mode. In this mode, when a new revision is created, the latest revision replaces the active revision.

### Revision mode: multiple

You can also set the revision mode to `Multiple`. The `Multiple` revision mode enables you to run multiple revisions of your app simultaneously. While in this mode, new revisions are activated alongside current active revisions.

For apps that implement external HTTP ingress, you can control the percentage of traffic that goes to each active revision. Configure traffic control from your container app's Revision management page in the Azure portal, using Azure CLI commands, or in an Azure Resource Manager template.

## Revision label and suffix

In Container Apps, you have the flexibility to customize the revision name and labels to align with your naming conventions or versioning strategy. This customization allows you to create revision names that are more meaningful for your applications.

### Revision label

For container apps with external HTTP traffic, labels are a portable means to direct traffic to specific revisions. A label provides a unique URL that you can use to route traffic to the revision that the label is assigned. To switch traffic between revisions, you can move the label from one revision to another.

- Labels keep the same URL when moved from one revision to another.
- A label can be applied to only one revision at a time.
- Allocation for traffic splitting isn't required for revisions with labels.
- Labels are most useful when the revision mode is set to `Multiple`.
- You can enable labels, traffic splitting or both.

Labels are useful for testing new revisions. For example, when you want to give access to a set of test users, you can give them the label's URL. Then when you want to move your users to a different revision, you can move the label to that revision.

Labels work independently of traffic splitting. Traffic splitting distributes traffic going to the container app's application URL to revisions based on the percentage of traffic. When traffic is directed to a label's URL, the traffic is routed to one specific revision.

A label name must:

- consist of lower case alphanumeric characters or dashes ('-')
- start with an alphabetic character
- end with an alphanumeric character
- not have two consecutive dashes (--)
- not be more than 64 characters

### Revision name suffix

Each revision in Container Apps is automatically assigned a unique identifier, but you can personalize the revision name by customizing the revision suffix. The typical format for a revision name is:

`<CONTAINER_APP_NAME>-<REVISION_SUFFIX>`

For example, if you have a container app named "album-api" and decide to set the revision suffix as "first-revision," the complete revision name becomes "album-api--first-revision."

When choosing a revision suffix name, keep in mind the following guidelines:

- It should consist of only lower case alphanumeric characters or dashes (-).
- It must start with an alphabetic character.
- It should end with an alphanumeric character.

Your custom revision suffix name should not:

- Have two consecutive dashes (--).
- Be more than 64 characters in length.

You can set the revision suffix in several ways:

- Directly in the Azure Resource Manager template.
- Through the Azure CLI using commands like `az containerapp create` and `az containerapp update`.
- When creating a revision via the Azure portal.

Customizing revision names allows you to create clear and structured names for your revisions, making it easier to manage and identify different versions of your container apps.
