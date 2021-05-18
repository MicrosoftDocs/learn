Let's create our first function. You will find yourself creating functions quite frequently when writing code. You will create a function to display a name on a webpage. The function will take one parameter - the name of the person you wish to greet, and return the message. You will then call this function to display the message.

> [!NOTE]
> You can find the full code at the bottom of this exercise.

## Create a sample page

You will start by creating a new page in Visual Studio Code.

1. Open a terminal or command window.
1. Run the following commands to create a new directory and change into it:

    ```bash
    # Windows
    md functions && cd functions

    # macOS or Linux
    md functions && cd functions
    ```

1. Run the following command to open the new directory in Visual Studio Code:

    ```bash
    code .
    ```

1. Inside the *EXPLORER* window in Visual Studio Code, hover over *FUNCTIONS*, and select *New File*.

    ![Screenshot of explorer window with new file outlined](./media/functions-create-file.png)

1. Name the new file *index.html* and select Enter

## Add the code to display the message

With our page created, we can now add the code to display our message.

1. Add the following HTML to *index.html* to create the core of the HTML file:

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
    > You may notice the `TODO` comments inside the script tag. Those are markers for where you will add code in both this exercise and an upcoming one.

1. Below the line inside *index.html* which reads `//TODO: Add hello code`, add the following code to create a function which takes one parameter called `name`, and returns a string saying 'Hello' to the person:

    ```javascript
    // TODO: Add hello code
    function getMessage(name) {
        return 'Hello, ' + name + '...';
    }
    ```

1. Below the `}` you just added, add the following code to get the message and use `document.write` to display it on the webpage.

    ```javascript
    const message = getMessage('Ornella');
    document.write(message);
    ```

1. Save the file by selecting *File* then *Save*.

## View the page

Our page is now created! Let's see how it looks.

1. Open the Visual Studio Code command pallette by by selecting *Ctl-Shift-P* (or *Cmd-Shift-P* on a Mac).
1. Open [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) by typing *Live Server* in the command pallette and selecting *Live Server: Open with Live Server*.

    ![Screenshot of command pallette with Live Server selected](./media/launch-live-server.png)

1. Live Server will start and open your browser window. You will see the message *Hello, Ornella...* display in your browser window!

    ![Screenshot of the browser window displaying Hello, Ornella...](./media/hello-ornella.png)

You have now created and called a function to display a message! You can try changing the name and saving the file to see the updated results.

> [!IMPORTANT]
> Leave Visual Studio Code and your browser running as you will use it in an upcoming unit.

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
