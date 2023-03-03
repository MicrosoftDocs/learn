HTML elements can raise events based on user interaction. Components allow you to do the same thing by emitting events. The parent component can then handle these events in much the same way that you would add code to listen to a click event for a button.

## Register events

When you create a component, you register any events that your component might emit by listing them in the `emits` field in `script`:

```html
<!-- inside the component's vue file -->
<script>
export default {
    name: 'Demo',
    emits: ['userUpdated']
}
</script>
```

## Emit events

You emit an event by using the `$emit` function. If you want to emit an event that an HTML control has raised directly, you can perform this operation inline. Notice how you can emit the `userUpdated` event by registering the `click` event handler for a button:

```html
<!-- inside the component's vue file -->
<template>
    <button @click="$emit('userUpdated')">Save user</button>
</template>
```

> [!NOTE]
> You're using the shortcut of `@click`, which is typically how you connect event handlers in Vue.

At times, you might need to perform more steps before emitting the event. If your component needs to save the value to a database before returning any updated information, you can add a method. Inside the method, you can use `this.$emit` to raise the event as you did before:

```html
<!-- inside the component's vue file -->
<template>
    <button @click="saveUser">Save user</button>
</template>
<script>
export default {
    name: 'UserDialog',
    emits: ['userUpdated'],
    methods: {
        saveUser() {
            // perform other operations
            this.$emit('userUpdated'); // emits event
        }
    }
}
</script>
```

## Emit events with data

The component might need to return data to the parent through events. You can return any data by passing other parameters to `$emit`. If you want to indicate that the update was successful by returning `true`, you can update the call like this:

```html
<button @click="$emit('userUpdated', true)">Save user</button>
```

Or you can use a method:

```javascript
methods: {
    saveUser() {
        // perform other operations
        this.$emit('userUpdated', true); // emits event
    }
}
```

## Listen to events

Listening to an event emitted by a component is similar to listening to events raised by normal HTML controls. You typically create a method in the parent component, and then you connect the method to the event by using the same `@<event-name>` syntax as you would for `@click` or other events. If the event returns any data, it will be passed as parameters to the function.

To add an event handler for the `userUpdated` event that you created earlier, you can use the following code. Notice how Vue.js will convert from a camelCase name into a kebab-case name.

```html
<template>
<user-dialog @user-updated="handleUserUpdated"></user-dialog>
</template>
<script>
import UserDialog from './UserDialog.vue';
export default {
    methods: {
        handleUserUpdated(success) {
            if (success) {
                alert('It worked!!');
            } else {
                alert('Something went wrong');
            }
        }
    },
    components: {
        UserDialog
    }
}
```
