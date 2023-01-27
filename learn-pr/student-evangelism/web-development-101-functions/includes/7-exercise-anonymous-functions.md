In this exercise, you'll use `setTimeout` with an anonymous function to display a message on a webpage. You'll create code that displays the message after a 2-second delay.

You'll use the same file that you used in the earlier exercise to complete this one.

> [!NOTE]
> You can find the full code for this exercise at the bottom of the page.

## Add the code to display the message

You'll now add the code to display the message, which will have a 2-second delay.

1. In Visual Studio Code, open the *index.html* file.

1. Below the commented line that reads `// TODO: Add setTimeout code`, add the following code:

    ```javascript
    setTimeout(
        () => { document.write('...Hello again!')},
        2000
    );
    ```

1. Save the file by selecting **File** > **Save**. Live Server  automatically refreshes the page for you when you save the file.

## View the page

Let's see the results!

1. Return to your browser window.

    The "...Hello again!" message might already be displayed, because Live Server will have already refreshed the window.

1. Refresh the browser window. Notice that the original message is displayed and then, after 2 seconds, it's replaced by the "...Hello again!" message.

   :::image type="content" source="../media/hello-again.png" alt-text="Screenshot of the browser, displaying the '...Hello again!' message.":::

You've now used an anonymous function to have a message appear after a delay.

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
        setTimeout(
            () => { document.write('...Hello again!')},
            2000
        );
    </script>
</body>
</html>
```
