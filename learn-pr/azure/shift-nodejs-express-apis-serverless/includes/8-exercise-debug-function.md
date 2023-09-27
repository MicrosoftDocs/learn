In this exercise, you run and debug the Angular application and the Azure Functions application together. You set breakpoints in the Angular code that displays the web app in the browser and in the Functions code that fetches and renders the vacations. You then use the Angular and Functions breakpoints to step through the Functions and Angular code with the debugger.

>[!NOTE]
>The files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project.

## Set breakpoints

When the application launches, Angular requests the vacations data from the Functions application. The two applications work together to get the data and render it in the browser.

To display a list of vacations, the Angular application runs the `getVacations()` function in the _vacations.component.ts_ file, which calls the `vacations` endpoint in the Azure Functions API. The file _functions/vacations-get/index.ts_ defines the endpoint's route. Set breakpoints in these files, so during debugging you can step through the code that fetches the vacations.

1. In Visual Studio Code, open the application's _src/app/vacations/vacations.component.ts_ file, and locate the `getVacations()` function.
1. Set a breakpoint by selecting the editor's gutter to the left of the first line of code, `this.vacationService.getAll();`, inside the `getVacations()` function.

   :::image type="content" source="../media/3-first-breakpoint.png" alt-text="Screenshot of the first breakpoint to set in Visual Studio Code.":::

1. Open the _functions/services/vacations.service.ts_ file, and locate the following code:

   ```typescript
   async function getVacations({ req, res }: Context) {
     try {
       const vacations = data.getVacations();
       res.status(200).json(vacations);
     } catch (error) {
       res.status(500).send(error);
     }
   }
   ```

1. Set a breakpoint by selecting the editor's gutter to the left of the `try {` line.

## Run and debug the application

Now that you have breakpoints in both the Angular and the Functions apps, you can step through and debug them together.

>[!NOTE]
>You don't run the functions in Azure yet. You're using core tools to run and debug locally.

### Proxy the requests from Angular to Functions

The Azure Functions API runs on port `7071`, while the Angular application runs on port `4200`. The Angular application can't make requests across the domains to the Functions application, so you proxy the calls from the Angular application to the Functions application.

To enable the Angular application to talk to and proxy requests to the Functions application, open _proxy.conf.json_ and change the port to `7071`.

   ```json
   {
     "/api": {
       "target": "http://localhost:7071",
       "secure": false
     }
   }
   ```

> [!NOTE]
> The Node.js Express application used port `7070`. If you removed the Node.js Express application, you could also use port `7070` for the Functions application. But for learning purposes, you keep both applications.

### Debug both applications

When you run and debug the applications together, the app pauses on the breakpoints, so you have the opportunity to explore how these applications work together.

1. Press **F1** to open the Visual Studio Code command palette.
1. Type and select **View: Show Run and Debug**.
1. At the top of the **Run and Debug** pane, select **Debug Functions and Angular** from the dropdown list.
1. Press **F5** to start the debugger.

   The application launches to get the list of vacations. The Angular `VacationComponent` starts the HTTP request to get the vacations. When the browser opens, the code execution pauses on the first breakpoint in the _vacations.component.ts_ file in the `getVacations()` function.

   :::image type="content" source="../media/paused-execution.png" alt-text="Screenshot of Visual Studio Code paused during debugging.":::

1. Unpause execution and continue by pressing **F5**.

1. The code pauses on the second breakpoint in the _functions/vacations-get/index.ts_ file, because the Angular application hits the Functions `vacations` route. Unpause execution and continue by pressing **F5**.

1. There are two debugging processes running: one for Angular and one for Azure Functions. Press **Shift+F5** to stop the active debugger.

1. Press **Shift+F5** to stop the remaining debugger.

