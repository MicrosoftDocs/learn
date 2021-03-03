React components are designed to be reusable units. To enable reuse, components allow for data to be passed into them through properties or `props`.

`props` are read-only values available to a single instance of a component. They can be set programmatically or with the same syntax you use when setting attributes for HTML elements. Unlike normal HTML, `props` aren't limited to strings or primitive values; they can be complex objects or arrays. `props` is available as a property of `this` inside a component. `props` can contain as many properties as your component needs, and is capable of storing objects or any other data type.

## Scenario

To make components reusable, you typically pass the data to be displayed as props. Here, you'll create a component named `RecipeTitle` to display the title of the recipe, which will be passed in as a property.

### Create the component

1. Open the **starter** folder in Visual Studio Code, as highlighted in the overview.
1. Inside Visual Studio Code, open **src/RecipeTitle.jsx**.
1. Add the following code under the line `// TODO: Create RecipeTitle component`:

    ```javascript
    // TODO: Create RecipeTitle component
    function RecipeTitle(props) {
        return (
            <section>
                <h2>{ props.title }</h2>
            </section>
        )
    };
    ```

#### Explore the code

`RecipeTitle` looks similar to a base React component, with two key updates.

First, it accepts a parameter named `props`. This will automatically contain all attributes or properties passed into the component when it's used.

Second, you're able to use the values contained in `props` like you would any normal parameter. You're looking for one value named `title`, which you display inside an `h2` element.

### Use the component

Now let's update **App.jsx** to use the new `RecipeTitle` component with the `title` property.

1. Open **App.jsx**
1. Add the following code under the line that reads `TODO: Add recipe object` to create an object for our recipe:

    ```javascript
    // TODO: Add recipe object
    const recipe = {
        title: 'Mashed potatoes',
        feedback: {
            rating: 4.8,
            reviews: 20
        },
        ingredients: [
            { name: '3 potatoes, cut into 1/2" pieces', prepared: false },
            { name: '4 Tbsp butter', prepared: false },
            { name: '1/8 cup heavy cream', prepared: false },
            { name: 'Salt', prepared: false },
            { name: 'Pepper', prepared: false },
        ],
    };
    ```

    > [!NOTE]
    > Over the course of the exercises in this module, you'll use the entire `recipe` object. For now, your focus is on `title`.

1. Add the following code under the line that reads `TODO: Add RecipeTitle component`:

    ```jsx
    {/* TODO: Add RecipeTitle component */}
    <RecipeTitle title={ recipe.title } />
    ```

#### Explore the code

Start by creating an object to represent the recipe you want to display, and add a `title` property to it. Then use the `RecipeTitle` component in the same way you would use an HTML element or any other React component. The key difference is that you set the `title` attribute to be the value of `recipe.title`. By using the handlebars (`{ }`), you're able to dynamically read the value.

> [!NOTE]
> If the value you wanted to use for `title` had been a string literal, you could set the property by using the syntax `title='Recipe title`.

### Display the page

1. Save all files.
1. Return to your browser and refresh the page. You should now see the title of **Mashed Potatoes** displayed on the page.
