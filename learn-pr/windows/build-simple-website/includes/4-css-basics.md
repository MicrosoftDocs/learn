Cascading Style Sheets (CSS) let you specify how your page should look. The basic idea is to define what the style should be for the elements that you use within your HTML pages. For example, you can select a box, and apply rounded corners or give the box a gradient background. Or you can use CSS to specify how your hyperlinks look and respond when you interact with them (although you define the destination address for your hyperlinks in your HTML code). You can apply styles to specific elements, or all elements of a specific type, or you can use classes to specify styles that can be applied to a number of different elements. In CSS3, you can also perform sophisticated animation effects.

In this exercise, you'll apply CSS styles to HTML page elements, then you'll add some CSS code to define your light and dark themes, and then you'll check the results in your browser's developer tools.

## External CSS

In the previous unit about HTML, you linked to an external CSS file from HTML.

```html
...
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Task Timeline</title>
  <link rel="stylesheet" href="main.css">
...
```

One benefit of external CSS is that multiple HTML pages can link to the same CSS file. If you make a change to the CSS, your styling will update for each page. Designating an HTML file for the structure of the page, a CSS file for the styling, and JavaScript file for interaction or events is called *separation of concerns*.

As described previously, you can also write CSS directly in HTML, which is called *internal CSS*. Even for a basic website, there are so many CSS rules the HTML page can become cluttered very quickly. With more than one page, the same CSS would often be repeated and challenging to manage.

## CSS rules

Imagine you have an old-fashioned key and a series of doors down a long corridor. First, you select a door, and then you unlock it with the key. After you have access to a room, you can decorate it however you'd like. You might paint the walls blue, or set the floor to be hardwood. You select a room, and define rules for how it should look. You can apply the same style to multiple rooms, which is just like CSS.

In **Visual Studio Code**, open the `main.css` file, and enter the following.

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

1. Copy the following code into your CSS file, after the closing curly bracket for `ul` selector that you added previously.

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

   The preceding custom attributes are called `.list` and `#msg`.

   - The period prefix for `.list` indicates that this is a *class selector*.
    
     Each HTML element that contains a `class` attribute set to "list" will inherit the styles that are defined within this selector.

   - The pound sign prefix for *#msg* indicates that this is an *ID selector*.
    
     The HTML element that has its `id` attribute set to "msg" will inherit the styles that are defined within this selector.

   The names that you use for your selectors can be arbitrary, as long as they match what you've defined in the HTML.

1. Save your work by selecting <kbd>Control+S</kbd> on Windows or <kbd>Command+S</kbd> on macOS.

## View in browser

1. To preview using **VS Code**, right-click the file name `index.html`, and then select **Open In Default Browser**.

   > [!IMPORTANT]
   > Even though you were just editing the `main.css` file, to preview the changes, you should select the `index.html` file.

   The webpage opens in your default browser.

   :::image type="content" source="../media/chrome-applied-font-styles.png" alt-text="Screenshot of website with font styles applied.":::

Are the font styles what you expected to see? It's interesting how styles cascade from `body` to `h1`. We didn't define anything for `h1`, so it inherits styling from the `body`. However, `li` takes precedence over the `body` tag because you specifically defined a style for it.

## Add a light theme

Next, you'll add support for a color theme for your website. Begin by defining a light-colored theme using hex color codes.

1. In your CSS file, add the following code at the end of the file.

    ```css
    .light-theme {
      color: #000000;
      background: #00FF00;
    }
    ```

   In this example, `#000000` specifies black for the font color, and `#00FF00` specifies green for the background color.

1. In your HTML file, update the `<body>` element with a class name, `light-theme`, so the class selector for light theme will apply the styles correctly.

    ```html
    <body class="light-theme">
    ```

## View in browser

- To preview using **Visual Studio Code**, right-click `index.html`, and then select **Open In Default Browser**.

  The webpage opens in your default browser. Notice that the light theme using a green background appears.

  :::image type="content" source="../media/chrome-light-theme.png" alt-text="Screenshot of website with light theme applied.":::

## View applied CSS

1. On the browser view, open Developer Tools.

   - In **Edge**, right click the page and select **Developer Tools**, or select the shortcut <kbd>F12</kbd> or <kbd>Ctrl-Shift+I</kbd>. Alternatively, view **Settings and more** by pressing <kbd>Windows+X</kbd>, and selecting **Developer Tools**

   - In **Chrome**, press the keyboard shortcut for **Developer Tools**, which is <kbd>Option+Command+I</kbd> or <kbd>F12</kbd>.

1. Select the **Styles** tab.

1. Select the **Elements** tab.

1. Hover over the various HTML elements, and as select a few elements, notice how the developer tools indicate which styles are applied.

1. Select the `<body>` element. Note the `light-theme` applied.

1. Expand the unordered list and select a `<li>` element. Note the custom style `font-family: helvetica;`, which overrides the style for the `<body>` element.

:::image type="content" source="../media/chrome-light-theme-in-dev-tools.png" alt-text="Screenshot of website in dev tools with light theme applied.":::

## Add a dark theme

For the dark theme, you'll set up the infrastructure in preparation for the next unit, in which you'll enable theme switching on the web page.

To add support for a dark theme to your CSS, use the following steps.

1. Add some constants to the page root at the top of your CSS file.

    ```css
    :root {
      --green: #00FF00;
      --white: #ffffff;
      --black: #000000;
    }
    ```

   The `:root` selector represents the `<html>` element in the HTML page. For this kind of task, a best practice is to define a set of global CSS variables in the `:root` element. In this example, you've defined three color variables that are attached to the page root.

1. At the end of the CSS file, replace the `light-theme` selector with the following code to update it and to add the `dark-theme` selector.

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

1. Next, in your CSS file, after the `:root` selector, replace the current `body` selector with the following code.

    ```css
    * {
      color: var(--fontColor);
      font-family: helvetica;
    }
    body {
        background: var(--bg);
    }
    ```

   The `*` selector is a universal selector that applies to all page elements (except where a more specific element selector overrides it). In this example, you use the `*` selector to set the default `color` property for all page elements. For the `color` and `background` properties, you specify the variables defined in the light and dark theme selectors.

1. In your CSS file, remove the `#msg` selector so that we can apply the same font to all elements.

1. To view the dark theme, open the file `index.html` and manually edit the default theme in the `<body>` class attribute to dark theme (`dark-theme`), and then view the page in the browser.

   :::image type="content" source="../media/chrome-dark-theme.png" alt-text="Screenshot of website with dark theme applied.":::

1. Edit the `<body>` class attribute to switch the default back to light theme.

In the next unit, you'll use JavaScript to provide interactivity and support the switching of themes.
