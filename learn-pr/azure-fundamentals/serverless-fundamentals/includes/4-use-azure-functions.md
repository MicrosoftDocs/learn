Data about each product that's sold at Tailwind Traders is packaged as a JSON message and sent to an event hub. The event hub distributes the JSON message to subscribers, which allows various systems to be notified.

Tailwind Traders wants to upgrade its e-commerce site to include real-time inventory tracking. Currently, the website updates product availability nightly at 2:00&nbsp;AM. A Windows service that's written in C# contains all of the necessary logic to:

- Retrieve the messages.
- Parse the JSON.
- Perform a lookup across multiple databases to find any other product information.
- Potentially, send notifications to the purchasing department so that they can reorder quantities that fall below certain levels.

The Windows service runs in a virtual machine that's hosted on Azure.

Most of the time, this system works fine. However, some products are in high demand, and some products are kept in low quantities at each store. Several times a day, customers drive to a store to pick up an item only to find that it's no longer in stock.

Instead of running the algorithm nightly, the company wants to run the inventory updater each time a product is purchased.

## Which service should you choose?

Because the Tailwind Traders developers team has already written the logic in C#, it would make sense to copy the relevant C# code from the Windows service and port it to an Azure function. The developers would bind the function to trigger each time a new message appears on a specific queue.

## Why not choose Azure Logic Apps?

It's possible to implement the same logic in Azure Logic Apps. However, because the team has already invested time in building the service in C#, it can use the same code in an Azure function.
