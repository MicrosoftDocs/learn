JavaScript (or *ECMAScript*) is a programming language that helps you interactivity add to your web pages. For example, you can use JavaScript to define the event or behavior that will happen when a user selects a button; for example, open a pop-up window. Using JavaScript, you can add or remove content from a web page without reloading it. As a web developer, you can use your web browser to test and get feedback about your scripts.

In this unit, you'll set up an example JavaScript file for your web app. You'll create a button to switch between light and dark themes, and then you'll attach the button to JavaScript code that performs the actual theme switching. When this is done, you'll check the finished project using your browser's developer tools.

## Link to JavaScript

Like CSS, you could add JavaScript directly to the HTML file, but a recommended best practice is to save your JavaScript in a separate file, which makes it easier to reuse your JavaScript code across several web pages. For example, you could create a pop-up alert by adding `<script>alert('Hello World')</script>` anywhere within the body of your web pages; however, it is better to add your JavaScript code to a separate file that can be linked to every file that needs your custom functionality. The HTML script tag `<script>` will let us link to an external JavaScript file, which is how you'll configure your web app in this exercise.

1. In **VS Code**, open your `index.html` file.
 
1. On a new line before the closing `</body>` element, enter `script:src`, and then select <kbd>Enter</kbd>. The opening and closing tags for a script are added to your code.

1. Modify the `<script>` element to load your `app.js` file as shown in the following example, and ensure that it is located after the closing `</ul>` element for the list.

    ```html
    ...
    <ul>
      <li class="list">Add visual styles</li>
      <li class="list">Add light and dark themes</li>
      <li>Enable switching the theme</li>
    </ul>
    <script src="app.js"></script>
    ...
    ```

The `<script>` element could be placed in the `<head>` or elsewhere in the `<body>`. However, putting `<script>` element at the end of the `<body>` section enables all the page content to display on the screen first, and then load the script.

## Add fault tolerance

1. In your HTML file, add a `<noscript>` element after the closing `</script>` tag, which can be used to show a message if JavaScript is deactivated.

    ```html
    <script src="app.js"></script>
    <noscript>You need to enable JavaScript to view the full site.</noscript>
    ```

   Adding the `<noscript>` element is an example of *fault tolerance* or *graceful degradation*. By using the `<noscript>` element, your code can detect and plan for when a feature isn't supported or available.

1. Save your changes with the keyboard shortcut <kbd>Control+S</kbd> on Windows or <kbd>Command+S</kbd> on macOS.

## Set strict mode

As you get started with JavaScript, your initial focus is often going to be working with numbers, math, text manipulation, dates, and storing information. Sometimes JavaScript makes assumptions about the type of data you enter; for example, assignment, math, or logical equality can give you unexpected results. JavaScript tries to be friendly, make your code work, and provide you with a solution, even if the result should be an error. To override this behavior, you can activate *strict mode*, which reduces silent errors, improves performance and provides you with more warnings and fewer unsafe features.

- In **VS Code**, open the `app.js` file, and enter the following.

    ```javascript
    'use strict'
    ```

> [!NOTE]
> In your javascript, you may want to add a closing semicolon at the end of the line of code. While it is possible to omit a closing semicolon from JavaScript code, it's a good idea to understand when semicolons are necessary before making any decisions about that. There's a debate about this topic within the JavaScript community, but you should consider using semicolons as a best practice.

## Add a button

You need a way to let your users switch between the light and dark themes in your web page. In this exercise, you will implement that functionality with an HTML `<button>` element.

1. In your HTML file, add a `<button>` element. Put the button at the end of the list inside of a `<div>` element.

    ```html
    ...
    <ul>
      <li class="list">Add visual styles</li>
      <li class="list">Add light and dark themes</li>
      <li>Enable switching the theme</li>
    </ul>
    <div>
      <button class="btn">Dark</button>
    </div>
    <script src="app.js"></script>
    ...
    ```

    Notice that the `<button>` element in this example has a *class* attribute that you will use to apply CSS styles.

1. In your CSS file, add a class selector for your HTML button. To make the button colors different from the general light or dark theme colors, set the `color` and `background-color` properties in the button selector. This class selector is specific to the button, and overrides the universal selector (*) used to apply font colors in your CSS file.

    ```css
    .btn {
      color: var(--btnFontColor);
      background-color: var(--btnBg);
    }
    ```

1. Next, modify the class selector to add some rules for the size, shape, appearance, and placement of the button. The following CSS creates a round button to the right of the page heading.

    ```css
    .btn {
      position: absolute;
      top: 20px;
      left: 250px;
      height: 50px;
      width: 50px;
      border-radius: 50%;
      border: none;
      color: var(--btnFontColor);
      background-color: var(--btnBg);
    }
    ```

