Because React is based on JSX, which is a combination of JavaScript and XML/HTML, we have the ability to generate HTML dynamically, fully integrated with our JavaScript.

## Scenario

We want to display the list of ingredients, including adding a line-through for any items marked as prepared. We will do this by creating a new CSS file for the style, and then a new component for our list of ingredients.

## Create the new style

1. Create a new file in **src** named **IngredientList.css**
1. Add the following code to **IngredientList.css**

    ```css
    .prepared {
        text-decoration: line-through;
    }

## Create the IngredientList component

Because your HTML is integrated with JavaScript in JSX, we rely on JavaScript for logic and looping. To display a set of items contained in an array, you typically use the `map` function. `map` is designed to create a new array of items based on the result of a function call. If we wanted to display a list of titles in an ordered list, we use both `map` and the `{ }` syntax we learned earlier.

1. Inside **src** create a new file named **IngredientList.jsx**
1. Just below the line which reads `import ReactDOM from 'react-dom';`, which should be line 3, add the following code.

    ```javascript
    import './IngredientList.css'
    import React from 'react';

    function IngredientList(props) {
        // Create the list items using map
        const ingredientListItems = props.ingredients.map((ingredient, index) => {
            return (
                // Return the desired HTML for each ingredient
                <li key={index} className={ ingredient.prepared ? 'prepared' : '' }>
                    { ingredient.name }
                </li>
            );
        });

        // return the HTML for the component
        // ingredientListItems will be rendered as li elements
        return (
            <ul>
                { ingredientListItems }
            </ul>
        );
    }

    export default IngredientList;
    ```

### Exploring the code

We start by creating an array of strings to contain our list of `ingredients`. We want each ingredient to be displayed as a list item. We implement this by using `map`.

As highlighted before, `map` behaves similarly to a for each statement. It will execute the function once for each item in the array. We want to display a collection of `li` HTML elements, so we return the appropriate JSX, with `{ingredient}` inside `li`.

## Update App to use IngredientList

Let's display our list of ingredients!

1. Open **src/app.jsx**
1. After the line which reads `TODO: Import IngredientList` add the following code:

    ```javascript
    // TODO: Import IngredientList
    import IngredientList from './IngredientList'
    ```

1. After the line which reads `TODO: Add IngredientList component` add the following JavaScript:

    ```javascript
    {/* TODO: Add IngredientList component */}
    <IngredientList ingredients={recipe.ingredients} />
    ```

## Display the results

Save all the files. The browser will automatically update and display the new updates. Notice the list of ingredients, with the last two items shown as prepared with a line through them.

:::image type="content" source="../media/ingredients.png" alt-text="Screenshot of list of ingredients.":::
