After you've identified the kind of data you want to store (structured, semi-structured, or unstructured), the next step is to determine how you'll use the data. For example, as an online retailer, you know that customers need quick access to product data, and business users need to run complex analytical queries. As you work through these requirements, taking your data classification into account, you can begin to plan your data storage solution.

Here, you'll answer some questions to help you determine what to do with your data.

## Operations and latency

What are the main operations you'll be completing on each data type, and what are the performance requirements for the data?

Ask these questions about your data:

- Will you be doing simple lookups by using an ID field?
- Do you need to query the database for one or more fields?
- How many create, update, and delete operations do you expect to run?
- Do you need to run complex analytical queries?
- How quickly do these operations need to process?

The answers to these questions will help you decide on the best storage solution for your data.

## Operations and latency: Evaluate your data types

Let’s walk through each of the datasets with these questions in mind and discuss the requirements.

### Product catalog data

For product catalog data in an online retail scenario, customer needs are the highest priority. Customers will want to query the product catalog to find an item or category they have in mind. For example, a customer might query all tennis shoes, then tennis shoes on sale, and then tennis shoes on sale in a particular size. Customer needs might require many read operations, and they must be able to query on specific fields.

When a customer places an order, the application must update product quantities. The update operations need to happen as quickly as the read operations so that users don't put an item in their shopping carts when that item just sold out. The application must support not only a large number of read operations, but it also requires increased write operations for product catalog data. Be sure to determine the priorities for all the users of the database, not only the primary users.

### Photos and videos

Photos and videos that are displayed on product pages have different requirements. They need fast retrieval times so that they're displayed on the site at the same time as product catalog data, but they don't need to be queried independently. Instead, you can rely on the results of the product query, and include the video ID or URL as a property on the product data. So, photos and videos need to be retrieved only by their ID.

Customers won't make updates to existing photos or videos. But, they can add new photos for product reviews. For example, a customer might upload an image of them wearing their new shoes.

As an employee, you also upload and delete product photos that are provided by your product vendor. But those updates don't need to happen as quickly as your other product data updates.

In summary, photos and videos can be queried by ID to return an entire file, but create operations and update operations are less frequent and are a lower priority.  

### Business data

For data analysis, the company uses only historical data. No original data is updated based on the analysis, so business data is read-only. Users don't expect their complex analytics to run instantly, so it's acceptable to have some latency in the results.

Business data is stored in multiple datasets. Not all business analysts need write access to all datasets, but all business analysts can read from all datasets.
