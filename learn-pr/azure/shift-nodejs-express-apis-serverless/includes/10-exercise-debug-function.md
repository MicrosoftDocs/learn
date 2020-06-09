Now it's time for you to run and debug both applications together.

Start by opening the project in Visual Studio Code.

## Set the Breakpoints

You see a list of vacations displayed in the application. Then, explore the code that fetches the vacations and renders them in the browser. You'll step through the code with the debugger by setting breakpoints in the Azure Functions and Angular code.

### Set a Breakpoint in the Azure Functions Code

The Angular application makes a call to the `vacations` endpoint in the Azure Functions API. The endpoint's route is defined in the file _functions/vacations-get/index.ts_. You'll set a breakpoint in this file so you can step through the code that fetches the vacations.

1. Open _functions/services/vacations.service.ts_ and locate the code shown below.

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

1. Set a breakpoint by clicking in the editor's gutter to the left of the line of code `try {`.

> The files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project.

## Run and Debug the Application

You've set a breakpoint in both the Angular and the Azure Functions applications. Now it's time to run and debug them together.

> You're not running the functions in Azure yet. You're using the very powerful and convenient core tools to run and debug locally.

### Proxy the Requests from Angular to Azure Functions

The Azure Functions API runs on port **7071**. The Angular application runs on a different port, **4200**. The Angular application can't make requests across the domains to the Azure Functions application. You'll proxy the calls from the Angular application to the Azure Functions application.

We'll allow the Angular application to proxy requests to the Azure Functions application using Angular's _proxy.conf.json_ file.

1. Open _proxy.conf.json_
1. Change the port to **7071**

   ```json
   {
     "/api": {
       "target": "http://localhost:7071",
       "secure": false
     }
   }
   ```

You just told the Angular application that it can talk to the Azure Functions application.

> [!NOTE]
> The Node.js Express application uses port **7070** and the Azure Functions application uses port **7071**. If you were truly removing the Node.js Express application, you could keep the same port. But for educational purposes, keep them both.

### Debug Both Applications

When the application launches, Angular requests the vacations data from the Node.js Express application. These two applications work together to get the data and render it in the browser.

You'll run and debug the applications together. You'll hit pause on the breakpoints, giving you the opportunity to explore how these applications work together.

1. Open the Visual Studio Code Command Palette **F1**
1. Type **View: Show Run and Debug** and press **ENTER**
1. Select **Debug Functions and Angular** from the dropdown list
1. Press **F5** to start the debugger

When the application launches, it will get the list of vacations. The Angular `VacationComponent` will start the HTTP request to get the vacations. When the browser opens to `http://localhost:7071`, the code execution will pause on your first breakpoint in the _vacations.component.ts_ file in the `getVacations()` function.

You can unpause execution and continue by pressing the **F5**.

Now the code will pause on your second breakpoint in the _functions/vacations-get/index.ts_ file. The Node.js Express route `vacations` was hit by the Angular application.

### Stop the Debuggers

There are two debugging processes running: one for Angular and one for Azure Functions. Stop both debuggers.

1. Press **SHIFT** and **F5** to stop the active debugger
1. Press **SHIFT** and **F5** to stop the remaining debugger

The debugger is no longer running.
