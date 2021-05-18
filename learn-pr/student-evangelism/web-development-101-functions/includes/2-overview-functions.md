Functions are a key building block for writing code. A function is a reusable collection of lines of code that makes something happen within your program. Functions are perfect for scenarios where we need to perform the same task multiple times; rather than duplicating the logic in multiple locations (which would make it hard to update when the time comes), we can centralize it in one location, and call it whenever we need the operation performed - you can even call functions from other functions!

Just as important is the ability to name a function. While this might seem trivial, the name provides a quick way of documenting a section of code. You could think of this as a label on a button. If I click on a button which reads "Cancel timer", I know it's going to stop running the clock.

## Creating and calling a function

A function takes some input, an and returns an output that somehow transforms the input. For example, an addition function could take in two integers, and return the sum of their values.

There are three different components that make up a function:

* The **function body** is the block of code that will begin executing when the function is called.
* A **parameter** is another name for the input that's passed to a function.
* Finally, there is some **return** value, or the output of the function.

The syntax for a function looks like the following:

 ```javascript
 function nameOfFunction(parameter) { // function definition with some input
 // function body
}
 ```

Parameters and return values are optional when writing a function, so to start, let's check out some basic functions that don't take any inputs or return any values. If I wanted to create a function to display a greeting in the debugging [console](https://developer.mozilla.org/docs/Web/API/console) of your code editor, it might look like this:

```javascript
function displayGreeting() {
  console.log('Hello, world!');
}
```

The function above is called `displayGreeting`, and when we run the function, the text "Hello, world!" will be printed to the console.

Whenever we want to call (or invoke) our function, we use the name of the function followed by `()`. It's worth noting the fact our function can be defined before or after we decide to call it; JavaScript will find it for you, as long as it's within the scope of where you're calling it.

```javascript
// calling our function
displayGreeting();
```

> [!NOTE] There is a special type of function known as a method, which you've already been using! In fact, we saw this in our demo above when we used console.log. What makes a method different from a function is a method is attached to an object (console in our example), while a function is free floating. You will hear many developers use these terms interchangeably.

## Best practices

There are a handful of best practices to keep in mind when creating functions:

* Use descriptive names so you know what the function will do. `displayGreeting` makes it clear the functionality of the function - a greeting will be displayed. A name like `greet`, for a function that performs the same task, is a little ambiguous - it might display a greeting, but it could perform a different operation.
* Use camelCasing to combine words. To write in camelCase, keep the first word of your variable or function lowercase, and capitalize each subsequent word. Since function and variable names can't contain spaces, camelCasing makes it faster to go back and read your code. For example, it's easier to read `displayGreeting` than `displaygreeting`.
* Keep your functions focused on a specific task. Not only does this make it more convenient to reuse your function several times throughout your program, but it also makes it easier to debug your code. If you have an issue with your function not performing the task you thought it would, you know the problem is contained within that function.
* Use comments to annotate what functions do. Another tip for improving the readability of your code is to include a small description of what each function does in the form of a comment. You can create a comment by typing `//`, followed by your comment.
