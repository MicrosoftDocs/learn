In this unit, you create a starter Vue application by using an HTML file. The file is linked to the Vue core library and an external JavaScript file that contains the application details. You define one Vue data variable and display it dynamically within the HTML page.

## Clone the starter repository

The starter site for the application includes images and a base style. Start by cloning the repository and opening it in Visual Studio Code.

In a terminal or command window, run the following commands.

```bash
git clone https://github.com/MicrosoftDocs/mslearn-vue-get-started/
cd mslearn-vue-get-started/start
code .
```

## Link to the Vue core library in your HTML file

You install Vue.js from the content delivery network (CDN).

1. In Visual Studio Code, open *index.html*.
1. Install Vue.js by linking to the Vue core library. In your starter *index.html* file, below the `TODO: Import Vue.js core library` comment, paste the following script tag.

    ```html
    <!-- TODO: Import Vue.js core library -->
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    ```

## Create a JavaScript file for your Vue application

You can start writing a Vue script inside your HTML file if you want. But typically you can manage your application more cleanly by placing the code in a separate JavaScript file.

1. Create a new file named *index.js*.
1. Create the app by adding the following code to *index.js*.

    ```javascript
    const app = Vue.createApp({
        data() {
            return {
                productName: 'Book a Cruise to the Moon',
                productDescription: 'Cruise to the moon in our luxurious shuttle. Watch the astronauts working outside the International Space Station.',
                // additional properties later


            }
        },
    });
    ```

    The `createApp()` function is available to you because you imported the Vue.js library into the `<head>` tag of your HTML page. You then pass an argument for this function as an object with a `data` property. This object returns another object that you use to store your data.

## Import and mount the application

Now that you created the JavaScript code, you can import and mount the application.

1. Return to *index.html*.
1. Below the `TODO: Import Vue app` comment, add the following script.

    ```html
    <script src="./index.js"></script>
    <script>
        app.mount('#app');
    </script>
    ```

## Use the Vue application

Now that you created and imported your Vue application, you can create the display for the information.

In the *index.html* file, below the `TODO: Add information display` comment, add the following HTML.

```html
<div id="app">
    <h2>{{ productName }}</h2>
    <div>{{ productDescription }}</div>
</div>
```

> [!IMPORTANT]
> Page order is important in Vue.js processing. You can't attach your application to the document object model (DOM) until the HTML page is fully loaded. So import the Vue application at the bottom of the page after all other HTML elements have been loaded into the browser. It's generally a good idea to let the HTML page load before you call an external script file that's intended to change the content or structure of the DOM.

## Open the page by using Live Server

The [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer&azure-portal=true) extension for Visual Studio Code creates a development web server that automatically refreshes the page as changes are detected. To install the extension, follow the preceding link. Then use it to host your page.

1. Save all files.
1. Open the command palette in Visual Studio Code by selecting Ctrl+Shift+P. On a Mac, select Cmd+Shift+P.
1. Type *Live Server: Open with Live Server*.

    In the dialog box that opens, you see that your page is now hosted on `http://localhost:5500`.

1. Open a browser and go to `http://localhost:5500`.

You should see the page you created!

:::image type="content" source="../media/getting-started.png" alt-text="Screenshot showing the newly created page.":::