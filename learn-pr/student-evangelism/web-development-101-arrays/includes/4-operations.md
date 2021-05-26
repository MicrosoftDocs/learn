You've come a long way, but there's more to arrays than just iterating through them or removing and adding items. You can also query them or perform operations on them. 

## Filtering

There are many useful operations you can perform on an array. Finding and filtering out what you need are useful operations that you are likely to do often.

### Finding an item with `find()`

Imagine you have your ice cream and someone asks, do you have "Chocolate", and if you do, can I have it? At that point, you can use the `find()` method on the array like so:

```javascript
let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Rocky Road", "Mint"];
iceCreamFlavors.find(flavor => flavor === "Chocolate") // "Chocolate"
```

What `find()` does, is run that function you provided as input for each item and return the searched for element, if it finds it, otherwise it will return `undefined`.

### Filtering items with a common property using `filter()`

What if the customer says, I want something that contains chocolate, what do you have? At this point, you need to reorganize your ice cream store a little and start categorizing things. So that query should result in both "Chocolate", "Rocky Road" and "Mint" being offered to the customer. So you choose to store your array in the following way instead:

```javascript
let iceCreamFlavors = [
  { name: "Chocolate", type: "Chocolate" }, 
  { name: "Strawberry", type: "fruit"}, 
  { name: "Vanilla", type: "Vanilla"}, 
  { name: "Pistachio", type: "Nuts"}, 
  { name: "Rocky Road", type: "Chocolate"}, 
  { name: "Mint", type: "Chocolate"}
];
```

Ok, you've organized things. The customer asked for any ice cream containing chocolate, and ok they seemed to want once scoop of each kind. Your best method to use in this case is the `filter()`. It takes a filter expression (a function), and will return any item matching the expression. Let's help our customer with the following code:

```javascript
iceCreamFlavors.filter(flavor => flavor.type === "Chocolate") // [{ name: "Chocolate", type: "Chocolate" }, { name: "Rocky Road", type: "Chocolate"}, { name: "Mint", type: "Chocolate"}]
```

### Checking condition with `some()`

One of your customers is allergic to "Nuts" and wants to know firstly, does any of your ice creams contain "Nuts". You check your inventory using the `some()` method. The method takes a function that checks whether at least one element fulfills a condition. 

```javascript
iceCreamFlavors.some(flavor => flavor.type === "Nuts") // true
```

Because the "Pistachio" contains nuts `some()` return with true. At this point, the customer wants to know all flavors they can have, which leads you to run this code instead:

```javascript
iceCreamFlavors.filter(flavor => flavor.type !== "Nuts") // returns everything except for Pistachio.
```


## Projections map

A projection is you trying to change your array in some way. Imagine for example that you take your original `iceCreamFlavor` array and want to add a `price` property to each flavor. This situation is good case for a projection method called `map()`. Imagine it's a sunny day and you've decided that each ice cream should cost 1$ per scoop. You write code to make that happen, like so:

```javascript
let iceCreamFlavors = [
  { name: "Chocolate", type: "Chocolate" }, 
  { name: "Strawberry", type: "fruit"}, 
  { name: "Vanilla", type: "Vanilla"}, 
  { name: "Pistachio", type: "Nuts"}, 
  { name: "Rocky Road", type: "Chocolate"}, 
  { name: "Mint", type: "Chocolate"}
];
iceCreamFlavors.map(flavor => {
  flavor.price = 1;
  return flavor;
}) // every item now has a new property price: 1 
```

What the code does, is to go through each item in the list, and attach the `price` property, give it the value one and then return the item. 

## Aggregations

Business has been good, it was sunny weather today and you sold a ton of ice cream. You look at the receipts from your cash machine, it's stored in one long array looking like this:

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

You could use a `for` loop to sum it all together like so:

```javascript
let sum = 0;
for( let i =0; i< sales.length; i++) {
  sum += sales[i].amount; 
}
```

It works, but there's a more elegant approach namely the `reduce()` method. The idea of this method is to go from a list to singular item, that could be either an object or a number for example. To use `reduce()` you need to provide it with a function that takes two parameters, an accumulated value and the current value in the loop. Within the function, you should recalculate the accumulated value using the current value. The second argument to `reduce()` is the starter value. Because you want to use `reduce()` in this case to calculate sales, your function should update the accumulated value with the value of what's on the `amount` property for each item. Your starter value should be 0. With this in mind, here's what the code will look like:

```javascript
sales.reduce((acc, curr) => acc + curr.amount, 0);
```

As you can see, there's no need for a `sum` variable. Now this approach takes some getting used to, but is powerful and can be used in a lot of situations.

## Spread operator
 