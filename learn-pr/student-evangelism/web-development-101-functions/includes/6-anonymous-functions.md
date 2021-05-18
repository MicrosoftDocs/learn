As we saw, you can call a function on demand by using its name and passing in any appropriate parameters. But there are cases when we want the ability to allow another process to execute functions we have created.

Imagine creating a webpage with different timers. When a timer completes we want to execute code to display a message. The problem we face is we know the timer will expire, but because the length of the timer might change we don't know exactly *when* it will expire, so we don't know exactly *when* we want our code to execute. To support this type of a scenario we can use **callbacks**.

## Introducing callbacks

At its core, a callback is a way of passing a function into another function as a parameter. This parameter will behave in the same way as any other parameter, like a string or a number, only it can be called because it's a function.

Let's imagine a friend of yours is going to the store. You ask your friend if they will pickup a couple of items for you while they're there.

In programming, this would be a callback. You have given your friend a set of instructions (your shopping list) to perform when they get to the store. You may have picked up on another key component about the timing of execution. You know your friend will complete the task, but you don't necessarily know *when*.

Callbacks are frequently used in different frameworks and libraries to indicate the code you want executed when something happens or completes. You will use this with to indicate what should happen when a user clicks on a button, when a long running operation completes, or when a timer expires.

## Using a callback

A callback is a normal function, and can be created like any function you've written in the past. If you take a look at the `displayDone` example below, you'll notice it's a normal function with no parameters.

```javascript
function displayDone() {
    console.log('Done!');
}
```

We can pass it into a function which accepts a callback like `setTimeout`. `setTimeout` is a built-in function which allows you to create a timer. When the timer completes it calls the function passed in as the first parameter. The second parameter indicates the number of milliseconds to wait until it calls the function.

If we want to set a 3 second timeout and display "Done!" when it's completed, we could use `setTimeout` like this:

```javascript
// timer value is in milliseconds
setTimeout(displayDone, 3000);
```

> [!IMPORTANT]
> Notice the there are no parenthesis for `displayDone` when passed as a parameter into `setTimeout`. If we wrote `setTimeout(displayDone(), 3000)`, we would be instructing JavaScript to execute `displayDone` immediately. Because we want to pass the function into `setTimeout` for `setTimeout` to call when the timer elapses we only use `displayDone`.

## Anonymous functions

While the code above is valid, this can cause what some developers call "namespace pollution", which means creating too many named items. If we create a lot of variables and functions and other entities with names it can become confusing to know the purpose of each, and we can sometimes run out of good names. In our example, if the only place `displayDone` will be used is with `setTimeout` we don't need to give it a name. We can create an *anonymous function*.

An anonymous function is a function without a name - it's anonymous. Anonymous functions behave the same as regular functions, and are typically the way developers setup callbacks.

We can create an anonymous function using the exact same syntax for creating a normal function, only we leave off the name.

```javascript
setTimeout(
    function() { // anonymous function
        console.log('Done!');
    },
    3000 // 3000 milliseconds (3 seconds)
)
```

The code above will perform the exact same task as we saw when we created the separate `displayDone`. The key difference is we create our function inline - inside the call to `setTimeout` - without a name. This helps keep our code a little cleaner.

## Arrow functions

Arrow (or fat arrow) functions are a slightly different way of creating anonymous functions. Arrow functions use the `=>` to indicate the start of the body of the function. We can rewrite our anonymous function example from above to the fat arrow syntax:

```javascript
setTimeout(
    () => { // anonymous function
        console.log('Done!');
    },
    3000 // 3000 milliseconds (3 seconds)
)
```

This code does the exact same thing as before. The only difference is the use of the `=>` operator. You will find many developers prefer the terse syntax provided by arrow functions.
