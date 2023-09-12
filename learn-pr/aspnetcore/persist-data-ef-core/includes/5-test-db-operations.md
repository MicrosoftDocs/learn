In the previous exercise, you wrote code for your team's API to implement database operations. In this exercise, you test the API now that it's connected to the database.

## Run the API

1. In the terminal pane, run the app:

   ```dotnetcli
   dotnet run
   ```

1. Inspect the output from running the app, and note the following information:

    - EF Core echoes SQL commands as `info` log events when they execute.
    - If the database does not already exist, the tables and indexes are defined by using SQL `CREATE` commands.
    - If the database has not yet been seeded, `INSERT` commands are executed to add the seed data.
    - For security, the parameter values are not echoed to the console. You can change this setting by using [EnableSensitiveDataLogging](/ef/core/logging-events-diagnostics/extensions-logging#sensitive-data).

1. Use SQLite Explorer to explore the seeded database. Each table has data.

## Go to Swagger

Now that the API is running, test the API to see if the operations work as expected. The API is configured to use [Swagger](https://swagger.io/) to provide a test UI. Swagger is a tool that helps you design, build, document, and consume RESTful web services.

1. In the output that appears after you run the app, find the HTTP URL where the app listens. The output looks similar to the following example:

    ```console
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5200
    ```

1. To open the URL, select it while holding <kbd>Ctrl</kbd>. The browser opens to the `/` location for the API, which returns the text `Contoso Pizza management API. Go to /swagger to open the Swagger test UI.`

1. In the browser's address bar, add `/swagger` to the end of the URL and select <kbd>Enter</kbd>.

## Test CRUD operations

In the following steps, you use the Swagger UI to test each of the API's operations the way that a client application would. After each operation, inspect the database in SQLite Explorer to see the database changes as they happen.

1. Request the full list of pizzas:

    1. Under the **Pizza** heading, expand the **GET /Pizza** operation and select **Try it out**.
    1. Select the **Execute** button.

    The API returns the list of pizzas as JSON (under **Response body**).

    ```json
    [
        {
            "id": 1,
            "name": "Meat Lovers",
            "sauce": null,
            "toppings": null
        },
        {
            "id": 2,
            "name": "Hawaiian",
            "sauce": null,
            "toppings": null
        },
        {
            "id": 3,
            "name": "Alfredo Chicken",
            "sauce": null,
            "toppings": null
        }
        ]
    ```

   > [!TIP]
   > *Why are the `sauce` and `toppings` properties null?* This result is expected because in the `PizzaService.GetAll` method, you didn't use the `Include` extension method to specify that the navigation properties should be loaded.

1. Request a single pizza:

    1. Scroll down to the **GET /Pizza{id}** operation and expand it. Then select **Try it out**.
    1. In the **id** field, enter `2` and select **Execute**.

    The API returns the "Hawaiian" pizza. Notice that the `sauce` and `toppings` properties are populated because the `PizzaService.GetById` method uses the `Include` extension method.

1. Add a new pizza:

    1. Scroll up to the **POST /Pizza** operation (located between the **GET** operations you just used) and expand it. Then select **Try it out**.
    1. In the **Request body** text box, paste the following JSON:

        ```json
        {
          "name": "BBQ Beef",
          "sauce": {
            "name": "BBQ",
            "isVegan": false
          },
          "toppings": [
            {
              "name": "Smoked Beef Brisket",
              "calories": 250
            }
          ]
        }
        ```

    1. Select **Execute**.

    The API returns the new pizza with the `id` property populated.

1. Add another topping to the BBQ Beef pizza:

    1. Scroll down to the **PUT /Pizza{id}/addtopping** operation and expand it. Select **Try it out**.
    1. In the **id** field, enter **4**.
    1. In the **toppingId** field, enter **5**.
    1. Select **Execute**.

    The API updates the pizza and returns a success code. In the database, a record is added to `PizzaTopping` to associate the pizza with the topping.

1. Change the sauce on the BBQ Beef pizza:

    1. Scroll down to the **PUT /Pizza{id}/updatesauce** operation and expand it. Select **Try it out**.
    1. In the **id** field, enter **4**.
    1. In the **sauceId** field, enter **2**.
    1. Select **Execute**.

    The API updates the pizza and returns a success code. In the database, the `Pizza` record is updated to associate the pizza with the new sauce.

1. Return to the **GET /Pizza{id}** operation and request the BBQ Beef pizza by setting the **id** field to **4**. Then, select **Execute**. Notice that the `sauce` and `toppings` properties are populated.

    ```json
    {
        "id": 4,
        "name": "BBQ Beef",
        "sauce": {
            "id": 2,
            "name": "Alfredo",
            "isVegan": false
        },
        "toppings": [
            {
            "id": 5,
            "name": "Pineapple",
            "calories": 75
            },
            {
            "id": 6,
            "name": "Smoked Beef Brisket",
            "calories": 250
            }
        ]
    }
    ```

1. You've realized that a smoked brisket pizza with Alfredo sauce and pineapple is a terrible idea.

    Delete the pizza:

    1. Find the **DELETE /Pizza{id}** operation and expand it. Select **Try it out**.
    1. In the **id** field, enter **4**.
    1. Select **Execute**.

    The API deletes the pizza and returns a success code. In the database, the `Pizza` record and the associated records in `PizzaTopping` are deleted.

1. In the terminal with the running app, select <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the running app.

> [!TIP]
> You can experiment with the app. Whenever you'd like to start with a fresh database, stop the app and delete the *ContosoPizza.db*, *.db-shm*, and *.db-wal* files. Then run the app again.

Great work! The app is working with your database as expected! In the next unit, you'll scaffold entity models from an existing database.
