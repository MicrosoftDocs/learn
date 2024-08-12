Let's explore more ways that CSS can make managing your content easier and your content more interesting for your readers.

## Comments

As with any computer language, CSS supports comments. To comment in a section of CSS, you would use `/* comment */`. The `/*` identifies the start of the comment, and `*/` marks the end. A CSS comment can cover multiple lines of text. Comments are a great way to leave notes for yourself or other developers or to take notes while learning the language.

> [!IMPORTANT]
> CSS comments are public, and accessible by both the browser and users of your website. **Do not** store sensitive information in comments.
> 
> CSS comments are formatted differently from HTML comments. Comments in HTML use the `<!--comment-->` syntax.

## Setting Fonts

You can use CSS to tell the browser what font you want to use for specific text. Sometimes you want to use Arial for readability or something fancier for style. The following image shows some text in Arial and other text in a font called "Impact."

:::image type="content" source="../media/two-fonts.png" alt-text="Screenshot of browser render of H T M L text in two fonts.":::

The most common option for setting the font to use on a page is `font-family`. `font-family` is typically set to a list of fonts, allowing the browser to use the first font listed it can support. For example, a setting of `Tahoma, Verdana, sans-serif` will attempt to use Tahoma, followed by Verdana, and finally a generic sans serif font.

You can also use other options, such as the style, weight, and decoration. `font-style` is used to italicize text by setting the value to `italic`. `font-weight` supports different bold settings, with `bold` being the most common. And finally, `text-decoration` is used to `underline`, `overline`, or `line-through` text.

| CSS                           | Result      |
| ----------------------------- | ----------- |
| `font-weight: bold;`          | **Demo**    |
| `font-style: italic;`         | *Demo*      |
| `text-decoration: line-through;` | ~~Demo~~ |

`text-decoration` can feel different from the other options used to modify a font's display. The key difference is that `text-decoration` is used to apply style around or on the text but doesn't modify the actual font itself. Bold and italics are modifying the font.

> [!NOTE]
> Using underline on a webpage should typically be avoided because the text may appear to be a hyperlink.

## Sizing Fonts

The `font-size` allows you to indicate the font size you wish to use. CSS offers the ability to use absolute or relative sizing. Absolute sizing is typically set in pixels and will always use the specified size. Relative sizing can be based on the default size for the browser and measured in percent or based on the sizing of the reference element.

> [!NOTE]
> The default font size for many browsers is 16 pixels.

Absolute sizing can be measured in pixels and is indicated in CSS by using `px`. To set a font to be 14 pixels, you could use the directive `font-size: 14px;`.

Relative sizing for fonts is typically measured using `em` or `rem`. `em` is short for element and is relative to either the parent (`em`) or root (`rem`). The root is the `html` element. `1em` or `1rem` is equal to the size of the parent or root element, while `2em` or `2em` would be double the size. Because screen sizes can vary, it's typically best to use relative sizing whenever possible.

Consider the following HTML and CSS as an example:

```html
<html>
    <body>  
        <div>Sample text</div>
    </body>
</html>
```

```css
html {
    font-size: 18px;
}
div {
    font-size: 14px;
}
```

If the `div` element, `1em` would be 14 pixels because the parent is `div` and set to `14px`, while `1rem` would be 18 pixels because the `html` root is set to `18px`.

`1.5em` for the `div` element would be 21 pixels (**14 * 1.5 = 21**), and `1.5rem` would be 27 pixels (**18 * 1.5 = 27**). You can use `em` and `rem` to ensure the rest of the page scales as you update the parent or root sizes.

## Colors

The font color can be set by using the `color` property. `color` can be set to RGB (red, green, blue) values or to one of many named colors like `black` or `lightgray`.

RGB values in CSS can be hex values prefixed with a `#`, or values of 0 to 255 inside the `rgb` function. To set the color to the default shade of brown, you would use `color: brown;`. For a custom shade of purple, you might use `color: #7462e0`.

```css
/* named value */
div {
    color: brown;
}

/* RGB hex value */
h1 {
    color: #7462e0;
}

/* RGB function */
h2 {
    color: rgb(105, 6, 19);
}
```

> [!IMPORTANT]
> Color selection should always consider those who have a color vision deficiency. You can use tools such as [Color Safe](http://colorsafe.co) to aid in the selection of contrasting colors to ensure your site is accessible to all users.

As you might suspect, there are dozens of available named colors, and RGB values offer an infinite set of options. Editors such as [vscode.dev](https://vscode.dev) or [Visual Studio Code](https://code.visualstudio.com) can help identify the available color values. Both editors will show a color swatch preview in your CSS. If you mouse over the swatch you're presented with a color selector you can use to set the color you desire.

:::image type="content" source="../media/color-selector.png" alt-text="Screenshot of color selector from Visual Studio Code.":::
