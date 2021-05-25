In an application, events are actions that can occur, but you don't necessarily know when. For example, if you have a button on a page, you know the user will likely select it. But you don't know the timing. 

You need to know how to handle events to create any web application. Here you'll explore how to manage events by using Vue.js.

## v-on directive and @

Vue.js provides a directive called `v-on` that you can bind to any event, such as `v-on:click`. Because handling events is a core task, Vue.js also provides the `@` shortcut for any event. So to bind a click event, you can use the `@click` shortcut.

## Event handlers

You can create event handlers by adding functions to the `methods` field in a Vue application or component. The `methods` field is like `data()`, but instead of returning state objects, it maintains a list of available functions for your application. You can reference these functions in your HTML in the same way you reference other JavaScript functions.

> [!NOTE]
> The key reason to add functions to the `methods` field is that functions can access any registered data.

When you add a method to a Vue app or component, `this` points to the active instance. Any data available to the active instance, such as `name` in the following example, is accessible from `this`.

### Create an event handler

To create a method that displays the value of the `name` data property when it's called, you could follow this example:

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

Because `displayName()` is added to the `methods` property, it's accessible to the template and can be bound to an event.

### Bind the event handler to an event

You can bind the `displayName()` function to the `click` event by using the shorthand `@click`. When the user selects the button, the `displayName()` function is invoked.

```html
<button type="button" @click="displayName">Display name</button>
```
