You want to begin styling your resume web page. You'll start by selecting the font and setting sizes for the various elements you'll use on the page.

This module uses [vscode.dev](https://vscode.dev/) - a web-based version of Visual Studio Code and [CodeSwing](https://marketplace.visualstudio.com/items?itemName=codespaces-Contrib.codeswing). These tools help streamline the development process. No local installation is required to complete the exercises that follow.

## Create a Project

You'll start by creating a folder, setting up your tooling, and creating a "swing" using CodeSwing in vscode.dev. A swing will automatically display the results of your code in vscode.dev. Using VSCode with CodeSwing allows you to quickly make modifications with a preview of updates happening in real time.

1. Create a folder on your desktop named **resume**.
1. Open [vscode.dev](https://vscode.dev).
1. Select **Open Folder**.
1. Navigate to the **resume** folder you created earlier and select **Select Folder**.
1. When prompted to **Let site view files**, select **View Files**.
1. Select the **Extensions** button.
    >:::image type="content" source="../media/extensions.png" alt-text="Screenshot of Visual Studio extensions button.":::
1. In the **Search Extensions in Marketplace** text box, type **CodeSwing**.
1. Select **Install** to install **CodeSwing**.
1. Open the Command Palette by selecting **Ctrl+Shift+P** or **Cmd-Shift-P** on a Mac.
1. Type **CodeSwing** in the Command Palette and select **CodeSwing: New Swing in Directory**.
1. Select **Select Folder** to use the current directory (which is the one you created in a prior step).
1. Select **Basic: HTML/CSS/JavaScript**.
1. If prompted to **Save changes to resume**, select **Save changes**.
1. Select the **x** next to **script.js** inside vscode.dev to close the JavaScript file as you won't be using this file during the exercise.

Visual Studio Code will create two sections side by side. The left will be your editors, where you can enter your HTML and CSS. The right will behave like a browser, displaying the results of your code.

## Create the HTML

You'll use existing HTML to allow us to focus solely on the CSS. The HTML includes the `link` element to reference the CSS file.

1. Copy the following HTML into the window titled **index.html**:

    ```html
    <html>
        <head>
            <title>Your Name resume</title>
            <link rel="stylesheet" href="style.css">
        </head>

        <body>
            <h1>Your Name</h1>
            <a href="mailto:your-email@example.com">your-email@example.com</a>

            <div id="social-media">
                <h2>Social media</h2>
                <ul>
                    <li><a href="https://github.com/">GitHub</a></li>
                    <li><a href="https://linkedin.com/in/">LinkedIn</a></li>
                    <li><a href="https://twitter.com/">Twitter</a></li>
                </ul>
            </div>

            <h2>Education</h2>
            <h3>School name</h3>
            <h4>Major</h4>
            <ul>
                <li>GPA: 4.0</li>
                <li>Years attended</li>
            </ul>

            <h2>Experience</h2>
            <div class="experience">
                <h3>Company name</h3>
                <h4>Title</h4>
            </div>
            <div class="experience">
                <h3>Cool hackathon</h3>
                <h4>Project title</h4>
            </div>

        </body>
    </html>
    ```

## Set Font Type and Size

By default, most browsers will use a serif font such as Times New Roman. You want to set the page default to a more popular font. Additionally, you want to set the size of the font for the page and various headers.

1. Inside the file titled **style.css**, add the following CSS to set the font family to Verdana with fallback options, and the font size to 12 pixels on the `html` element:

    ```css
    html {
        font-family: Verdana, Geneva, Tahoma, sans-serif;
        font-size: 12px;
    }
    ```

    You're using the `html` element to update the root font and sizing. With the `html` element will allow you to use `rem` sizing.

1. Notice the page automatically updates with the changes.
1. Add the following CSS code to the end of **style.css** to set the sizes for `h1` through `h4`.

    ```css
    h1 {
        font-size: 1.6rem;
    }

    h2 {
        font-size: 1.4rem;
    }

    h3 {
        font-size: 1.2rem;
    }

    h4 {
        font-size: 1.1rem;
    }
    ```

    `rem` is based on the root size, which is 14 pixels. As an example, this CSS will set the size of `h1` to 22.4 pixels.

1. The page is automatically updated in vscode.dev.
1. Leave the window open as you'll use it in the next exercise.

## Result and Next Steps

The following screenshot is the result of the CSS you applied in this exercise. If you wish to experiment with different fonts and sizes, you can modify the CSS as you wish.

:::image type="content" source="../media/fonts-final.png" alt-text="Screenshot of final page as rendered in browser":::
