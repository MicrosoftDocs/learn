In this unit, the application event log is analyzed through Kudu console.

## Access the Application Event Log through Azure Portal

1. In the Azure Portal, open the app in **App Services**.
1. Select **Diagnose and solve problems**.
1. Select **Diagnose Tools** menu option.
1. Select **Application Events** under **Support Tools**.
1. Review the latest error provided by *IIS AspNetCoreModule* or *IIS AspNetCoreModule V2* in the **Source** column.

## Access the Application Event Log through Kudu Console

1. Under the **Development Tools** section, open **Advanced Tools**. 
1. Select the **Go** button. This opens Kudu Console in a new window.
1. Open **Debug Console** in the top navigation bar and select **CMD**.
1. Open **LogFiles** folder.
1. Examine the **eventlog.xml** file and scroll to the bottom to see the most recent events.

## Run the app in Kudu Console

You can run the app in Kudu Console Remote Execution Console to discover useful information that is not immediately visible in the Application Event Log.

1. Under the **Development Tools** section, open **Advanced Tools**. 
1. Select the **Go** button. This opens Kudu Console in a new window.
1. Open **Debug Console** in the top navigation bar and select **CMD**.

#### Test a 64-bit (x64) app

##### Current release

* If the app is a 64-bit (x64) [framework-dependent deployment](/dotnet/core/deploying/#framework-dependent-deployments-fdd):
  1. `cd D:\Program Files\dotnet`
  1. Run the app: `dotnet \home\site\wwwroot\{ASSEMBLY NAME}.dll`
* If the app is a [self-contained deployment](/dotnet/core/deploying/#self-contained-deployments-scd):
  1. `cd D:\home\site\wwwroot`
  1. Run the app: `{ASSEMBLY NAME}.exe`

The console output from the app, showing any errors, is piped to the Kudu console.

##### Framework-dependent deployment running on a preview release

*Requires installing the ASP.NET Core {VERSION} (x64) Runtime site extension.*

1. `cd D:\home\SiteExtensions\AspNetCoreRuntime.{X.Y}.x64` (`{X.Y}` is the runtime version)
1. Run the app: `dotnet \home\site\wwwroot\{ASSEMBLY NAME}.dll`

The console output from the app, showing any errors, is piped to the Kudu console.