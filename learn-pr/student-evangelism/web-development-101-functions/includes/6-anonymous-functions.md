As you've seen, you can call a function on demand by using its name and passing in any appropriate parameters. But sometimes you might want to allow another process to execute the functions you've created.

Imagine creating a webpage with several timers. When a timer finishes, you want to run code to display a message. The problem is that you know the timer will expire but, because the timer length might change, you don't know exactly *when* it will expire. Therefore, you don't know exactly *when* you want your code to run. To support this type of a scenario, you can use a *callback*.

## Introducing callbacks

At its core, a callback is a way of passing a function into another function as a parameter. This parameter behaves in the same way as any other parameter, such as a string or a number, except that it can be called because it's a function.

Let's imagine that a friend of yours is going to the store, and you ask the person to pick up two ice cream sandwiches and, importantly, to bring them to you before they melt.

In programming, this situation can be represented by a callback. You've given your friend a set of instructions (go to the store, pick up ice cream sandwiches). The callback here would be a further instruction to bring them to you before they melt. 

You might have picked up on another key component about the timing of execution: you know your friend will complete the task, but you don't necessarily know *when*.

Callbacks are frequently used in various frameworks and libraries to indicate the code that you want to run when something happens or finishes. You'll use a callback to indicate what should happen when, for example, a user selects a button, a long-running operation finishes, or a timer expires.

## Use a callback

A callback is a normal function, and you can create it as you would any function you've written in the past. In the following `displayDone` example, you'll notice that it's a normal function with no parameters.

```javascript
function displayDone() {
    console.log('Done!');
}
```

You can pass it into a function, which accepts a callback such as `setTimeout`. The `setTimeout` callback is a built-in function that allows you to create a timer. When the timer finishes, it calls the function that's passed in as the first parameter. The second parameter indicates the number of milliseconds to wait until it calls the function.

If you want to set a 3-second timeout and have the code display "Done!" when it's finished running, you could use `setTimeout`, like this:

```javascript
// timer value is in milliseconds
setTimeout(displayDone, 3000);
```

> [!IMPORTANT]
> Notice that `displayDone` isn't followed by an empty pair of parentheses (`()`) when it's passed as a parameter into `setTimeout`. If you write `setTimeout(displayDone(), 3000)`, you're instructing JavaScript to execute `displayDone` immediately. Because you want to pass the function into `setTimeout` for `setTimeout` to call when the timer elapses, you use only `displayDone`.

## Anonymous functions

Although the preceding code is valid, such code can create what some developers call "namespace pollution." That is, when you write code with numerous variables, functions, and other entities with names, it can become confusing to know the purpose of each, and you can sometimes run out of good names. In our example, if the only place `displayDone` will be used is with `setTimeout` you don't need to give it a name. You can create an *anonymous function*.

An anonymous function is a function without a name. Anonymous functions behave the same way as regular functions, and they're how developers ordinarily set up callbacks.

You can create an anonymous function by using the same syntax you would use to create a normal function, except that you omit the name. For example:

```javascript
setTimeout(
    function() { // anonymous function
        console.log('Done!');
    },
    3000 // 3000 milliseconds (3 seconds)
)
```

This code performs precisely the same task as the preceding code with the `displayDone` function. The key difference is that you create your function inline (that is, inside the call to `setTimeout`), without a name. By doing so, you make your code a little cleaner.

## Arrow functions

*Arrow* functions, or *fat arrow* functions, are a slightly different way of creating anonymous functions. Arrow functions use the `=>` operator to indicate the start of the body of the function. You can rewrite the preceding anonymous function example by using fat arrow syntax:

```javascript
setTimeout(
    () => { // anonymous function
        console.log('Done!');
    },
    3000 // 3000 milliseconds (3 seconds)
)
```

This code does the exact same thing as before. The only difference is the use of the `=>` operator. You'll find that many developers prefer the terse syntax that's provided by arrow functions.
