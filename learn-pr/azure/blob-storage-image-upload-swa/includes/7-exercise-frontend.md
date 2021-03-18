# Exercise: create the image upload frontend

Start by creating an index.html file in the root folder, and add the following code to it:

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
            function 'images', () {
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

To implement the blobUpload function, create a src folder and add an index.js file there. Then insert the following code:

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

Install Webpack by running the following command in your projects root folder:

```bash
npm install webpack --save-dev
npm install webpack-cli --save-dev
```

Then run webpack by typing:

```bash
webpack --mode=development
```
