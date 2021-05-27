Up to this point, the functions you've built have output to the [console](https://developer.mozilla.org/docs/Web/API/console). This can be exactly what you're looking for, especially when you create functions that call other services. But what if you want to create a helper function to perform a calculation and then provide a value that you can use elsewhere?

You can do this by using a *return value*. A return value is returned by the function, and it can be stored in a variable just you can store a literal value, such as a string or number.

If a function does return something, the keyword `return` is used. Usually, the `return` keyword is followed by a value or a reference to what's being returned. However, you can also use `return` on its own to exit a function.

Here's an example of a return statement that returns a value:

```javascript
return myVariable;
```

And here's how you'd use `return` on its own:

```javascript
return;
```

Continuing from our previous example, you could create a function to create a greeting message and then return the value back to the caller. Note that the `return` keyword stops the execution of a function and returns the specified value, if there is one, so you usually want to use `return` at the end of your function, like this:

```javascript
function createGreetingMessage(name) {
  const message = `Hello, ${name}`;
  return message;
}
```

> [!NOTE] 
> Variables that you define inside a function can't be accessed from anywhere outside the function. These variables are called *local variables*. Outside the function, they're considered *out of scope*.

When you call this function, you store the value in a variable. You do this in much the same way as you would set a variable to a static value (for example, `let name = 'Christopher'`).

```javascript
let greetingMessage = createGreetingMessage('Christopher');
```

Return values help demonstrate another reason why functions are such an important part of JavaScript. You can reuse the same function with different arguments to produce multiple return values.
