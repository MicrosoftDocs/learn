HTML elements are the building blocks you use to create pages. We can configure their behavior by setting attributes to different values. As highlighted earlier, creating a component is similar to creating a custom HTML tag. As a result, we can pass in information to enhance the reuse of components through props.

## Defining props

Props, short for properties, are a set of values you can pass into a component. You will typically add props to a component to pass in the values it should display or otherwise change its behavior.

You define props for a component by adding the `props` field inside the `script` element. You can list the names of a components props by listing them in an array:

```html
<!-- UserDisplay component -->
<script>
export default {
    name: 'UserDisplay',
    props: ['name', 'age']
}
</script>
```

Props are set by the caller of the component using the same syntax as an HTML attribute. Assuming the above component, we can set `name` and `age` like this:

```html
<!-- inside parent component -->
<template>
    <user-display :name='Cheryl' :age='28'></user-display>
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

The values `Cheryl` and `28`, are bound to the `name` and `age` property respectively, using an attribute binding.

> [!NOTE]
> The component named `UserDisplay` will be converted into the kebab-cased `user-display` by Vue.js. Also, the `:` in front of each name indicates this is a Vue.js property we are setting.

## Restricting types

By listing them as part of an array, the caller can pass in values of any type. This can be appropriate for basic applications, but you will often want to indicate what data types you are expecting for each prop.

You can provide more robust information about the props by defining a schema. If you want to indicate `name` should be a string and `age` a number, you can define your props schema like the following:

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

Notice how you're creating a props object with the types for `name` and `age`. This component will now only accept the specified data types. You can still set them as before:

```html
<!-- inside parent component -->
<user-display :name='Cheryl' :age='28'></user-display>
```

However, where you to set them to values that doesn't match with the schema, like passing a number to `name`, for example, you will get a warning in the console, asking you to take action.

## Complex objects

When working with Vue, you will typically work with objects rather than individual values. Fortunately, you can declare more complex structures with props as well.

If you're using a `User` object with the properties `name` and `age`, you can declare this as a full construct in your props:

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

You can set the value using the attribute as you did before. In addition, you can pass in dynamic data as well by specifying the name of the object you wish to use. In the example below you have a piece of data named `user`, which is passed using the same syntax as static values.

```html
<!-- parent component -->
<template>
<user-display :user="user"></user-display>
</template>

<script>
import UserInfo from './UserInfo.vue';
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

Inside a component, props can be read in the same way you would read data. The full `UserDisplay` component might look like this:

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
> Unlike stateful data, values passed via props are a one-way binding. If changes are made to a prop those updates do *not* bubble back to the parent.
