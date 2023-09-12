In this unit, you get the existing application's code from GitHub, prepare the code, and set up your development environment.

## Get and prepare the code

1. In a bash terminal, clone the code repository.

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless learn-functions
   ```

1. Change to the code repository directory.

   ```bash
   cd learn-functions
   ```

1. Install the npm package dependencies.

   ```bash
   npm install
   ```

1. Build the Node.js Express and Angular code.

   ```bash
   npm run full:build
   ```

## Understand application structure

The sample application is a conventional Node.js and Express API with four methods that serve the following endpoints:

| Method | Route endpoint |
| ------- | --------------- |
| `GET`     | `vacations`     |
| `POST`    | `vacations`     |
| `PUT`     | `vacations:id`  |
| `DELETE`  | `vacations/:id` |

Open the project in Visual Studio Code, and open the _server_ folder to explore the structure of the API.

```files
server
 | - routes
 | | - index.ts            👈 1. Entry point
 | | - vacation.routes.ts  👈 2. The vacation routes
 | - services
 | | - data.ts             👈 3. The vacation data (could be database API calls)
 | | - index.ts
 | | - vacation.service.ts 👈 3. The logic to get the vacation data
 | - index.ts
 | - server.ts             👈 The Express server
 | - tsconfig.json
```

1. The entry point is the _server/index.ts_ file, which runs the _server.ts_ code to start the Express server.
1. Then the routes, such as `/vacations`, are loaded from the _/routes_ folder.
1. The routes execute the appropriate code in the _/services_ folder. The data store configuration is defined in the _data.ts_ file.

For example, the Angular client app makes an `HTTP GET` request to the _routes/vacation.routes_ route, and the route executes the logic in the _/services/vacation.service.ts_ file to get the vacations.

### Proxy configuration

Open _proxy.conf.json_ and notice that the port is set to `7070`.

```json
{
  "/api": {
    "target": "http://localhost:7070",
    "secure": false
  }
}
```

The Node.js Express API runs on port `7070`, while the Angular application runs on port `4200`. The Angular application can't make requests across the domains to the Node.js Express application. Setting up a proxy enables the browser to locate the Express server.

<!-- Commenting out the run/debug steps pending resolution of the Express API proxy issue

## Set breakpoints

To display a list of vacations, the Angular application runs the `getVacations()` function in the _vacations.component.ts_ file, which calls the route in the _vacation.routes.ts_ file. Set breakpoints in these files, so during debugging you can step through the code that fetches the vacations.

>[!NOTE]
>The files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project.

1. In Visual Studio Code, open the application's _src/app/vacations/vacations.component.ts_ file, and locate the `getVacations()` function.
1. Set a breakpoint by selecting the editor's gutter to the left of the first line of code, `this.vacationService.getAll();`, inside the `getVacations()` function.

   :::image type="content" source="../media/3-first-breakpoint.png" alt-text="Screenshot of the first breakpoint to set in Visual Studio Code.":::

1. Open _server/routes/vacation.routes.ts_ and locate the following code:

   ```typescript
   router.get('/vacations', (req, res) => {
     vacationService.getVacations(req, res);
   });
   ```

1. Set a breakpoint by selecting the editor's gutter to the left of the line `vacationService.getVacations(req, res);`.

   :::image type="content" source="../media/3-next-breakpoint.png" alt-text="Screenshot of the next breakpoint to set in Visual Studio Code.":::

## Run and debug the app

Now run and debug the Angular and Express apps together to show how the Vacation Wishlist app gets the list of vacations.

1. Open the Visual Studio Code command palette by pressing **F1**, and enter and select **View: Show Run and Debug**.
1. Select **Debug Express and Angular** from the dropdown list and then press **F5** to start the debugger.

   When the application launches, the Angular `VacationComponent` sends an HTTP request to get the vacation data for the list of vacations. When the browser opens, the code execution pauses on your first breakpoint in the _vacations.component.ts_ file for the `getVacations()` function.

   :::image type="content" source="../media/3-paused-execution.png" alt-text="Screenshot of Visual Studio Code paused during execution.":::

1. Unpause execution and continue by pressing **F5**.

1. The code now pauses on your second breakpoint in the _vacation.routes.ts_ file, because the Angular application hits the Node.js Express route `vacations`. Unpause execution and continue by pressing **F5**.

1. There are two debugging processes running: one for Angular and one for Node.js Express. Press **SHIFT+F5** to stop the active debugger.

1. Press **SHIFT+F5** again to stop the remaining debugger.-->
 

