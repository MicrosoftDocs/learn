Now you are going to create your application frontend. This is what your users will see. A form they will use to submit their images to your application. The web frontend will take care of contacting the Azure Functions REST API you created in the previous exercise. From the API the frontend will obtain a Shared Access Signature that will be used to authenticate and authorize users to upload their images to your storage backend. 

## Create the frontend HTML

1. Start by creating an `index.html` file in the root folder, and add the following code to it:

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Azure Blob Storage Image Upload</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css">
      </head>
      <body>
      <section class="section">
        <div class="container">
          <h1 class="title">Loading SASKey from the API: </h1>
          <pre id="name">...</pre>
          <br>
          <label for="image">Choose a profile picture:</label>
          <input type="file" id="image" name="image" accept="image/png, image/jpeg">
        </div>
      </section>
      <script src="./dist/main.js" type="text/javascript"></script>
        <script>
            (async function () {
                const {url, sasKey} = (await fetch("/api/credentials")).json();
                document.querySelector('#name').textContent = `SAS Key: ${sasKey}` + "\n" + `URL: ${url}`;
                function uploadFile() {
                    const file = document.getElementById('image').files[0];
                    blobUpload(file, url, 'images', sasKey);
                };
                const fileInput = document.getElementById('image');
                fileInput.addEventListener("change", uploadFile);
            }())
        </script>
      </body>
    </html>
    ```

2. Create a `src` folder and add an `index.js` file there.

3. Implement the `blobUpload` function like this:

    ```javascript
    const { BlockBlobClient, AnonymousCredential } = require("@azure/storage-blob");
    
    blobUpload = function(file, url, container, sasKey) {
        var blobName = buildBlobName(file);
        var login = `${url}/${container}/${blobName}?${sasKey}`;
        var blockBlobClient = new BlockBlobClient(login, new AnonymousCredential());
        blockBlobClient.uploadBrowserData(file);
    }
    
    function buildBlobName(file) {
        var filename = file.name.substring(0, file.name.lastIndexOf('.'));
        var ext = file.name.substring(file.name.lastIndexOf('.'));
        return filename + '_' + Math.random().toString(16).slice(2) + ext;
    }
    ```

## Use the Azure Blob Storage SDK with Webpack

1. Install Webpack by running the following commands in your projects root folder:

    ```bash
    npm install webpack --save-dev
    npm install webpack-cli --save-dev
    ```

2. Edit your `package.json` file and add `"build": "webpack --mode=development"` to the `scripts` key, so it ends up looking like this:

    ```json
    "scripts": {
        "start": "func start",
        "test": "echo \"No tests yet...\"",
        "build": "webpack --mode=development"
      }
    ```

3. Run `webpack` by typing:

    ```bash
    npm run build
    ```

## Run your project locally

Now it's time to test your project locally.

1. Press `F5` to start the Azure Functions project in debug mode.
 
2. Wait till VSCode has launched your project. You'll see a URL like the following in the console. Copy it and open it in your browser:

    ```
    http://localhost:7071/api/credentials
    ```

You will see the return value of the function displayed in your browser screen, looking like this:

:::image type="content" source="../media/api-result.png" alt-text="API result in the browser":::

## Test your project using Live Server

Then it's time to run the frontend side of the project. For that you are going to use Live Server.

1. You need to configure Live Server so it forwards calls to your `credentials` API to the Azure Functions backend running on your machine. Add the following configuration key into your `.vscode/settings.json` file.

    ```json
        "liveServer.settings.proxy": {
            "enable": true,
            "baseUri": "/api",
            "proxyUri": "http://127.0.0.1:7071/api"
        }
    ```

2. In the VS Code file tree, right-click on your `index.html` file and select `Open with Live Server` from the contextual menu.

3. Navigate to `http://localhost:5500/` to see your app running on the browser. It should look something like this:

    :::image type="content" source="../media/frontend.png" alt-text="Frontend app in the browser":::

4. Select an image for uploading.

5. Go to your storage account in Azure portal. Click on `Storage Explorer`, then select `Blob Storage` and click on the `images` container. Your image will be there like in the following screenshot.

    :::image type="content" source="../media/container-image.png" alt-text="Storage Explorer listing the uploaded image":::

Congratulations! You just upload an image to Azure Blog Storage directly from your static web app, all thanks to the SAS token generated by your Azure Function.
