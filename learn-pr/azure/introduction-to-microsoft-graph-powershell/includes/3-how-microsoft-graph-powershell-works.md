Here, we'll discuss how Microsoft Graph PowerShell works. You'll learn how to install the module and the different commands that will help you find what you are looking for. This knowledge will help you decide if Microsoft Graph PowerShell is appropriate for your automation needs.

## Installation

The Microsoft Graph PowerShell SDK is published on the [PowerShell Gallery](https://www.powershellgallery.com/packages/Microsoft.Graph/1.11.0)

PowerShell 7 and later is the recommended PowerShell version for use with the Microsoft Graph PowerShell SDK on all platforms. There are no additional prerequisites to use the SDK with PowerShell 7 or later. 

The following prerequisites are required to use the Microsoft Graph PowerShell SDK with Windows PowerShell.

- Upgrade to [PowerShell 5.1 or later](/powershell/scripting/windows-powershell/install/installing-windows-powershell#upgrading-existing-windows-powershell)
- Install [.NET Framework 4.7.2 or later](/dotnet/framework/install/)
- Update **PowerShellGet** to the latest version using `Install-Module PowerShellGet -Force`
- The PowerShell script execution policy must be set to `remote signed` or `less restrictive`. Use `Get-ExecutionPolicy` to determine the current execution policy. For more information, see [about_Execution_Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).
To set the execution policy, run;

    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```

> [!NOTE]
> Installing the main module of the SDK, Microsoft.Graph, will install all 38 sub modules. Consider only installing the necessary modules, including `Microsoft.Graph.Authentication` which is installed by default when you opt to install the sub modules individually. For a list of available Microsoft Graph modules, use `Find-Module Microsoft.Graph*`.
> Only cmdlets for the installed modules will be available for use.

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

To change your environment to **USGov** run the following command. Subsequent commands will target the USGov environment.

```powershell
Connect-MgGraph -Environment USGov
```

## Navigating Microsoft Graph PowerShell

The Microsoft Graph PowerShell SDK comes with a toolkit of cmdlets that helps you navigate the SDK. Here, we'll cover a number of cmdlets that help you navigate the SDK.

### Using Find-MgGraphCommand

`Find-MgGraphCommand` aims to make it easy for you to discover which API path a command calls by providing a URI or a command name.

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

To get a list of all devices in the directory using the API URI, run:

```powershell
$devices = (Invoke-MgGraphRequest -Method GET https://graph.microsoft.com/v1.0/devices).Value
```

This command works for any Graph API, if you know the REST URI, method and optional body parameter. It can be useful for accessing an API for which there isn’t an equivalent cmdlet yet.

If you get stuck executing or finding the right Microsoft Graph PowerShell command, use `Invoke-MgGraphCommand`.

## Common query parameters

Microsoft Graph PowerShell SDK supports optional query parameters that you can use to control the amount of data returned in an output. Support for the exact query parameters varies from one cmdlet to another, and depending on the profile, can differ between the v1.0 and beta endpoints. Microsoft Graph PowerShell cmdlets support one or more of the following OData system query options, which are only supported in the **GET** operations.

|Name|Description|Example|
|--------|----|-----|
| -Count |Retrieves the total count of matching resources|`Get-MgUser -ConsistencyLevel eventual -Count count`<br>`$count`|
| -Expand | Retrieves related resources|`Get-MgGroup -GroupId '0e06b38f-931a-47db-9a9a-60ab5f492005' -Expand members \| Select -ExpandProperty members`|
| -Filter | Filters results (rows)|`Get-MgUser -Filter "startsWith(DisplayName, 'Conf')"`|
| -OrderBy | Orders results|`Get-MgUser -OrderBy DisplayName`|
|-Search | Returns results based on search criteria|`Get-MgUser -ConsistencyLevel eventual -Search '"DisplayName:Conf"'`|
|-Select | Filters properties (columns)|`Get-MgUser \| Select DisplayName, Id`|
| -Top | Sets the page size of results. |`Get-MgUser -Top 10`|

### Advanced queries

Azure AD commands support advanced queries via the **ConsistencyLevel** parameter. This adds the ConsistencyLevel header to the Graph API request.

To get a count of all the devices in your tenant, you'll need to run the command using advanced queries.

```powershell
Get-MgDevice -Count deviceCount -ConsistencyLevel eventual
```

`$deviceCount` will contain the count of your devices.

To clean up stale devices, you'll need to define a timeframe that is your indicator for stale devices. When defining your timeframe, factor the window noted for updating the activity timestamp into your value. For example, you shouldn't consider a timestamp that is younger than 21 days as an indicator for a stale device. There are scenarios that can make a device look like stale while it isn't. For example, the owner of the affected device can be on vacation or on a sick leave that exceeds your timeframe for stale devices.

While you can clean up stales devices in the Azure portal, it's more efficient to handle the process using PowerShell. Using Microsoft Graph PowerShell, we'll use the timestamp filter and filter out system-managed devices.

A typical routine consists of the following steps:

1. Connect to Azure AD using `Connect-MgGraph` cmdlet
1. Get a list of the stale devices
1. Disable the device using the `Update-MgDevice` cmdlet (disable by using **-AccountEnabled** option).
1. Wait for the grace period of however many days you choose before deleting the device. For this module, we'll use 30 days wait period.
1. Remove the device using the `Remove-MgDevice` cmdlet.

Using a timeframe of **90** days run the following command to get a list of all the stale devices.

```powershell
$timeframe = (Get-Date).AddDays(-90)
Get-MgDevice | Where {$_.ApproximateLastSignInDateTime -le $timeframe} | export-csv stale-devices.csv
```

To disable the stale devices by setting **AccountEnabled** to false, run:

```powershell
$Devices = Get-MgDevice | Where {$_.ApproximateLastSignInDateTime -le $timeframe} foreach ($Device in $Devices) {Update-MgDevice -DeviceId $Device.Id -AccountEnabled $False}
```

To delete disabled devices, now inactive for 120 days, we'll get all the disabled devices and pipe the output to `Remove-MgDevice`.

```powershell
$timeframe = (Get-Date).AddDays(-120)
$Devices = Get-MgDevice | Where {($_.ApproximateLastSignInDateTime -le $timeframe) -and $_.AccountEnabled -eq $false} foreach ($Device in $Devices) {Remove-MgDevice -DeviceId $Device.Id}
```