1. To improve the button's appearance, add a pseudo-class selector, `btn:focus`, after the button selector. By setting the `outline-style` rule to `none`, you eliminate a rectangular outline when the button is selected (receives focus).

    ```css
    .btn:focus { outline-style: none; }
    ```

1. Next, update the CSS for the light and dark theme. Define some new variables, `btnBg` and `btnFontColor`, to specify the button-specific background color and font color.

    ```css
    .light-theme {
      --bg: var(--green);
      --fontColor: var(--black);
      --btnBg: var(--black);
      --btnFontColor: var(--white);
    }

    .dark-theme {
      --bg: var(--black);
      --fontColor: var(--green);
      --btnBg: var(--white);
      --btnFontColor: var(--black);
    }
    ```

## Add an event handler

To make the button do something when you select it, you need an event handler in your JavaScript file. For a button, you need an event handler for the `click` event; the event handler function runs when the `click` event occurs.

Before you can add the event handler, you need a reference to the button.

1. In your JavaScript file, use `document.querySelector` to get the button reference.

    ```js
    const switcher = document.querySelector('.btn');
    ```

1. Next, add the event listener and the event handler for the `click` event. In the following code, you add a listener for the `click` event. The function passed into the event listener is your actual event handler.

    ```js
    switcher.addEventListener('click', function() {
        document.body.classList.toggle('dark-theme')
    });
    ```

In the preceding code, you used the `toggle` method to switch the \<body\> element to the `dark-theme` class. This automatically applies the dark theme styles instead of light theme. However, the label for the button also needs to be updated to show the correct theme, so you need to add an `if` statement to determine the current theme, and update the button label.

Here is what the complete JavaScript code should look like.

```js
'use strict'

const switcher = document.querySelector('.btn');

switcher.addEventListener('click', function() {
    document.body.classList.toggle('dark-theme')

    var className = document.body.className;
    if(className == "light-theme") {
        this.textContent = "Dark";
    }
    else {
        this.textContent = "Light";
    }

});
```

It's a JavaScript convention to use *camel case* for variable names with more than one word; for example: the variable `className`.

## Console message

You can create a hidden message that won't appear on your webpage. However, what you write in the console will show up in the browser developer tools. Using *console messages* can be really helpful for seeing the result of your code.

- Add a call to `console.log` after the `if` statement, but inside the event listener.

    ```javascript
    switcher.addEventListener('click', function() {
        document.body.classList.toggle('dark-theme')

        var className = document.body.className;
        if(className == "light-theme") {
            this.textContent = "Dark";
        }
        else {
            this.textContent = "Light";
        }

        console.log('current class name: ' + className);

    });
    ```

In **VS Code**, when in a JavaScript file, you can use autocomplete for `console.log` by entering `log`, and then pressing <kbd>Enter</kbd>.

You can define a text *string* with single or double quotes around the text.

## Open in browser

As previously described, even though you were just editing the `app.js` file, to preview the changes, select the `index.html` file.

1. To preview, select `index.html`, and select **Open In Default Browser**.

   The webpage opens in your default browser.

   :::image type="content" source="../media/chrome-light-theme-with-button.png" alt-text="Screenshot of website with the button.":::

1. Select the new **Dark** button to switch to the dark theme.

   :::image type="content" source="../media/chrome-dark-theme-with-button.png" alt-text="Screenshot of website after switching to dark theme.":::

1. Make sure that everything looks correct and behaves as expected. If not, you should review the preceding steps to see if you missed something

## Check the page in the developer tools

1. Open Developer Tools.

   - In **Edge** or **Chrome**, right-click and select **Inspect**, or use the keyboard shortcut <kbd>F12</kbd>. Alternatively, select <kbd>Alt +X</kbd> and then select Developer Tools.

   - In **macOS**, select <kbd>Option+Command+I</kbd> or select Develop in the menu. If you don’t see the Develop menu in the menu bar, select **Safari > Preferences > Advanced**, and then select *Show Develop menu in menu bar.*
 

1. Select the **Styles** tab.

1. Select the **Elements** tab.

1. Select the `<body>` element. In the **Styles** tab, look at the applied theme. If the current theme is dark, the `dark-theme` styles are applied.

   Make sure the dark theme is selected.

1. Select the **Console** tab to see the `console.log` message, "current class name: light-theme dark-theme".

:::image type="content" source="../media/chrome-console-output.png" alt-text="Screenshot of console message in Chrome.":::

Using the console, you get an interesting look at how the CSS theme switching is handled. Both class names are applied to the `<body>` element when you switch to dark theme. However, it is the last class name applied, in this example the the dark theme, which takes precedence.

In the **Styles** tab, you can see that the dark theme rules override the light theme rules, which are shown using strikethrough text.
