You'll find yourself creating functions frequently when you write code. In this exercise, you'll create a function to display a name on a webpage. The function will take one parameter, the name of the person you want to greet, and then return the message. You'll then call this function to display the message.

> [!NOTE]
> You can find the full code for this exercise at the bottom of the page.

## Create a sample page

Start by creating a new page in Visual Studio Code.

1. Open a Visual Studio Code terminal or command window.
1. To create a new directory and change into it, run one of the following commands:

    ```bash
    # Windows
    md functions && cd functions

    # macOS or Linux
    md functions && cd functions
    ```

1. To open the new directory in Visual Studio Code, run the following command:

    ```bash
    code .
    ```

1. On the **Explorer** pane, hover over **Functions**, and then select the **New File** icon.

   :::image type="content" source="../media/functions-create-file.png" alt-text="Screenshot of the Explorer pane with the 'New File' icon highlighted.":::

1. Name the new file *index.html*, and then select Enter.

## Add the code to display the message

You can now add the code to display your message.

1. In the *index.html* file, create the core of the HTML file by pasting the following HTML code:

    ```html
    <!DOCTYPE html>
    <html>
    <head>
        <title>Message</title>
    </head>
    <body>
        <script>
            // TODO: Add hello code

            // TODO: Add setTimeout code

        </script>
    </body>
    </html>
    ```

    > [!NOTE]
    > The `TODO` comments inside the script tag are markers for adding code in both this exercise and an upcoming one.

1. In the *index.html* file, below the commented line that reads `//TODO: Add hello code`, create a function by adding the following code. 
 
   The function takes one parameter, called `name`, and it returns a string that says "Hello" and the name of the person who's providing the input:

    ```javascript
    // TODO: Add hello code
    function getMessage(name) {
        return 'Hello, ' + name + '...';
    }
    ```

1. Below the closing brace (`}`) you just added, add the following code to get the message and use `document.write` to display it on the webpage.

    ```javascript
    const message = getMessage('Ornella');
    document.write(message);
    ```

1. Save the file by selecting **File** > **Save**.

## View the page

Your page is now created! Let's see how it looks.

1. In Visual Studio Code, open the **Command Palette** by selecting Ctrl+Shift+P (Windows) or Cmd+Shift+P (Mac).

1. In the **Command Palette**, open [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) by typing **Live Server** and then selecting **Live Server: Open with Live Server**.

    :::image type="content" source="../media/launch-live-server.png" alt-text="Screenshot of the Command Palette with 'Live Server: Open with Live Server' highlighted.":::

   Live Server opens in your browser, and the "Hello, Ornella..." message is displayed.

    :::image type="content" source="../media/hello-ornella.png" alt-text="Screenshot of the browser window, displaying the message 'Hello, Ornella...'.":::

You've now created and called a function to display a message. You can try changing the name and saving the file again to see the updated results.

> [!IMPORTANT]
> Keep Visual Studio Code and your browser open to use in an upcoming unit.

## Full code

```html
<!DOCTYPE html>
<html>
<head>
    <title>Message</title>
</head>
<body>
    <script>
        // TODO: Add hello code
        function getMessage(name) {
            return 'Hello, ' + name + '...';
        }
        const message = getMessage('Ornella');
        document.write(message);

        // TODO: Add setTimeout code

    </script>
</body>
</html>
```
