So you have an array, now what? Well, you can use *loops* to perform iterations on each item in the array. You can perform operations such as printing each item, summing it up or find specific items given a condition.

## About loops

Loops allow for repetitive, or *iterative*, tasks, and they can save you much time and code. An iteration can vary in its variables, values, and conditions. There are different types of loops in JavaScript, each with its small differences. But they all essentially do the same thing: they loop over data.

### `For` loops

A `for` loop requires three parts to iterate:

- **Counter**: A variable that's ordinarily initialized with a number that counts the number of iterations. Here's an example:

   ```javascript
   let i = 0;
   ```

   You ordinarily use this value as the first position you want to access in an array.

- **Condition**: An expression that uses comparison operators to cause the loop to stop when `false`. Here's an example of a condition that stops when the array is out of indexes:

   ```javascript
   i < 10;   
   ```

   In this example, the expression will be false when `i` equals `arry.length`. If you're looping through an array, that's what you want. You don't want to address an index outside of the array bounds.

- **Increment expression**: An expression that runs at the end of each iteration, ordinarily to change the counter value. You can increment as much as you want per iteration, but it's common to increase by one, as shown in this example:

   ```javascript
   i++;
   i +=2; // this would work too and increases by 2
   ```

When the three parts are used together, a `for` loop can look like this:

```javascript
for (let i = 0; i < 10; i++ ) {
  console.log(i);
}
```

> [!TIP]
> Run this code in a browser console. What happens when you make small changes to the counter, condition, or increment expression? Can you make it run backward, creating a countdown?

### `While` loops

Unlike the `for` loop, a `while` loop requires a condition that will stop the loop only when the expression in the `while` loop evaluates to `false`. 

Conditions in loops usually rely on other values, such as counters, and they must be managed during the loop. 

Starting values for counters must be created outside the loop, and any expressions to meet a condition, including changing the counter, must be maintained inside the loop. In the following example, the `while` loop runs for 10 iterations.

```javascript
//Counting up to 10
let i = 0;
while (i < 10) {
 console.log(i);
 i++;
}
```

> [!NOTE]
> Why would you choose either a `for` loop or a `while` loop? On StackOverflow, [17,000 viewers had the same question](https://stackoverflow.com/questions/39969145/while-loops-vs-for-loops-in-javascript/?azure-portal=true), and some of the opinions might be interesting to you.

Arrays are often used with loops because most conditions require the length of the array to stop the loop, and the index can also be the counter value.

## Loops and arrays

Let's head back to your list of delicious ice cream flavors. A customer has asked you to name all the flavors you're selling before they decide what to buy. Luckily, you know about `for` loops, so go ahead and use one. Remember, you defined a condition on when to end the list, like this:

```javascript
i < 10
```

Well, your array of ice cream flavors has an arbitrary length, which means that you can remove or add items to it at any time. You know you have six kinds of ice cream, but you can use the `length` field on the array and rely on that instead:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Neapolitan", "Mint Chip"];

for (let i = 0; i < iceCreamFlavors.length; i++) {
  console.log(iceCreamFlavors[i]);
} // Ends when all flavors are printed
```

There you have it. You've listed all the flavors, and your customer has picked "Vanilla." Which flavor would you pick?

## The `forEach()` loop

So far, you've learned about the `for` and `while` loops. There's another loop on the array itself called `forEach()`. The `forEach()` loop iterates over the items and offers a simplified way to loop, because you don't need a counter if all you want to do is loop. For example:

```javascript
let numbers = [1, 2, 3, 4, 5];
numbers.forEach(number => console.log(number)); // 1 2 3 4 5
```

Also, if you want access to the current index, you can have that too, by slightly changing the preceding code to the following:

```javascript
numbers.forEach((number, index) => console.log(`Number ${number} ${index}`));
```

### When to use which loop construct

 The `for` and `forEach()` loops both let you loop over the array's items, but the difference between them is that the `for` loop lets you exit if a certain condition is fulfilled. 

Consider the following code:

```javascript
let numbers = [1, 2, -1, 4, 5];
for(let i = 0; i< numbers.length; i++>) {
  if (numbers[i] < 0) {
    break;
  }
  console.log(numbers[i]);
}
```

Adding `break` makes the loop stop at a negative item. The `forEach()` loop can't do that.

> [!TIP]
> Experiment with looping over an array of your own making in your browser's console. If you want to challenge yourself, there are other ways of looping over arrays other than `for` and `while` loops. There are [`forEach`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach), [`for-of`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/for...of/?azure-portal=true), and [`map`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/map/?azure-portal=true) loops. Try rewriting your array loop by using one of these techniques.
