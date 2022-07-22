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

Optionally, specify **-Scope** parameter to install for all users or just the current user. For example,

```powershell
Install-Module Microsoft.Graph -Scope AllUsers
```

## Sign in Connect-MgGraph

 ```powershell
Connect-MgGraph -Scopes "Device.Read.All"
```

The **-Scopes** parameter is optional, only needed if you don't already have consent. For example, if you don't have consent for **User.Read** and you need it, specify it with **Scopes**. Next time you use Connect-MgGraph, you don't need to specify any permission scopes.

Once you're signed in, you will remain signed in until you invoke **Disconnect-MgGraph**. Microsoft Graph PowerShell automatically refreshes the access token for you and sign-in persists across PowerShell sessions because Microsoft Graph PowerShell securely caches the token.

Use **Disconnect-MgGraph** to sign out if you have sign-in issues.

Use **Connect-MgGraph** command to explicitly target US Government, China or public clouds. The **-Environment** parameter default to the global public cloud. **Get-MgEnvironment** shows the list of all clouds you can choose from.

:::image type="content" source="../media/clouds.png" alt-text="Available clouds":::

To specify **Environment** with USGov - subsequent commands will target the USGov environment.

```powershell
Connect-MgGraph -Environment USGov
```

You can create custom environments using **Add-MgEnvironment**.

## Navigating Microsoft Graph PowerShell

The Microsoft Graph PowerShell SDK comes with a toolkit of cmdlets that help you in navigating and learning it. Here, we'll cover a number of cmdlets that help you navigate the SDK.

## Using Invoke-MgGraphRequest

Invoke-MgGraphRequest issues REST API requests to the Graph API.

```powershell
Invoke-MgGraphRequest -Method GET https://graph.microsoft.com/v1.0/devices
```

This command works for any Graph API, if you know the REST URI, method and optional body parameter.

- The URI can be any valid Graph URI
- You can include ODATA queries, for example $Select, $Filter
- Specify **OutputType** to get JSON, PSObject, HTTPResponseMessage instead of the default HashTable
- This command does not support paging. Read the **@nextlink** property from the reponse and iterate through it yourself.

### Using Select-MgProfile

By default the Microsoft Graph PowerShell commands target the v1.0 API version. Commands for APIs that are only available in beta are not available in PowerShell by default. To change to the beta version, use **Select-MgProfile**.

```powershell
Select-MgProfile -Name Beta
```

To switch back to using v1.0 API commands, specify **v1.0** for the name parameter. Use **Get-MgProfile** for check your current profile.

### Using Find-MgGraphCommand

Find-MgGraphCommand enables you to discover which API path a command calls by providing a URI or a command name.

The Find-MgGraphCommand allows to;

- Pass a Microsoft Graph URL (relative and absolute) and get an equivalent Microsoft Graph PowerShell command.
- Pass a command and get the URL it calls.
- Pass a command or URI wildcard (.*) to find all commands that match it.

To use the cmdlet, run;

```powershell
Find-MgGraphCommand -Uri <String[]> [-Method <String>] [-ApiVersion <String>] [<CommonParameters>]
```

For example,

```powershell
Find-MgGraphCommand -Uri '/users/{id}'
```

```Output
APIVersion: v1.0

Command       Module Method URI              OutputType          Permissions                                                                                                                                                   Variants
-------       ------ ------ ---              ----------          -----------                                                                                                                                                   --------
Get-MgUser    Users  GET    /users/{user-id} IMicrosoftGraphUser {DeviceManagementApps.Read.All, DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All...} {Get1, GetViaIdentity1}
Remove-MgUser Users  DELETE /users/{user-id}                     {DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.ReadWrite.All, DeviceManagementServiceConfig.ReadWrite.All, User.ReadWrite.All}           {Delete, DeleteViaIdentity}
Update-MgUser Users  PATCH  /users/{user-id}                     {DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.ReadWrite.All, DeviceManagementServiceConfig.ReadWrite.All, Directory.ReadWrite.All...}   {Update, UpdateExpanded, UpdateViaIdentity, UpdateViaIdentityExpanded}


   APIVersion: beta

Command       Module Method URI              OutputType           Permissions                                                                                                                                                   Variants
-------       ------ ------ ---              ----------           -----------                                                                                                                                                   --------
Get-MgUser    Users  GET    /users/{user-id} IMicrosoftGraphUser1 {DeviceManagementApps.Read.All, DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All...} {Get, GetViaIdentity}
Remove-MgUser Users  DELETE /users/{user-id}                      {DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.ReadWrite.All, DeviceManagementServiceConfig.ReadWrite.All, User.ReadWrite.All}           {Delete1, DeleteViaIdentity1}
Update-MgUser Users  PATCH  /users/{user-id}                      {DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.ReadWrite.All, DeviceManagementServiceConfig.ReadWrite.All, Directory.ReadWrite.All...}   {Update1, UpdateExpanded1, UpdateViaIdentity1, UpdateViaIdentityExpanded1}

```

