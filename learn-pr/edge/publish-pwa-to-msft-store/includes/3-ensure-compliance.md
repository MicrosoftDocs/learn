Before you publish your PWA to the Microsoft Store, you need to ensure it aligns with our guidelines and requirements. 

## Confirm web app manifest specifications

The web app manifest is a JSON file that provides crucial information about your app to the browser. It allows your PWA to behave more like a native app.

Ensure that your web app manifest is correctly structured and includes all the necessary attributes.

- **name**: Defines the name of your app as it's usually displayed to the user (amongst a list of other applications or as a label for an icon).
- **start_url**: Indicates the default URL that opens when the user launches your PWA.
- **display**: Defines the preferred display mode for your app. It can be: "fullscreen," "standalone," "minimal-ui," or "browser".
- **icons**: Specifies an array of image files that can serve as application icons.
- **background_color**: Defines the expected background color for the website. This value repeats what's already provided in the site's CSS.
- **theme_color**: Defines the default theme color for the application. This sometimes affects how the OS displays the site. For example, on Android's task switcher, the theme color surrounds the site.

## Confirm service worker API standards

Service workers are scripts that your browser runs in the background, separate from a web page. They enable features that don't need a web page or user interaction, like push notifications and background sync. Here are the key steps for ensuring your service worker meets the standards:

1. **Register your service worker**.  For example:

    ```
    if ('serviceWorker' in navigator) {
     window.addEventListener('load', function() {
     navigator.serviceWorker.register('/service-worker.js');
     });
    }
    ```

1. **Implement caching for offline functionality**. Here's a basic example of how to use the cache API within a service worker:

    ```
    self.addEventListener('install', function(event) {
      event.waitUntil(
       caches.open('my-cache').then(function(cache) {
         return cache.addAll(
              [
              '/',
              '/index.html',
              '/style.css',
              '/script.js',
              '/icon.png',
              ]
             );
           })
         );
    });
    ```

1. **Handle push notifications**. Here's an example of how you can listen for push events and display a notification:

    ```
    self.addEventListener('push', function(event) {
     const title = 'Get Started With Workbox';
     const options = {
            body: event.data.text()
            };
     event.waitUntil(self.registration.showNotification(title, options));
    });
    ```

## Review store policies and code of conduct

In addition to technical specifications, your PWA must also align with the relevant [store policies and code of conduct](/windows/apps/publish/store-policies-and-code-of-conduct). Regularly review these policies to ensure that your application remains in compliance.
