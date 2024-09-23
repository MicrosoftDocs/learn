In this unit, you create and configure functions in the Azure Functions app for the `GET`, `POST`, `PUT`, and `DELETE` endpoints in the Node.js Express app.

## Add data access to the GET function 

You created the first API endpoint when you created the Azure Functions app in the last unit. This function executes when an HTTP `GET` is requested on `/vacations`. You need to update the boilerplate code to call the data service to get the vacations.

1. Open the _functions/src/functions/getVacations.ts_ file.
1. Open the _server/routes/vacation.routes.ts_ file in a separate window so you can see both files side by side.
1. In _getVacations.ts_, add the _vacationService_ import statement.

   ```typescript
   import { vacationService } from '../services';
   ```

1. In _getVacations.ts_, edit the `getVacations` function to call the vacationService.

   ```typescript
    export async function getVacations(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
        context.log(`Http function processed request for url "${request.url}"`);
        return { jsonBody: vacationService.getVacations() }; // Data access logic within the return object
    };
   ```

1. You could stop there. That is the only code you _need_ to add to the function to get the vacations. However, you should also provide code to handle errors and return a status code. Update the function to use the following code.

   ```typescript
    export async function getVacations(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
      context.log(`Http function processed request for url "${request.url}"`);
      
      try {
        const vacations = vacationService.getVacations();  // Data access logic
        
        if (vacations) {
          return {
            status: 200,
            jsonBody: vacations
          };
        } else {
          return {
            status: 404,
            jsonBody: {
              error: 'No vacations found'
            }
          };
        }      
      } catch (error: unknown) {
        const err = error as Error;
        context.error(`Error listing vacations: ${err.message}`);
        
        return {
          status: 500,
          jsonBody: {
            error: 'Failed to list vacations'
          }
        };
      }
    };
   ```

## Organize the Azure Functions routes

In the v4 programming model, you can organize your routes in several ways. You could leave the route definition with the route handler in a single file. This is fine for an application with one endpoint. As a developer at Tailwind Traders, you know this application will grow to many APIs which need to be organized. 

1. To start that organization, create a new `./functions/src/index.ts` file to capture the route definitions.
1. Add the dependency for the app provided from the `@azure/functions` package.

    ```typescript
    import { app } from '@azure/functions';
    ```
1. Add the dependency for the getVacations function from the `./functions/getVacations` file.

    ```typescript
    import { getVacations } from `./functions/getVacations`;
    ```
1. Move the route definition from `./functions/getVacations` to the _index.ts_ file. Update the **method** property array to `GET`. 

    ```typescript
    app.http('getVacations', {
        methods: ['GET'],
        route: 'vacations',
        authLevel: 'anonymous',
        handler: getVacations
    });
    ```

## Naming the function and handler

The name `getVacations` is used as both the first parameter to _app.http_ and as a property in the second parameter. This may be confusing and you may want different naming rules in your organization or team, depending on how the name is used.

:::image type="content" source="../media/http-definition.png" alt-text="Screenshot of the http definition with the first parameter numbered as one, and the second parameter's handler property numbered as two.":::

* **First parameter - name as string**: The value for the first parameter is the name of the function as it will appear in the Azure portal. Those names are listed alphanumerically in the portal, so you may want to use a naming convention that groups similar functions together by purpose, such as `vacationGet` or by method, such as `getVacation`. You may also choose a different case such as snake_case, kebab-case, or camelCase. 
* **Second parameter - handler function**: The value for the second parameter is the name of the function handler as it is imported and used in the code. This name should be descriptive and match the purpose of the function. It can conform to naming conventions you already have for functions in your code base and may be enforced with typical code conformity tools.

## Create the remaining functions

There are four endpoints in the Node.js Express application, and you just created the function for the `GET` endpoint. Now create functions for the remaining route endpoints.

| Method | HTTP trigger name   | Route  |
| ------- | ------------------ | -------|
| `POST`    | `postVacation`   | `vacations` |
| `PUT`     | `updateVacation` | `vacations/{id}` |
| `DELETE`  | `deleteVacation` | `vacations/{id}` |

While the GET and POST routes are the same. The `PUT` and `DELETE` routes use a parameter to identify which vacation to use.

### Create the HTTP POST function

Create the `POST` function that handles adding a vacation.

1. In Visual Studio Code, open the command palette with <kbd>Ctrl</kbd> + <kbd>Shift</kbd> +<kbd>P</kbd> and type `Azure Functions: Create Function` and press <kbd>Enter</kbd>.
1. Select **HTTP Trigger** as the type, and *postVacation* as the name.
1. Add the _vacationService_ import statement to the file.

   ```typescript
   import { vacationService } from '../services';
   ```
