The Azure Functions app now has folders that map to their appropriate endpoints as shown below.

| methods | route endpoints | folders          |
| ------- | --------------- | ---------------- |
| GET     | `vacations`     | vacations-get    |
| POST    | `vacations`     | vacations-post   |
| PUT     | `vacations:id`  | vacations-put    |
| DELETE  | `vacations/:id` | vacations-delete |

The structure of the Azure Function app contained in the _functions_ folder should look like the following.

```files
functions
 | - vacations-delete
 | | - function.json
 | | - index.ts
 | - vacations-get
 | | - function.json      👈 The vacation route's configuration
 | | - index.ts           👈 The vacation routes
 | - vacations-post
 | | - function.json
 | | - index.ts
 | - vacations-put
 | | - function.json
 | | - index.ts
 | - services              👈 The same folder that the Express app has
 | | - data.ts             👈 The vacation data (could be database API calls)
 | | - vacation.service.ts 👈 The logic to get the vacation data
 | | - index.ts
 | - .funcignore
 | - .gitignore
 | - host.json
 | - local.settings.json
 | - package.json
 | - proxies.json
 | - tsconfig.json
```
