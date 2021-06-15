You've come a long way, but there's more to arrays than just iterating through them or removing and adding items. You can also query them or perform operations on them. 

## Filtering

You can perform many useful operations on an array. Finding and filtering out what you need are operations that you're likely to do often.

### Find an item by using `find()`

Imagine you have your ice cream and someone asks, do you have "Chocolate," and if you do, can I have it? At that point, you can use the `find()` method on the array, as shown here:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Neapolitan", "Mint Chip"];
iceCreamFlavors.find(flavor => flavor === "Chocolate") // "Chocolate"
```

The `find()` operation runs the function that you provided as input for each item. If the operation finds the searched-for element, it returns the element. If it doesn't find the element, it returns `undefined`.

### Filter items with a common property by using `filter()`

What if the customer says, I want ice cream that *contains* "Chocolate," what do you have? Now you need to reorganize your ice cream store a little and start categorizing things. This customer query should return "Chocolate", "Neapolitan," and "Mint Chip" as flavor offerings that contain "Chocolate." With this in mind, you choose to store your array in the following way:

```javascript
let iceCreamFlavors = [
  { name: "Chocolate", type: "Chocolate" }, 
  { name: "Strawberry", type: "fruit"}, 
  { name: "Vanilla", type: "Vanilla"}, 
  { name: "Pistachio", type: "Nuts"}, 
  { name: "Neapolitan", type: "Chocolate"}, 
  { name: "Mint Chip", type: "Chocolate"}
];
```

Okay, you've now reorganized your offering. The customer asked for any ice cream containing chocolate, and they seem to want one scoop of each of the three flavors returned by the query. Your best method to use in this case is the `filter()` operation. It takes a filter expression (a function) and returns any item that matches the expression. To help your customer find what they want, use the following code:

```javascript
iceCreamFlavors.filter(flavor => flavor.type === "Chocolate") // [{ name: "Chocolate", type: "Chocolate" }, { name: "Neapolitan", type: "Chocolate"}, { name: "Mint Chip", type: "Chocolate"}]
```

### Check a condition by using `some()`

One of your customers is allergic to "Nuts" and wants first to know whether any of your ice creams contains "Nuts." You check your inventory by using the `some()` method. The method takes a function that checks whether at least one element fulfills a condition.

```javascript
iceCreamFlavors.some(flavor => flavor.type === "Nuts") // true
```

Because the "Pistachio" flavor contains nuts, the `some()` method returns with *true*. Now, the customer wants to know all flavors they *can* safely have, which leads you to run this code instead:

```javascript
iceCreamFlavors.filter(flavor => flavor.type !== "Nuts") // returns everything except for Pistachio.
```

## Projections map

A projection is you trying to change your array in some way. Imagine, for example, that you take your original `iceCreamFlavor` array and want to add a `price` property to each flavor. This situation is good case for a projection method called `map()`. Imagine it's a sunny day and you've decided that your ice cream should cost $1 per scoop. You write code to make that happen, like this:

```javascript
let iceCreamFlavors = [
  { name: "Chocolate", type: "Chocolate" }, 
  { name: "Strawberry", type: "fruit"}, 
  { name: "Vanilla", type: "Vanilla"}, 
  { name: "Pistachio", type: "Nuts"}, 
  { name: "Neapolitan", type: "Chocolate"}, 
  { name: "Mint Chip", type: "Chocolate"}
];
iceCreamFlavors.map(flavor => {
  flavor.price = 1;
  return flavor;
}) // every item now has a new property price: 1 
```

The code goes through each item in the list, attaches the `price` property, gives it the value `1`, and then returns the item.

## Aggregations

Business has been good. The weather is sunny today, and you've sold a ton of ice cream. Your cash machine receipts are stored in one long array, which looks like the following code:

```javascript
let sales = [{
 date : '2021-05-01',
 amount: 2
},
{
 date : '2021-05-01',
 amount: 1
}
// and so on...
]
```

You could use a `for` loop to sum it all together, like this:

```javascript
let sum = 0;
for( let i =0; i< sales.length; i++) {
  sum += sales[i].amount; 
}
```

This code works, but there's a more elegant approach: namely, the `reduce()` method. The idea of this method is to *reduce* a long list to a single item, which could be either an object or a number, for example. To use `reduce(),` you need to provide it with a function that takes two parameters, an accumulated value and the current value in the loop. 

Within the function, you should recalculate the accumulated value by using the current value. The second argument to `reduce()` is the starter value. Because you want to use `reduce()` in this case to calculate sales, your function should update the accumulated value with the value of what's on the `amount` property for each item. Your starter value should be `0`. With this in mind, here's what the code looks like:

```javascript
sales.reduce((acc, curr) => acc + curr.amount, 0);
```

As you can see, there's no need for a `sum` variable. Now, this approach takes some getting used to, but it's powerful and can be used in many situations.
