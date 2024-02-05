After you analyze your project, [PWABuilder](https://aka.ms/pwa/mslearn/data) provides options to generate the app manifest and service worker files if the app doesn't have them already. As a review, the app manifest is a JSON file that provides information about a web application. The service worker is a JavaScript file that is a virtual proxy between the browser and the network. It's very powerful and can do things like managing network requests, enabling offline usage, and handling push notifications.

## Generate app manifest and service worker files

Here are the PWABuilder steps for generating app manifest and service worker files:

1. After the analysis is complete, select the **Edit Your Manifest** tab under **Manifest**.
1. Review and modify the manifest members as needed, such as app name, icons, theme colors, and display options.
1. Select **Download** to download the manifest file.
1. Select the **Generate Service Worker** tab under **Service Worker**.
1. Choose the appropriate service worker template based on your project's requirements. There are three different templates available:

   - **Offline pages**: This simple but elegant solution pulls a file from your web server called *offline.html*. You must make sure the file is there. It serves the file whenever a network connection can't be made.
   - **Offline page copy of pages**: A solution that expands the offline capabilities of your app. A copy of each page is stored in the cache as your visitors view them. This allows a visitor to load any previously viewed page while they're offline.
   - **Offline copy with backup offline page**: A copy of each page is stored in the cache as your visitors view them. This allows a visitor to load any previously viewed page while they're offline. This then adds the offline page that allows you to customize the message and experience if the app's offline and the page isn't in the cache.
  
1. Select **Download** to download the service worker file.
1. Move the downloaded manifest and service worker files to your project's root folder.
1. Open your project's *index.html* file in a code editor or text editor of your choice.
1. Add a link to the manifest file in the head section of your *index.html* file by inserting the following line of code: `<link rel="manifest" href="manifest.json" />`

1. Add the following JavaScript code to the `index.html` file to register the service worker. You can place the code either in the head section, inside a `<script>` tag, or at the end of the body section, before the closing `</body>` tag:

   ```javascript
   if (typeof navigator.serviceWorker !== 'undefined') {
       navigator.serviceWorker.register('sw.js')
   }
   ```

1. Save the changes to your *index.html* file.
1. Push any changes to your server.
