`props` is available as a property of `this` inside a component. `props` can contain as many properties as your component needs, and is capable of storing objects or any other data type.

## Scenario

To make components reusable, we typically pass the data to be displayed as props. We will do this by creating a component named `RecipeTitle` to display the title of the recipe, which will be passed in as a property.

## Create the RecipeTitle component

1. Open the **starter** folder in Visual Studio Code as highlighted in the overview.
1. Inside Visual Studio Code, open **src/RecipeTitle.jsx**
1. Add the following code under the line `// TODO: Create RecipeTitle component`

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

### Exploring the code

`RecipeTitle` looks similar to a base React component, with two key updates.

The first is it accepts a parameter named `props`. This will automatically contain all attributes or properties passed into the component when it is used.

The second is we are able to use the values contained in `props` like we would any normal parameter. We are looking for one value named `title`, which we display inside an `h2` element.

## Use the RecipeTitle component

Let's update **App.jsx** to use the new `RecipeTitle` component with the `title` property.

1. Open **App.jsx**
1. Add the following code below the line which reads `TODO: Add recipe object` to create an object for our recipe:

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
    > Over the course of the exercises in this module we will use the entire `recipe` object. For now our focus will be on `title`.

1. Add the following code below the line which reads `TODO: Add RecipeTitle component`:

    ```jsx
    {/* TODO: Add RecipeTitle component */}
    <RecipeTitle title={ recipe.title } />
    ```

### Exploring the code

We start by creating an object to represent the recipe we wish to display, and add a `title` property to it. We then use the `RecipeTitle` component in the same way we would use an HTML element or any other React component. The key difference is we set the `title` attribute to be the value of `recipe.title`. By using the handlebars (`{ }`) we are able to dynamically read the value.

> [!NOTE]
> If the value we wanted to use for `title` was a string literal, we could set the property by using the syntax `title='Recipe title`.

## Display the page

1. Save all files
1. Return to your browser and refresh the page. You should now see the title of **Mashed Potatoes** displayed on the page.
