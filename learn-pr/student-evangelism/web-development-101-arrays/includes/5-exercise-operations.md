As a business owner of an ice cream shop, you've picked up some programming skills and decide that you want to build some software for your business, maybe one day you will turn it all into a franchise.

You want to first encode all you know about your shop like flavors and prices. Then you want to simulate some customer interactions and lastly calculate your profits and gain some other useful insights.

## Build your business

First off you want to start your ice cream empire by encoding all the ice cream flavors. 

1. Create a file _app.js_ and give it the following content:

   ```javascript
   let iceCreamFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Rocky Road", "Mint", "Raspberry"];
   ```

1. Next you want to categorize every flavor, by what they are and give each flavor a price. So you end up modifying the code in the following way:

   ```javascript
   let iceCreamFlavors = [
    { name: "Chocolate", type: "Chocolate", price: 2 }, 
    { name: "Strawberry", type: "Fruit", price: 1 }, 
    { name: "Vanilla", type: "Vanilla", price 2 }, 
    { name: "Pistachio", type: "Nuts", price: 1.5 }, 
    { name: "Rocky Road", type: "Chocolate", price: 2}, 
    { name: "Mint", type: "Chocolate", price: 1.5 },
    { name: "Raspberry", type: "Fruit", price: 1},
   ];
   ```

   At this point, you turned your converted your array item from strings to objects. You did this change to anticipate customers asking for things by price or type.

## Receive customers

At this point you want to simulate a few customer scenarios in your code, to make sure the way you categorized your inventory is flexible enough.

1. Before your first customer transaction, you realize you need a `transactions` array. You start thinking about what information you want to save on each transaction, the price definitely, probably what they buy as well. You add the following code:

   ```javascript
   // { scoops: [], total: }
   let transactions = []
   ```

1. Next, you decide to encode a couple of transactions by adding the following code:

   ```javascript
   transactions.push({ scoops: ["Chocolate", "Vanilla", "Mint"], total: 5.5 })
   transactions.push({ scoops: ["Raspberry", "StrawBerry"], total: 2 })
   transactions.push({ scoops: ["Vanilla", "Vanilla"], total: 4 })
   ```

   Ok, that simulates three customer interactions, next you want to analyze the result.

## Analyze your business

When you run a business, it's not only about profits, but also about what you sell much so you have enough on stock. Also things that you don't sell much of are maybe things you shouldn't have in stock?

1. To calculate your earnings, add the following code:

   ```javascript
   const total = transactions.reduce((acc, curr) => acc + curr.total, 0);
   console.log(`You've made ${total} $ today`); // You've made 11.5 $ today
   ```

1. To find out how much you sold of each, add the following code:

   ```javascript
   let flavorDistribution = transactions.reduce((acc, curr) => {
     curr.scoops.forEach(scoop => {
       if (!acc[scoop]) {
         acc[scoop] = 0;
       }
       acc[scoop]++;
     })
     return acc;
   }, {}) // { Chocolate: 1, Vanilla: 3, Mint: 1, Raspberry: 1, StrawBerry: 1 }
   ```

   The above code, goes through all the transactions. For each transaction, it checks through the scoops and updates a dictionary with how often a scoop has been purchased. If these sales were a real sales situation, you would probably need to stock up on more vanilla.

Congratulations, you've started an Ice Cream franchise, you know how to encode flavors and transactions using arrays and objects. You've also learned to summarize your earnings and understanding how much you've sold of each flavor.
