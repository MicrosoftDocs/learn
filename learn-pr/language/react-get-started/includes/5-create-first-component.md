React development is based on *components*. These self-contained units are designed for reuse and modularity. React projects typically contain many components.

A component can be either a function or a class. Most React developers prefer to create components with functions, so we'll focus on this style. 

Applications generally have one core component, commonly called an `App`. The `App` acts as the root of the application. We'll start by creating our `App` component.

## Create the component

1. Open Visual Studio Code.
1. Create a new file in *src*. Name it *App.jsx*.
1. Add the following code:

    ```javascript
    import React from 'react';

    function App() {
        return (
            <article>
                <h1>Recipe Manager</h1>
            </article>
        )
    }

    export default App;
    ```

### Explore the code

We start the *App.jsx* file by importing `React` so we can use JSX syntax. We then create a function named `App`, like we would create any other function in JavaScript. Finally, we export the function by using the standard JavaScript syntax. The core of our component is contained in the `return` statement. 

Notice that we're using HTML (technically XML) embedded in JavaScript. This functionality shows the power of JSX. We can use the logic and power of JavaScript to create self-contained units of work (components).

The HTML returned by the function (or component) is displayed on the page. The heading contains the text **Recipe Manager**.

> [!NOTE]
> The `h1` element nests inside an HTML 5 `article` element. Because JSX uses XML, we must have one root element. The `article` element is the root for this component. This structure allows us to add HTML and other React components as our application grows.

## Update the application to use the core component

Let's update our application to use our new component.

1. Open *index.jsx*.
1. After the line that reads `import ReactDOM from 'react-dom';` (it should be line 3), add the following code:

    ```javascript
    import App from './App';
    ```

1. Find the code that reads `<h1>Hello, world!</h1>`. Replace this initial message with a call to the `App` component:

    ```jsx
    <App />
    ```

### Explore the code

Here are the complete contents of *index.jsx* now:

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(
    <App />,
    document.getElementById('app')
);
```

Our `import` statement imports our component by using the same syntax we would use for any other module. We can now use the component as if it were HTML.

> [!NOTE]
> Because JSX uses XML syntax, we must close the `App` tag. We can do this by using either the long-form syntax `<App></App>` or the "self-closing" shorthand `<App />`. Both options work the same, but most developers use the shorthand option.

## See the results

Save all of the files. The browser automatically refreshes with the results!

![Screenshot of the Recipe Manager heading in the browser window.](../media/recipe-manager.png)
