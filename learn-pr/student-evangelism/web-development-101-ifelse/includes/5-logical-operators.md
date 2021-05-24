Decisions might require more than one comparison, and can be strung together with logical operators to produce a Boolean value.

## Logical Operators and Booleans

There are specific operators that let us connect many boolean statements. The result is a more complex statement that still evaluates to `true` or `false`. Below is a set of operators able to construct these more complex comparisons:

| Symbol | Description                                                                                     | Example                                                                 |
| ------ | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `&&`   | **Logical AND**: Compares two Boolean expressions. Returns true **only** if both sides are true | `(5 > 6) && (5 < 6 ) //One side is false, other is true. Returns false` |
| `||` | **Logical OR**: Compares two Boolean expressions. Returns true if at least one side is true     | `(5 > 6) || (5 < 6) //One side is false, other is true. Returns true` |
| `!`    | **Logical NOT**: Returns the opposite value of a Boolean expression                             | `!(5 > 6) // 5 is not greater than 6, but "!" will return true`         |

## Conditions and Decisions with Logical Operators

You can use these complex operators with both assignments but also with `if` and `else` clauses.

### In assignments

As part of assigning a value to a variable, you can for example use an or `||` operator like so:

```javascript
let isHoliday = true;
let isMember = true;
let hasDiscount = isHoliday || isMember;
``` 

With the above code, you express whether a customer can have a discount or not. Just one of the variables `isMember` or `hasDiscount` needs to have a truthy value for the `hasDiscount` to be assigned true.

### In If..Else

You can also use this kind of logical operator in an `if/else`. In the below code example, you have a situation where there are two laptops, one on discount and one sold at full price. By using an `||` operator you are able to construct a more complex looking `if` clause.

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
> Remember what we said about learning to read code? What does the code tell you, are you getting a new laptop? Scroll down for the answer.

Yes you can :)

## Negation operator

You've seen so far how if you can use an `if...else` statement to create conditional logic. Anything that goes into an `if` needs to evaluate to true/false. By using the `!` operator you can _negate_ the expression. It would look like so:

```javascript
if (!condition) {
  // runs if condition is false
} else {
  // runs if condition is true
}
```

## Ternary expressions

`if...else` isn't the only way to express decision logic. You can also use something called a ternary operator. The syntax for it looks like this:

```javascript
let variable = condition ? <return this if true> : <return this if false>
```

Below is a more tangible example:

```javascript
let firstNumber = 20;
let secondNumber = 10
let biggestNumber = firstNumber > secondNumber ? firstNumber: secondNumber;
```

The code states that:
 
if `firstNumber` is larger than `secondNumber`, 
then assign `firstNumber` to `biggestNumber`, otherwise assign `secondNumber`. 


> [!TIP]
> Take a minute to read this code a few times. Do you understand how these operators are working?

  
The ternary expression is a compact way of writing the code below:

```javascript
let biggestNumber;
if (firstNumber > secondNumber) {
  biggestNumber = firstNumber;
} else {
  biggestNumber = secondNumber;
}
```

> [!TIP]
> Take a moment to reflect, which of the two approaches ternary expressions or if/else was easier to understand?