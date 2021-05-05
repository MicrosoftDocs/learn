React manages state in a few ways. We'll focus on one of the main ways, *React Hooks*. 

A *Hook* is a mechanism that allows you to access the inner workings of React. You can use Hooks to run code when something changes in React. Or use them to register something with React, such as state. When we create state by using the `useState` Hook, for example, we get the state object and an updater function to update the Hook value.

## Scenario

One common technique many cooks use is *mise en place*, which is from the French "putting in place." Cooks ensure all items are prepared before they begin cooking. 

In our recipe application, we want to allow users to tap ingredients to mark them as prepared. We'll start by creating the state and passing the display information to the component. In the next unit, we'll explore how to handle events.

## Add state

Any JavaScript object or data type can be registered as stateful in React. The function used to register the object is `useState`. The `useState` function specifies the initial value. It returns the newly created stateful object and another function you can use to update the value.

> [!NOTE]
> In React, state is *immutable*, meaning it can't be changed. To modify the value of a stateful object, replace it with a new instance that contains the appropriate values. The function returned by `useState` manages this process.

1. Open the *App.jsx* file. Notice the existing `initialRecipe` object. We'll use this object as the default value for our stateful `recipe`.
1. Create the `recipe` state object and `setRecipe` function from `useState`. To do so, add the following code after the line that reads, `TODO: Create recipe state`.

    ```javascript
    const [ recipe, setRecipe ] = useState(initialRecipe);
    ```

    In this code, `recipe` is the stateful object. The `setRecipe` function will be used to replace `recipe` with any new versions.

1. We can use `recipe` to pass props into components. In the following code, the `RecipeTitle` component will be used to display the title and feedback. Pass the `title` and `feedback` values into `RecipeTitle` by adding the following code after the comment that reads, `TODO: Pass recipe metadata to RecipeTitle`.

    ```javascript
    <RecipeTitle title={recipe.title} feedback={recipe.feedback} />
    ```

1. Open the *RecipeTitle.jsx* file. Notice the existing component that displays `title` and `feedback` props.

## Test the page

1. Save all of the files.
1. Return to your browser and refresh it. You should now see the recipe metadata displayed on the page.

   :::image type="content" source="../media/recipe-metadata.png" alt-text="Screenshot of the recipe metadata in the browser window.":::
