Decisions might require more than one comparison and can be strung together with logical operators to produce a Boolean value.

## Logical operators and Booleans

There are specific operators that let us connect many Boolean statements. The result is a more complex statement that still evaluates to `true` or `false`. You can use the following set of operators to construct these more complex comparisons:

| Symbol | Description                                                                                     | Example                                                                 |
| ------ | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `&&`   | **Logical AND**: Compares two Boolean expressions. Returns true *only* if both sides are true. | `(5 > 6) && (5 < 6 ) //One side is false, other is true. Returns false` |
| `||` | **Logical OR**: Compares two Boolean expressions. Returns true if at least one side is true.     | `(5 > 6) || (5 < 6) //One side is false, other is true. Returns true` |
| `!`    | **Logical NOT**: Returns the opposite value of a Boolean expression.                             | `!(5 > 6) // 5 is not greater than 6, but "!" will return true`         |

## Conditions and decisions with logical operators

You can use these complex operators with both assignments but also with `if` and `else` clauses.

### In assignments

As part of assigning a value to a variable, you can use an or (`||`) operator.

```javascript
let isHoliday = true;
let isMember = true;
let hasDiscount = isHoliday || isMember;
```

With the preceding code, you express whether a customer can have a discount or not. Only one of the variables: `isHoliday` or `isMember`, needs to have a value that evaluates to true, for the `hasDiscount` variable to be assigned true.

### In if...else

You can also use this kind of logical operator in an `if/else` statement. In the following code example, you have a situation where there are two laptops, one on discount and one sold at full price. By using an `||` operator, you're able to construct a more complex-looking `if` clause.

```javascript
let currentMoney= 800;
let laptopPrice = 1000;
let laptopDiscountPrice = laptopPrice - (laptopPrice * .20) //Laptop price at 20 percent off

if (currentMoney >= laptopPrice || currentMoney >= laptopDiscountPrice){
    //Condition was true. Code in this block will run.
    console.log("Getting a new laptop!");
}
else {
    //Condition was true. Code in this block will run.
    console.log("Can't afford a new laptop, yet!");
}
```

> [!TIP]
> Remember what we said about learning to read code? What does the code tell you? Are you getting a new laptop? Scroll down for the answer.

Yes, you are.

## Negation operator

Earlier, you saw how you can use an `if...else` statement to create conditional logic. Anything that goes into an `if` needs to evaluate to true or false. By using the `!` operator, you can _negate_ the expression. It would look like so:

```javascript
if (!condition) {
  // runs if condition is false
} else {
  // runs if condition is true
}
```

## Ternary expressions

Using `if...else` isn't the only way to express decision logic. You can also use something called a *ternary* operator. The syntax for it looks like this:

```javascript
let variable = condition ? <return this if true> : <return this if false>
```

Here's a more tangible example:

```javascript
let firstNumber = 20;
let secondNumber = 10
let biggestNumber = firstNumber > secondNumber ? firstNumber : secondNumber;
```

The code states that:

If `firstNumber` is larger than `secondNumber`,
then assign `firstNumber` to `biggestNumber`, otherwise assign `secondNumber`.

> [!TIP]
> Take a minute to read this code a few times. Do you understand how these operators are working?

The ternary expression is a compact way of writing the following code:

```javascript
let biggestNumber;
if (firstNumber > secondNumber) {
  biggestNumber = firstNumber;
} else {
  biggestNumber = secondNumber;
}
```

> [!TIP]
> Take a moment to reflect. Which of the two approaches, ternary expressions or if/else, was easier to understand?
