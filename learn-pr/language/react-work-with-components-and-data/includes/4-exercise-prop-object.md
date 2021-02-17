Component `props` are not limited to strings, but can use JavaScript objects. We can use this to create more robust components.

## Scenario

We want to update `RecipeTitle` to display the feedback for the recipe. If the average rating is at or below 3.5 we want to display the rating as red; higher than 3.5 and we want to display green. We will use the ternary operator and CSS classes to help us manage the display.

## Create the CSS

By importing CSS into an individual component it allows us to avoid naming conflicts and other issues which often arise with CSS. We will start by creating a CSS file for `RecipeTitle`.

1. Add a new file to the **src** folder named **RecipeTitle.css**
1. Add the following CSS to **src/RecipeTitle.css**:

    ```css
    .red {
        color: red;
    }
    .green {
        color: green;
    }
    ```

## Update RecipeTitle

Now we will update `RecipeTitle` to import the CSS and display the values.

1. Open **src/RecipeTitle.jsx**
1. At the top of the file add the following line of code:

    ```javascript
    import './RecipeTitle.css';
    ```

1. Below the line which reads `<h2>{ props.title }</h2>` add the following code:

    ```jsx
    <h3 className={ props.feedback.rating <= 3.5 ? 'red' : 'green' }>
        { props.feedback.rating } from { props.feedback.reviews } reviews
    </h3>
    ```

### Exploring the code

We started by importing the CSS file we created. We added a new `h3` element to display the `feedback`. We used the ternary operator to set the class based on the `rating`.

The entire contents of **ReactTitle.jsx** should now be:

```jsx
import './RecipeTitle.css';
import React from 'react';

// TODO: Create RecipeTitle component
function RecipeTitle(props) {
    return (
        <section>
            <h2>{ props.title }</h2>
            <h3 className={ props.feedback.rating <= 3.5 ? 'red' : 'green' }>
                { props.feedback.rating } from { props.feedback.reviews } reviews
            </h3>
        </section>
    )
};

export default RecipeTitle;
```

## Update App component to pass ratings to RecipeTitle

We will update `RecipeTitle` to set the `feedback` attribute.

1. Open **src/App.jsx**
1. Modify the existing `RecipeTitle` element to add the `feedback` attribute:

    ```jsx
    <RecipeTitle title={ recipe.title } feedback={ recipe.feedback } />
    ```

## See the results

Save all files. The browser should automatically refresh with the updated display.

![Screenshot of the recipe display](../media/reviews.png)
