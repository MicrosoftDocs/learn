Congratulations! You created your Azure Functions application by shifting your Node.js Express code and making minimal changes. You took the following steps to refactor your code from Node.js Express to Functions:

1. Created the Functions application.
1. Copied the Node.js Express services from the _server/services_ folder to the _functions_ folder.
1. Imported the Functions host `Context` from `@azure/functions`.
1. Used destructuring to access the request and response objects.
1. Created a function for every route endpoint.
1. Named and set the method for each endpoint in the function's _function.json_ file.
1. Added code to each function's _index.tx_ file to call the appropriate service.

## Functions folders

The Functions application has folders that map to each of their endpoints, as shown in the following table:

| Method | Route endpoint | Folder          |
| ------- | --------------- | ---------------- |
| `GET`     | `vacations`     | *vacations-get*    |
| `POST`    | `vacations`     | *vacations-post*   |
| `PUT`     | `vacations:id`  | *vacations-put*    |
| `DELETE`  | `vacations/:id` | *vacations-delete* |

## File structure

The Functions application in the _functions_ folder should have the following file structure:

```files
TBD
```

In the next unit, you run and debug your Angular application and Functions application together.
