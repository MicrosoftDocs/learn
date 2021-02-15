There are a few ways to manage state in React and we're going to focus on one of the main ways, React Hooks. To create state with Hooks we use the `useState` Hook, which provides us with the state object and an updater function to update the Hook value.

## Scenario

One common technique many cooks use is mise en place, which is from the French "putting in place". Cooks ensure all items are prepared before they begin cooking. We would like to allow a user of the recipe application to tap on ingredients to mark them as prepped. We will start by creating the state, and passing the necessary information to the component for display on the page. In the next unit we will explore how to handle events.

## Add state

Any JavaScript object or data type can be registered as stateful in React. The function used to register the object is `useState`. `useState` allows you to specify the initial value, and returns the newly created stateful object and a function you can use to update the value.

> [!NOTE]
> State in React is immutable, meaning it cannot be changed. To modify the value of a stateful object you replace it with a new instance containing the appropriate values. The function returned by `useState` manages this process for you.

1. Open **App.jsx**. Notice the existing `initialRecipe` object. We will use this as the default value for our stateful `recipe`.
1. Create the `recipe` state object and `setRecipe` function from `useState` by adding the following code after the line which reads `TODO: Create recipe state`:

    ```javascript
    const [ recipe, setRecipe ] = useState(initialRecipe);
    ```

    `recipe` is the stateful object. `setRecipe` is the function we will use to replace `recipe` with any new versions.

1. We can use `recipe` to pass props into components. Pass the `title` and `feedback` values into `RecipeTitle`, a component which will display the title and feedback, by adding the following code after the comment which reads `TODO: Pass recipe metadata to RecipeTitle`:

    ```javascript
    <RecipeTitle title={recipe.title} feedback={recipe.feedback} />
    ```

1. Open **RecipeTitle.jsx**. Note the existing component which displays `title` and `feedback` props.

## Test the page

1. Save all files.
1. Return to your browser and hit refresh; you should now see the Recipe metadata displayed on the page.

    ![Screenshot of recipe metadata.](/media/recipe-metadata.png)
