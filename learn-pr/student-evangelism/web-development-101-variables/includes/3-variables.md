Knowing how to properly use variables and data types is essential to being able to write code in JavaScript. Variables store values that can be used and changed throughout your code, and data types help describe what type of data is stored in those variables.

## Variables

Suppose that in your code, you have a value that you want to remember for future use. By storing the value, you can refer to it later in your code.

You can create and declare a variable by using the following syntax: `[keyword] [name]`. Here's an example of a variable declaration:

```js
var aVariable;
```

The keyword `var` indicates that you want to declare a variable, and `aVariable` is the name of the variable. The name of a variable is something you choose and should reflect what it's used for.

## Keyword to work with variables

The keyword `let` was introduced in the JavaScript standard EcmaScript 6 (ES6). Using `let` gives your variable _block scope_. We recommend that you use `let` over `var` to better manage scope in your application. We'll cover block scopes in depth later.

To declare a variable by using `let`, use the following syntax:

```javascript
let myVariable;
```

`myVariable` has now been declared through the `let` keyword. It currently doesn't have a value, but you can give it one.

### Assigning a value

To store a value in a variable, you use the assignment operator (`=`) followed by the expected value:

```javascript
myVariable = 123;
```

> [!TIP]
> The use of `=` in this example means we're using an *assignment operator*, which sets a value to a variable. It differs from a comparison, which uses two or three operators like `==` or `===`.

`myVariable` has now been _assigned_ the value `123`.

### Explicit initialization

Initialization differs from assignment in that you both declare the value and give it a value. Here's an example of an initialization:

```javascript
let myVariable = 123;
```

The reason for using explicit initialization over an assignment is that you want a variable to contain a _starter value_. Imagine, for example, that you want all the players in a card game to have 100 points worth of poker chips before starting a game. To represent that state, you could declare it like this:

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
> Try it out yourself to practice. You can write JavaScript right in your browser! Open a browser window and go to **Developer tools**. In the console, you'll find a prompt. Enter `let myVariable = 123`, and then enter `myVariable`. What happens? You'll learn more about these concepts in subsequent lessons.

Sometimes you don't want variable values to change. Such a situation can happen when you rely on a mathematical constant like the value of pi. To address this need, JavaScript lets you create *constants*.

## Constants

The declaration and initialization of a constant follows the same concepts as a variable, except that it uses the `const` keyword. 

```javascript
const MY_VARIABLE = 123;
```

> [!TIP]
> Even though you're allowed to name a constant variable any way you like, you're encouraged to use all uppercase.

Constants are similar to variables, with two exceptions:

- *They must have a value*. Constants must be initialized, or you'll get an error when running code.
- *The reference can't be changed*. The reference of a constant can't be changed after it's initialized, or you'll get an error when running code. 

Let's look at three examples:

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
