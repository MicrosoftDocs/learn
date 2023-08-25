In this exercise, you move the static data from the app into a mock server, and then you use the actual server.

## Use a mock server

At this point, you have a front-end app with static data inside of the app. You want to move the static data into a mock server, while you're waiting for the back-end team to finish building the API. Performing this step will set you up nicely for using the actual API, once it's done.

1. In _Pizza.jsx_, replace the code with the following code:

    :::code language="javascript" source="../code/with-components-and-fetch/Pizza.jsx":::

    The data is fetched with a call to a mocked API instead of a front-end app's in-memory array. Notice that the URL used is `/pizza` without the reference to the back-end server. This is because a proxy make the requests toward the mocked API.

1. Create a file named _db.json_ in the _PizzaClient_ directory. Insert the following content:

    :::code language="json" source="../code/mock-server/db.json" :::

   The above is a JSON representation of the deleted JavaScript array.
 
1. Right-click on the **PizzaClient** subfolder and select **Open in integrated terminal**. 
1. Start the mock API with the following command in that new terminal.

    ```bash
    npx json-server --watch --port 5100 db.json
    ```

    Running this code starts the mock server, and output similar to the following appears:

   ```output
   \{^_^}/ hi!
   Loading db.json
   Done
    
   Resources
   http://localhost:5100/pizza
    
   Home
   http://localhost:5100
   ```

1. Open the `vite.config.json` and replace it with the following to allow for a proxy to the mock server.

    :::code language="javascript" source="../code/with-components-and-fetch/vite.config.js":::

    
    Vite reloads the React app to use the new proxy configuration.

1. Use your app in the browser to fetch data from the mock API. Create, update, and delete pizzas to make sure the changes work. 

1. Use <kbd>Ctrl</kbd> + <kbd>C</kbd> to stop the server.

## Use the server API

Suppose the back-end team has now finished building the server. To use the server, you just need to fetch the code from GitHub and run it and configure CORS as well.

1. In the terminal with the mock database server, press **Ctrl**+**C** to stop the server.
1. The back-end project is in the PizzaStore subdirectory. Right-click on that subdirectory and select **Open in integrated terminal.**.

1. Run `dotnet ef database` to apply the migrations that will create a database with tables.

   ```bash
   dotnet ef database update
   ```

   > [!NOTE]
   > If the `dotnet ef` can't be found, install it with `dotnet tool install -g dotnet-ef` then repeat the previous command.

1. In the file explorer, browse to the _PizzaStore_ directory, and open _Program.cs_. Replace with the following code to enable CORS (the CORS-related code is highlighted):

   :::code language="csharp" source="../code/dot-net-server/Program-cs-full.cs" highlight="14-27,38,39":::

   The changes will configure CORS. You'll be able to read and write toward the API, despite the front-end app and API running on different ports.

1. Start the .NET Core API in the terminal. The server runs on port 5100.

    ```dotnetcli
    dotnet run
    ```

1. In the Visual Studio Code panel, typically found below the editor region, select **Ports**. The **Ports** panel appears.

1. Find the local address for the API on port 5100. However over the address and select **Copy local address**.

1. Paste this value as the proxy property in the Vite React **vite.config.js** so the front-end app uses the correct server port.

1. In a browser, use the app, it displays one item with the title, _Pepperoni_.

Congratulations, you've created a full stack application! The React front-end app is reading data from a back-end database via a minimal API.
