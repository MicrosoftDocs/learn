As a business owner of an ice cream shop, you've picked up some programming skills and decided to build some software for your business. Maybe one day you'll turn it all into a franchise.

You want to first encode all you know about your shop, such as your various flavors and their prices. Then you want to simulate some customer interactions. Finally, you want to calculate your profits and gain some other useful insights.

## Build your business

First, start your ice cream empire by encoding all the ice cream flavors. 

1. Create a file called _app.js_, and add the following content:

   ```javascript
   let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Neapolitan", "Mint Chip", "Raspberry"];
   ```

1. Next, you want to categorize the flavors by type and give each one a price. You end up modifying the code in the following way:

   ```javascript
   let iceCreamFlavors = [
    { name: "Chocolate", type: "Chocolate", price: 2 }, 
    { name: "Strawberry", type: "Fruit", price: 1 }, 
    { name: "Vanilla", type: "Vanilla", price 2 }, 
    { name: "Pistachio", type: "Nuts", price: 1.5 }, 
    { name: "Neapolitan", type: "Chocolate", price: 2}, 
    { name: "Mint Chip", type: "Chocolate", price: 1.5 },
    { name: "Raspberry", type: "Fruit", price: 1},
   ];
   ```

   You've now converted your array item from strings to objects. You made this change to anticipate customers asking for things by price or type.

## Receive customers

You want to simulate a few customer scenarios in your code, to make sure that the way you categorized your inventory is flexible enough.

1. Before your first customer transaction, you realize you need a `transactions` array. You start thinking about what information you want to save on each transaction. The price is definitely one thing to save, and probably what your customers are buying as well. You add the following code:

   ```javascript
   // { scoops: [], total: }
   let transactions = []
   ```

1. Next, you decide to encode a couple of transactions by adding the following code:

   ```javascript
   transactions.push({ scoops: ["Chocolate", "Vanilla", "Mint Chip"], total: 5.5 })
   transactions.push({ scoops: ["Raspberry", "StrawBerry"], total: 2 })
   transactions.push({ scoops: ["Vanilla", "Vanilla"], total: 4 })
   ```

   Okay, that simulates three customer interactions. Next, you want to analyze the result.

## Analyze your business

When you run a business, profits are important, but they aren't the only important thing. What do you sell so much of that you need to ensure that there's enough of it in stock? Also, what don't you sell as much of, so you don't need to keep as much of it in stock?

1. To calculate your earnings, add the following code:

   ```javascript
   const total = transactions.reduce((acc, curr) => acc + curr.total, 0);
   console.log(`You've made ${total} $ today`); // You've made 11.5 $ today
   ```

1. To find out how much you've sold of each flavor, add the following code:

   ```javascript
   let flavorDistribution = transactions.reduce((acc, curr) => {
     curr.scoops.forEach(scoop => {
       if (!acc[scoop]) {
         acc[scoop] = 0;
       }
       acc[scoop]++;
     })
     return acc;
   }, {}) // { Chocolate: 1, Vanilla: 3, Mint Chip: 1, Raspberry: 1, StrawBerry: 1 }
   ```

   The preceding code goes through all the transactions. For each transaction, it checks through the scoops and updates a dictionary with how often scoops of each flavor have been purchased. If these sales were a real sales situation, you would probably need to stock up on more vanilla.

Congratulations, you've started an ice cream business. You know how to encode flavors and transactions by using arrays and objects. You've also learned how to summarize your earnings and understand how much you've sold of each flavor.
