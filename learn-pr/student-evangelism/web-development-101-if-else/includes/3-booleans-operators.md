When you want to define different paths through your code, you use operators and Boolean variables to do so. Let's first look at Boolean variables, how to declare them, and how to assign values to them.

## A brief recap on Booleans

Booleans can be only two values: `true` or `false`. Booleans help make decisions on which lines of code should run when certain conditions are met.

Consider the following code:

```javascript
let myTrueBool = true;
let myFalseBool = false;
```

In the code example, the variables `myTrueBool` and `myFalseBool` are declared. The first variable is given the value `true`, and the second variable is assigned `false`.

> [!NOTE]
> Booleans are named after the English mathematician, philosopher, and logician George Boole (1815–1864).

## Comparison operators and Booleans

Operators are used to evaluate conditions by making comparisons that will create a Boolean value. The following list describes operators that are frequently used.

| Symbol | Description                                                                                                                                                   | Example            |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| `<`    | **Less than**: Compares two values and returns the `true` Boolean data type if the value on the left side is less than the right                              | `5 < 6 // true`    |
| `<=`   | **Less than or equal to**: Compares two values and returns the `true` Boolean data type if the value on the left side is less than or equal to the right      | `5 <= 6 // true`   |
| `>`    | **Greater than**: Compares two values and returns the `true` Boolean data type if the value on the left side is larger than the right                         | `5 > 6 // false`   |
| `>=`   | **Greater than or equal to**: Compares two values and returns the `true` Boolean data type if the value on the left side is larger than or equal to the right | `5 >= 6 // false`  |
| `===`  | **Strict equality**: Compares two values and returns the `true` Boolean data type if values on the right and left are equal *and* are the same data type       | `5 === 6 // false` |
| `!==`  | **Inequality**: Compares two values and returns the opposite Boolean value of what a strict equality operator would return                                    | `5 !== 6 // true`  |

To use an operator, you can either use it as part of an assignment or part of a comparison in an `if/else` construct. You'll learn more about `if/else` later in the module. The following code shows how you can use an operator as part of an assignment.

```javascript
let timeOfDay = 8;
let timeToWakeUp = timeOfDay >= 8; // `timeToWakeUp` holds the value `true`
```

> [!TIP]
> Try it out yourself to practice. You can write JavaScript right in your browser. Open a browser window, and go to **Developer Tools**. In the console, you'll find a prompt. Try writing some comparisons in your browser's console. Does any returned data surprise you?
