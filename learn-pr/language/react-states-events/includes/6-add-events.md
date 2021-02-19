Storing state in the core component of our application (`Recipe`) allows us to read the current values of all important properties. We don't have to interact with each component. We can also centralize events, ensuring data is modified in only one location.

## Scenario

We want to allow users of the application to tap an item in the ingredient list when they complete it. We'll mark the item as `prepared` in the state. This setting will be reflected across the application. When the values change, the component detects the updates and reevaluates as needed.

## Add the method for click events

1. Open the *App.jsx* file.
1. Create an event listener named `ingredientClick`. Add it under the comment that reads, `TODO: Create ingredientClick event listener`.

    ```javascript
    function ingredientClick(index) {
        const updatedRecipe = { ... recipe };
        updatedRecipe.ingredients[index].prepared = !updatedRecipe.ingredients[index].prepared;
        setRecipe(updatedRecipe);
    }
    ```

    The logic starts by creating a copy of `recipe` by using the spread operator. We then retrieve the updated `ingredient` by using the `index`. We reverse the value of `prepared`. Finally, we replace the `recipe` object in state by using `setRecipe`.

1. Add `IngredientList`, a component that displays the ingredients of a recipe. To do so, add the following code after the comment that reads, `TODO: Pass ingredients and event listener to IngredientList`.

    ```jsx
    <IngredientList ingredients={recipe.ingredients} onClick={ ingredientClick } />
    ```

    Notice we can pass the `ingredientClick` function as we would pass any other prop to a component.

## Update IngredientList to use event listener

In React, properties (or *props*) can be any JavaScript type, including functions. So we can set up an event handler as a prop. This setup allows us to centralize event handling. 

Let's update `IngredientList` to use the `ingredientClick` function we created earlier:

1. Open the *IngredientList.jsx* file. Notice the existing component. We'll use this component to show how to use events.
1. Below the `TODO: Add onClick event` comment, add the following JSX.

    ```jsx
    onClick={ () => props.onClick(index) }
    ```

    Notice we can pass a parameter into the prop `onClick` function.

    > [!NOTE]
    > There's no particular reason we used the name `onClick` on the component's `props`. It was just the name we chose. It was passed in earlier from the *App.jsx* file.

## Test the page

1. Save all of the files.
1. Return to the browser and refresh the page. If you select the ingredients, the line-through status should change. It changes because the `prepared` property is being updated.
