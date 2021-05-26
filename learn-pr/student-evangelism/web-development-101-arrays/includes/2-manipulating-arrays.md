In order for the data and information on the websites to be interactive, we need a way to manipulate and store data in our code. Thankfully JavaScript has a way to store multiple items in an **array**. Using an array will save you from declaring many variables, among other things.

## Arrays

An array is a type of data structure that contains more than one element. Imagine a purchase order, having multiple order items or an ice cream bar having multiple flavors you can choose from. Instead of storing let's say eight ice cream flavors in eight variables, you can instead use an array to store that information like in the below code:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Rocky Road"];
```

In the above code, you are using double brackets `[]` to indicate that here's an array and all its content within the brackets. 

### Accessing an item

The elements in array are commonly referred to as either elements or items. Often you need to access a specific element to either read its value, update it or even remove it. To access a specific element you use square brackets and the position you are interested in, like so:

```javascript
array[<number>]
```

The first item in an array starts on 0 and the last item is its length -1. So if an array has three items, 0 would be the first position and 2 its last position. A position in an array is referred to as index. Looking at the `iceCreamFlavors` array, let's assume we want **Pistachio**, to read said value, we can write the following code:

```javascript
iceCreamFlavors[3] // Pistachio
```

### Changing a value

To change a value in an array, you need to select the index for the item and assign it a new value using the assignment operator `=` and a value to the right of the operator. Our ice cream shop has run out of "Rocky Road", but don't worry, we found some "Butter Pecan":

```javascript
iceCreamFlavors[4] = "Butter Pecan"; //Changed "Rocky Road" to "Butter Pecan"
```

### Adding more values

At some point, your ice cream business expands and you want to offer more flavors, what to do? You can use the method `push()` to add more flavors. The `push()` takes an item as input and it ends up adding the item to the array. Below you are adding "Mint" as flavor, cause who doesn't love mint?

```javascript
iceCreamFlavors.push("Mint");
``` 

### Using the array length

Imagine that someone asked, how many flavors of ice cream do you have? You look in the back room but all you see is an ocean of flavors, that's going to take some time to count. But wait, there's actually a `length` field on the array you can use for counting all the flavors:

```javascript
iceCreamFlavors.length // 6, because you added mint, remember
```

> [!TIP] Try it yourself!
> Use your browser's console to create and manipulate an array of your own creation. Remember, you can write JavaScript right in your browser! Just open a browser window and navigate to Developer Tools. In the console, you will find a prompt. Experiment with how you can manipulate an array with indexes and properties you just learned.

### Remove value

To remove a value from an array, you can use `delete`. Think of deleting a value as you having a number of ice cream containers and you simply run out of "Mint" for example. The bucket will still be there but the "Mint" is gone. The code looks like so:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Rocky Road", "Mint"];
delete iceCreamFlavors[iceCreamFlavors.length-1];
console.log(iceCreamFlavors[length-1]) // undefined
```

All your items are still there but the bucket, where the "Mint" used to be, is cleared. You can now assign it with a new flavor, what would you add?

```javascript
iceCreamFlavor[iceCreamFlavor.length-1] = "your choice";
```

### Remove item

Sometimes it's not enough to remove the value, the whole bucket must go. Maybe you don't have enough room at home? You decide on eating all the "Vanilla" (you will probably regret that later) and throw away the carton it came in. For this operation you will use the array method `splice()`, it takes a position and how many elements to remove, like so:

```javascript
array.splice(<position index, <no of elements to remove>)
```

To remove (eat all the vanilla and toss the carton), use the `splice()` method like so:

```javascript
iceCreamFlavor.splice(2,1); 
iceCreamFlavor // [ 'Chocolate', 'Strawberry', 'Pistachio', 'Rocky Road', 'Mint' ]
```