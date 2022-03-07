Knowing how to properly use variables and data types is essential to writing code in JavaScript. Variables store values that can be used and changed throughout your code, and data types help describe what type of data is stored in those variables.

## Variables

Suppose that in your code, you have a value that you want to remember for future use. By storing the value, you can refer to it later in your code.

You can create and declare a variable by using the following syntax: `[keyword] [name]`. Here's an example of a variable declaration:

```js
var aVariable;
```

The keyword `var` indicates that you want to declare a variable, and `aVariable` is the name of the variable. The name of a variable is something you choose and should reflect what it's used for.

## Keyword to work with variables

The keyword `let` was introduced in the JavaScript standard ECMAScript 6 (ES6). Using `let` gives your variable _block scope_. We recommend that you use `let` over `var` to better manage scope in your application.

JavaScript uses the different types of scope, like global scope and function scope, to determine what variables are available in which parts of the code. For example, a global variable is available inside a function because it belongs to global scope, or "outer" scope. Variables designated with the keyword `var` are scoped (their values are visible) within the function body, and `let` variables are scoped to their enclosing block within curly brackets. That means that if you use `var` in a for loop, it's visible outside the for loop, which might have unexpected results. Using `let` is a better choice because it's available only in the enclosing block (that is, the for loop), so its availability might be more expected.

To declare a variable by using `let`, use the following syntax:

```javascript
let myVariable;
```

`myVariable` has now been declared through the `let` keyword. It currently doesn't have a value, but you can give it one.

### Assigning a value

To store a value in a variable, you use the *assignment operator* (`=`) followed by the expected value:

```javascript
myVariable = 123;
```

> [!TIP]
> The use of the assignment operator (`=`) in this example sets a value to a variable. It differs from a comparison, which uses two or three operators like `==` or `===`.

`myVariable` has now been _assigned_ the value `123`.

### Explicit initialization

An *initialization* differs from an assignment in that you both declare the value and give it a value. Here's an example of an initialization:

```javascript
let myVariable = 123;
```

The reason for using an explicit initialization over an assignment is that you want a variable to contain a _starter value_. Imagine, for example, that you want all the players in a card game to have 100 points worth of poker chips before starting a game. To represent that state, you could declare it like this:

```javascript
let pokerChips = 100;
```

### Changing variables

You might want to store a value in a variable temporarily. An example is the sum of a calculation.

The following code shows how you use the assignment operator (`=`) and how you _assign_ a value on the right side of the operator:

```javascript
myVariable = 321;
```

> [!TIP]
> Try it out yourself to practice. You can write JavaScript right in your browser! Open a browser window and go to **Developer tools**. In the console, you'll find a prompt. Enter `let myVariable = 123`, and then enter `myVariable`. What happens?

Sometimes you don't want variable values to change. Such a situation can happen when you rely on a mathematical constant like the value of pi. To address this need, JavaScript lets you create *constants*.

## Constants

The declaration and initialization of a constant follows the same concepts as a variable, except that it uses the `const` keyword: 

```javascript
const MY_VARIABLE = 123;
```

> [!TIP]
> Even though you're allowed to name a constant variable any way you like, you're encouraged to use all uppercase.

Constants are similar to variables, with two exceptions:

- *They must have a value*. Constants must be initialized, or you'll get an error when running code.
- *The reference can't be changed*. If the reference of a constant changes after it's initialized, you'll get an error when running code. 

Let's look at a few examples:

- The following code syntax for a simple value is *not* allowed:

  ```javascript
  const PI = 3;
  PI = 4; // not allowed
  ```

- The following syntax has a protected object reference and is *not* allowed:

  ```javascript
  const obj = { a: 3 };
  obj = { b: 5 } // not allowed
  ```

- The following syntax has an object value that's not protected. It *is* allowed, because you're changing the value of the object but not the reference itself.

  ```javascript
  const obj = { a: 3 };
  obj.a = 5;  // allowed
  ```

> [!NOTE]
> The presence of `const` means the reference is protected from reassignment. But the value is not _immutable_ and can change, especially if it's a complex construct like an object.
