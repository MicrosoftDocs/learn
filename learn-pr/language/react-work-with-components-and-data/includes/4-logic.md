JSX is a combination of HTML and JavaScript. As a result, whenever we need logic, such as determining how we want to display something (or if we want to display it at all), we use JavaScript. We can use `if...else` statements, `case` statements, or any other boolean logic.

## Ternary operator

One of the most popular ways of injecting boolean logic into an application is the [ternary](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Conditional_Operator) operator. The ternary operator is a shorthand way of creating an `if...else` statement in a single line of code. There are three components of the ternary syntax - the boolean expression, the return value if the expression is true, and the return value if the expression is false.

If we wanted to display a message if a number is even or odd we could write the following:

```javascript
const number = 3;
console.log(number % 2 ? 'The number is even' : 'The number is odd');
```

We start the expression with our boolean value (`number % 2`). If the number is even the boolean value is true; the first value (`The number is even`) will be used. If the number is odd the boolean value is false and the second value will be used (`The number is odd`). If you run the code above you will see the display **The number is odd**.

## Ternary and JSX

We can take advantage of this syntax to determine how values should be displayed. If we want to dynamically set the `class` of an HTML element based on a value, we could use the following:

```jsx
<div className={ isComplete ? 'done' : 'normal' }>{ value }</div>
```

> [!NOTE]
> You may notice the attribute used is `className` rather than `class`. This is because the word `class` is reserved in JavaScript. To avoid confusing the runtime we use `className` instead.
