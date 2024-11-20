<!--Manage sensitive data and security policies in GitHub-->

Sometimes you need more details about actions performed in your organization, like who performed the action, when, and how. You might also need to check who deleted a repository, or when a workflow ran. These pieces of information can be helpful in situations where something went wrong in your organization after a specific event.

Here you'll learn what your organization's audit log records, and how to access and export it.

## What are log records?

Your organization's log records actions taken by organization members. The log is available to organization owners, and records information about actions that affect the organization including:

- The repository in which the action was performed.
- The user that performed the action.
- The action that was performed.
- Which country/region in which the action took place.
- The date and time of the action.

You can access the audit log through GitHub.com, GitHub Enterprise Server, or GitHub AE to review actions from the past 90 days. However, interacting with the audit log using either the GraphQL API or the Rest API can allow easy retrieval of specific information types, with other limitations.

## The GraphQL API

The GraphQL API is available for organizations using GitHub Enterprise, and can retrieve information about actions up to 120 days old. It can monitor:

- Access to your organization or repository settings.
- Changes in permissions.
- Added or removed users in an organization, repository, or team.
- Users being promoted to admin.
- Changes to permissions of a GitHub App.

It can't provide information about Git events.

## The Rest API

The Rest API is available for organizations that use GitHub Enterprise Cloud, and can retrieve information about actions up to 90 days old. It can monitor the same actions as the GraphQL API, as well as Git events. However, information about Git events only remains in the log for seven days.

## Generate reports for auditing

For compliance and record-keeping purposes, you should export your audit logs in a common format. This is a simple process that you can complete by accessing the **Audit log** from the **Settings** sidebar in **Your organizations** and choosing the **Export** drop-down menu.

:::image type="content" source="../media/org-audit-log.png" alt-text="Screenshot of the GitHub interface for exporting an organization's audit log, with the Filters field and the Export drop-down.":::

If you want to export an audit log that focuses on specific events, like those enacted by one user or that happened on a given day, you can filter the audit log results by adding a qualifier and accompanying value to the **Filters** field next to the **Export** drop-down menu.

| Qualifier | Example value          |
| :-------- | :--------------------- |
| `action`  | team.create            |
| `actor`   | octocat                |
| `user`    | codertocat             |
| `org`     | octo-org               |
| `repo`    | octo-org/documentation |
| `created` | 2019-06-01             |
