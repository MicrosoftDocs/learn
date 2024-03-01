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
 | - data
 | | - vacations.json
 | - models
 | | - vacation.model.ts
 | - routes
 | | - index.ts            👈 1. Entry point
 | | - vacation.routes.ts  👈 2. The vacation routes
 | - services
 | | - index.ts
 | | - vacation.service.ts 👈 3. The logic and data 
 | - index.ts
 | - server.ts             👈 The Express server
 | - tsconfig.json
```

1. The entry point is the _server/index.ts_ file, which runs the _server.ts_ code to start the Express server.
1. Then the routes, such as `/vacations`, are loaded from the _/routes_ folder.
1. The routes execute the appropriate code in the _/services_ folder. The data store configuration is defined in the _vacation.service.ts_ file.

The Angular client app makes an `HTTP GET` request to the `/api/vacations` route, and the route in `routes/vacation.routes.ts` calls the data logic in the `services/vacation.service.ts` file to get the vacations.

### Proxy configuration

The Angular application needs to be able to make requests to the Node.js Express API. The Angular application uses a proxy to forward requests to the Express server. Setting up a proxy enables the browser to locate the Express server. Open _proxy.conf.json_ and notice that the port is set to `7070`, the Express app's port.

```json
{
  "/api": {
    "target": "http://localhost:7070",
    "secure": false
  }
}
```