## CSS Structure

If you want your HTML page to display all text between the `h1` tags with the color orange, you could use the CSS code that follows.

```css
h1 {
    color: orange;
}
```

The CSS code above starts with (`h1`) that selects the HTML you want to style. The `h1` in the sample is called a **selector**.

Notice the code inside the curly braces, `color: orange;`t declares how the selected `h1` tag should be styled. The CSS code in the curly braces `{ }`, such as `color: orange;` is called a **declaration**.

Your sample declaration contains a **property**, `color`, which is separated from a **value**, `orange`, with a colon (`:`), and the end of the setting is marked by a semicolon (`;`).

> [!NOTE]
> There is no need to memorize every available property and value in CSS. There are a lot of websites that you can reference. Also, tools such as [vscode.dev](https://vscode.dev) or [Visual Studio Code](https://code.visualstudio.com) offer auto-complete options that can help guide you as you create a CSS.

## Embed a CSS file

A quick way to add style information is to place it within the `head` tags of your HTML page by using a `style` attribute. This method isn't considered the best practice, but is OK to use for learning and testing.

The example that follows adds the `<style>` tag with styling information for any `h1` to display gray. Since that is the only styling, the rest of the HTML displays with the browser's default styling.

```html
<!DOCTYPE html>
<html>
    <head>
        <!-- Here's the styling information -->
        <style>
            h1 {
                color: gray;
               }
        </style>
    </head>
    <body>
        <h1>Welcome</h1>
        <p>This is my site</p>
    </body>
</html>
```

When viewed in a browser, the "Welcome" text in the `<h1>` tag displays gray.

:::image type="content" source="../media/simple-html-embeded-css.png" alt-text="Screenshot of rendered H T M L page displays the heading 1 in grey.":::

### Apply styles to HTML using CSS

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE5ax20]

## Link to a CSS file

When you add styles to Hypertext Markup Language (HTML), it's best to do your styling in a separate CSS file. When several HTML files use the same CSS, they'll have a consistent appearance. Plus, updating one CSS file is easier than having to update each individual HTML file.

To reference the CSS file, you use the `link` element.

`link` has two attributes, `rel` and `href`. `rel` is used to identify the resource type you're referencing, **style sheet** for style sheets. `href` is used to identify the path to the CSS file. If your CSS file was in the same folder as your HTML file and had the name **style.css**, you could use the following to reference it from your page:

```html
<link rel="stylesheet" href="style.css">
```

Now you'll have at least two files, an `.html` file and a `.css` file. The previous example would have an HTML file that links to the CSS.


```html
<!DOCTYPE html>
<html>
    <head>
        <title>Welcome</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Welcome</h1>
        <p>This is my site</p>
    </body>
</html>
```
