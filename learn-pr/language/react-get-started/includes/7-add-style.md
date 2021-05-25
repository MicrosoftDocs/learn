When you use React, you're creating HTML. The method of creation is different, but the browser still renders HTML, CSS, and JavaScript. 

We can even add CSS to our components to apply style to them. To add CSS to a component, we reference it the same way we'd import any other JavaScript dependency.

## Add CSS

1. Add a new file to the *src* folder. Name it *index.css*.
1. Add the following style to the file:

    ```css
    article {
        margin-left: 10%;
        margin-right: 10%;
        font-family: Verdana, Geneva, Tahoma, sans-serif;
        font-size: 18px;
    }
    ```

    Feel free to customize this style!

## Import the CSS

1. Open the *App.jsx* file.
1. At the top of the file, add the following line of code:

    ```javascript
    import './index.css'
    ```

1. Return to your browser and refresh it. The site is updated with the new style!
