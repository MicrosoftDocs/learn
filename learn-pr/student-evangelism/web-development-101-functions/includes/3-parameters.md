To make a function more reusable you'll often want to pass information into it. These inputs are called **parameters**.

Let's say we wanted to change our `displayGreeting` function from the last example to be able to greet a specific person, instead of printing "Hello, world!" each time we call the function. We can use a parameter to specify the name. A parameter (also sometimes called an argument), is additional information sent to a function.

Parameters are listed in the definition of the function within parenthesis. There can be multiple parameters, comma separated like so:

```javascript
function name(param, param2, param3) {

}
```

We can update our displayGreeting function to take a name as input, and have a customized message print to the console.

```javascript
// function with a parameter called name
function displayGreeting(name) { 
    // creating a new local variable that inserts the name into a string   
    const message = `Hello, ${name}!`; 
    // printing the variable to the console
    console.log(message);
}
```

When we want to call our function and pass in the parameter, we specify it in the parenthesis.

```javascript
displayGreeting('Christopher');
// displays "Hello, Christopher!" when run
```

## Default values

We can make our function even more flexible by adding more parameters. But what if we don't want to require every value be specified? Keeping with our greeting example, we could leave name as required (we need to know who we're greeting), but we want to allow the greeting itself to be customized as desired. If someone doesn't want to customize it, we provide a default value instead. To provide a default value to a parameter, we set it much in the same way we set a value for a variable - `parameterName = 'defaultValue'`. To see a full example:

```javascript
function displayGreeting(name, salutation='Hello') {
  console.log(`${salutation}, ${name}`);
}
```

When we call the function, we can then decide if we want to set a value for salutation.

```javascript
displayGreeting('Christopher');
// displays "Hello, Christopher"

displayGreeting('Christopher', 'Hi');
// displays "Hi, Christopher"
```
