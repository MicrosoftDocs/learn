In this exercise, you build the front-end app. You start with a scaffold, and then you build out the view you need and add data to the app.

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet6-sdk-version.md)]

## Scaffold an app

To scaffold an app, you use the `create-react-app` scaffolder. By using `npx`, you can call the scaffolder and have it create a working React app in a matter of seconds.

1. Create the app by using `npx create-react-app`:

    ```bash
    npx create-react-app pizza-web
    ```

    What you get is a directory, _pizza-web_, that contains your scaffolded React app. 

1. Start the app by calling `yarn start`:

   ```bash
   cd pizza-web
   yarn start
   ```

1. In your browser, go to `http://localhost:3000`.

   You should see the page render like this example:

   :::image type="content" source="../media/react.png" alt-text="Screenshot that shows a rendered SPA app.":::

## Build the master view

Next, you build a component that's capable of handling a list of pizzas.

Create a file, _Main.js_, and give it the following content:

   ```javascript
   import React, { useState } from "react";

   let pizzas = [{
      id: 1, name: 'Cheese pizza', description: 'very cheesy'
    },
    {
      id: 2, name: 'Al Tono pizza', description: 'lots of tuna'
   }];

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
     const data = pizzas.map(pizza => <Pizza pizza={pizza} />)

     return (<React.Fragment>
       {data}
     </React.Fragment>)
     }

   export default Main;
   ```

What you have at this point are two components:

- **Pizza:** This component is capable of rendering on the `Pizza` object. It also listens to changes from input and runs the `update()` function, if either text field changes. 
- **Main:** This component renders the initial data, a list of pizzas.

Take note of the use of the `dirty` variable. This variable keeps track of whether a user has attempted to change the input. If the input in either field has been changed, `dirty` is set to `true`, and the **Save** button is rendered. If the **Save** button is invoked, the `onSave()` method will be invoked. Ideally, this place in the code is where you want to make any calls to a back end, to notify the back end that a pizza item has been changed.

## Add some CSS

It's always great to improve the appearance of the UI. There's more than one way to do so for React. In this case, you use the `styled-components` library.

1. Run `yarn add` to add the `styled-components` library:

   ```bash
   yarn add styled-components
   ```

1. Configure _package.json_ by adding the following entry:

   ```json
   "resolutions": {
      "styled-components": "^5"
   }
   ```

   This entry will remove lots of warnings that you would otherwise get.

1. Make the following changes to _Main.js_ (the changes are highlighted):

   :::code language="javascript" source="../code/minimal-spa-add-some-css.js" highlight="2, 4-31, 55, 57, 60, 63, 65":::

   Now, you have components that render with a decent appearance. Next, ensure that your program is using this component.

1. Open _App.js_, and ensure that it has the following content:

   ```javascript
    import './App.css';

    import Main from './Main.js';
    
    function App() {
      return (
        <div className="App">
          <Main />
        </div>
      );
    }
    
    export default App;
    
   ```

1. Run `yarn start` to run the app:

   ```bash
   yarn start
   ```

   You should see the following image:

   :::image type="content" source="../media/ui.png" alt-text="Screenshot of the rendered Pizza app.":::

1. Type in an input field. It should mark it as *dirty*, and the **Save** button for that item should appear.

   :::image type="content" source="../media/ui-changed.png" alt-text="Screenshot that shows editing an item in the Pizza app.":::
