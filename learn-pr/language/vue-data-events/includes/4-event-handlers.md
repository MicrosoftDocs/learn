Events are actions which can occur in our application but you don't necessary know when. For example, if you have a button on a page you know it's likely the user will click on it, but the timing is unknown. Handling events is a key component to creating any web application. You will explore how Vue.js allows you to manage events.

## v-on directive and @

Vue.js provides a directive called `v-on` which can be bound to any event, such as `v-on:click`. However, since handling events is a core task Vue.js also provides the `@` shortcut for any event. To bind a click event you can use `@click` instead.

## Event handlers

You can create event handlers by adding functions to the `methods` field in a Vue application or component. `methods` is just like `data()`, only instead of returning state objects it maintains a list of available functions for your application. You can then reference these in your HTML in the same way you would reference other JavaScript functions.

> [!NOTE]
> The key reason to add functions to the `methods` field is the functions can access any registered data.

When adding a method to a Vue app or component, `this` points to the active instance. Any data available to the active instance, such as `name` in our example below, is accessible from `this`.

### Creating an event handler

To create a method, which would display the value of the `name` data property when called, you could add it like so:

```javascript
const app = Vue.createApp({
    data() {
        return {
            name: 'Cheryl'
        }
    },

    methods: {
        displayName() {
            console.log(this.name);
        }
    }
});
```

As `displayName()` has been added to the `methods` property and it's now accessible to the template and is ready to be bound to an event.

### Bind the event handler to an event

You can bind the `displayName()` function to the `click` event, using the shorthand `@click`. When the user then clicks the button, the `displayName()` function is invoked.

```html
<button type="button" @click="displayName">Display name</button>
```
