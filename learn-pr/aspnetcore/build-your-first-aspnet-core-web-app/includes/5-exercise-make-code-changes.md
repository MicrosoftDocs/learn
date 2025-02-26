Enhance your development workflow with the .NET CLI `dotnet watch` command. Unlike the `dotnet run` command, `dotnet watch` automatically rebuilds and re-runs your application whenever you make changes to the source files. Additionally, `dotnet watch` includes a hot reload feature, which injects updates directly to your running application without requiring a restart. `dotnet watch` allows you to see the results of your changes faster, boosting productivity, and efficiency.

In this exercise, you will:

- Run your web app created in the previous exercise, using the `dotnet watch` command.
- View code change results while the web app is running.

## Run the web app with `dotnet watch`

Run the web app using the `dotnet watch` command from the command line:

::: zone pivot="vscode"
In Visual Studio Code, if the integrated terminal pane isn't already available, select **New Terminal** from the **Terminal** menu to open the integrated terminal.

::: zone-end

::: zone pivot="shell"

::: zone-end

1. Build and Run the app with the following command:

    ```dotnetcli
    dotnet watch
    ```
    
    The project is built, run, and provides the ASP.NET Core app's endpoint URL on the command line:
    
    ```output
    Now listening on: http://localhost:5287
    ```
    
    Since the port number in the URL provided is set randomly in configuration at project creation, your endpoint may have a different port number.

1. Open a browser to the URL generated at your own command line output, the app's response `Hello World!` is displayed.

## Change the app's code and quickly view the results 

With the *MyWebApp* application still running and the browser still displaying the `Hello World!` response:

1. Select the *Program.cs* in the **Explorer** pane of Visual Studio Code.
1. Change the `app.MapGet` method so that it responds with `"Hello .NET Developer Community!"` instead of `"Hello World!"`.
1. Save the changes to your code.

After saving the changes, `dotnet watch` will automatically detect the modification to the *Program.cs* file. It will then:

- Hot Reload the Application: `dotnet watch` applies the changes to the running application without requiring a full rebuild when possible.
- Rebuild the Application (if necessary): If the changes can't be hot reloaded, `dotnet watch` automatically rebuilds the application to incorporate the changes you made.
- Restart the Application (if necessary): If a full rebuild is required, `dotnet watch` restarts the application.

The output in the terminal indicates that the file *Program.cs* changed and the changes were hot reloaded into the running app.

To see the result of the change, refresh your browser. The updated response "Hello .NET Community!" is displayed.

This automatic rebuild and restart process allows you to quickly see the results of your changes without manually stopping and restarting the application.
