Functions are a key building block for writing code. A function is a reusable collection of lines of code that makes something happen within your program. 

Functions are perfect for scenarios where you need to perform the same task multiple times. Rather than duplicate logic in multiple locations, which makes code hard to update later, you can centralize it in one location. That way, you can call it whenever you need the operation performed again. You can even call functions from other functions!

Just as important is the ability to name a function. Although naming a function might seem trivial, the name provides a quick way of documenting a section of code. You could think of naming as a label on a button. For example, if I select a button that reads "Cancel timer," I know it's going to stop running the clock.

## Create and call a function

A function takes some input and then returns an output that somehow transforms the input. For example, an addition function can take in two integers and then return the sum of their values.

Functions are made up of three different components:

* A *function body* is a block of code that runs when the function is called.
* A *parameter* is another name for the input that's passed to a function.
* Finally, there is a *return value*, or the output of the function.

The syntax for a function looks like the following code:

 ```javascript
 function nameOfFunction(parameter) { // function definition with some input
 // function body
}
 ```

Parameters and return values are optional when you're writing a function. To start, let's check out some basic functions that don't take any inputs or return any values. If you want to create a function to display a greeting in the debugging [console](https://developer.mozilla.org/docs/Web/API/console) of your code editor, it might look like this:

```javascript
function displayGreeting() {
  console.log('Hello, world!');
}
```

This function is called `displayGreeting`. When you run the function, the text "Hello, world!" is printed to the console.

Whenever you want to call, or invoke, the function, you use the name of the function followed by opening and closing parentheses (`()`). It's worth noting that you can define your function before or after you decide to call it. Either way, the JavaScript will find it for you, as long as it's within the scope of where you're calling it.

```javascript
// calling our function
displayGreeting();
```

> [!NOTE] 
> There's a special type of function known as a *method*, which you've already been using. In fact, you saw a method in the preceding demo when you used console.log. What makes a method different from a function is that a method is attached to an object (*console*, in the example), and a function is free floating. You'll hear many developers use these terms interchangeably.

## Best practices

When you're creating functions, keep in mind a few best practices:

* Use descriptive names that say what the functions are intended to do. For example, the name `displayGreeting` makes it clear that the purpose of the function is to display a greeting. A name like `greet`, for a function that performs the same task, is a little ambiguous. It might display a greeting, but it might also perform a different operation.

* Use camelCasing to combine words. To write in camelCase, keep the first word of your variable or function lowercase, and capitalize each subsequent word. Because function and variable names can't contain spaces, camelCasing makes it faster to go back and read your code. For example, `displayGreeting` is easier to read than `displaygreeting`.

* Keep your functions focused on a specific task. Doing so not only makes a function easier to reuse throughout a program, but it also makes it easier to debug your code. If you have an issue with your function not performing the task you thought it would, you know the problem is contained within that function.

* Use commented text to annotate what your functions do. To improve the readability of your code, include in the comment a short description of what each function does. You can create a comment by typing a double slash (`//`), followed by your description.
