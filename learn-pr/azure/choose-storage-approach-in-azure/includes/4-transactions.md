If a change to one piece of data must result in a change to another piece of data, an application needs to group together a series of data updates. You can use *transactions* to group these updates. In a transaction, if one event in a series of updates fails, the entire series can be rolled back or undone. 

An example is an online retailer that uses a transaction to place an order, verify payment, and update the product inventory. Grouping the related events ensures that you don't reduce your inventory levels until you receive an approved form of payment.

Next, learn about transactions and whether they're required for your data.

## What is a transaction?

A transaction is a logical group of database operations that run together.

Here's the question to ask yourself regarding whether you need to use transactions in your application: Will a change to one piece of data in your dataset affect another piece of data? If the answer is yes, you'll need support for transactions in your database service.

Transactions are often defined by a set of four requirements call *ACID guarantees*. ACID is an acronym for *atomicity*, *consistency*, *isolation*, and *durability*.

- *Atomicity* means a transaction must run exactly once, and it must be atomic. Either all of the work is done or none of it is. Operations within a transaction usually share a common intent and are interdependent.
- *Consistency* ensures that the data is consistent both before and after the transaction.
- *Isolation* ensures that each transaction is unaffected by other transactions.
- *Durability* means that changes made as a result of a transaction are permanently saved in the system. The system saves data that's committed so that even in the event of a failure and system restart, the data is available in its correct state.

When a database offers ACID guarantees, these principles are consistently applied to each transaction.

### OLTP vs. OLAP

Transactional databases are often called *online transaction processing (OLTP)* systems. OLTP systems commonly support many users, have quick response times, and handle large volumes of data. They also are highly available, which means they have minimal downtime. OLTP systems typically handle small transactions or relatively simple transactions.

An example of an Azure service that supports OLTP is Azure SQL Database.

*Online analytical processing (OLAP)* systems commonly support fewer users, have longer response times, can be less available, and typically handle large transactions or complex transactions.

An example of an Azure service that supports OLAP is Azure Analysis Services.

The terms OLTP and OLAP aren't used as frequently as they used to be, but understanding them makes it easier to categorize the needs of your application.

## Transactions: Evaluate your data types

Ensuring that your data is in the correct state isn't always an easy task. Transactions can help by enforcing data integrity requirements on your data. If your data benefits from ACID principles, choose a storage solution that supports transactions.

Let's walk through each of the datasets in the online retail scenario and determine the need for transactions.

### Product catalog data

Product catalog data should be stored in a transactional database. When a user places an order and the payment is verified, the item inventory should be updated. Likewise, if the customer's credit card is declined, the order should be rolled back and the inventory shouldn't be updated. These relationships require transactions.

### Photos and videos

Photos and videos in a product catalog don't require transactional support. These files are changed only when an update is made or new files are added. Even though there's a relationship between the image and the actual product data, it's not transactional in nature.

### Business data

Because business data is historical and unchanging, transactional support isn't required. Business analysts who work with the data also have unique query needs. They often work with aggregates in their queries, so they can work with the totals of other smaller data points.
