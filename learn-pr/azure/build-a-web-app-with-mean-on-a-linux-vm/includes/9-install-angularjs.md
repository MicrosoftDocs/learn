AngularJS is a framework for creating clear and succinct dynamic web applications. You use HTML for your content template language, but extend your HTML with data-binding syntax. Using AngularJS for data-binding and dependency-injection helps eliminate much of the code you would otherwise have to write to manage content updates. The updating of your user's content happens within the browser, which allows AngularJS to pair with any server-side hosting technology.

## Angular.js information

Because AngularJS is a front-end JavaScript framework, it only needs to be made available to the clients that access the application. This can be achieved in several ways:

- Reference AngularJS via a content delivery network (CDN).
- Serve AngularJS from your hosted content as a Node.js package using npm as a package manager.
- Serve AngularJS from your hosted content as a Bower package.

We will be using AngularJS directly from a CDN for this module for simplicity. This passes the script file dependency to the CDN, instead of managing it on our server content directly. This can also improve download speeds based on the speed and geographical distribution of the CDN used for a given resource.

> [!NOTE]
> AngularJS is the predecessor to Angular, which was a complete rewrite of the web application platform. While many of the concepts are similar between the two versions, they are separate projects now. Angular will have versions of 2.x.y and higher, while AngularJS will have versions ending in 1.x.y. AngularJS is still commonly used for web application scenarios.

## How to install AngularJS via CDN

You don't really _install_ AngularJS. You just add a reference to the JavaScript file via a script tag in your HTML page. Since AngularJS is critical to any functionality of our web application, we include it within the `<head>` tag like this (as compared to later-loading of JavaScript files toward the end of the `<body>` tag).

```html
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.2/angular.min.js"></script>
```
