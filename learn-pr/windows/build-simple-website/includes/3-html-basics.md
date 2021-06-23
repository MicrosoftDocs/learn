At the moment, your website has an empty HTML file. Let's add some code! The goal is to use hypertext markup language (HTML) to describe the web page your customers' browsers should display. Wouldn't it be nice to have a starting template? Editors can conveniently fill in some of the typical boilerplate or HTML structure for you.

In this unit, you add basic HTML content, open the HTML page in the browser, and get your first look at the developer tools.

## Add some HTML code

Visual Studio Code provides basic support for HTML programming out of the box. There is syntax highlighting, smart completions with IntelliSense, and customizable formatting.

1. Open your website in **Visual Studio Code**, then open the `index.html` file by selecting the `index.html` file in the **Explorer** window.
 
1. When the `index.html` page, type `html:5`, and then press <kbd>Enter</kbd>. HTML5 template code gets added to the file.

   Note: If the HTML5 template code is not added to the `index.html` file, try closing and reopening the file.

1. Edit your code so that it resembles the following, and then save the file by pressing <kbd>Control+S</kbd> on Windows or <kbd>Command+S</kbd> on macOS.

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
     <meta charset="UTF-8">
     <title>Document</title>
   </head>
   <body>

   </body>
   </html>
   ```

There have been different versions of HTML. The document type `<!DOCTYPE html>` indicates this is HTML5 code.

While we aren't going to delve deeply into the meaning of all the HTML elements, we will point out a few important items. The `meta` tag indicates *metadata* information that won't typically be visible to the viewer unless they view the source code in their browser. Meta elements or tags provide descriptive information about the webpage. For example, they help search engines process which information in your web pages to return in search results.

The *character set* (charset) for UTF-8 may seem insignificant, but is crucial for establishing how computers interpret characters. If the metadata for the character set is missing, that can lead to compromised security. There's quite a bit of history and technical information behind the charset attribute, but important takeaway from this exercise is that the VS Code boilerplate provides some sensible defaults.

## Edit the head

The *title* of a webpage appears at the top of a browser window, and is significant in a few ways. For example, the title is used by and displayed in search engines. Let's add a title.

> [!IMPORTANT]
> From this point forward, the ellipsis (...) indicates that previously declared code precedes or follows. There should be enough code provided as context to make necessary changes or update to your work, but you should not copy and paste the ellipsis into your code.

1. In **Visual Studio Code**, modify the `<title>` element so that it resembles the following example.

   ```html
   ...
   <head>
     <meta charset="utf-8">
     <title>Simple website</title>
   ...
   ```

   To apply styles to the HTML elements on the page, you could write the CSS code directly in the head of the website, which is called *internal CSS*. However, it's a best practice to separate HTML structure and CSS styling. Having a separate CSS page is called *external CSS*. Code tends to be easier to read when it's concise and compartmentalized. You can use one or more external style sheets to service multiple webpages. Rather than updating each HTML page with duplicated CSS code, you can make changes to a single CSS file, and have those updates applied to all of the dependent pages. Let's link to an external stylesheet.

1. In **Visual Studio Code**, add a blank line after the `<title>` element, type `link`, and then press <kbd>Enter</kbd>. VS Code should add the following line to your `index.html` file.

   ```html
   <link rel="stylesheet" href="">
   ```

1. Update the `href` to `main.css`, and save the file by pressing <kbd>Control+S</kbd> on Windows or <kbd>Command+S</kbd> on macOS.

   ```html
   ...
   <head>
     <meta charset="utf-8">
     <title>Task List</title>
     <link rel="stylesheet" href="main.css">
   </head>
   ...
   ```

## Edit the body

Let's start filling in the *body* element now.

1. Add a *heading* `<h1>` element, followed by a *paragraph* `<p>` element, and then create an *unordered list* `<ul>` that contains several *list item* `<li>` elements.

1. Edit your code, or copy and paste, so it looks like the following example.

    ```html
    <!DOCTYPE html>
    <html lang="en" dir="ltr">
      <head>
        <meta charset="utf-8">
        <title>Simple website</title>
        <link rel="stylesheet" href="main.css">
      </head>
      <body>
        <h1>Task List</h1>
        <p id="msg">Current tasks:</p>
        <ul>
          <li class="list">Add visual styles</li>
          <li class="list">Add light and dark themes</li>
          <li>Enable switching the theme</li>
        </ul>
      </body>
    </html>
    ```

An ID attribute (used in the `<p>`) can be used for styling one element, while the class attribute (used in the `<li>` element) is for styling all elements of the same class.

Before the next step, make sure your file is saved by pressing <kbd>Control+S</kbd> or <kbd>Command+S</kbd>.

## Open in browser

You can preview your webpage locally by opening the HTML file in a browser. Instead of a website address that begins with `https://`, your browser points to the local file path. For example, the path might look similar to the following: *file:///Users/username/Desktop/public/index.html*.

- To preview using **Visual Studio Code**, right-click `index.html`, and select **Open In Default Browser**, or select the `index.html` file and use the keyboard shortcut <kbd>Alt+B</kbd>.

   :::image type="content" source="../media/vs-code-open-in-browser.png" alt-text="Screenshot of Open in Browser in Visual Studio Code":::

  > [!IMPORTANT]
  > If you're having trouble, make sure you're directly right-clicking the filename icon or text.

  The webpage opens in your default browser.

## View the page using developer tools

You can inspect a webpage by using the developer tools in your browser. Let's give this a try.

1. Open Developer Tools.

   - In **Edge**, press the keyboard shortcut for **Developer Tools**, which is <kbd>F12</kbd> or <kbd>Ctrl-Shift+I</kbd>. Alternatively, view **Settings and more** by pressing <kbd>Alt+X</kbd>, and selecting **Developer Tools**.

   - In **Chrome**, press the keyboard shortcut for **Developer Tools**, which is <kbd>Option+Command+I</kbd> or <kbd>F12</kbd>.

1. Select the **Elements** tab.

   :::image type="content" source="../media/chrome-developer-tools-elements-tab.png" alt-text="Screenshot of the Chrome developer tools":::

1. Scroll your mouse over the HTML elements, and expand the contents of the various elements.

The **Elements** tab in developer tools shows you the document object model (DOM) as rendered in the browser. When debugging, it is often important to see how the browser interprets your source code.

> [!NOTE]
> If you're using **Safari**, see the [Web Developer Tools](https://developer.apple.com/safari/tools/). When installed, select **Safari > Preferences**, and then select **Advanced**. At the bottom of the pane, select the **Show Develop menu in menu bar** checkbox. Select **Develop > Show Web Inspector**. For more information, check the Safari Web Inspector documentation.

Inspecting the page in a browser provides all sorts of useful information, and can help you troubleshoot problems. You can also view CSS details with the inspector, as you'll see in the next section.
