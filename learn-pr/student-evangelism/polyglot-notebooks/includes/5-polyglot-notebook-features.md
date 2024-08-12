At this point, you learnt about features you might expect from Jupyter Notebook if you worked with Notebooks before. Polyglot Notebooks really shine when you need to work with many different things. It could be working with a data source, a backend, and a frontend and maybe you for some reason can’t or prefer not to use the same language throughout the entire stack.

Let’s in this unit discuss a feature like magic commands, or rather a specific concept known as variable sharing. 

## Working with data output

When you want to output data from a cell, you have a few different techniques you can rely on like:

- **Expression**. In this case, you put the variable on a standalone row like this: 

    ```csharp
    var name = "Diego";
    name
    ```

In the example, you see how the variable name is placed on the last row and there’s no semicolon. Polyglot Notebook interprets that as an expression rather than a statement (code that is completed with a semicolon at the end).

- **Language specific output**. Depending on what language you’re writing in, the way to output information has a different syntax. Here are two examples of C# and JavaScript respectively:

    ```csharp
    var name = "Diego";
    Console.WriteLine(name);
    ```

    Next, Create a separate code cell with JavaScript as selected kernel

    ```javascript
    name = "Chris";
    console.log(name)
    ```

- **Display command**. To further improve the output, you can use a display helper. When you call the `display`function, it provides a more appealing output. Other benefits of using display helper include:

    1. It can be called repeatedly. You can, for example, call `Display()` using either of the following code snippets, and each output is shown:

    ```csharp
    (1+1).Display();
    name.Display();
    ```

    1. It reacts to updates. You can assign the result of calling display to a reference and by calling Update, the result updates in the cell’s output like so:

    ```csharp
    var displayRef =  "initial value".Display(); 
    System.Threading.Thread.Sleep(10000); 
    displayRef.Update("different value");
    ```

    This code cell shows "initial value" and 10 seconds later it shows "different value".

## Magic commands

Magic commands are simple commands that do something special. It could be telling time, connecting to data source, or sharing values between cells and kernels.  A magic command can take parameters. You recognize it's a magic command, if the code begins with `#!`, followed by the command as shown:

```javascript
#!mycommand 
```

In following example, we would use the set command. The set command enables us to use a variable in between kernels. Here’s how to use parameters with the set command:

```javascript
#!set --value @csharp:name --name name
```

This command enables us to use the variable `name` in our C# kernel for operations in our JavaScript kernel.

## Sharing values between code cells

As it stands, what you write in one cell can be used in another cell. For example, if you define an array in code cell, that same array can be used in another cell like so:

```javascript
let companies = ["Microsoft", "Apple"]; // a code cell
console.log(companies[0]); // a different code cell, prints "Microsoft"
```

The above case isn't what we mean by variable sharing but a built-in capability. Variable comes into play when I need to share variables between code cells, so let’s describe that in the next section.

## Variable sharing

Ok, so you think you want to write some code in C# and some other code in JavaScript? Most likely you want to accomplish different things. Maybe you want the C# code to fetch some data and then use JavaScript to render it differently or use a library that C# doesn’t have. Now that we have a use case, how would we make it happen?

### The Set command

To carry out variable sharing, we would be using the set command. Let’s show you the command in action. Let’s say we have the code written out in a C# code cell:

```csharp
var cars = new []{"Saab", "Volvo","BMW" };
Console.WriteLine(cars[0]);
```

To use the cars variable in a JavaScript code cell, we would need to utilize the set command. First switch your kernel to JavaScript and then input the line of code:

```javascript
#!set --value @csharp:cars --name carsFromCSharp
console.log(carsFromCSharp)
```

Let’s summarize what Set command does - The set command point out which variable to share via `--value @csharp:cars` and then names the variable in the JavaScript cell to carsFromCsharp.

The biggest takeaway is that the parameter names are different but that they're otherwise equivalent.

So how do you use the value in the JavaScript cell? Well, we gave it the name carsFromSharp, so that’s what we would need to refer to like so:

```javascript
console.log(carsFromCSharp[0]); // prints "Saab"
```

## Variables view

When you create variables in code cells, there’s a UI element, a "variables view", that keeps track of all variables created. It lists information on the variable, like type, value, kernel, and so on. Here’s what it looks like:

![A screenshot showing a table that keeps track of all variables created within Polyglot Notebooks and their details.](../media/variable-table-12.png)

From the image, you can see the name of the variable - cars, its values "Saab", "Volvo" and "BMW", what type it's and what kernel it’s part of. What kernel it’s part of becomes extra interesting as we also have an Actions column that lets you share this particular variable in another cell of a different kernel type.

## User input

To make your code flexible, you might want to rely on user input. You could be asking the user for information on things like configuration, secrets, API keys and more. Polyglot Notebook offers a way to collect user input using an `@input` prefix. The idea is that by adding this prefix, the user receives a prompt and can submit their value that is assigned to a specific variable. Here’s an example of how it works:

```csharp
#!set --name url --value @input:"Please enter a URL"
```

In the code, the user is prompted for input with the text "Please enter a URL" and the result is stored in the `url` variable.

## Direct data entry with `#!value`

Another handy functionality is being able to store values of different types. Imagine you have a few lines of JSON or XML or whatever you have, and you just want to store the value as is. Here’s a great prefix you can use for the call `#!value`. Here’s an example of it being used:

```javascript
#!value --name productsJSON
[
    {"id": 1, "name": "video game"},
    {"id": 2, "name": "book"}
]
```

What’s great about storing a value as shown is that this variable productsJSON isn't tied to any specific programming language. Hence, it can be used from different cells with different kernels. You could, for example, use it from a .NET cell or JavaScript cell through variable sharing.