1. Replace the boilerplate `postVacation` function with the following code for data access and error handling.

    ```typescript
    export async function postVacation(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
        context.log(`HTTP function processed request for URL: "${request.url}"`);
    
        try {
            const vacation = await request.json() as Vacation;
    
            // Validate the vacation object
            if (!vacation || typeof vacation !== 'object' || !vacation.name || !vacation.description) {
                return {
                    status: 400,
                    jsonBody: { 
                        error: 'Invalid or missing vacation data.' 
                    }
                };
            }
    
            // Data access logic
            const newVacation = vacationService.addVacation(vacation); 
    
            // Successfully added the vacation
            return {
                status: 201,
                jsonBody: newVacation
            };
        } catch (error: unknown) {
            const err = error as Error;
            context.error(`Error create vacation: ${err.message}`);
    
            return {
                status: 500,
                jsonBody: {
                    error: 'Failed to create vacation'
                }
            };
        }
    }
    ```

    To read the incoming vacation data, you use the `request.json()` method. This method returns a promise that resolves to the JSON data in the request body. You then use the `await` keyword to wait for the promise to resolve. The `as Vacation` syntax is a type assertion that tells TypeScript to treat the result as a `Vacation` object.

    ```typescript
    const vacation = await request.json() as Vacation;
    ```

1. Move the route definition from the _postVacation_ file to the _index.ts_ file. Update the method property array to `POST`. 

    ```typescript
    app.http('post-vacation', {
        methods: ['POST'],
        route: 'vacations',
        authLevel: 'anonymous',
        handler: postVacation
    });
    ```
    

### Create the HTTP PUT function

Create the `PUT` function that handles adding a vacation.

1. In Visual Studio Code, open the command palette with <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> and type `Azure Functions: Create Function` and press <kbd>Enter</kbd>.
1. Select **HTTP Trigger** as the type, and *updateVacation* as the name.
1. Add the _vacationService_ import statement to the file.

   ```typescript
   import { vacationService } from '../services';
   ```
1. Replace the boilerplate `updateVacation` function with the following code for data access and error handling.

    ```typescript
    export async function updateVacation(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
      try {
        const id = request.params.id;
        const { name, description } = await request.json() as Vacation;
        
        // Data access logic
        const updatedVacation = vacationService.updateVacation({ id, name, description });
        
        if (updatedVacation !== undefined) {
          return {
            status: 200,
            jsonBody: {
              updatedVacation
            }
          };
        } else {
          return {
            status: 404,
            jsonBody: {
              error: `Vacation with ID ${id} not found`
            }
          };
        }
      } catch (error: unknown) {
        const err = error as Error;
        context.error(`Error updating vacation: ${err.message}`);
        
        return {
          status: 500,
          jsonBody: {
            error: 'Failed to update vacation'
          }
        };
      }
    };
    ```

    The `request.params.id` property is used to get the vacation ID from the URL. The `request.json()` method is used to get the vacation data from the request body. The `as Vacation` syntax is a type assertion that tells TypeScript to treat the result as a `Vacation` object.


1. Move the route definition from the _putVacation_ file to the _index.ts_ file. Update the method property array to `PUT`. 

    ```typescript
    app.http('updateVacation', {
        methods: ['PUT'],
        route: 'vacations/{id}',
        authLevel: 'anonymous',
        handler: updateVacation
    });
    ```

### Create the HTTP DELETE function

Create the `DELETE` function that handles adding a vacation.

1. In Visual Studio Code, open the command palette with <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> and type `Azure Functions: Create Function` and press <kbd>Enter</kbd>.
1. Select **HTTP Trigger** as the type, and *deleteVacation* as the name.
1. Add the _vacationService_ import to the file.

   ```typescript
   import { vacationService } from '../services';
   ```
1. Replace the boilerplate `deleteVacation` function with the following code for data access and error handling.

    ```typescript
    export async function deleteVacation(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
      context.log(`Http function processed request for url "${request.url}"`);
      
      try {
        
        const id = request.params.id;
    
        if (!id) {
          return {
            status: 400,
            jsonBody: {
              error: 'ID parameter is required'
            }
          };
        }
        
        const deletedVacation = vacationService.deleteVacation(id);
        
        if (deletedVacation) {
          return {
            status: 204,
            jsonBody: {
              deleteVacation
            }
          };
        } else {
          return {
            status: 404,
            jsonBody: {
              error: `Vacation with ID ${id} not found`
            }
          };
        }
      } catch (error: unknown) {
        const err = error as Error;
        context.error(`Error deleting vacation: ${err.message}`);
        
        return {
          status: 500,
          jsonBody: {
            error: 'Failed to delete vacation'
          }
        };
      }
    };
    ```

    The `request.params.id` property is used to get the vacation ID from the URL.

1. Move the route definition from the _deleteVacation_ file to the _index.ts_ file. Update the method property array to `DELETE`. 

    ```typescript
    app.http('deleteVacation', {
        methods: ['DELETE'],
        route: 'vacations/{id}',
        authLevel: 'anonymous',
        handler: deleteVacation
    });
    ```

Go to the next unit to review the Azure Functions application you created.
