In this unit, you create a web app and run it in the browser.

## Create app folder

1. In a console window (such as cmd, PowerShell, or Bash), run the following commands to create a new folder for your app and change into it:

    ```console
    mkdir VoiceCallingApp
    cd VoiceCallingApp
    ```

1. Prepare the new folder to become a web app:

    ```console
    npm init -y
    ```

These commands set up the folder for Node.js and allow you to save and manage dependencies.

## Add the required dependencies

Now you can add the required dependencies.

1. Add the dependencies that are specific to Azure Communication Services:

    ```console
    npm install --save @azure/communication-common @azure/communication-calling
    ```

1. Add the Parcel dependency so that you can run your app in a browser:

    ```console
    npm install --save-dev parcel
    ```

## Create the index HTML file

1. Create a new file in your app directory named *index.html*.
1. Enter the following text for the contents of this file:

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

1. Create a new file in the app directory named *app.js*.
1. For now, leave the *app.js* file empty. (You add to that file during the next unit.)

## Test your new app

1. In a console window, go to the project directory and run the following command:

    ```console
    npx parcel index.html
    ```

   Parcel compiles and runs your app. Once the command finishes, it gives you a link to see your app within the browser. This link is usually `http://localhost:1234/`:

   ```console
   PS C:\Users\contoso-user\VoiceCallingApp> npx parcel index.html
   Server running at http://localhost:1234
   ✨ Built in 555ms
   ```

1. Open this link in your browser. You should see your blank app in the browser:

   :::image type="content" source="../media/3-blank-app.png" alt-text="Screenshot of the blank web app showing in a browser.":::
