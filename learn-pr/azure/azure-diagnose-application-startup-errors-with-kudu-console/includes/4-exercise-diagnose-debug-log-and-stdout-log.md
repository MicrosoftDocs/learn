Sometimes the application event log does not record the relevant information required to diagnose the issue. The ASP.NET Core Module stdout log and debug log provides, deeper and more meaningful information that can help resolve the startup issues. 

### ASP.NET Core Module stdout log

To view stdout logs:

1. Navigate to the **Diagnose and solve problems** blade in the Azure portal.
1. Under **SELECT PROBLEM CATEGORY**, select the **Web App Down** button.
1. Under **Suggested Solutions** > **Enable Stdout Log Redirection**, select the button to **Open Kudu Console to edit Web.Config**.
1. In the Kudu **Diagnostic Console**, open the folders to the path **site** > **wwwroot**. Scroll down to reveal the *web.config* file at the bottom of the list.
1. Click the pencil icon next to the *web.config* file.
1. Set **stdoutLogEnabled** to `true` and change the **stdoutLogFile** path to: `\\?\%home%\LogFiles\stdout`.
1. Select **Save** to save the updated *web.config* file.
1. Make a request to the app.
1. Return to the Azure portal. Select the **Advanced Tools** blade in the **DEVELOPMENT TOOLS** area. Select the **Go&rarr;** button. The Kudu console opens in a new browser tab or window.
1. Using the navigation bar at the top of the page, open **Debug console** and select **CMD**.
1. Select the **LogFiles** folder.
1. Inspect the **Modified** column and select the pencil icon to edit the stdout log with the latest modification date.
1. When the log file opens, the error is displayed.

Disable stdout logging when troubleshooting is complete:

1. In the Kudu **Diagnostic Console**, return to the path **site** > **wwwroot** to reveal the *web.config* file. Open the **web.config** file again by selecting the pencil icon.
1. Set **stdoutLogEnabled** to `false`.
1. Select **Save** to save the file.

> [!WARNING]
> Failure to disable the stdout log can lead to app or server failure. There's no limit on log file size or the number of log files created. Only use stdout logging to troubleshoot app startup problems.
>
> For general logging in an ASP.NET Core app after startup, use a logging library that limits log file size and rotates logs. For more information, see [third-party logging providers](xref:fundamentals/logging/index#third-party-logging-providers).

### ASP.NET Core Module debug log

To view stdout logs:

1. To enable the enhanced diagnostic log, perform either of the following:
   * Follow the instructions in [Enhanced diagnostic logs](xref:host-and-deploy/aspnet-core-module#enhanced-diagnostic-logs) to configure the app for an enhanced diagnostic logging. Redeploy the app.
   * Add the `<handlerSettings>` shown in [Enhanced diagnostic logs](xref:host-and-deploy/aspnet-core-module#enhanced-diagnostic-logs) to the live app's *web.config* file using the Kudu console:
     1. Open **Advanced Tools** in the **Development Tools** area. Select the **Go&rarr;** button. The Kudu console opens in a new browser tab or window.
     1. Using the navigation bar at the top of the page, open **Debug console** and select **CMD**.
     1. Open the folders to the path **site** > **wwwroot**. Edit the *web.config* file by selecting the pencil button. Add the `<handlerSettings>` section as shown in [Enhanced diagnostic logs](xref:host-and-deploy/aspnet-core-module#enhanced-diagnostic-logs). Select the **Save** button.
1. Open **Advanced Tools** in the **Development Tools** area. Select the **Go&rarr;** button. The Kudu console opens in a new browser tab or window.
1. Using the navigation bar at the top of the page, open **Debug console** and select **CMD**.
1. Open the folders to the path **site** > **wwwroot**. If you didn't supply a path for the *aspnetcore-debug.log* file, the file appears in the list. If you supplied a path, navigate to the location of the log file.
1. Open the log file with the pencil button next to the file name.

Disable debug logging when troubleshooting is complete:

1. To disable the enhanced debug log, perform either of the following:
   * Remove the `<handlerSettings>` from the *web.config* file locally and redeploy the app.
   * Use the Kudu console to edit the *web.config* file and remove the `<handlerSettings>` section. Save the file.

> [!WARNING]
> Failure to disable the debug log can lead to app or server failure. There's no limit on log file size. Only use debug logging to troubleshoot app startup problems.
>
> For general logging in an ASP.NET Core app after startup, use a logging library that limits log file size and rotates logs. For more information, see [third-party logging providers](xref:fundamentals/logging/index#third-party-logging-providers).

