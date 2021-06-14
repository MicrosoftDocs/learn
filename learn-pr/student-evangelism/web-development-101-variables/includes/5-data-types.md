Variables can store many different types of values, like numbers and text. These values are called *data types*. 

## Data types

Data types are an important part of software development because developers use them to make decisions about how the code should be written and how the software should run. Some data types have unique features that help transform or extract additional information in a value.

Data types are also called *JavaScript data primitives*, because they're the lowest-level data types that the language provides. There are six primitive data types: `string`, `number`, `bigint`, `boolean`, `undefined`, and `symbol`.

> [!TIP]
> Take a minute to visualize what each of these primitives might represent. What is a zebra? How about `0`? How about `true`?

## Numbers

In the previous section, the value of `myVariable` was a `number` data type:

`let myVariable = 123;`

Variables can store all types of numbers, including decimals or negative numbers. Numbers also can be used with *arithmetic operators*.

Here are some types of operators that you can use when performing arithmetic functions:

| Symbol | Description                                                              | Example                          |
| ------ | ------------------------------------------------------------------------ | -------------------------------- |
| `+`    | **Addition**: Calculates the sum of two numbers.                          | `1 + 2 //expected answer is 3`   |
| `-`    | **Subtraction**: Calculates the difference of two numbers.                | `1 - 2 //expected answer is -1`  |
| `*`    | **Multiplication**: Calculates the product of two numbers.                | `1 * 2 //expected answer is 2`   |
| `/`    | **Division**: Calculates the quotient of two numbers.                     | `1 / 2 //expected answer is 0.5` |
| `%`    | **Remainder**: Calculates the remainder from the division of two numbers. | `1 % 2 //expected answer is 1`   |

> [!Tip]
> Try an arithmetic operation in your browser's console. Do the results surprise you?

## Strings

Strings are sets of characters that reside between single or double quotes.

- `'This is a string'`
- `"This is also a string"`
- `let myString = 'This is a string value stored in a variable';`

> [!TIP]
> Remember to use quotes when you're writing a string, or JavaScript will assume it's a variable name.

Strings are textual and require formatting from time to time.

To *concatenate* two or more strings, or join them together, use the `+` operator:

```javascript
let myString1 = "Hello";
let myString2 = "World";

myString1 + myString2 + "!"; //HelloWorld!
myString1 + " " + myString2 + "!"; //Hello World!
myString1 + ", " + myString2 + "!"; //Hello, World!

```

Why does `1 + 1 = 2` in JavaScript, but `'1' + '1' = 11?` Think about it. What about `'1' + 1`?

*Template literals* are another way to format strings, except that instead of quotes, you use backticks. Anything that's not plain text must be placed inside placeholders `${ }`, including any variables that might be strings. Here's an example:

```javascript
let myString1 = "Hello";
let myString2 = "World";

`${myString1} ${myString2}!` //Hello World!
`${myString1}, ${myString2}!` //Hello, World!
```

You can achieve your formatting goals with either method, but template literals will respect any spaces and line breaks.

> [!TIP]
> Take a moment to consider the use cases for different string types. When would you use a template literal versus a plain string?

## Booleans

Booleans can be only two values: `true` or `false`. Booleans can help make decisions on which lines of code should run when certain conditions are met. In many cases, operators assist with setting the value of a Boolean. You'll often notice that variables are initialized with an operator, or their values are updated with an operator. Here's an example:

- `let myTrueBool = true`
- `let myFalseBool = false`

A variable can be considered "truthy" if it evaluates to a Boolean whose value is `true`. In JavaScript, [all values are truthy unless they're defined as "falsy"](https://developer.mozilla.org/docs/Glossary/Truthy/?azure-portal=true).

[!TIP] Explore the gotchas of JavaScript! Remember, you can write JavaScript right in your browser. Just open a browser window and go to **Developer tools**. In the console, you'll find a prompt. This code resolves to `false`: `let age = 1`; `let Age = 2`; `age == Age`. Why do you think that is, and what other gotchas can you find?
