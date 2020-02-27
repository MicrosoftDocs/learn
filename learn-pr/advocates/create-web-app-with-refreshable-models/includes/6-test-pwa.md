You have a web app, and it's been published to Azure. Now you can make sure that it works as a PWA, or Progressive Web App. These apps are particularly interesting if they need to be used offline.

## What is a PWA?

A Progressive Web App is a web site that looks and behaves as if it is a mobile app. That means that it works offline, might use push notifications, and has access to hardware such as bluetooth and cameras. In the case of this app, you can leverage PWA functionality to ensure that your app can work offline as well as online, as all the files needed by the app are available during the build process and no online API calls are needed to access its machine learning model.

## Configure your PWA

For the most part, the Vue CLI has already created the files you need for your PWA. If you look in the `/public/images/icons` folder, you will find ready made icons so that a user can create a bookmark to the app on a desktop. In addition, the build process creates a `service-workers.js` file to launch a service worker that takes care off offline capabilities. You need to make sure that that service worker can be created by adding one more file to your app: a `vue.config.js` file.

Add a new file called `vue.config.js` to the root of your web app. This file will help webpack filter files that stop service workers from being created.

In that file, add this code:

```JavaScript
module.exports = {
	pwa: {
		workboxOptions: {
			exclude: [/\.map$/, /web\.config$/],
		},
	},
};
```

Now, when you push your code to GitHub and it is built, a service worker should be created. You can use the Developer Tools to determine your page's Lighthouse Score, which is a good way to gauge the performance of your PWA.

![lighthouse score](../media/lighthouse.png)

## Test the app

To test your Lighthouse score, open your web app in a browser and open the Developer Tools. Navigate to Audit and create an audit report for your web app. You can test its offline capabilities by clicking `Application` in the Developer Tools area, then click `Service Workers`. Take your app offline by clicking the offline checkbox, then try the app. The model should perform inference well, as if it were online.

Try building a new model in Custom Vision AI with new images for testing and verification, and loading your model again via your build process. The Service Worker should pick up the fact that there is a new model and alert you in console that it exists. When you refresh the screen, the new model should appear.
