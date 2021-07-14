To make a function more reusable, you'll often want to pass information into it. This type of input is called a *parameter*. Also sometimes called an argument, a parameter is additional information that's sent to a function.

Let's say you want to change your `displayGreeting` function to be able to greet a specific person, instead of printing only "Hello, world!" each time you call the function. You can use a parameter to specify the person's name. 

Parameters are listed in the function's definition, and they're enclosed in parentheses (`()`). You can have multiple, comma-separated parameters, as shown here:

```javascript
function name(param, param2, param3) {

}
```

You can update your `displayGreeting` function to take a person's name as input, and then print a customized message to the console, as shown here:

```javascript
// function with a parameter called name
function displayGreeting(name) { 
    // creating a new local variable that inserts the name into a string   
    const message = `Hello, ${name}!`; 
    // printing the variable to the console
    console.log(message);
}
```

When you want to call your function and pass in the parameter, you specify it within the parentheses, like this:

```javascript
displayGreeting('Christopher');
// displays "Hello, Christopher!" when run
```

## Default values

You can make your function even more flexible by adding more parameters. But what if you don't want to require every value to be specified? Keeping with our greeting example, you could leave `name` as required (you need to know whom you're greeting), but you want to allow the greeting itself to be customized. If someone doesn't want to customize it, you can provide a default value instead. To do so, you set the value in much the same way as you set a value for a variable: `parameterName = 'defaultValue'`. For example:

```javascript
function displayGreeting(name, salutation='Hello') {
  console.log(`${salutation}, ${name}`);
}
```

When you call the function, you can then decide whether to set a value for the salutation, as shown here:

```javascript
displayGreeting('Christopher');
// displays "Hello, Christopher"

displayGreeting('Christopher', 'Hi');
// displays "Hi, Christopher"
```
