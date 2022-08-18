Many tools  are available for automation and for interaction with the Graph APIs. Here, we'll discuss how you can evaluate whether Microsoft Graph PowerShell is the right choice for your workflow.

## Decision criteria

Microsoft Graph PowerShell exposes the entire set of Microsoft Graph APIs for use in PowerShell. The cases where Microsoft Graph PowerShell might be the best option involve automation of repetitive business processes, handling complex functions, manipulation of data in the Microsoft 365 tenants and integration between different Microsoft services like Outlook, SharePoint and Teams.

Here's some discussion of each of these factors.

### Managing identities at scale

Microsoft Graph PowerShell can be used when you want to connect, retrieve, update, and delete data from productivity APIs at Microsoft, for example files, drive, calendar and you don't want to have an application for it.

Since Microsoft Graph PowerShell provides access to all the Graph APIs, it allows to automate these processes for any resource that has an API.

### Automating tasks to save time

IT admins and DevOps professionals can automate the generation of reports and the management of systems, users and tenants by creating a script instead of building an application for some scenarios. PowerShell provides a richer admin experience that can lead to automation.

### Run complex functions

Microsoft Graph PowerShell allows you to carry out tasks that are not necessarily available from the portal UI. The Azure portal UI provides access to common, useful administrative tasks that apply to most environments. However, to carry out more complex tasks you would need to use Microsoft Graph PowerShell.

For the example scenario, we were able to filter all stales devices using a function. This function can be used everyone you want to manage your devices.

### Support for modern authentication

Microsoft Graph PowerShell uses the Microsoft Authentication Library and supports modern authentication. This provides the latest authentication options, for example, Multi-Factor Athentication (MFA), Conditional Access and PasswordLess sign in experiences.
