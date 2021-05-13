The API that you will build in this module will connect the frontend website to the backend database. But why not just connect the website directly to the database? Why is an API needed at all?

## Why we need an API

In order to connect to the database, we have to have a connection string. That connection string will allow anyone anywhere to access the database and do whatever they like with it. If we put that connection string in the website, it can be easily seen and copied by anyone. That would be bad.

By creating an API, we put a layer that we control in between the website and the database. The database connection string is safe there, because the API is running on our server. Having an API also gives us the ability to create an authentication layer so that we could control access to the API, and in the same way, the database.

Right now, these are the parts of the Product Manager application:

:::image type="content" source="../media/product-manager-parts.svg" alt-text="A diagram showing the product manager application and database with no api":::

In this module, you'll be building the layer that sits in between the frontend and the database, safely storing the connection string. This layer is the API. You'll be using Azure Functions, so it will be serverless. This means that instead of paying for a full server or virtual machine, you deploy just your code and only pay when it is executed.

When you finish this module, you will have created the API that allows the frontend and the backend to safely communicate. The Product Manager Application will look like this:

:::image type="content" source="../media/product-manager-all-parts.svg" alt-text="Diagram displaying the parts of the application: web site, the API using Azure Functions, and the database with the products data":::
