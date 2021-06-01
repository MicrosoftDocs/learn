When designing a data model for a NoSQL database, the objective is to ensure operations on data are done in the fewest number of requests. To do this, we need to understand the relationships between the data and how data will be accessed. The access patterns are important because it, along with the relationships, will determine how and where data is stored in Azure Cosmos DB.

## Identify access patterns for customer entities

Let's start with the customer entities in our e-commerce database. Below there are three different entities and the relationships between them. The three entities are, Customer, CustomerAddress, and CustomerPassword. Our Customer entity has a 1:Many  relationship to CustomerAddress and Customer has a 1:1 relationship to CustomerPassword.

  :::image type="content" source="../media/3-customer-relational-model.png" alt-text="Diagram that shows the relational model for customer entities." border="false":::

In our application, there are three operations we will perform on the Customer entities.

- **Create a customer**: When a new user first visits the e-commerce site a new customer will be created.
- **Update a customer**: When an existing user updates their profile information their customer record will be updated.
- **Retrieve a customer**: When an existing user visits the site, they sign in with their password. During that same session, they will need to access other customer data to purchase new items such as address.

For each of these operations, we need all this data at the same time. These entities could be modeled as separate documents but it would require multiple round trips to the server to create, update, and retrieve the customer data.

## Model customer entities

Azure Cosmos DB stores data as JSON, so we can model the 1:Many relationship between customer and customerAddress and embed the customer address data as an array. For the 1:1 relationship between customer and customerPassword, we can embed that as an object into our new single customer document. Then the e-commerce application can create, edit, or retrieve customer data in a single request. The following diagram shows what our customer entity looks like.

  :::image type="content" source="../media/3-modeled-customer-document.png" alt-text="Diagram that shows modeled customer document." border="false":::
