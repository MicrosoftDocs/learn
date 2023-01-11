By using the handlebars syntax (`{{ }}`), you can display values and inject JavaScript into your HTML. This syntax is powerful, but it can lead to confusing or repetitive code. You can use computed properties in Vue to offload calculations and other forms of dynamic strings.

## Create a computed property

Similarly to how methods are added under a `methods` field, computed properties are added to the `computed` field. A *computed property* is a function that returns a value. Like a method, a computed property can access the active instance of Vue by using `this`.

You can use computed properties to combine `firstName` and `lastName` into a `fullName` property, do lookups in an array to return the correct value, or do other dynamic tasks.

Further, a computed property is *reactive*. If any values in the computed property change, the computed property is updated to reflect the change.

The following example creates a `fullName`.

```javascript
const app = Vue.createApp({
    data() {
        return {
            firstName: 'Cheryl',
            lastName: 'Smith'
        }
    },
    computed: {
        fullName() {
            return `${this.lastName}, ${this.firstName}`
        }
    },
});
```

A string literal concatenates the `lastName` and `firstName` fields.
