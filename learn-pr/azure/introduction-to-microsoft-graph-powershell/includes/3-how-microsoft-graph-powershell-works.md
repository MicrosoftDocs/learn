Here, we'll discuss how Microsoft Graph PowerShell works. You'll learn how to install the module and the different commands that will help you find what you are looking for. This knowledge will help you decide if Microsoft Graph PowerShell is appropriate for your automation needs.

## Installation

To install **all** modules, run:

```powershell
Install-Module Microsoft.Graph
```

Installation may take up to 5 minutes and 1 GB of disk space.

To install specific modules - which takes less time and disk space, run:

```powershell
Find-Module Microsoft.Graph.Applications*, Microsoft.Graph.Directory*, Microsoft.Graph.Users*, Microsoft.Graph.Groups* | Install-Module
```

Optionally, specify **-Scopes** parameter to install for all users or the current user. For example,

```powershell
Install-Module Microsoft.Graph -Scope AllUsers
```

## Sign in Connect-MgGraph

 ```powershell
Connect-MgGraph -Scopes "Device.Read.All"
```

Microsoft Graph PowerShell permissions are NOT pre-authorized and you must perform one-time request for permissions depending on needs.

The **-Scopes** parameter is optional, only needed if you don't have consent. For example, if you don't have consent for **Device.Read.All** and you need it, specify it with the **-Scopes** parameter. Next time you use `Connect-MgGraph`, you don't need to specify any permission scopes.

Once you're signed in, you'll remain signed in until you invoke `Disconnect-MgGraph`. Microsoft Graph PowerShell automatically refreshes the access token for you and sign-in persists across PowerShell sessions because Microsoft Graph PowerShell securely caches the token.

Use `Disconnect-MgGraph` to sign-out if you have sign-in issues.

By default, `Connect-MgGraph` targets the global public cloud. To explicitly target other clouds, for example, US Government and Azure China, use the **-Environment** parameter. Use `Get-MgEnvironment` to list all the clouds you can choose from.

:::image type="content" source="../media/clouds.png" alt-text="Available clouds":::

To specify **Environment** with USGov - subsequent commands will target the USGov environment.

```powershell
Connect-MgGraph -Environment USGov
```

You can create custom environments using **Add-MgEnvironment**.

## Navigating Microsoft Graph PowerShell

The Microsoft Graph PowerShell SDK comes with a toolkit of cmdlets that helps you in navigating the SDK. Here, we'll cover a number of cmdlets that help you navigate the SDK.

### Using Find-MgGraphCommand

`Find-MgGraphCommand` aims to make it easy for you to discover which API path a command calls by providing a URI or a command name.

`Find-MgGraphCommand` allows to;

- Pass a Microsoft Graph URL (relative and absolute) and get an equivalent Microsoft Graph PowerShell command.
- Pass a command and get the URL it calls.
- Pass a command or URI wildcard (.*) to find all commands that match it.

To use the cmdlet, run;

```powershell
Find-MgGraphCommand -Uri <String[]> [-Method <String>] [-ApiVersion <String>] [<CommonParameters>]
```

For example,

```powershell
Find-MgGraphCommand -Uri '/devices'
```

```Output
  APIVersion: v1.0

Command      Module                       Method URI      OutputType            Permissions                                Variants
-------      ------                       ------ ---      ----------            -----------                                --------
Get-MgDevice Identity.DirectoryManagement GET    /devices IMicrosoftGraphDevice {Device.Read.All, Directory.ReadWrite.All} {List}
New-MgDevice Identity.DirectoryManagement POST   /devices IMicrosoftGraphDevice {Directory.AccessAsUser.All}               {Create, CreateExpanded}

   APIVersion: beta

Command      Module                       Method URI      OutputType             Permissions                                Variants
-------      ------                       ------ ---      ----------             -----------                                --------
Get-MgDevice Identity.DirectoryManagement GET    /devices IMicrosoftGraphDevice1 {Device.Read.All, Directory.ReadWrite.All} {List1}
New-MgDevice Identity.DirectoryManagement POST   /devices IMicrosoftGraphDevice1 {Directory.AccessAsUser.All}               {Create1, CreateExpanded1}
```

OR

```powershell
Find-MgGraphCommand -Command <String[]> [-ApiVersion <String>] [<CommonParameters>]
```

For example,

```powershell
Find-MgGraphCommand -Command 'Get-MgDevice'
```

