To start using Vue.js, you need to install the framework, create a Vue app, and then register it on the page. Registration tells the page how to use the app. 

Let's get started.

## Add Vue.js to a page

You can add Vue.js to an application in a few ways. In this module, you'll add a `script` element to import Vue from a content delivery network (CDN). By using a CDN, you can add Vue to existing applications without rewriting them.

To add Vue to a page by using a CDN, you add the following `script` element to your page.

```html
<script src="https://unpkg.com/vue@next"></script>
```

This element tells the browser to run the script file that the `src` directive references. After the script runs, the Vue APIs become available.

## Create an app

All Vue.js applications begin with creating an app object. The app is the central location for any data and methods your application uses. Although the app object follows some conventions, at its core, it's a JavaScript object. 

To create a Vue app, invoke the method `createApp()`.

```javascript
const App = Vue.createApp({
    // methods and content go here
});
```

## Add data

Now that you've created your app, you can add properties that give your app more functionality. An important method that most apps use is `data()`. Vue.js uses this method to access any information you need to make available to your application.

> [!NOTE]
> You'll use the `data()` method throughout this module.

Any properties inside the object that `data()` returns are dynamic. Vue.js automatically detects any value changes. It then updates and refreshes the appropriate portions of the display with the updated information.

### Create a data object

Vue.js invokes the `data()` method. In return, Vue.js expects a JavaScript object. 

In the following example, the returned object contains the properties `firstName` and `lastName`.

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

At this point, the data is exposed so it can be displayed for the user. 

## Mount the app

The created app object must be *mounted* before Vue.js can use it. By mounting the app, you indicate the portion of the page the app controls, allowing it to display information or even HTML. 

To mount the application, you reference the `id` of an ordinary HTML element.

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

At runtime, the contents of the `id= 'app'` element are replaced with the contents of the Vue.js application.

## Display data

To display data on the page, you use the `{{ }}` syntax, sometimes called *handlebars*. Inside the `{{ }}` syntax, you can provide whatever JavaScript code is necessary to access the information you want to display.

The `data()` function you created earlier returns an object. Vue.js automatically makes the object available, so you don't need to call `data()`. 

If you want to display the first name, you can use the syntax `{{ firstName }}`. The following example shows the full application, which can display `lastName` and `firstName`.

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
> The `{{ }}` syntax works only inside elements that Vue controls. The syntax would work either inside a component or inside the HTML element that Vue mounted.
