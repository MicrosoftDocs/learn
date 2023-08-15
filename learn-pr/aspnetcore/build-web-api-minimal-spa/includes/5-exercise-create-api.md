In this exercise, you move the static data from the app into a mock server, and then you use the actual server.

## Use a mock server

At this point, you have a front-end app with static data inside of the app. You want to move the static data into a mock server, while you're waiting for the back-end team to finish building the API. Performing this step will set you up nicely for using the actual API, once it's done.

1. In _Pizza.js_, replace the code with the following code:

    :::code language="javascript" source="../code/with-components-and-fetch/Pizza.jsx":::

    The data is now pulled from the API instead of a front-end in-memory array. Notice that the URL used is `/pizza` without the referencee to the back-end server. This is because you'll use a proxy to make requests toward the mocked API.

1. Create a file named _db.json_ file in the _pizza-web_ directory. Insert the following content:

    :::code language="json" source="../code/mock-server/db.json" :::

   The above is a JSON representation of the deleted JavaScript array.
 
1. Run `npx json-server --watch --port 5000 db.json` in a separate terminal. Running this code starts the mock server, and output similar to the following appears:

   ```output
   \{^_^}/ hi!
   Loading db.json
   Done
    
   Resources
   http://localhost:5000/pizza
    
   Home
   http://localhost:5000
   ```

1. Open the `vite.config.json` and replace it with the following to allow for a proxy to the mock server.

    :::code language="javascript" source="../code/with-components-and-fetch/vite.config.js":::

    Your app is now pulling data from the mock API! Create, update, and delete pizzas to make sure the changes work. 

1. Use <kbd>Ctrl</kbd> + <kbd>C</kbd> to stop the server.

## Use the server API

Suppose the back-end team has now finished building the server. To use the server, you just need to fetch the code from GitHub and run it and configure CORS as well.

1. In the terminal with the mock database server, press **Ctrl**+**C** to stop the server.
1. Navigate to the parent of the _pizza-web_ directory, and then download the back-end project:

   ```bash
   cd ..
   git clone https://github.com/MicrosoftDocs/minimal-api-work-with-databases
   ```

1. Set your location to the _PizzaStore_ subdirectory and run `dotnet ef database` to apply the migrations that will create a database with tables.

   ```bash
   cd minimal-api-work-with-databases
   cd PizzaStore
   dotnet ef database update
   ```

   > [!NOTE]
   > If the `dotnet ef` can't be found, install it with `dotnet tool install -g dotnet-ef` then repeat the previous command.

1. In the file explorer, browse to the _PizzaStore_ directory, and open _Program.cs_. Add the following code to enable CORS (the code you need to add is highlighted):

   :::code language="csharp" source="../code/dot-net-server/Program-with-cors.cs":::

   The changes will configure CORS. You'll be able to read and write toward the API, despite the frontend and back-end running on different ports.

1. Save all your changes, and then start the API in the terminal with `dotnet run`.

   The server runs on port 5000.
   
1. Modify the proxy property in _package.json_ so the front-end app uses the correct server port:

   ```
   "proxy": "http://localhost:5000",
   ```

1. In the terminal running the frontend app, stop the app with **Ctrl**+**C**. Restart the frontend with `npm run dev`.

   Upon loading the app, it displays one item with the title, _Pepperoni_.

Congratulations, you've created a full stack application! The React frontend is reading data from a backend database via a minimal API.
