Up to this point, the functions you've built have output to the [console](https://developer.mozilla.org/docs/Web/API/console). This output can be exactly what you're looking for, especially when you create functions that call other services. But what if you want to create a helper function to perform a calculation and then provide a value that you can use elsewhere?

You can create this function by using a *return value*. A return value is returned by the function, and you can store it in a variable just as you can store a literal value, such as a string or number.

If a function should return something, you use the `return` keyword, usually followed by a value or a reference to what's being returned. However, you can also use `return` on its own to exit a function.

Here's an example of a return statement that returns a value:

```javascript
return myVariable;
```

And here's how you'd use `return` on its own:

```javascript
return;
```

Continuing from our earlier example, you could write a function to create a greeting message and then return the value back to the caller. The `return` keyword stops the function from running and returns the specified value, if there's one. So you usually want to use `return` at the end of your function, like this:

```javascript
function createGreetingMessage(name) {
  const message = `Hello, ${name}`;
  return message;
}
```

> [!NOTE] 
> Variables that you define inside a function can't be accessed from anywhere outside the function. These variables are called *local variables*. Outside the function, they're considered *out of scope*.

When you call this function, you store the value in a variable. You store the value in much the same way as you would set a variable to a static value (for example, `let name = 'Christopher'`), like this:

```javascript
let greetingMessage = createGreetingMessage('Christopher');
```

Return values help demonstrate another reason why functions are such an important part of JavaScript. You can reuse the same function with different arguments to produce multiple return values.
