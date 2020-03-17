### Looking at the Functions App

The Azure Functions app now has folders that map to their appropriate endpoints as shown below.

| method | route endpoint | folder          |
| ------ | -------------- | --------------- |
| GET    | heroes         | heroes-get      |
| POST   | heroes         | heroes-post     |
| PUT    | heroes:id      | heroes-put      |
| DELETE | heroes/:id     | heroes-delete   |
| GET    | villains       | villains-get    |
| POST   | villains       | villains-post   |
| PUT    | villains:id    | villains-put    |
| DELETE | villains/:id   | villains-delete |

The structure of the Azure Function app contained in the _functions_ folder should look like the following.

```text
functions
 | - heroes-delete
 | | - function.json
 | | - index.ts
 | - heroes-get
 | | - function.json  👈 The hero route's configuration
 | | - index.ts       👈 The hero routes
 | - heroes-post
 | | - function.json
 | | - index.ts
 | - heroes-put
 | | - function.json
 | | - index.ts
 | - services          👈 The same folder that the Express app has
 | | - data.ts         👈 The hero data (could be database API calls)
 | | - hero.service.ts 👈 The logic to get the hero data
 | | - index.ts
 | | - villain.service.ts
 | - villains-delete
 | | - function.json
 | | - index.ts
 | - villains-get
 | | - function.json
 | | - index.ts
 | - villains-post
 | | - function.json
 | | - index.ts
 | - villains-put
 | | - function.json
 | | - index.ts
 | - .funcignore
 | - .gitignore
 | - host.json
 | - local.settings.json
 | - package.json
 | - proxies.json
 | - tsconfig.json
```
