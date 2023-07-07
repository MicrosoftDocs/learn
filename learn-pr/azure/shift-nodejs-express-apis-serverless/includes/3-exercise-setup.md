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

1. Build the Node.js Express and the Angular code.

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
 | | - index.ts
 | | - vacation.routes.ts  👈 The vacation routes
 | - services
 | | - data.ts             👈 The vacation data (could be database API calls)
 | | - index.ts
 | | - vacation.service.ts 👈 The logic to get the vacation data
 | - index.ts
 | - server.ts             👈 The Express server
 | - tsconfig.json
```

The entry point is the _server/index.ts_ file, which runs the _server.ts_ code to start the Express server. Then the routes, such as `/vacations`, are loaded from the _/routes_ folder. These routes execute the appropriate code in the _/services_ folder. The app defines the data store configuration in the _data.ts_ file.

For example, the client app makes an `HTTP GET` request to the _/vacations_ route, and the route executes the logic in the _/services/vacation.service.ts_ file to get the vacations.

## Prepare your development environment

1. In Visual Studio Code, open the application's _src/app/vacations/vacations.component.ts_ file, and locate the `getVacations()` function.
1. Set a breakpoint by selecting the editor's gutter to the left of the first line of code inside the `getVacations()` function.

   ```typescript
   getVacations() {
     this.vacationService.getAll(); // Set a breakpoint on this line
     this.clear();
   }
   ```

1. Open _server/routes/vacation.routes.ts_ and locate the following code:

   ```typescript
   router.get('/vacations', (req, res) => {
     vacationService.getVacations(req, res);
   });
   ```

1. Set a breakpoint by selecting the editor's gutter to the left of the line of code `vacationService.getVacations(req, res);`.

1. Open _proxy.conf.json_ and notice that the port is set to `7070`.

   ```json
   {
     "/api": {
       "target": "http://localhost:7070",
       "secure": false
     }
   }
   ```

    The Node.js Express API runs on port `7070`, while the Angular application runs on a port `4200`. The Angular application can't make requests across the domains to the Node.js Express application. Setting up a proxy makes the browser locate the Express server at `http://localhost:4200/api` instead of `http://localhost:7070`.

## Run and debug the app

1. Open the Visual Studio Code command palette by pressing **F1**, and enter and select **View: Show Run and Debug**.
1. Select **Debug Express and Angular** from the dropdown list and then press **F5** to start the debugger.

   When the application launches, the Angular `VacationComponent` sends an HTTP request to get the vacation data for the list of vacations. When the browser opens, the code execution pauses on your first breakpoint in the _vacations.component.ts_ file for the `getVacations()` function.

   :::image type="content" source="../media/3-paused-execution.png" alt-text="Screenshot of Visual Studio Code paused during execution.":::

1. Unpause execution and continue by pressing **F5**.

   The code now pauses on your second breakpoint in the _vacation.routes.ts_ file because the Angular application hit the Node.js Express route `vacations`.

1. Press **SHIFT** and **F5** to stop the active debugger.
1. Press **SHIFT** and **F5** again to stop the remaining debugger.
