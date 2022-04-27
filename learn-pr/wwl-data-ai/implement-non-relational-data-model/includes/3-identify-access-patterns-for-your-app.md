When you're designing a data model for a NoSQL database, the objective is to ensure that operations on data are done in the fewest requests. To do this, you need to understand the relationships between the data and how data will be accessed by the application. These access patterns are important because they, along with the relationships, will determine how the properties of the various entities are grouped together and stored in documents within containers in Azure Cosmos DB SQL API databases.

In Cosmos DB SQL API, documents are called Items and containers are often synonymously referred to as collections.

## Identify access patterns for customer entities

Let's start with the customer entities in our e-commerce database. The following diagram shows three entities and the relationships between them. The three entities are **Customer**, **CustomerAddress**, and **CustomerPassword**. The **Customer** entity has a 1:Many relationship to **CustomerAddress**. **Customer** has a 1:1 relationship to **CustomerPassword**.

  :::image type="content" source="../media/3-customer-relational-model.png" alt-text="Diagram that shows the relational model for customer entities.":::

In our application, we'll perform three operations on the customer entities:

- **Create a customer**: When a new user first visits the e-commerce site, a new customer will be created.
- **Update a customer**: When an existing user updates their profile information, their customer record will be updated.
- **Retrieve a customer**: When an existing user visits the site, they'll sign in with their password. During that same session, they'll need to access other customer data (such as address) to purchase new items.

For each of these operations, we need all this data at the same time. These entities can be modeled as separate documents, but it would require multiple round trips to the server to create, update, and retrieve the customer data.

## Model customer entities

Azure Cosmos DB stores data as JSON, so we can model the 1:Many relationship between **Customer** and **CustomerAddress** and embed the customer address data as an array. For the 1:1 relationship between **Customer** and **CustomerPassword**, we can embed that as an object in our new single customer document. Then the e-commerce application can create, edit, or retrieve customer data in a single request. 

The following diagram shows what our customer entity looks like.

  :::image type="content" source="../media/3-modeled-customer-document.png" alt-text="Diagram that shows a modeled customer document.":::
