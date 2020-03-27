Now our code is ready for us to run it. But before we do, let's step back and see what we have.

## Node and Express APIs

Let's explore the sample project we cloned and built. The application is a conventional Node.js and Express API that serves the following four endpoints.

| methods | route endpoints |
| ------- | --------------- |
| GET     | `vacations`     |
| POST    | `vacations`     |
| PUT     | `vacations:id`  |
| DELETE  | `vacations/:id` |

The structure of the Node Express app is straight-forward and contained in the _server_ folder.

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

For example, when the client app makes an HTTP GET to the _/vacations_ route, the route executes the logic in the _/services/vacation.service.ts_ file to get the vacations.

Feel free to explore the code for the Express logic in the _server_ folder on your own.

Next, we'll run the application and test our HTTP endpoints.
