In this unit, you'll create a web app and run it in the browser.

## Create app folder

1. In a console window (such as cmd, PowerShell, or Bash), use the following commands to create a new folder for our app and change into it

    ``` console
    mkdir VoiceCallingApp
    cd VoiceCallingApp
    ```

1. Next we'll prepare the new folder to become a web app.

    ```console
    npm init -y
    ```

This will setup, the folder for Node.js and allow you to save and manage dependencies.

## Add the required dependencies

Now we'll add the required dependencies.

1. We'll start by adding the Azure Communication Services specific ones.

    ```console
    npm install --save @azure/communication-common @azure/communication-calling
    ```

1. Followed by Parcel, which will allow us to run our app in a browser.

    ```console
    npm install --save-dev parcel
    ```

## Create the index HTML file

1. Create a new file in your app directory called `index.html`.
1. Enter the following text for the contents of this file.

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <title>Azure Communication Services - Simple voice calling app</title>
      </head>
      <body>
        <h1>Azure Communication Services</h1>
        <h2>Simple voice calling app</h2>

        <!-- Calling HTML here -->

        <script src="./app.js" type="module"></script>
      </body>
    </html>
    ```

## Create the app's JavaScript file

1. Create a new file in the app directory called `app.js`
1. For now leave the `app.js` file empty, we'll add to it during the next unit.

## Test your new app

1. In a console window, within the project directory run the following command:

    ```console
    npx parcel index.html
    ```

1. Parcel will now compile and run your app.
1. Once it completes, it will give you a link to see your app within the browser. This link is usually `http://localhost:1234/`:
    :::image type="content" source="../media/3-parcel-response.png" alt-text="Parcel showing a complete build with a hyperlink pointing to the app.":::
1. Open this link in your browser and you should see your blank app in the browser:
    :::image type="content" source="../media/3-blank-app.png" alt-text="Our blank web app showing in a browser.":::
