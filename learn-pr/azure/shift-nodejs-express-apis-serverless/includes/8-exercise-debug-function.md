In this exercise, you run and debug both the Express.js application and the Azure Functions application together. You explore the Azure Functions code that fetches the vacations and renders them in the browser, and set a new breakpoint in the code. You then use the breakpoints to step through the Azure Functions and Angular code with the debugger.

>[!NOTE]
>The files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project.

## Set a breakpoint in the Functions code

To display a list of vacations, the Angular application makes a call to the `vacations` endpoint in the Azure Functions API. The file _functions/vacations-get/index.ts_ defines the endpoint's route. Set a breakpoint in this file so you can step through the code that fetches the vacations.

1. Open the project in Visual Studio Code, and in _functions/services/vacations.service.ts_, locate the following code:

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

You've set breakpoints in both the Angular and the Functions applications. Now run and debug them together.

>[!NOTE]
>You don't run the functions in Azure yet. You're using powerful and convenient core tools to run and debug locally.

### Proxy the requests from Angular to Functions

The Azure Functions API runs on port `7071`, while the Angular application runs on port `4200`. The Angular application can't make requests across the domains to the Functions application, so you proxy the calls from the Angular application to the Functions application.

Use the following code in Angular's _proxy.conf.json_ file to enable the Angular application to talk to and proxy requests to the Functions application.

1. Open _proxy.conf.json_.
1. Change the port to `7071`.

   ```json
   {
     "/api": {
       "target": "http://localhost:7071",
       "secure": false
     }
   }
   ```

> [!NOTE]
> The Node.js Express application used port `7070`, and the Functions application uses port `7071`. If you removed the Node.js Express application, you could use port `7070` for the Functions application. But for educational purposes, keep both ports.

### Debug both applications

When the application launches, Angular requests the vacations data from the Functions application. The two applications work together to get the data and render it in the browser.

Run and debug the applications together. The app pauses on the breakpoints, giving you the opportunity to explore how these applications work together.

1. Press **F1** to open the Visual Studio Code command palette.
1. Type and select **View: Show Run and Debug**.
1. Select **Debug Functions and Angular** from the dropdown list.
1. Press **F5** to start the debugger.

   The application launches to get the list of vacations. The Angular `VacationComponent` starts the HTTP request to get the vacations. When the browser opens to `http://localhost:7071`, the code execution pauses on the first breakpoint in the _vacations.component.ts_ file in the `getVacations()` function.

1. Unpause execution and continue by pressing **F5**.

   The code pauses on the second breakpoint in the _functions/vacations-get/index.ts_ file, because the Angular application hits the Functions `vacations` route.

1. There are two debugging processes running: one for Angular and one for Azure Functions. Press **SHIFT** and **F5** to stop the active debugger.
1. Press **SHIFT** and **F5** to stop the remaining debugger.

