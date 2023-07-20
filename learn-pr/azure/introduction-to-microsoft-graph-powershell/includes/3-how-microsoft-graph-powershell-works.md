In this unit, we'll discuss how Microsoft Graph PowerShell works. You'll learn how to install the module and the different commands that will help you find what you are looking for. This knowledge will help you decide if Microsoft Graph PowerShell is appropriate for your automation needs.

## Installation

The Microsoft Graph PowerShell SDK is published on the PowerShell Gallery.

PowerShell 7 and later is the recommended PowerShell version for use with the Microsoft Graph PowerShell SDK on all platforms. There are no additional prerequisites to use the SDK with PowerShell 7 or later. Microsoft Graph PowerShell is also compatible with Windows PowerShell 5.1 or later.

The Microsoft Graph PowerShell SDK comes in 2 modules, **Microsoft.Graph** and **Microsoft.Graph.Beta**, that you will install separately. These modules call the Microsoft Graph v1.0 and Microsoft Graph beta endpoints, respectively. You can install the 2 modules on the same PowerShell version.

> [!NOTE]
> Installing the main module of the SDK, Microsoft.Graph, will install all the 38 sub modules. Consider installing only the necessary modules, including `Microsoft.Graph.Authentication`, which is installed by default when you opt to install the sub modules individually. For a list of available Microsoft Graph modules, use `Find-Module Microsoft.Graph*`.
> Only cmdlets for the installed modules will be available for use.

To install the v1 module, run:

```powershell
Install-Module Microsoft.Graph
```

To install the beta module, run:

```powershell
Install-Module Microsoft.Graph.Beta
```

>[!NOTE]
> Commands for APIs in the beta endpoint are subject to change. We don't recommend that you use them in your production apps.

## Sign in Connect-MgGraph

Microsoft Graph PowerShell supports two types of authentication: **delegated** and **app-only** access.

Microsoft Graph PowerShell permissions are NOT pre-authorized and you must perform one-time request for permissions depending on your needs.

In delegated access, the **-Scopes** parameter is optional, only needed if you don't have consent. For example, if you don't have consent for **User.Read.All** and you need it, specify it with the **-Scopes** parameter. Next time you use `Connect-MgGraph`, you won't need to specify the **User.Read.All** scope.

```powershell
Connect-MgGraph -Scopes "User.Read.All"
```

Once you're signed in, you'll remain signed in until you invoke `Disconnect-MgGraph`. Microsoft Graph PowerShell automatically refreshes the access token for you and sign-in persists across PowerShell sessions because Microsoft Graph PowerShell securely caches the token.

App-only access grants permissions directly to an application, and requires admin consent to the required permissions.

## Navigating Microsoft Graph PowerShell

The Microsoft Graph PowerShell SDK comes with a toolkit of cmdlets that helps you navigate the SDK. In the following section, we'll cover various cmdlets that help you navigate the SDK.

### Using Find-MgGraphCommand

`Find-MgGraphCommand` shows you which API path a command calls by providing a URI or a command name.

`Find-MgGraphCommand` allows you to;

- Pass a Microsoft Graph URL (relative and absolute) and get an equivalent Microsoft Graph PowerShell command.
- Pass a command and get the URL it calls.
- Pass a command or URI wildcard (.*) to find all commands that match it.

To use the cmdlet, run;

```powershell
Find-MgGraphCommand -Uri <String[]> [-Method <String>] [-ApiVersion <String>] [<CommonParameters>]
```

For example,

```powershell
Find-MgGraphCommand -Uri '/users'
```

OR

```powershell
Find-MgGraphCommand -Command <String[]> [-ApiVersion <String>] [<CommonParameters>]
```

For example,

```powershell
Find-MgGraphCommand -Command 'Get-MgUser'
```

### Using Find-MgGraphPermission

The Microsoft Graph PowerShell SDK application requires users to have domain knowledge of both the semantics and syntax of Microsoft Graph API permissions used to authorize access to the API.

`Find-MgGraphPermission` helps you find what permissions are applicable to a certain domain. You'll use permissions to sign in to your application using the [Connect-MgGraph](#sign-in-connect-mggraph).

To find permissions related to a given domain, run;

```powershell
Find-MgGraphPermission user.read
```

## Common query parameters

Microsoft Graph PowerShell SDK supports optional query parameters that you can use to control the amount of data returned in an output. Support for the exact query parameters varies from one cmdlet to another, and can differ between the v1.0 and beta endpoints. Microsoft Graph PowerShell cmdlets support one or more of the following OData system query options, which are only supported in the **GET** operations.

|Name|Description|Example|
|--------|----|-----|
| -Count |Retrieves the total count of matching resources|`Get-MgUser -ConsistencyLevel eventual -Count count`<br>`$count`|
| -Expand | Retrieves related resources|<code>Get-MgGroup -GroupId '0e06b38f-931a-47db-9a9a-60ab5f492005' -Expand members &#124; Select -ExpandProperty members</code>|
| -Filter | Filters results (rows)|`Get-MgUser -Filter "startsWith(DisplayName, 'Conf')"`|
| -OrderBy | Orders results|`Get-MgUser -OrderBy DisplayName`|
|-Search | Returns results based on search criteria|`Get-MgUser -ConsistencyLevel eventual -Search '"DisplayName:Conf"'`|
|-Select | Filters properties (columns)|<code>Get-MgUser &#124; Select DisplayName, Id</code>|
| -Top | Sets the page size of results. |`Get-MgUser -Top 10`|

## Advanced queries

Azure AD commands support advanced queries via the **ConsistencyLevel** parameter. These queries add the **-ConsistencyLevel** header to the Graph API request.

To get a count of all the devices in your tenant, you'll need to run the command using advanced queries.

```powershell
Get-MgUser -Count userCount -ConsistencyLevel eventual
```

`$userCount` will contain the count of your users.

### Using Invoke-MgGraphRequest

`Invoke-MgGraphRequest` issues REST API requests to Microsoft Graph API.

To get a list of all users in the directory using the API URI, run:

```powershell
$users = (Invoke-MgGraphRequest -Method GET https://graph.microsoft.com/v1.0/users).value
```

This command works for any Graph API if you know the REST URI, method, and optional body parameter. It can be useful for accessing an API for which there isn’t an equivalent cmdlet yet.

If you get stuck executing or finding the right Microsoft Graph PowerShell command, use `Invoke-MgGraphRequest`.

Although you can manage users in the Azure portal, it's more efficient to handle the process using PowerShell.
