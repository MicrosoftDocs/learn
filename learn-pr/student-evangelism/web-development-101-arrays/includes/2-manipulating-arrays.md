For data and information on your websites to be interactive, you need a way to manipulate and store the data in your code. Thankfully, JavaScript has a way to store multiple items in an *array*. Using arrays will help save you from declaring many variables, among other benefits.

## About arrays

An array is a type of data structure that contains more than one element. Imagine a purchase order containing multiple order items or an ice cream bar having multiple flavors to choose from. Instead of storing, for example, eight different ice cream flavors as eight different variables, you can use a single array to store that information, as shown in the following below:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Neapolitan"];
```

In this code, you're indicating an array by enclosing all its content within brackets (`[]`).

### Access an item

An array's contents are commonly referred to as either *elements* or *items*. You often need to access a specific element to read its value, update it, or even remove it. To access a specific element, you use brackets and the position you're interested in, like this:

```javascript
array[<number>]
```

The first item in an array starts on 0 and the last item is its length (number of items) minus 1. Thas is, if an array has three items, 0 would be the first position and 2 its last position. A position in an array is referred to as its *index*. Looking at the `iceCreamFlavors` array, let's assume you want **Pistachio**. To read its value, you can write the following code:

```javascript
iceCreamFlavors[3] // Pistachio
```

### Change a value

To change a value in an array, you need to select the item's index and assign it a new value by using the equal sign assignment operator (`=`) and a value to the right of the operator. Our ice cream shop has run out of "Neapolitan," but don't worry, we found some "Butter Pecan":

```javascript
iceCreamFlavors[4] = "Butter Pecan"; //Changes "Neapolitan" to "Butter Pecan"
```

### Add more values

At some point, your ice cream business expands and you want to offer more flavors. What do you do? You can use the method `push()` to add more flavors. The `push()` method takes an item as input and adds the item to the original array. For example, to add "Mint Chip" as flavor, you would use the following code:

```javascript
iceCreamFlavors.push("Mint Chip");
```

### Use the array length

Imagine that someone asks, how many flavors of ice cream do you have? You look in the back room, but all you see is an ocean of flavors, which are going to take some time to count. But wait, on the array, there's a `length` field that you can use to count all the flavors:

```javascript
iceCreamFlavors.length // 6 flavors, because you recently added "Mint Chip"
```

> [!TIP]
> Use your browser's console to create and manipulate an array of your own creation. Remember, you can write JavaScript right in your browser. To do so, open a browser window and go to Developer Tools. In the console, you'll find a prompt. Experiment with manipulating an array with indexes and properties, which you just learned about.

### Remove a value

To remove a value from an array, you can use `delete`. Let's say you've just run out of "Mint Chip." The bucket is still there, but the "Mint Chip" ice cream is gone. The code looks like this:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Neapolitan", "Mint Chip"];
delete iceCreamFlavors[iceCreamFlavors.length-1];
console.log(iceCreamFlavors[length-1]) // undefined
```

All your items are still there but the bucket, where the "Mint Chip" used to be, is cleared. You can now assign it with a new flavor, what would you add?

```javascript
iceCreamFlavor[iceCreamFlavor.length-1] = "your choice";
```

### Remove an item

Sometimes, it's not enough to remove the value. The whole bucket must go. Maybe you don't have enough room at home? You decide to eat all the "Vanilla" (you'll probably regret this later) and throw away the carton it came in. For this operation, you'll use the array method `splice()`. It takes a position and how many elements to remove, as shown in this code:

```javascript
array.splice(<position index, <number of elements to remove>)
```

To remove an item (eat all the "Vanilla" and toss the carton), use the `splice()` method, like this:

```javascript
iceCreamFlavor.splice(2,1); 
iceCreamFlavor // [ 'Chocolate', 'Strawberry', 'Pistachio', 'Neapolitan', 'Mint Chip' ]
```
