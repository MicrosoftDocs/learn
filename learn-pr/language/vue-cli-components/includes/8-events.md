HTML elements can raise events based on user interaction. Components allow you to do the same thing by emitting events. These events can then be handled by the parent component much in the same way you would add code to listen to an click event for a button.

## Registering events

When creating the component, you register any events your component may emit, by listing them in the `emits` field in the `script`.

```html
<!-- inside the component's vue file -->
<script>
export default {
    name: 'Demo',
    emits: ['userUpdated']
}
</script>
```

## Emitting events

Emitting an event is done by using the `emit` function. If you wish to emit an event raised directly by an HTML control, you can perform this operation inline. Notice how you can emit the `userUpdated` event by registering the `click` event handler for a button:

```html
<!-- inside the component's vue file -->
<template>
    <button @click="emit('userUpdated')">Save user</button>
</template>
```

> [!NOTE]
> You are using the shortcut of `@click`, which is typically how you connect event handlers in Vue.

There may be times when you need to perform some additional steps before emitting the event. If your component needed to save the value to a database before returning any updated information, you can do this by adding a method. Inside the method you can use `this.$emit` to raise the event as you did before.

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

## Emitting events with data

The component may need to return data back to the parent through events. You can return any data by passing additional parameters to `emit` or `$emit`. If you wanted to indicate the update was successful by returning `true`, you could update the call as shown below:

```html
<button @click="emit('userUpdated', true)">Save user</button>
```

or in a method:

```javascript
methods: {
    saveUser() {
        // perform other operations
        this.$emit('userUpdated', true); // emits event
    }
}
```

## Listening to events

Listening to an event emitted by a component, is similar to listening to events raised by normal HTML controls. You typically will create a method in the parent component, and connect the method to the event by using the same `@<event-name>` syntax as you would for `@click` or other events. If the event returns any data, those will be passed as parameters to the function.

To add an event handler for the `userUpdated` event you created earlier, we could use the following code. Notice how Vue.js will convert from the camelCased name into a kebab-case name.

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
