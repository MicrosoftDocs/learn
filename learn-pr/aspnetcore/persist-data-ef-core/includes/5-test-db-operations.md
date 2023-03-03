In this unit, you'll use the [HttpRepl](/aspnet/core/web-api/http-repl/) tool to test the API. The API will use your code to interact with the database.

## Run the app and connect

1. From the terminal, run the following command:

    ```dotnet-cli
    dotnet tool install -g Microsoft.dotnet-httprepl
    ```

    This command installs the HttpRepl tool.

1. Run the app with the following command:

    ```dotnetcli
    dotnet run --urls=https://localhost:5101
    ```

    This command launches the app and specifies the listening port to `5101`.

1. Inspect the output from running the app.
    - EF Core echoes SQL commands as `info` log events as they execute.
    - If the database does not already exist, then the tables and indexes are defined with `CREATE` SQL commands.
    - If the database has not yet been seeded, then `INSERT` commands are executed to add the seed data.
    - For security, the parameter values are not echoed to the console. This can be changed using [EnableSensitiveDataLogging](/ef/core/logging-events-diagnostics/extensions-logging#sensitive-data)

1. Use SQLite Explorer to explore the seeded database. Each table has data.
1. Since the terminal is blocked by the running app, open another terminal (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>`</kbd>) to test the app.
1. In the new terminal, run the following command:

    ```dotnetcli
    httprepl https://localhost:5101
    ```

    HttpRepl connects to the running API and uses the OpenAPI specification to discover the available endpoints.

## Test database operations

Now that you've connected with HttpRepl, let's try out our app. After each CRUD operation, inspect the database in SQLite Explorer to see the changes as they happen.

1. At the HttpRepl command prompt, run the following command to list the discovered endpoints.

    ```dotnetcli
    ls
    ```

1. Switch to the `Pizza` endpoint.

    ```dotnetcli
    cd Pizza
    ```

1. Run the following command to get the list of all pizzas:

    ```dotnetcli
    get
    ```

    The API returns the list of pizzas as JSON.

    > [!NOTE]
    > **Why are the `sauce` and `toppings` properties null?** Remember in the `PizzaService.GetAll` method, you didn't use the `Include` extension method to specify that the navigation properties should be loaded.

1. Run the following command to get a single pizza:

    ```dotnetcli
    get 2
    ```

    The API returns the "Hawaiian" pizza. Notice that the `sauce` and `toppings` properties are populated because the `PizzaService.GetById` method uses the `Include` extension method.

1. Run the following command to add a new pizza:

    ```dotnetcli
    post
    ```

    A temporary JSON file opens in your registered JSON editor or a new tab in VS Code. The file contains a template for posting a new pizza. Paste in the following JSON, save, and close the tab/editor.

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

1. Run the following command to add another topping to the new BBQ Beef pizza:

    ```dotnetcli
    put 4/addtopping?toppingId=5 --no-body
    ```

1. Run the following command to change the sauce on the BBQ Beef pizza:

    ```dotnetcli
    put 4/updatesauce?sauceId=2 --no-body
    ```

1. Run the following command to view the current BBQ Beef pizza.

    ```dotnetcli
    get 4
    ```

1. You've realized a smoked brisket pizza with Alfredo sauce and pineapple is a terrible idea. Delete it with the following command:

    ```dotnetcli
    delete 4
    ```

1. Enter `exit` to leave HttpRepl.
1. In the terminal with the running app, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the running app.

> [!TIP]
> You may experiment with the app as you wish. Whenever you'd like to start with a fresh database, stop the app and delete the *ContosoPizza.db*, *.db-shm*, and *.db-wal* files, and then run the app again.

Great work! The app is working with your database as expected! In the next unit, you'll scaffold entity models from an existing database.
