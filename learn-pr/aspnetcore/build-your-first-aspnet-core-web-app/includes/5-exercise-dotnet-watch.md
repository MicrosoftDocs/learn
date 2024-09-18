Enhance your development workflow with the .NET CLI `dotnet watch` command. Unlike the `dotnet run` command, `dotnet watch` automatically rebuilds and re-runs your application whenever you make changes to the source files. This immediate feedback loop allows you to see the results of your changes instantly, significantly boosting productivity, and efficiency.

In this exercise, you will:

* Run your web app created in the previous exercise, using the `dotnet watch` command.
* View code change results while the web app is running.

## Run the web app with the `dotnet watch` task using Visual Studio Code

In Visual Studio Code with the .NET C# Dev Kit extension:

* Open the **Command Palette** by pressing Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (Mac).
* Type "Tasks: Run Task" and select Tasks: Run Task from the list. and select from the list.
* Choose **dotnet** > **dotnet watch MyWebApp** > **Continue without scanning the task output**.

Visual Studio Code runs the `dotnet watch MyWebApp` task without attempting to scan the output for errors or warnings.

The default browser is launched at `http://localhost:{PORT}`, which displays the app's response. The `{PORT}` placeholder is the random port assigned to the app when the app's project is created.

## Alternatively run the web app using the `dotnet watch` command from the command line

In Visual Studio Code, if integrated terminal pane isn't already available, select **New Terminal** from the **Terminal** menu to open the integrated terminal.

Build and Run the app with the following command:

```dotnetcli
dotnet watch
```
The project is built, run, and provides the ASP.NET Core app's endpoint URL on the command line:

```output
Now listening on: http://localhost:5287
```

Since the port number in the URL provided is set randomly in configuration at project creation, your endpoint may have a different port number.

Open a browser to the URL generated at your own command line output, the app's response `Hello World!` is displayed.

## Change the app's code and quickly view the results 

With the `MyWebApp` application still running and the browser still displaying the `Hello World!` response:

* Select the `Program.cs` in the **Explorer** pane of Visual Studio Code.
* Change the `app.MapGet` method so that it responds with `"Hello .NET Developer Community!"` instead of `"Hello World!"`.
* Save the changes to `program.cs`.

After saving the changes, `dotnet watch` will automatically detect the modification to the Program.cs file. It will then:

* Rebuild the Application: dotnet watch rebuilds the application to incorporate the changes you made.
* Restart the Application: Once the rebuild is complete, dotnet watch restarts the application.

The output in the terminal indicates that the file `Program.cs` changed and the application was rebuilt and run.

Refresh your browser. The updated response "Hello .NET Community!" should now be displayed.

This automatic rebuild and restart process allows you to quickly see the results of your changes without manually stopping and restarting the application.
