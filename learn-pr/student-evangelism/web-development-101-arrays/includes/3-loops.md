So you have an array, now what? Well you can use loops to perform iterations on each item in the array. You can perform operations like printing each item, summing it up or find specific items given a condition.

## Loops

Loops allow for repetitive or **iterative** tasks, and can save much time and code. Each iteration can vary in their variables, values, and conditions. There are different types of loops in JavaScript, and they have small differences, but essentially do the same thing: loop over data.

### For Loop

The `for` loop requires three parts to iterate:

- **Counter**. A variable that is typically initialized with a number that counts the number of iterations. Here's an example:

   ```javascript
   let i = 0;
   ```

   Usually you use this value as the first position you want to access in an array.

- **Condition**. Expression that uses comparison operators to cause the loop to stop when `true`. Here's an example of condition that stops when the array is out of indexes:

   ```javascript
   i < 10;   
   ```

   In this case, the expression will be false when i equals `arry.length`. If you are looping through an array, that's what you want. You don't want to address an index outside of the array bounds.

- **Increment expression**. Runs at the end of each iteration, typically used to change the counter value. You can increment as much as you want per iteration but it's common to increase by one like the below example:

   ```javascript
   i++;
   i +=2; // this would work too and increases by 2
   ```

Used together a for loop can look like so:

```javascript
for (let i = 0; i < 10; i++ ) {
  console.log(i);
}
```

> [!TIP] 
> Run this code in a browser console. What happens when you make small changes to the counter, condition, or increment expression? Can you make it run backwards, creating a countdown?

### While loop

Unlike the syntax for the `for` loop, `while` loops only require a condition that will stop the loop when the expression in the `while` loop evaluates to `true`. Conditions in loops usually rely on other values like counters, and must be managed during the loop. Starting values for counters must be created outside the loop, and any expressions to meet a condition, including changing the counter must be maintained inside the loop. Below is an example of a `while` loop that runs for 10 iterations.

```javascript
//Counting up to 10
let i = 0;
while (i < 10) {
 console.log(i);
 i++;
}
```

[!NOTE] Why would you choose a for loop vs. a while loop? 17 K viewers had the same question on StackOverflow, and some of the opinions [might be interesting to you](https://stackoverflow.com/questions/39969145/while-loops-vs-for-loops-in-javascript).

Arrays are often used with loops because most conditions require the length of the array to stop the loop, and the index can also be the counter value.

## Loops and Arrays

Let's head back to our delicious list of ice cream. A customer has asked us to name all the flavors we are selling before they can decide. Luckily we know about for-loops, so let's use that fact. Remember how we defined a condition on when to end like so:

```javascript
i < 10
```

Well, our array of ice cream has an arbitrary length, meaning that, at any time we can remove or add items to it. We know since before we have six kinds of ice cream but we can use the `length` field on the array and rely on that instead:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Rocky Road", "Mint"];

for (let i = 0; i < iceCreamFlavors.length; i++) {
  console.log(iceCreamFlavors[i]);
} //Ends when all flavors are printed
```

There you have it, we listed all the flavors and our customer picked, "Vanilla". What would you pick?

## forEach

So far you've been familiarized with the `for` loop and the `while` loop. There's another loop on the array itself called `forEach()`. The `forEach()` loop, iterates over the items and offers a simplified way to loop, as you don't need a counter, if all you want to do is loop, like in the below example:

```javascript
let numbers = [1, 2, 3, 4, 5];
numbers.forEach(number => console.log(number)); // 1 2 3 4 5
```

Also, should you want access to the current index, you have that too, by slightly changing the code above to the below code:

```javascript
numbers.forEach((number, index) => console.log(`Number ${number} ${index}`));
```

### When to use which loop construct?

The difference between the two `for` and `forEach()` is that they both let you loop over the array's items, but the `for` loop allows you to exit if a certain condition is fulfilled. Consider the below code:

```javascript
let numbers = [1, 2, -1, 4, 5];
for(let i = 0; i< numbers.length; i++>) {
  if (numbers[i] < 0) {
    break;
  }
  console.log(numbers[i]);
}
``` 

The usage of `break` makes the loop stop at a negative item. The `forEach()` loop can't do that.

> [!TIP]
> Experiment with looping over an array of your own making in your browser's console. If you'd like to challenge yourself, there are other ways of looping over arrays other than for and while loops. There are [forEach](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach), [for-of](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/for...of), and [map](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/map). Rewrite your array loop using one of these techniques.