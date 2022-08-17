Many tools  are available for automation and for interaction with the Graph APIs. Here, we'll discuss how you can evaluate whether Microsoft Graph PowerShell is the right choice for your workflow.

## Decision criteria

Microsoft Graph PowerShell exposes the entire set of Microsoft Graph APIs for use in PowerShell. The cases where Microsoft Graph PowerShell might be the best option involve automation of repetitive business processes, handling complex functions, manipulation of data in the Microsoft 365 tenants and integration between different Microsoft Service like Outlook, SharePoint and Teams.

Here's some discussion of each of these factors.

### Managing identities at scale

Microsoft Graph PowerShell can be used when you want to connect, retrieve, update, and delete data from productivity APIs at Microsoft, for example files, drive, calendar and you don't want to have an application for it.

Since Microsoft Graph PowerShell access all the Graph APIs, it allows to automate these process for any resource that has an API.

### Automating tasks to save time

IT admins and DevOps professionals can automate the generation of reports and the management of systems, users and tenants by creating a script instead of building an application for some scenarios. PowerShell provides a richer admin experience that can lead to automation.

### Run complex functions

Microsoft Graph PowerShell allows you to carry out tasks that are not necessarily available from the portal UI. The Azure portal UI provides access to common, useful administrative tasks that apply to most environments. However, to carry out more complex tasks you would need to use Microsoft Graph PowerShell.

For example, for our scenario, to get all the stales devices, we'll need to use the timestamp filter and to also filter out system-managed devices. Microsoft Graph PowerShell will enable you to get the filtered list and save the returned data in a csv file.

```PowerShell
Get-MgDevice | Where {$_.ApproximateLastSignInDateTime -ge $dt}| export-csv stale-devices.csv
```

### Support for modern authentication

Microsoft Graph PowerShell supports modern authetication, for example, the use of Multifactor Athentication via the Microsoft Authentication Library. You can use Passwordless sign-in experiences for your applications.
