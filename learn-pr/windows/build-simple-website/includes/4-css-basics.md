Cascading Style Sheets (CSS) let you specify how your page should look. The basic idea is to target HTML code, and then define what the style should be. For example, you can select a box, and apply rounded corners or give the box a gradient background. CSS is responsible for determining how hyperlinks look and respond when you interact with them, although you define the destination address in HTML. In CSS3, you can also do sophisticated animation effects.

In this unit, you apply CSS styles to page elements, add CSS code to support light and dark themes, and check the results in developer tools.

## External CSS

In the previous unit about HTML, you linked to an external CSS file from HTML.

```html
...
<head>
  <meta charset="utf-8">
  <title>Task Timeline</title>
  <link rel="stylesheet" href="main.css">
...
```

One benefit of external CSS is that multiple HTML pages can link to the same CSS file. If you make a change to the CSS, your styling will update for each page. Designating an HTML file for the structure of the page, a CSS file for the styling, and JavaScript file for interaction or events is called *separation of concerns*.

As described previously, you can also write CSS directly in HTML, which is called internal CSS. Even for a basic website, there are so many CSS rules the HTML page becomes cluttered very quickly. With more than one page, the same CSS would often be repeated and challenging to manage.

## CSS rules

Imagine you have an old-fashioned key and a series of doors down a long corridor. First, you select a door, and then you unlock it with the key. After you have access to a room, you can decorate it however you'd like. You might paint the walls blue, or set the floor to be hardwood. You select a room, and define rules for how it should look. You can apply the same style to multiple rooms, which is just like CSS.

- In **Visual Studio Code**, open the `main.css` file, and enter the following.

    ```css
    body {
        font-family: monospace;
    }

    ul {
        font-family: helvetica;
    }
    ```

You can use CSS rules to style HTML. The unordered list element `ul {}` is a *selector*, which selects the `<ul>` HTML element to apply styles. The *declaration* is `font-family: helvetica` and determines what the style should be. The *property name* is `font-family`, and the *value* is `helvetica`. The property and value together make a key-value pair.

What you're selecting is an existing element that you previously defined in HTML (`<body>` and `<ul>`). As you'll see next, you can define your own custom names for elements.

## Selectors

*ID* and *class selectors* enable you to apply styles to custom attribute names in your HTML. An ID is used to style one element, whereas classes can style multiple elements.

1. Copy the following code into your CSS file, after the `ul` selector you added previously.

    ```css
    li {
      list-style: circle;
    }

    .list {
      list-style: square;
    }

    #msg {
      font-family: monospace;
    }
    ```

   The preceding custom attributes are called `.list` and `#msg`. The class selector *list* has a period prefix, while the ID selector is *msg* and has a pound sign prefix. The names can be arbitrary as long as they match what you've defined in the HTML.

1. Save your work by pressing the keyboard shortcut <kbd>Control+S</kbd> (Windows) or <kbd>Command+S</kbd> (macOS).

## View in browser

1. To preview using **Visual Studio Code**, right-click `index.html`, and then select **Open In Default Browser**.

   > [!IMPORTANT]
   > Even though you were just editing the `main.css` file, to preview the changes, you should select the `index.html` file.

   The webpage opens in your default browser.

   :::image type="content" source="../media/chrome-applied-font-styles.png" alt-text="Screenshot of website with font styles applied":::

Are the font styles what you expected to see? It's interesting how styles cascade from `body` to `h1`. We didn't define anything for `h1`, so it inherits styling from the `body`. However, `li` takes precedence over the `body` tag because you specifically defined a style for it.

## Add a light theme

Next, add support for a color theme for your website. Begin by defining a light-colored theme. For the light theme, use hex color codes. For the font color, select (#000000, black); and for the background color, select (#00FF00, a green hue).

1. In your CSS file, add the following code at the end of the file.

    ```css
    .light-theme {
      color: #000000;
      background: #00FF00;
    }
    ```

1. In your HTML file, update the `<body>` element with a class name, `light-theme`, so the class selector for light theme will apply the styles correctly.

    ```html
    <body class="light-theme">
    ```

## View in browser

- To preview using **Visual Studio Code**, right-click `index.html`, and then select **Open In Default Browser**.

  The webpage opens in your default browser. Notice that the light theme using a green background appears.

  :::image type="content" source="../media/chrome-light-theme.png" alt-text="Screenshot of website with light theme applied":::

## View applied CSS

1. Open Developer Tools.

   - In **Edge**, press the keyboard shortcut for **Developer Tools**, which is <kbd>F12</kbd> (<kbd>FN+F12</kbd>). Alternatively, view **Settings and more** by pressing <kbd>Alt+X</kbd>, and selecting **Developer Tools**.

   - In **Chrome**, press the keyboard shortcut for **Developer Tools**, which is <kbd>Option+Command+I</kbd>. (<kbd>F12</kbd> also works.)

1. Select the **Styles** tab.

1. Select the **Elements** tab.

1. Roll over, and select the HTML elements.

1. Select the `<body>` element. Note the `light-theme` applied.

1. Open the disclosure triangles.

1. Select a `<li>` element. Note the custom style `font-family: helvetica;`, which overrides the style for the `<body>` element.

:::image type="content" source="../media/chrome-light-theme-in-dev-tools.png" alt-text="Screenshot of website in dev tools with light theme applied":::

## Add a dark theme

For the dark theme, you set up the infrastructure in preparation for the next unit, in which you will enable theme switching on the web page.

To set up support for a dark theme:

1. Add some constants to the page root in your CSS file.

    ```css
    :root {
      --green: #00FF00;
      --white: #ffffff;
      --black: #000000;
    }
    ```

   The `:root` selector represents the `<html>` element in the HTML page. For this kind of task, a best practice is to define a set of global CSS variables in the `:root` element. Here, you define three color variables attached to the page root.

1. At the end of the CSS file, add the `dark-theme` selector, and update the `light-theme` selector.

    ```css
    .light-theme {
      --bg: var(--green);
      --fontColor: var(--black);
    }

    .dark-theme {
      --bg: var(--black);
      --fontColor: var(--green);
    }
    ```

   In the preceding code, you defined some new variables, `bg` and `fontColor`, to specify the background color and font color. Use the `var` keyword to specify variables to use as the property values. You set the values previously in your `:root` selector.

1. Next, in your CSS file, add the following after the `:root` selector, replacing the current `body` selector.

    ```css
    * {
      color: var(--fontColor);
      font-family: helvetica;
    }

    body {
        background: var(--bg);
    }
    ```

   The * selector is a universal selector that applies to all page elements (except where a more specific element selector overrides it). Here, you use it to set the default `color` property for all page elements. For the `color` and `background` properties, you specify the variables defined in the light and dark theme selectors.

1. Remove the `#msg` selector in your CSS, so that we can apply the same font to all elements.

1. To view the dark theme, manually edit the default theme in the `<body>` element to dark theme (`dark-theme`), and then view the page in the browser.

   :::image type="content" source="../media/chrome-dark-theme.png" alt-text="Screenshot of website with dark theme applied":::

1. Edit the `<body>` element to switch the default back to light theme.

In the next unit, you will use JavaScript to provide interactivity and support the switching of themes.
