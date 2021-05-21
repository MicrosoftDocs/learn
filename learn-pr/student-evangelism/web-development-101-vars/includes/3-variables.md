Usung variables and data types, are essential to being able to writing code in JavaScript. Variables store values that can be used and changed throughout your code, and data types help describe what type of data is stored in those variables.

## Variables

The reason for using a variable is that you have a value that you would like to remember. By storing the value you are able to refer to it later on in your code.

Creating and declaring a variable has the following syntax `[keyword] [name]`. Here's an example of declaration:

```js
var aVariable;
```

`var` is a keyword that indicates that you want to declare a variable, and `aVariable` is the name of the variable. The name of a variable is something you chose and should reflect what it's used for.

## Use `let` to work with variables

The keyword `let` was introduced in ES6 and gives your variable a so called _block scope_. It's recommended that you use `let` over `var`. We will cover block scopes more in depth in future parts.

To declare a variable using `let`, type like so:

```javascript
let myVariable;
```

`myVariable` has now been declared using the `let` keyword. It currently doesn't have a value, but you can give it a value.

### Assign a value 

To store a value in a variable, you must do so using the assignment, `=` operator, followed by the expected value.

```javascript
myVariable = 123;
```

> [!TIP]: The use of `=` in this example means we make use of an "assignment operator", used to set a value to a variable. It differs from a comparison, that uses two, or three operators like so `==` or so `===`.

`myVariable` has now been *assigned* the value 123.

### Explicit initialization

Initialization differs from assignment as you both declare the value and give it a value. Below is an example of an initialization:

```javascript
let myVariable = 123;
```

The reason for wanting to use explicit initialization over an assignment is that you want a variable to contain a _starter value_. Imagine for example you want all the players in a card game to have 100 points worth of poker chips before starting a game. To represent that state, then you could declare it like so:

```javascript
let pokerChips = 100;
```

### Changing variables

Another reason for storing a value in avariable, other than being a _starter value_, is that you want to use it to temporarily store something. That something can be the sum of a calculation for example.

To change the value, assign it a new value on the right hand side like so:

```javascript
myVariable = 321;
```

Above you see how assignment operator `=` is used and how a value is being _assigned_ on the right side of the operator.

> [!TIP]: Try it out yourself to practice- you can write JavaScript right in your browser! Open a browser window and navigate to Developer Tools. In the console, you will find a prompt; type let myVariable = 123, press return, then type myVariable. What happens? You'll learn more about these concepts in subsequent lessons.

Sometimes you don't want variable values to change. Such a situation can occur when you rely on a mathematical constant for example like the value of PI for example. To address this need, JavaScript let's you create so called constants.

## Constants

Declaration and initialization of a constant follows the same concepts as a variable, with the exception of the `const` keyword. Constants are typically declared with all uppercase letters.

```javascript
const MY_VARIABLE = 123;
```

> [!TIP]
> even though you are allowed to name a constant variable in all lowercase you are strongly discouraged to use all uppercase.

Constants are similar to variables, with two exceptions:

- **Must have a value**. Constants must be initialized, or an error will occur when running code.
- **Reference cannot be changed**. The reference of a constant cannot be changed once initialized, or an error will occur when running code. Let's look at two examples:
   - **Simple value**. The following is NOT allowed:
   
      ```javascript
      const PI = 3;
      PI = 4; // not allowed
      ```
 
   - **Object reference is protected**. The following is NOT allowed.
   
      ```javascript
      const obj = { a: 3 };
      obj = { b: 5 } // not allowed
      ```

    - **Object value is not protected**. The following IS allowed:
    
      ```javascript
      const obj = { a: 3 };
      obj.a = 5;  // allowed
      ```

      Above you are changing the value of the object but not the reference itself, which makes it allowed.

   > [!NOTE] A `const` means the reference is protected from reassignment. The value is not _immutable_ though and can change, especially if it's a complex construct like an object.