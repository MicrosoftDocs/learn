When I want to become familiar with an app, I find it helpful to run and step through an application with the debugger.

Let's start by opening the app in Visual Studio Code.

## Set Breakpoints

We see a list of vacations displayed in the application. Let's explore the code that fetches the vacations and renders them in the browser. We'll step through the code with the debugger by setting breakpoints in the Express and Angular code.

### Set a Breakpoint in the Angular Code

The vacations are rendered using the `VacationComponent` Angular code found in the file _src/app/vacations/vacations.component.ts_. We'll set a breakpoint in this file where it makes the call to get the list of vacations.

1. Open _src/app/vacations/vacations.component.ts_ and locate the `getVacations()` function in Visual Studio Code.
1. Set a breakpoint by clicking in the editor's gutter to the left of the first line of code inside the `getVacations()` function.

   ```typescript
   getVacations() {
     this.vacationService.getAll(); // Set a breakpoint on this line
     this.clear();
   }
   ```

### Set a Breakpoint in the Express Code

The Angular app makes a call to the `vacations` endpoint in the Node.js Express API. The endpoint's route is defined in the file _server/routes/vacation.routes.ts_. We'll set a breakpoint in this file so we can step through the code that fetches the vacations.

1. Open _server/routes/vacation.routes.ts_ and locate the code shown below.

   ```typescript
   router.get('/vacations', (req, res) => {
     vacationService.getVacations(req, res);
   });
   ```

1. Set a breakpoint by clicking in the editor's gutter to the left of the line of code `vacationService.getVacations(req, res);`.

> The files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project. I encourage you to explore those files and copy/refactor their contents for your own purposes.

## Run and Debug the Application

### Proxy the Requests from Angular to Node.js Express

The Node.js Express API runs on port **7070**. The Angular application runs on a different port, **4200**. The Angular application can't make requests across the domains to the Node.js Express application. We'll proxy the calls from the Angular application to the Node.js Express application.

We'll allow the Angular application to proxy requests to the Node.js Express application using Angular's _proxy.conf.json_ file.

1. Open _proxy.conf.json_ and change that the port to **7070**

   ```json
   {
     "/api": {
       "target": "http://localhost:7070",
       "secure": false
     }
   }
   ```

You just told the Angular application that it can talk to the Node.js Express application.

### Debug Both Applications

When the application launches, Angular requests the vacations data from the Node.js Express application. These two applications work together to get the data and render it in the browser.

We'll run and debug the applications together. We'll hit pause on the breakpoints, giving us the opportunity to explore how these applications work together.

1. Open the VS Code Command Palette **F1**
1. Type **View: Show Run and Debug** and press **ENTER**
1. Select **Debug Express and Angular** from the dropdown list
1. Press **F5** to start the debugger

When the application launches, it will get the list of vacations. The Angular `VacationComponent` will start the HTTP request to get the vacations. When the browser opens to <http://localhost:7070>, the code execution will pause on your first breakpoint in the _vacations.component.ts_ file in the `getVacations()` function.

You can unpause execution and continue by pressing the **F5**.

Now the code will pause on your second breakpoint in the _vacation.routes.ts_ file. The Node.js Express route `vacations` was hit by the Angular application.

### Stop the Debuggers

There are two debugging processes running: one for Angular and one for Node.js Express. Let's stop both debuggers.

1. Press **SHIFT** and **F5** to stop the active debugger
1. Press **SHIFT** and **F5** to stop the remaining debugger

The debugger is no longer running.
