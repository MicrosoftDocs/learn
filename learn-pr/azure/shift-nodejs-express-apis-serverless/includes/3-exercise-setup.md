A great place for you to start is to get your existing application's code out of GitHub.

Start by getting the code and setting up your development environment. Follow these steps to prepare the code.

1. Clone the code repository

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless learn-functions
   ```

1. Change your directory to where you cloned the code repository

   ```bash
   cd learn-functions
   ```

1. Install the npm package dependencies

   ```bash
   npm install
   ```

1. Build the Node.js Express and the Angular code

   ```bash
   npm run full:build
   ```

1. The application is a conventional Node.js and Express API that serves the following four endpoints.

    | Methods | Route endpoints |
    | ------- | --------------- |
    | GET     | `vacations`     |
    | POST    | `vacations`     |
    | PUT     | `vacations:id`  |
    | DELETE  | `vacations/:id` |

1. Open the _server_ folder to explore the structure of the API.

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

    The entry point is the _server/index.ts_ file, which runs the _server.ts_ code to start the Express server. Then the routes (such as `/vacations`) are loaded from the _/routes_ folder. These routes execute the appropriate code in the _/services_ folder. The _data.ts_ file is where the app defines the data store configuration.

    Here is an example flow: when the client app makes an HTTP GET request to the _/vacations_ route, the route executes the logic in the _/services/vacation.service.ts_ file to get the vacations.

1. Open _src/app/vacations/vacations.component.ts_ and locate the `getVacations()` function in Visual Studio Code.
1. Set a breakpoint by clicking in the editor's gutter to the left of the first line of code inside the `getVacations()` function.

   ```typescript
   getVacations() {
     this.vacationService.getAll(); // Set a breakpoint on this line
     this.clear();
   }
   ```

1. Open _server/routes/vacation.routes.ts_ and locate the code shown below.

   ```typescript
   router.get('/vacations', (req, res) => {
     vacationService.getVacations(req, res);
   });
   ```

1. Set a breakpoint by clicking in the editor's gutter to the left of the line of code `vacationService.getVacations(req, res);`.

1. Open _proxy.conf.json_. You'll Notice the port is set to **7070**

   ```json
   {
     "/api": {
       "target": "http://localhost:7070",
       "secure": false
     }
   }
    ```

    The Node.js Express API runs on port **7070**. The Angular application runs on a different port, **4200**. The Angular application can't make requests across the domains to the Node.js Express application. Setting up a proxy tricks the browser into seeing the Express server to be located at `http://localhost:4200/api` instead of `http://localhost:7070`.

1. Open the Visual Studio Code Command Palette by pressing **F1**. Type **View: Show Run and Debug** and press **ENTER**.
1. Select **Debug Express and Angular** from the dropdown list and press **F5** to start the debugger.

    :::image type="content" source="../media/3-paused-execution.png" alt-text="Screenshot of VS Code paused during execution.":::

    When the application launches, it gets the list of vacations. The Angular `VacationComponent` sends an HTTP request to get the vacation data. When the browser opens to `http://localhost:7070`, the code execution pauses on your first breakpoint in the _vacations.component.ts_ file for the `getVacations()` function.

1. You can unpause execution and continue by pressing the **F5**.

    Now the code pauses on your second breakpoint in the _vacation.routes.ts_ file because the Node.js Express route `vacations` was hit by the Angular application.

1. Press **SHIFT** and **F5** to stop the active debugger
1. Press **SHIFT** and **F5** to stop the remaining debugger