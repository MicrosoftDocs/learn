HTML elements are the building blocks for creating pages. You can configure their behavior by setting attributes to different values. As highlighted earlier, creating a component is similar to creating a custom HTML tag. As a result, you can pass in information to enhance the reuse of components through *props*.

## Defining props

Props, short for *properties*, are a set of values that you can pass in to a component. You'll typically add props to a component to pass in the values that it should display or otherwise change its behavior.

You define props for a component by adding the `props` field inside the `script` element. You can list the names of a component's props by listing them in an array:

```html
<!-- UserDisplay component -->
<script>
export default {
    name: 'UserDisplay',
    props: ['name', 'age']
}
</script>
```

The caller of the component sets props by using the same syntax as an HTML attribute. Assuming the previous component, we can set `name` and `age` like this:

```html
<!-- inside parent component -->
<template>
    <user-display name='Cheryl' age='28'></user-display>
</template>
<script>
import UserDisplay from './UserDisplay.vue';
export default {
    components: {
        UserDisplay
    }
}
</script>
```

The values `Cheryl` and `28` are bound to the `name` and `age` property, respectively, through an attribute binding.

> [!NOTE]
> Vue.js will convert the component named `UserDisplay` into the kebab-cased `user-display`.

## Restricting types

The caller can pass in values of any type by listing them as part of an array. This method can be appropriate for basic applications, but you'll often want to indicate what data types you're expecting for each prop.

You can provide more robust information about the props by defining a schema. If you want to indicate that `name` should be a string and `age` should be a number, you can define your prop schema like the following:

```html
<!-- UserDisplay component script -->
<script>
export default {
    name: 'UserDisplay',
    props: {
        name: String,
        age: Number
    }
}
</script>
```

Notice how you're creating a prop object with the types for `name` and `age`. This component will now accept only the specified data types. You can still set them as before:

```html
<!-- inside parent component -->
<user-display name='Cheryl' age='28'></user-display>
```

However, if you set data types to values that don't match with the schema, like passing a number to `name`, you'll get a warning in the console. The warning will ask you to take action.

## Complex objects

When you're working with Vue, you typically work with objects rather than individual values. Fortunately, you can declare complex structures with props.

If you're using a `User` object with the properties `name` and `age`, you can declare this object as a full construct in your props:

```html
<!-- UserDisplay component script -->
<script>
export default {
    name: 'UserDisplay',
    props: {
        user: {
            name: String,
            age: Number
        }
    }
}
</script>
```

You can set the value by using the attribute as you did before. In addition, you can pass in dynamic data by specifying the name of the object that you want to use. In the following example, a piece of data named `user` is passed by using the same syntax as static values:

```html
<!-- parent component -->
<template>
<user-display :user="user"></user-display>
</template>

<script>
import UserDisplay from './UserDisplay.vue';
export default {
    data() {
        return {
            user: {
                firstName: 'Cheryl',
                age: 28
            }
        }
    },
    components: {
        UserDisplay
    }
}
</script>
```

## Using props inside a component

Inside a component, props can be read in the same way that you would read data. The full `UserDisplay` component might look like this:

```html
<template>
    <div>Name: {{ user.name }}</div>
    <div>Age: {{ user.age }}</div>
</template>
<script>
export default {
    name: 'UserDisplay',
    props: {
        user: {
            name: String,
            age: Number
        }
    }
}
</script>
```

> [!IMPORTANT]
> Unlike stateful data, values passed via props are a one-way binding. If changes are made to a prop, those updates don't bubble back to the parent.
