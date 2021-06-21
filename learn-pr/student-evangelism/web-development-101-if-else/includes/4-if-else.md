So far, you've seen how you can use logical operators as part of an assignment. Another common use for operators is as part of `if/else` constructs.

## If statement

The if statement runs code in between its blocks if the condition is true. The condition within the `if` clause can either be a value that contains a truthy value or a conditional statement that evaluates to true. The following code shows how you express an `if` clause.

```javascript
if (condition){
    //Condition was true. Code in this block will run.
}
```

### Compare a value

You can pass a variable or a Boolean value to an `if` clause like so:

```javascript
let isTrue = true;
if (isTrue) {
  // run code if true
}

if (true) {
  // run code if true
}
```

### Use a logical operator

Logical operators are often used to form the condition. You need three things: a value, a comparison operator that shows how you want to compare, and a value to compare to. The syntax looks like the following code:

```json
if (value operator compareToThisValue) {
  // run code
}
```

Here's an example that uses the preceding syntax to compare variables' values by using a larger-than (`>=`) operator:

```javascript
let currentMoney = 1000;
let laptopPrice = 1500;

if (currentMoney >= laptopPrice){
    //Condition was true. Code in this block will run.
    console.log("Getting a new laptop!");
}
```

> [!TIP]
> As a developer, you need to get used to reading code and understanding how it will execute. Take a short break here, and try to figure out if the code within the `if` clause will execute or not.

Because the value of `currentMoney` is lower than the value of `laptopPrice`, the statement within the `if` clause will evaluate to false. The statement within the `if` clause won't run.

## If...else statement

The `else` statement will run the code in between its blocks when the `if` condition evaluates to false. Using `else` is optional.

```javascript
let currentMoney = 1000;
let laptopPrice = 1500;

if (currentMoney >= laptopPrice) {
    //Condition was true. Code in this block will run.
    console.log("Getting a new laptop!");
} else{
    //Condition was true. Code in this block will run.
    console.log("Can't afford a new laptop, yet!");
}
```

> [!TIP]
> Test your understanding of the preceding code by running it in a browser console. Change the values of the `currentMoney` and `laptopPrice` variables to change the returned `console.log()`.
