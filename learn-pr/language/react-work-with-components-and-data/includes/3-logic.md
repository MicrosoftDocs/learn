JSX is a combination of HTML and JavaScript. If you want logic, such as determining how or whether to display something, use JavaScript. You can use `if...else` statements, `case` statements, or any other Boolean logic.

## Ternary operator

One of the most popular ways of injecting Boolean logic into an application is the [ternary operator](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Conditional_Operator/?azure-portal=true). The ternary operator is a shorthand way of creating an `if...else` statement in a single line of code. There are three components of the ternary syntax: the Boolean expression, the return value if the expression is true, and the return value if the expression is false.

For example, if you want to display a message if a number is even or odd, you can write the following:

```javascript
const number = 3;
console.log(number % 2 ? 'The number is even' : 'The number is odd');
```

You start the expression with your Boolean value (`number % 2`). If the number is even, the Boolean value is true; the first value (`The number is even`) will be used. If the number is odd, the Boolean value is false, and the second value will be used (`The number is odd`). The previous code results in the message, `The number is odd`.

## Ternary and JSX

You can take advantage of this syntax to determine how values should be displayed. If you want to dynamically set the `class` of an HTML element based on a value, you can use the following:

```jsx
<div className={ isComplete ? 'done' : 'normal' }>{ value }</div>
```

> [!NOTE]
> You might notice the attribute used is `className` rather than `class`. This is because the word `class` is reserved in JavaScript. To avoid confusing the runtime, use `className` instead.
