Cascading Style Sheets (CSS) let you specify how your page should look. The basic idea is to target HTML code then define what the style should be. For example, you can select a box and apply rounded corners or give the box a gradient background. CSS is responsible for determining how hyperlinks look and respond when you interact with them—although you define the destination address in HTML. In CSS3, you can also do sophisticated animation effects.

## External CSS

In the previous unit on HTML, we put our CSS in an external file and linked it to the HTML.

```html
...
<head>
  <meta charset="utf-8">
  <title>Task Timeline</title>
  <link rel="stylesheet" href="main.css">
...
```

One benefit of external CSS is that multiple HTML pages can link to the same CSS file. If you make a change to the CSS, then your styling will update for each page. Designating an HTML file for the structure of the page, a CSS file for the styling, and JavaScript file for interaction or events is called *separation of concerns*.

As mentioned previously, you can also write CSS directly in HTML, which is called internal CSS. Even for a basic website, there are so many CSS rules the HTML page becomes cluttered very quickly. With more than one page, the same CSS would often be repeated and challenging to manage.

## CSS rules

Imagine you have an old fashioned key and a series of doors down a long corridor. First, you select a door; then you unlock it with the key. Once you have access to a room, you can decorate however you'd like. You might paint the walls blue or set the floor to be hardwood. You select a room and define rules for how it should look. You can apply the same style to multiple rooms, which is just like CSS.

In **Visual Studio Code**, open the `main.css` file and type the following.

```css
body {
    font-family: helvetica;
}
  
ul {
    font-family: helvetica;
}
```

You can use CSS rules to style HTML. The unordered list element `ul {}` above is a *selector*, which selects the `<ul>` HTML element to apply styles. The *declaration* is `font-family: helvetica` and says what the style of should be. The *property name* is `font-family`, and the *value* is `helvetica`. The property and value together make a key-value pair.

What you're selecting is an existing element that you previously defined in HTML (`<body>` and `<ul>`). As you'll see next, you can define your own custom names for elements.

## Selectors

*ID* and *class selectors* allow you to apply styles to custom attribute names in your HTML. An ID is used to style one element, whereas classes can style multiple elements. The custom attributes below are called `.list` and `#msg`. The ID selector is *msg* and has a pound sign prefix, while the class selector *list* has a period prefix. The names are arbitrary so long as they match what you've defined in the HTML.

```css
...
li {
  list-style: circle;
}

.list {
  list-style: square;
}

#msg {
  font-family: sans-serif;
}
```

Copy the preceding code into your CSS file. Remember to save your work with the keyboard shortcut Control+S (Windows) or Command+S (macOS).

## View in browser

To preview using **Visual Studio Code**, select on `index.html` and select **Open In Default Browser**.

> [!IMPORTANT]
> Even though you were just editing the `main.css` file, to preview the changes, you should select the `index.html` file.

The webpage will open in your default browser.

Are the font styles what you expected to see? It's interesting how styles cascade from `body` to `h1`. We didn't define anything for `h1`, so it inherits styling from the `body`. However, `li` takes precedence over the `body` tag because we specifically defined a style for it.

## Add a light theme

Next, add support for a color theme for your website. Begin by defining a light-colored theme.

.light-theme {
  color: #000000;
  background: #00FF00;
}

In your HTML file, update the `<body>` element with a class name, `light-theme`, so the class selector for light theme will apply the styles correctly.

```html
<body class="light-theme">
```

## View in browser

To preview using **Visual Studio Code**, select on `index.html` and select **Open In Default Browser**.

The webpage will open in your default browser. Notice that the light theme with a green background appears.

## View applied CSS

**IMPORTANT Move this to previous section, since we are not viewing in the browser.**

In **Edge**, the keyboard shortcut for **Developer Tools** is F12 (FN+F12). Alternately, view **Settings and more** with Alt+X and select **Developer Tools**.

In **Chrome**, the keyboard shortcut for **Developer Tools** is Option+Command+I.

1. Select the **Styles** tab.
2. Select the **Elements** tab.
3. Roll over and select the HTML elements.
4. Open the disclosure triangles.
5. Select a `<li>` element. Note the custom style `font-family: monospace;`.

## Add a dark theme

For the dark theme, we want to set up the plumbing in preparation for the next unit, in which we will enable theme switching on the web page.

To set up support for a dark theme, add some constants to the page root in your CSS file. The `:root` selector represents the `<html>` element in the HTML page. A best practice is to define a set of global CSS variables in the `:root` element. Here, you define three color variables attached to the page root.

```css
:root {
  --green: #00FF00;
  --white: #ffffff;
  --black: #000000;
}
```

At the end of the CSS file, add the `dark-theme` selector and update the `light-theme` selector. Here, you define some new variables, `bg` and `fontColor`, to specify the background color and font color. Use the `var` keyword to specify variables to use as the property values. You set the values previously in your `:root` selector.

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

Next, in your CSS file, add the following after the `:root` selector, replacing the current `body` selector. The * selector is a universal selector that applies to all page elements (except where a more specific selector overrides it). Here, you use it to set the default `color` property for all page elements. For the `color` and `background` properties, you specify the variables defined in the light and dark theme selectors.

```css
* {
  color: var(--fontColor);
}

body {
    font-family: helvetica, sans-serif;
    background: var(--bg);
}
```

To view the dark theme, we could manually switch the default theme in the `<body>` element to dark theme. However, instead of this, in the next unit we will use JavaScript to provide interactivity and support switching of themes.