The objective when designing a data model for a NoSQL database is to ensure operations on data are done in the fewest number of requests. To do this we need to understand the relationships between the data as well as how data will be accessed. The access patterns are important because it, along with the relationships, will determine how and where data is stored in Azure Cosmos DB.

Let's start with the customer entities in our e-commerce database. Below there are three different entities and the relationships between them. The three entities are, Customer, CustomerAddress and CustomerPassword. Our Customer entity has a 1:Many  relationship to CustomerAddress and Customer has a 1:1 relationship to CustomerPassword.

  :::image type="content" source="../media/customer-relational-model.png" alt-text="relational model for customer entities":::

In our application, there are three operations we will perform on the Customer entities.
    - **Create a customer**: When a new user first visits the e-commerce site a new customer will be created.
    - **Update a customer**: When an existing user updates their profile information their customer record will be updated.
    - **Retrieve a customer**: When an existing user visits the site, they login, requiring the password information. During that same session, they will need to access other customer data to purchase new items such as address.

For each of these operations we need all this data at the same time. These entities could be modeled as separate documents but it would require multiple round trips to the server to create, update and retrieve the customer data.

Azure Cosmos DB stores data as JSON, so we can model the 1:Many relationship between customer and customerAddress and embed the customer address data as an array. For the 1:1 relationship between customer and customerPassword, we can embed that as an object into our new single customer document. This will allow the e-commerce application to create, edit or retrieve customer data in a single request. Below is what our customer entity looks like.

  :::image type="content" source="../media/modeled-customer-document.png" alt-text="modeled customer document":::