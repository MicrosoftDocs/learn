To start using Vue.js, we need to install the framework, create a Vue app, and then register it on the page (tell the page how to use the app). Let's see how this is done.

## Add Vue.js to a page

There are a few different ways of adding Vue.js to an application. In this module, we will explore how you can implement Vue by adding a `script` element to import Vue from a content delivery network (or CDN). By using a CDN, it's possible to add Vue to existing applications without having to completely rewrite them.

To add Vue to a page by using the CDN, you add the following `script` element to your page.

```html
<script src="https://unpkg.com/vue@next"></script>
```

This will tell the browser to run the script file referenced in the `src` directive. After it runs, Vue's APIs will become available.

## Create an app

All Vue.js applications begin with creating an app object. The app is the central location for any data and methods your application will use. While the app object follows certain conventions, at its core, it's a JavaScript object. To create a Vue app, invoke the method `createApp()`.

```javascript
const App = Vue.createApp({
    // methods and content go here
});
```

## Add data

You've seen so far how you can create a Vue.js application by calling the `createApp()` method. You can add various properties to it to give your app more functionality. An important method, that most apps have, is `data()`. It's used by Vue.js to access any information you need to make available to your application.

> [!NOTE]
> You'll focus on using this method throughout this module.

Any of the properties inside the object returned by `data()`, are dynamic. If the values change, Vue.js will automatically detect those updates and refresh the appropriate portions of the display as needed with the updated information.

### Creating a data object

The `data()` method will be invoked by Vue.js itself and Vue.js expects the method to return a JavaScript object. Here's an example where an object is returned containing the properties `firstName` and `lastName`.

```javascript
// a sample app object
const App = Vue.createApp({
    data() {
        return {
            firstName: 'Christopher',
            lastName: 'Harrison'
        };
    }
});
```

At this point, the data is now exposed so that it can be displayed for the user, more on that later.

## Mount the app

In order for Vue.js to use the created app object, it must be *mounted*. By mounting the app, you're telling Vue.js the portion of the page it controls, allowing it to display information or even HTML. To mount the application you reference the `id` of an ordinary HTML element.

```html
<!-- the HTML element which will host our app -->
<div id='app'>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    const App = Vue.createApp({
        data() {
            return {
                firstName: 'Christopher',
                lastName: 'Harrison'
            };
        }
    });
    // Registering and mounting our app
    App.mount('#app');
</script>
```

At runtime, the element with id `app` will now have its content replaced with that of the Vue.js application.

## Display data

To display data on the page you use the `{{ }}` syntax, sometimes called **handlebars**. Inside `{{ }}`, you can provide whatever JavaScript code is necessary to access the information you wish to display.

You'll notice you created a `data()` function earlier, which returns an object. Vue.js will automatically make the object available, so there is no need to call `data()`. If you wish to display the `firstName` from before, you can use the syntax `{{ firstName }}`. You can see the full application below, which can display `lastName` and `firstName`.

```html
<!-- the HTML element which will host our app -->
<div id='app'>
    {{ lastName }}, {{ firstName }}
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    const App = Vue.createApp({
        data() {
            return {
                firstName: 'Christopher',
                lastName: 'Harrison'
            };
        }
    });
    // Registering and mounting our app
    App.mount('#app');
</script>
```

> [!NOTE]
> The `{{ }}` syntax will only work inside elements which are controlled by Vue. This could either be inside of a component (which is covered in other modules), or inside the HTML element "mounted" by Vue.
