Congratulations! You created your Azure Functions application by shifting your Node.js Express code and making minimal changes. You took the following steps to refactor your code from Node.js Express to Functions:

1. Created the Functions application.
1. Created a function for every route endpoint.
1. Named and set the method.
1. Added code to each function's handler to call the appropriate vacation service method.

## Functions folders

The `./functions/src/functions` folder map to each of the endpoints, as shown in the following table:

| Method | Route endpoint | File          |
| ------- | --------------- | ---------------- |
| `GET`     | `vacations`     | *getVacations*    |
| `POST`    | `vacations`     | *postVacations*   |
| `PUT`     | `vacations:id`  | *updateVacation*    |
| `DELETE`  | `vacations/:id` | *delete* |

## File structure

The Functions application in the _functions_ folder should have the following file structure:

```files
functions
├── data
│   └── vacations.json
├── host.json
├── local.settings.json
├── models
│   └── vacation.models.ts
├── package.json
├── package-lock.json
├── services
│   ├── index.ts
│   └── vacation.services.ts
├── src
│   ├── functions
│   │   ├── deleteVacation.ts
│   │   ├── getVacations.ts
│   │   ├── postVacation.ts
│   │   └── updateVacation.ts
│   └── index.ts
└── tsconfig.json
```

In the next unit, you run and debug your Angular application and Functions application together.
