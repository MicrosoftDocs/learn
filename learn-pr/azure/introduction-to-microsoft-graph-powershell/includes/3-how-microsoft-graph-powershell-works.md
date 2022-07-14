Here, we'll discuss how Microsoft Graph PowerShell works behind the scenes. We'll learn how to install the module and different commands that will help you find what you are looking for. This knowledge will help you decide if Microsoft Graph PowerShell is appropriate for your automation needs.

## Installation

To install **all** modules, run;

```powershell
Install-Module Microsoft.Graph
```

This may take up to 5 minutes and 1 GB of disk space.

To install specific modules - which takes less time and disk space, run;

```powershell
Find-Module Microsoft.Graph.Applications*, Microsoft.Graph.Directory*, Microsoft.Graph.Users*, Microsoft.Graph.Groups* | Install-Module
```

Optionally, specify -Scope parameter to install for all users or just the current user. For example,

```powershell
Install-Module Microsoft.Graph -Scope AllUsers
```

## Sign in Connect-MgGraph

Connect-MgGraph must be invoked before any commands that access Microsoft Graph.

```powershell
Connect-MgGraph -Scopes "Device.Read.All"
```

The **-Scopes** parameter is optional, only needed if you don't already have consent. For example, if you don't have consent for **User.Read** and you need it, specify it with **Scopes**. Next time you use Connect-MgGraph, you don't need to specify any permission scopes.

Once you're signed-in, you will remain signed-in until you invoke **Disconnect-MgGraph. Microsoft Graph PowerShell automatically refreshes the access token for you and sign-in persists across PowerShell sessions because Microsoft Graph PowerShell securely caches the token.

Use **Disconnect-MgGraph** to sign-out if you have sign-in issues.

Use **Connect-MgGraph** Command to explicitly target US Government, China or public clouds. The **-Environment** parameter default to the global public cloud. **Get-MgEnvironment** shows the list of all clouds you can choose from.

:::image type="content" source="../media/clouds.png" alt-text="Available clouds":::

To specify **Environment** with USGov - subsequest commands will target the USGov environment.

```powershell
Connect-MgGraph -Environment USGov
```

You can create custom environments using **Add-MgEnvironment**.

## Using Invoke-MgGraphRequest

Invoke-MgGraphRequest issue REST API requests to the Graph API.

```powershell
Invoke-MgGraphRequest -Method GET https://graph.microsoft.com/v1.0/devices
```

This command works for any Graph API, if you know the REST URI, method and optional body parameter.

- The URI can be any valid Graph URI
- You can include ODATA queries, for example $Select, $Filter
- Specify **OutputType** to get JSON, PSObject, HTTPResponseMessage instead of the default HashTable
- This command does not support paging. Read the **@nextlink** property from the reponse and iterate through it yourself.

## Common parameters

|Parameter|Description|Notes|
|:----|:----|:----|
|All|Return all results|Override API paging|
|ConsistencyLevel|Eventual or Session consistency|Eventual == AAD advanced queries|
|CountVariable|PS variable in which to return result count| |
|Filter|OData filter to apply to the request|Equivalent of OData $filter|
|ExpandProperty|Expands a relationship property in a result|Equivalent of OData $expand|
|PageSize|Override the API default page size|AAD default is 100|
|Property|Project only the specified properties|Equivalent of OData $select|
|Search|Perform content / “smart” search|For AAD requires Eventual consistency|
|Skip|Return results after skipping first N results|Equivalent of Odata $skip|
|Sort|Server-side sort of results on a property|Equivalent of OData $sort|
|Top|Limit the result count to N items|Equivalent of OData $top|

MS Graph PowerShell permissions are NOT pre-authorized and user must perform one-time request for app permissions depending on needs.

### Advanced queries

Azure AD commands support advanced queries via the **ConsistencyLevel** parameter. This adds the ConsistencyLevel header to the Graph API request. 

Use this parameter with *Filter* to specify advanced queries. For example,

```powershell
$dt = (Get-Date).AddDays(-90)
Get-MgDevice | Where {$_.ApproximateLastLogonTimeStamp -le $dt} 
```

Use it with *Search* to restrict the results of a request to match a search criterion. For example, to find every device with `My_PC` in the displayName, run;

```powershell
Get-MgDevice -ConsistencyLevel eventual  -Search '"DisplayName:My_PC"'
```

### Using Select-MgProfile

By default the Microsoft Graph PowerShell commands target the V1.0 API version. Commands for APIs that are only avaialble in beta are not available in PowerShell by default. To change to the beta version, use **Select-MgProfile**.

```powershell
Select-MgProfile -Name Beta
```

To switch back to using v1.0 API commands, specify **v1.0** for the name parameter. Use **Get-MgProfile** for check your current profile.
