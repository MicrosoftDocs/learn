As you develop your Progressive Web App (PWA), you might want to make it more engaging and personalized. This is where customizing your PWA becomes essential. You can modify your PWA's icons, theme colors, and display options to align them more closely with your brand, thereby enhancing your users' experience. In this unit, we'll explore the various options to achieve customization available through PWABuilder.

## Edit manifest in PWABuilder

You can edit your manifest (modify PWA icons, theme colors, and display options, etc.) prior to downloading it.

To edit your manifest on the PWABuilder site:

1. From the **report card page**, select the **Edit Your Manifest** button.

    :::image type="content" source="../media/select-edit-your-manifest-button.png" alt-text="Screenshot of PWABuilder's report card page that shows the Action Items section and the Manifest section.  The Edit Your Manifest button located on the bottom right of the page is highlighted.":::

1. The **manifest editor modal** appears, allowing you to edit the fields of your manifest using a form.

    :::image type="content" source="../media/manifest-editor-modal.png" alt-text="Screenshot of PWABuilder's Manifest Editor modal.":::

1. The manifest editor has six tabs, each for editing or displaying a different part of your manifest:

   - **Info tab**: Contains manifest members that contain display information for your application.
   - **Settings tab**: Contains manifest members that manage how your application runs and displays at the most basic level. This includes how your application is oriented, its start URL, and other important options.
   - **Platform tab**: Contains manifest members that relate to how your application interacts with native operating systems and app stores.
   - **Icons tab**: Allows you to generate proper icons for your progressive web app. See Icon Generation for more details.  
   - **Screenshots tab**: Allows you to generate screenshots to be displayed with your progressive web app in stores.
   - **Code tab**: Contains a preview of the manifest code generated if you download your edited manifest.

1. After you edit and review your manifest, click the **Download Manifest** button to download a copy to add to your PWA.

## Generate icon from PWABuilder

You can use the PWABuilder website to generate appropriate-sized icons for your Progressive Web App (PWA). Currently, PWABuilder supports generating the proper icons for Android, Windows, and iOS.

To get icons from PWABuilder:

1. From your app's dashboard on PWABuilder, select **Edit Your Manifest**.
1. Navigate to the **Icons tab** using the top-level menu.

    :::image type="content" source="../media/manifest-editor-modal-icons-pane.png" alt-text="Screenshot of PWABuilder's Manifest Editor modal with the Icons pane open.":::

1. Select **Upload** and select an image you want to generate platform icons from. We recommend that it's a square icon, sized around 512x512.
1. Check/uncheck which platforms you would like to generate icons for and select **Generate Zip**.
1. A zip containing your icons is downloaded to your Downloads folder.

Next, you need to add references to the downloaded icons in your manifest.json. To add the references, refer to the following steps:

1. Decompress the zip archive you downloaded from PWABuilder.
1. Create an icon folder within the assets folder.
1. Add all of the icon images into the newly created icon folder.
1. Finally, copy and paste the icons field in the icons.json field into your manifest.json.
1. Once the folders are included and the icons member is added to your manifest, your new icons will be properly associated with your PWA.

## Modify the app manifest file properties

The app manifest provides metadata about the web application. By updating your app manifest file, you can modify your PWA's icons, theme colors, and display options to align with your desired settings and provide a consistent brand experience to your users. To update the manifest file properties:

1. Locate your app manifest file (manifest.json) in your project directory.
1. Open the file in a code editor or text editor of your choice.
1. To update your PWA's theme colors, locate the properties "theme_color" and "background_color" in the JSON file. Replace the default color values with the hexadecimal color values that you prefer. For example:

  ```json
    {"theme_color": "#123456","background_color": "#abcdef"}
  ```

1. To change the display options of your PWA, locate the "display" property in the JSON file. Update its value to one of the following options: "fullscreen", "standalone", "minimal-ui", or "browser". For example:

  ```json
    {"display": "standalone"}
  ```

1. To replace the default icons with your custom icons, locate the "icons" property in the JSON file. It should contain an array of icon objects, each with "src," "sizes," and "type" properties. Replace the "src" value with the relative path to your custom icon file. Additionally, update the "sizes" and "type" values to match the dimensions and file format of your new icon. Repeat this process for each icon object in the array. For example:

```json
{"icons": [{"src": "/path/to/your/icon-48x48.png","sizes": "48x48","type": "image/png"},{"src": "/path/to/your/icon-192x192.png","sizes": "192x192","type": "image/png"}]}
```

1. Save the changes to your app manifest file.

## Additional PWA features

When using PWABuilder to create a PWA, you can incorporate additional features like push notifications, background sync, and offline capabilities by extending the generated service worker file and customizing your app's code. Here's how to implement these features using PWABuilder:

### Implement push notifications

To enable push notifications in your PWABuilder-generated PWA, follow these steps:

1. **Modify your app code**: In your app's JavaScript file, request permission from users to send notifications using the Notification.requestPermission() method. Once granted, subscribe the user to a push service using the PushManager.subscribe() method, which requires a public VAPID (Voluntary Application Server Identification) key from your push service.
1. **Set up a backend server**: Create a backend server to store user subscriptions and send notifications through the push service.
1. **Update the service worker**: Extend the generated service worker file from PWABuilder to include a 'push' event listener. In the event listener, use the showNotification() method to display notifications when a push event is received.

### Implement background sync

To implement background sync with PWABuilder, follow these steps:

1. **Register a sync event**: In your app's JavaScript file, register a sync event with a unique tag by calling the SyncManager.register() method. This event will be triggered when the device is back online.
1. **Update the service worker**: Modify the generated service worker file from PWABuilder to listen for 'sync' events. Inside the sync event listener, perform the necessary actions, such as sending data to the server or fetching updates.

To learn more about the manifest file, refer to [PWABuilder - Customizing Your Web App Manifest](https://docs.pwabuilder.com/#/builder/manifest) for the full breakdown.
