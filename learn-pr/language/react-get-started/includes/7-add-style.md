When you use React, you are still creating HTML; the method of creation is different, but the browser still renders HTML, CSS and JavaScript. We can even add CSS to our components, allowing us to tie style to them. If we add CSS to a component, we reference it the same way we'd import any other JavaScript dependency.

## Add CSS

1. Add a new file to **src** named **index.css**.
1. Add the following style to **index.css**:

    ```css
    article {
        margin-left: 10%;
        margin-right: 10%;
        font-family: Verdana, Geneva, Tahoma, sans-serif;
        font-size: 18px;
    }
    ```

    If you want to add your own custom style, feel free!

## Import the CSS

1. Open **App.jsx**.
1. At the top of **App.jsx** add the following line of code:

    ```javascript
    import './index.css'
    ```

1. Return to your browser and refresh. The site is updated with the new style!
