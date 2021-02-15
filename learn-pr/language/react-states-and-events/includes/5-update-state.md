As highlighted before, state in React is immutable. When we want to modify the value of a stateful object we replace with a completely new object. By making an object immutable it avoids an entire class of bugs where an object might be in an invalid state because it is being edited.

## Copying objects

Primitive types (such as booleans or numbers) are value-based objects (as opposed to reference), meaning any change automatically replaces the entire object. Strings behave in a similar fashion, as they are immutable; you modify a string by replacing it with a new value.

```javascript
let message = 'Hello, ';
message = message + 'world!';
```

When working with an object it is our responsibility to create a new instance of it to ensure immutability. The most common syntax for creating a copy of an object is to use the [spread syntax](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Spread_syntax/?azure-portal=true) (or spread operator).

```javascript
let message = {
    text: 'Hello, world',
    color: 'red'
}

let messageCopy = { ...message };
```

## Modifying individual properties

Typically you only need to update a subset of properties on an object. Creating a copy and modifying each property would become tedious. You will notice in the syntax above we are creating a new JSON object by using `{ }`. The spread operator can be used to create an initial version of the new object, and allow us to specify updated values for certain properties. If we have a new value for `color` but want to retain the text, we can use the following:

```javascript
let message = {
    text: 'Hello, world',
    color: 'red'
}

let messageCopy = {
    ...message,
    color: 'green'
};
```

`text` will retain the original value, while `color` will be updated to green.

```javascript
// new object
{
    text: 'Hello, world',
    color: 'red'
}
```
