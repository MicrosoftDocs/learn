In the previous exercise, you wrote code for your team's API to implement database operations. In this exercise, you'll test the API now that it's connected to the database.

## Run the API

1. In the terminal window, run the app with the following command:

    ```dotnetcli
    dotnet run
    ```

1. Inspect the output from running the app.
    - EF Core echoes SQL commands as `info` log events as they execute.
    - If the database does not already exist, then the tables and indexes are defined with `CREATE` SQL commands.
    - If the database has not yet been seeded, then `INSERT` commands are executed to add the seed data.
    - For security, the parameter values are not echoed to the console. This can be changed using [EnableSensitiveDataLogging](/ef/core/logging-events-diagnostics/extensions-logging#sensitive-data)

1. Use SQLite Explorer to explore the seeded database. Each table has data.

## Navigate to Swagger

Now that the API is running, we'll want to test the API to see if the operations work as expected. The API is configured to use [Swagger](https://swagger.io/) to provide a test UI. Swagger is a tool that helps you design, build, document, and consume RESTful web services.

1. In the output from running the app, find the HTTP URL where the app is listening. The output looks similar to the following:

    ```console
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5200
    ```

1. Open the URL with **Ctrl+*Click***. The browser opens to the `/` location for the API, which returns the text: `Contoso Pizza management API. Navigate to /swagger to open the Swagger test UI.`

1. In the browser's navigation bar, add `/swagger` to the URL and press **Enter** to navigate.

## Test operations

In the following steps, you'll use the Swagger UI to test each of the API's operations the same way a client application would. After each operation, inspect the database in SQLite Explorer to see the database changes as they happen.

1. Request the full list of pizzas:
    - Under the **Pizza** heading, expand the **GET /Pizza** operation and select **Try it out**.
    - Select the **Execute** button.

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

    > [!NOTE]
    > **Why are the `sauce` and `toppings` properties null?** Remember in the `PizzaService.GetAll` method, you didn't use the `Include` extension method to specify that the navigation properties should be loaded.

1. Let's request a single pizza:
    - Scroll down to the **GET /Pizza{id}** operation, expand it, and select **Try it out**.
    - In the **id** field, enter `2` and select **Execute**.

    The API returns the "Hawaiian" pizza. Notice that the `sauce` and `toppings` properties are populated because the `PizzaService.GetById` method uses the `Include` extension method.

1. Add a new pizza:
    - Scroll up to the **POST /Pizza** operation (located between the **GET** operations you just used), expand it, and select **Try it out**.
    - In the **Request body** text box, paste the following JSON:

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

    - Select **Execute**.

    The API returns the new pizza with the `id` property populated.

1. Add another topping to the BBQ Beef pizza:
    - Scroll down to the **PUT /Pizza{id}/addtopping** operation, expand it, and select **Try it out**.
    - In the **id** field, enter `4`.
    - In the **toppingId** field, enter `5`.
    - Select **Execute**.

    The API updates the pizza and returns a success code. In the database, a record is added to `PizzaTopping` that associates the pizza with the topping.

1. Change the sauce on the BBQ Beef pizza:
    - Scroll down to the **PUT /Pizza{id}/updatesauce** operation, expand it, and select **Try it out**.
    - In the **id** field, enter `4`.
    - In the **sauceId** field, enter `2`.
    - Select **Execute**.

    The API updates the pizza and returns a success code. In the database, the `Pizza` record is updated to associate the pizza with the new sauce.

1. Return to the **GET /Pizza{id}** operation and request the BBQ Beef pizza by setting the **id** field to 4 and selecting **Execute**. Notice that the `sauce` and `toppings` properties are populated.

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

1. You've realized a smoked brisket pizza with Alfredo sauce and pineapple is a terrible idea. Delete the pizza:
    - Find the **DELETE /Pizza{id}** operation, expand it, and select **Try it out**.
    - In the **id** field, enter `4`.
    - Select **Execute**.

    The API deletes the pizza and returns a success code. In the database, the `Pizza` record is deleted, as well as the associated records in `PizzaTopping`.

1. In the terminal with the running app, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the running app.

> [!TIP]
> You may experiment with the app as you wish. Whenever you'd like to start with a fresh database, stop the app and delete the *ContosoPizza.db*, *.db-shm*, and *.db-wal* files, and then run the app again.

Great work! The app is working with your database as expected! In the next unit, you'll scaffold entity models from an existing database.