OR

```powershell
Find-MgGraphCommand -Command <String[]> [-ApiVersion <String>] [<CommonParameters>]
```

For example,

```powershell
Find-MgGraphCommand -Command 'Get-MgUser'
```

```Output
  APIVersion: v1.0

Command    Module Method URI              OutputType          Permissions                                                                                                                                                   Variants
-------    ------ ------ ---              ----------          -----------                                                                                                                                                   --------
Get-MgUser Users  GET    /users           IMicrosoftGraphUser {DeviceManagementApps.Read.All, DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All...} {List1}
Get-MgUser Users  GET    /users/{user-id} IMicrosoftGraphUser {DeviceManagementApps.Read.All, DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All...} {Get1, GetViaIdentity1}


   APIVersion: beta

Command    Module Method URI              OutputType           Permissions                                                                                                                                                   Variants
-------    ------ ------ ---              ----------           -----------                                                                                                                                                   --------
Get-MgUser Users  GET    /users/{user-id} IMicrosoftGraphUser1 {DeviceManagementApps.Read.All, DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All...} {Get, GetViaIdentity}
Get-MgUser Users  GET    /users           IMicrosoftGraphUser1 {DeviceManagementApps.Read.All, DeviceManagementApps.ReadWrite.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All...} {List}

```

### Using Find-MgGraphPermission

The Microsoft Graph PowerShell SDK application requires users to have domain knowledge of both the semantics and syntax of Microsoft Graph API permissions used to authorize access to the API. 

Find-MgGraphPermission helps you find what permissions are applicable to a certain domain. You will use these permissions to sign in to your application using the [Connect-MgGraph](#sign-in-connect-mggraph).

To find permissions related to a given domain, run;

```powershell
Find-MgGraphPermission application
```

```Output

   PermissionType: Delegated

Id                                   Consent Name                                      Description
--                                   ------- ----                                      -----------
c79f8feb-a9db-4090-85f9-90d820caa0eb Admin   Application.Read.All                      Allows the app to read applications and service principals on behalf of the signed-in user.
bdfbf15f-ee85-4955-8675-146e8e5296b5 Admin   Application.ReadWrite.All                 Allows the app to create, read, update and delete applications and service principals on behalf of the signed-in user. Does not allow management of consent grants.
b27add92-efb2-4f16-84f5-8108ba77985c Admin   Policy.ReadWrite.ApplicationConfiguration Allows the app to read and write your organization's application configuration policies on behalf of the signed-in user.  This includes policies such as activityBasedTimeoutPolicy, claimsMappingPolicy, homeRealmDiscoveryPolicy,  tokenIssuancePolicy and tokenLifetimePolicy.


   PermissionType: Application

Id                                   Consent Name                                      Description
--                                   ------- ----                                      -----------
9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30 Admin   Application.Read.All                      Allows the app to read all applications and service principals without a signed-in user.
1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9 Admin   Application.ReadWrite.All                 Allows the app to create, read, update and delete applications and service principals without a signed-in user.  Does not allow management of consent grants.
18a4783c-866b-4cc7-a460-3d5e5662c884 Admin   Application.ReadWrite.OwnedBy             Allows the app to create other applications, and fully manage those applications (read, update, update application secrets and delete), without a signed-in user.  It cannot update any apps that it is not an owner of.
be74164b-cff1-491c-8741-e671cb536e13 Admin   Policy.ReadWrite.ApplicationConfiguration Allows the app to read and write your organization's application configuration policies, without a signed-in user.  This includes policies such as activityBasedTimeoutPolicy, claimsMappingPolicy, homeRealmDiscoveryPolicy, tokenIssuancePolicy  and tokenLifetimePolicy.
```

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
