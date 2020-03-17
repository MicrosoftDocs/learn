Now our code is ready for us to use it. But before we do, let's step back and see what we have.

## Node and Express APIs

Now let's explore the [sample project on GitHub](https://github.com/johnpapa/express-to-functions).

The application is a conventional Node.js and Express API that serves the following eight endpoints.

| method | route endpoint |
| ------ | -------------- |
| GET    | heroes         |
| POST   | heroes         |
| PUT    | heroes:id      |
| DELETE | heroes/:id     |
| GET    | villains       |
| POST   | villains       |
| PUT    | villains:id    |
| DELETE | villains/:id   |

The structure of the Node Express app is straight-forward and contained in the _server_ folder.

```text
server
 | - routes
 | | - hero.routes.ts  👈 The hero routes
 | | - index.ts
 | | - villain.routes.ts
 | - services
 | | - data.ts         👈 The hero data (could be database API calls)
 | | - hero.service.ts 👈 The logic to get the hero data
 | | - index.ts
 | | - villain.service.ts
 | - index.ts
 | - server.ts         👈 The Express server
 | - tsconfig.json
```

The entry point is the _server/index.ts_ file, which runs the _server.ts_ code to start the Express server. Then the routes (such as /heroes) are then loaded from the _/routes_ folder. These routes execute the appropriate code in the _/services_ folder. The _data.ts_ file is where the app defines the data store configuration.

For example, when the client app makes an HTTP GET to the _/heroes_ route, the route executes the logic in the _/services/hero.service.ts_ file to get the heroes.

Feel free to explore the code for the Express logic in the _server_ folder on your own.