```Output
APIVersion: v1.0

Command      Module                       Method URI                  OutputType            Permissions                                                    Variants
-------      ------                       ------ ---                  ----------            -----------                                                    --------
Get-MgDevice Identity.DirectoryManagement GET    /devices             IMicrosoftGraphDevice {Device.Read.All, Directory.ReadWrite.All}                     {List}
Get-MgDevice Identity.DirectoryManagement GET    /devices/{device-id} IMicrosoftGraphDevice {Device.Read.All, Directory.Read.All, Directory.ReadWrite.All} {Get, GetViaIdentity}

   APIVersion: beta

Command      Module                       Method URI                  OutputType             Permissions                                                    Variants
-------      ------                       ------ ---                  ----------             -----------                                                    --------
Get-MgDevice Identity.DirectoryManagement GET    /devices/{device-id} IMicrosoftGraphDevice1 {Device.Read.All, Directory.Read.All, Directory.ReadWrite.All} {Get1, GetViaIdentity1}
Get-MgDevice Identity.DirectoryManagement GET    /devices             IMicrosoftGraphDevice1 {Device.Read.All, Directory.ReadWrite.All}                     {List1}

```

### Using Find-MgGraphPermission

The Microsoft Graph PowerShell SDK application requires users to have domain knowledge of both the semantics and syntax of Microsoft Graph API permissions used to authorize access to the API.

`Find-MgGraphPermission` helps you find what permissions are applicable to a certain domain. You will use permissions to sign in to your application using the [Connect-MgGraph](#sign-in-connect-mggraph).

To find permissions related to a given domain, run;

```powershell
Find-MgGraphPermission device.read
```

```Output

Id                                   Consent Name            Description
--                                   ------- ----            -----------
11d4cd79-5ba5-460f-803f-e22c8ab85ccd User    Device.Read     Allows the app to see your list of devices.
951183d1-1a61-466f-a6d1-1fde911bfd95 Admin   Device.Read.All Allows the app to read your organization's devices' configuration information on behalf of the signed-in user.

   PermissionType: Application

Id                                   Consent Name                 Description
--                                   ------- ----                 -----------
7438b122-aefc-4978-80ed-43db9fcc7715 Admin   Device.Read.All      Allows the app to read your organization's devices' configuration information without a signed-in user.
1138cb37-bd11-4084-a2b7-9f71582aeddb Admin   Device.ReadWrite.All Allows the app to read and write all device properties without a signed in user.  Does not allow device creation, device deletion or update of device alternative security identifiers.
```

### Using Select-MgProfile

By default the Microsoft Graph PowerShell commands target the v1.0 API version. Commands for APIs that are only available in beta are not available in PowerShell by default. 

To check your current profile, run:

```powershell
Get-MgProfile
```

```Output
Name Description
---- -----------
v1.0 A snapshot of the Microsoft Graph v1.0 API for the Global cloud.
```

To change to the beta version, use `Select-MgProfile`.

```powershell
Select-MgProfile -Name Beta
```

To switch back to using v1.0 API commands, specify **v1.0** for the name parameter. 

## Using Invoke-MgGraphRequest

Invoke-MgGraphRequest issues REST API requests to Microsoft Graph API.

To get a list of all devices in the directory, run:

```powershell
$devices = (Invoke-MgGraphRequest -Method GET https://graph.microsoft.com/v1.0/devices).Value
```

This command works for any Graph API, if you know the REST URI, method and optional body parameter.

If you get stuck executing or finding the right Microsoft Graph PowerShell command,user `Invoke-MgGraphCommand`.

## Common parameters

|Parameter|Description|
|:----|:----|
|All|Return all results|
|ConsistencyLevel|Eventual or Session consistency|
|CountVariable|PS variable in which to return result count|
|Filter|OData filter to apply to the request|
|ExpandProperty|Expands a relationship property in a result|
|PageSize|Override the API default page size|
|Property|Project only the specified properties|
|Search|Perform content / “smart” search|
|Skip|Return results after skipping first N results|
|Sort|Server-side sort of results on a property|
|Top|Limit the result count to N items|

### Advanced queries

Azure AD commands support advanced queries via the **ConsistencyLevel** parameter. This adds the ConsistencyLevel header to the Graph API request.

Use this parameter with *Filter* to specify advanced queries. For example,

```powershell
$dt = (Get-Date).AddDays(-90)
Get-MgDevice | Where {$_.ApproximateLastSignInDateTime -le $dt} 
```

Use it with *Search* to restrict the results of a request to match a search criterion. For example, to find every device with `My_PC` in the displayName, run;

```powershell
Get-MgDevice -ConsistencyLevel eventual  -Search '"DisplayName:Desktop"'
```

```Output
Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime 
--------------- --                                   -------------- ----------------------------- -------------
40a0f030-1f82-42c3-8032-66c2baedef7c True           4/16/2019 9:09:25 PM                                      
65f85070-5b3c-4bb7-b306-8383672a6c7d True           2/15/2022 10:09:22 AM                                    
add714d9-fd8e-4238-9db7-5e3f2c14228c True           6/3/2019 3:14:39 PM                                      
e43ccd95-c8b6-4ef4-acea-0d3e646ca74b True           11/24/2020 6:57:31 PM
