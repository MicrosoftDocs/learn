In this exercise, you move the static data from the app into a mock server, and then you use the actual server.

## Use a mock server

At this point, you have a front-end app with static data inside of the app. You want to move the static data into a mock server, while you're waiting for the back-end team to finish building the API. Performing this step will set you up nicely for using the actual API, once it's done.

1. In _Main.js_, locate and delete the following code:

   ```javascript
   let pizzas = [{
      id: 1, name: 'Cheese pizza', description: 'very cheesy'
   },
   {
      id: 2, name: 'Al Tono pizza', description: 'lots of tuna'
   }];
   ```

1. Create a file named _db.json_ file in the _pizza-web_ directory. Insert the following content:

   ```json
   {
     "pizzas" : [{
        "id": 1, 
        "name": "Cheese pizza", 
        "description": "very cheesy"
      },
      {
        "id": 2, 
        "name": "Al Tono pizza", 
        "description": "lots of tuna"
      }]
   }
   ```

   The above is a JSON representation of the deleted JavaScript array.

1. Locate the definition of your `Main` component in _Main.js_, and change the definition of `Main` to the following content (don't change anything else):

   ```javascript
   const Main = () => {
      const [pizzas, setPizzas] = useState([]);
      useEffect(() => {
        fetchData();
      }, [])
      
      function fetchData() {
        fetch("/pizzas")
          .then(response => response.json())
          .then(data => setPizzas(data)) 
      }
    
      const data = pizzas.map(pizza => <Pizza pizza={pizza} />)
    
      return (<React.Fragment>
        {pizzas.length === 0 ?
         <div>No pizzas</div> :
         <div>{data}</div>
        }
      </React.Fragment>)
    }
   ```

   The above call to `useState()` creates a state with a list `pizzas` and a method to change the content in `pizzas` called `setPizzas()`. You also added `useEffect()` which is used to call side effects. At closer inspection, you are calling `fetchData()` inside of `useEffect()` which triggers a call to your API, which in turn fetches your data from the backend, and ends up calling `setPizzas()` to update your React app.

   Also change the `import` at the top from:

   ```javascript
   import React, { useState } from "react";
   ```

   To:

   ```javascript
   import React, { useState, useEffect } from "react";
   ```

   The method `fetchData()` has been added, and it's being invoked. This action triggers a `GET` request to `http://localhost:5000/pizzas`. Next, you need to ensure that the mock server is up and running.

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

1. Add the following property to _package.json_ :

   ```json
   "proxy": "http://localhost:5000",
   ```

   API calls from the frontend will be proxied to `http://localhost:5000`.

1. Save all your changes and start the app:

   ```bash
   yarn start
   ```

   Your app is now pulling data from the mock API!

## Use the server API

Suppose the back-end team has now finished building the server. To use the server, you just need to fetch the code from GitHub and run it. You might need to configure CORS as well.

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

   :::code language="csharp" source="../code/minimal-spa-use-server-api.cs" highlight="6, 23-30, 39":::

   The changes will configure CORS. You'll be able to read and write toward the API, despite the frontend and back end running on different ports.

1. Save all your changes, and then start the API in the terminal with `dotnet run`.

   The server runs on port 5059.
   
1. Modify the proxy property in _package.json_ so the front-end app uses the correct server port:

   ```
   "proxy": "http://localhost:5059",
   ```

1. In the terminal running the frontend app, stop the app with **Ctrl**+**C**. Restart the frontend with `yarn start`.

   Upon loading the app, it displays one item with the title, _Pepperoni_.

Congratulations, you've created a full stack application! The React frontend is reading data from a backend database via a minimal API.
