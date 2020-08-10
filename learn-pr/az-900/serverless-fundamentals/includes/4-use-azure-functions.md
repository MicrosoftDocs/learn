Data about each product that's sold at Tailwind Traders is packaged up as a JSON message and sent to an event hub.  The event hub distributes the JSON message to subscribers allowing different systems to be notified.

Tailwind Traders wants to upgrade their eCommerce site to include real-time inventory tracking.  Currently, the website updates product availability each night at 2am.  A Windows Service written in C# contains all of the necessary logic to retrieve the messages, parse the JSON, perform a look-up across multiple databases to find additional product information and potentially send notifications to the purchasing department so that they can re-order quantities that fall below certain levels.  The Windows Service runs in a VM hosted on Azure.

Most of the time, this system works fine.  However, some products are in high demand, and some products are kept in low quantities at each store.  Several times a day, customer drive to the store to pick up an item only to find that it is no longer in stock.

Instead of running the algorithm on a nightly basis, they want to run the inventory updater each time a product is purchased.

## Which service should we choose?

Since Tailwind Traders already has the logic written in C#, it would make sense to copy the relevant C# code from the Windows Service and port it to an Azure Function. The developers would bind the function to trigger each time a new message appears on a specific queue.

## Why not choose Azure Logic Apps?

It's possible that the same logic could be implemented in Azure Logic Apps.  However, since the team has already invested time in building the service in C#, they can leverage it for use in an Azure Function.