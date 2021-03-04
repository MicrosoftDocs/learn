Because state in React is immutable, to modify the value of a stateful object, we replace it with a new object. So we avoid an entire class of bugs where an object might be in an invalid state because it's being edited.

## Copy objects

Primitive types, such as Boolean values or numbers, are value-based objects as opposed to reference objects. So any change automatically replaces the entire object. 

Strings behave similarly because they're immutable. We modify a string by replacing it with a new value.

```javascript
let message = 'Hello, ';
message = message + 'world!';
```

When we work with an object, we need to create a new instance of it to ensure immutability. The most common syntax for creating a copy of an object is the [*spread syntax*](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Spread_syntax/?azure-portal=true), also called the *spread operator*.

```javascript
let message = {
    text: 'Hello, world',
    color: 'red'
}

let messageCopy = { ...message };
```

## Modify individual properties

Typically, we need to update only a subset of properties for an object. Creating a copy and modifying each property would become tedious. 

In the preceding syntax, notice that we create a new JSON object by using curly brackets (`{ }`). The spread operator can be used to create an initial version of the new object. It allows us to specify updated values for certain properties. If we have a new value for `color` but want to keep the text, for example, we can use the following code.

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

Here, `text` keeps the original value. The `color` value is updated to green.

```javascript
// new object
{
    text: 'Hello, world',
    color: 'red'
}
```
