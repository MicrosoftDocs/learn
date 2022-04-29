In this exercise, you move the static data from the app into a mock server, and then you use the actual server.

## Use a mock server

At this point, you have a front-end app with static data inside of the app. You want to move the static data into a mock server, while you're waiting for the back-end team to finish building the API. Performing this step will set you up nicely for using the actual API, once it's done.

1. In _Main.js_, locate this part of the code and cut it out:

   ```javascript
   let pizza = [{
      id: 1, name: 'Cheese pizza', description: 'very cheesy'
    },
    {
      id: 2, name: 'Al Tono pizza', description: 'lots of tuna'
    }];
   ```

1. Create a file, _db.json_, and give it the following content:

   ```json
   {
     "pizza" : [{
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

   What you're looking at is a JSON representation of your JavaScript array.

1. Locate the definition of your `Main` component in _Main.js_, and change the definition of `Main` to the following content (don't change anything else):

   ```javascript
   const Main = () => {
      const [pizzas, setPizzas] = useState([]);
      useEffect(() => {
        fetchData();
      }, [])
      
      function fetchData() {
        fetch("/api/pizza")
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

1. Run `npx json-server --watch --port 5000 db.json` in a separate terminal. Running this code should bring up the mock server, and you should see an output like the following:

   ```output
   \{^_^}/ hi!
   Loading db.json
   Done
    
   Resources
   http://localhost:5000/pizza
    
   Home
   http://localhost:5000
   ```

1. In another terminal, run `yarn start`. It should bring up your React app:

   ```bash
   yarn start
   ```

   Your app should render normally at `http://localhost:3000`.

1. Add a proxy by opening up _package.json_ and the following entry:

   ```json
   "proxy": "http://localhost:5000"    
   ```

   Any calls to */api/* will be translated as calling `http://localhost:5000`.

1. Restart your app with `yarn start`:

   ```bash
   yarn start
   ```

   Your app should start as normal on `http://localhost:5000`.

## Use the server API

Suppose the back-end team has now finished building the server. To use the server, you just need to fetch the code from GitHub and run it. You might need to configure CORS as well.

1. Clone the back-end project by running `git clone`:

   ```bash
   cd ..
   git clone https://github.com/MicrosoftDocs/minimal-api-work-with-databases
   cd minimal-api-work-with-databases
   cd PizzaStore
   ```

1. In a terminal, run `dotnet ef database` to apply the migrations that will create a database with tables.

   ```bash
   dotnet ef database update
   ```

1. Open _Program.cs_, and add the following code to enable CORS (the code you need to add is highlighted):

   :::code language="csharp" source="../code/minimal-spa-use-server-api.cs" highlight="6, 17-24, 33":::

   The changes will configure CORS. You'll be able to read and write toward the API, despite the front end and back end running on different ports.

1. Start your API with `dotnet run` (ensure that you quit the JSON server first).

   The server runs on port 5059. Adjust the proxy in _package.json_ for the front-end app to match the port the server assumes.

   Your front end should show one item with the title, *Pepperoni*.

Congratulations, you've managed to create a full stack application, with both front and back ends.

## Solution for frontend app

If you get lost by any of the above instructions, here's the code for _Main.js_ file for the frontend project:

```javascript
import React, { useState, useEffect } from "react";

const Pizza = ({ pizza }) => {
   const [data, setData] = useState(pizza);
   const [dirty, setDirty] = useState(false);
   
   function update(value, fieldName, obj) {
      setData({ ...obj, [fieldName] : value });
      setDirty(true);
   }
   
   function onSave() {
      setDirty(false);
      // make rest call
   }
   
   return (<React.Fragment>
      <div>
      <h3>
         <input onChange={(evt) => update(evt.target.value, 'name', data)} value={data.name} /> 
      </h3>
      <div>
         <input onChange={(evt) => update(evt.target.value, 'description', data)} value={data.description} />
      </div>
      {dirty ? 
      <div><button onClick={onSave}>Save</button></div> : null
      }
      </div>
   </React.Fragment>);
}

const Main = () => {
  const [pizzas, setPizzas] = useState([]);
  
  useEffect(() => {
    fetchData();
  }, [])

  function fetchData() {
    fetch("/api/pizza")
      .then(response => response.json())
      .then(data => setPizzas(data)) 
  }

  const data = pizzas.map(pizza => <Pizza pizza={pizza} />)

  return (<React.Fragment>
   {data}
  </React.Fragment>)
}

export default Main;
```