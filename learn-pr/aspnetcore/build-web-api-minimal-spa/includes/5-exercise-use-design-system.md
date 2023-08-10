### Install Fluent UI

To install Fluent UI, run the following command:

```bash
npm install @fluentui/react-components
```

### Import Fluent UI

To import Fluent UI, add the following line to the top of the `Counter.js` file:

```jsx
import { PrimaryButton } from '@fluentui/react';
```


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

1. Open _src/App.js_, and ensure that it has the following content:

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

1. Open a terminal window in Visual Studio Code by pressing **Ctrl**+**\`**.
1. Save all your changes and run `yarn start` to run the app:

   ```bash
   yarn start
   ```

   You should see the following image:

   :::image type="content" source="../media/ui.png" alt-text="Screenshot of the rendered Pizza app.":::

1. Type in an input field. It should mark it as *dirty*, and the **Save** button for that item should appear.

   :::image type="content" source="../media/ui-changed.png" alt-text="Screenshot that shows editing an item in the Pizza app.":::

1. Return to the terminal window and press **Ctrl+C** to end execution.
