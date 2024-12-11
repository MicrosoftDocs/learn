The API that you build in this module connects the front-end website to the backend database. But why not just connect the website directly to the database? Why do we need an API at all?

## Why we need an API

To connect to the database, we have to have a connection string. That connection string allows anyone, anywhere to access the database and do whatever they like with it. If we put that connection string in the website, anyone can easily see and copy it. That would be bad.

By creating an API, we put a layer that we control between the website and the database. The database connection string is safe there, because the API is running on our server. Having an API also lets us create an authentication layer so that we can control access to the API, and in the same way, the database.

Right now, these are the Product Manager application's parts:

:::image type="content" source="../media/product-manager-parts.svg" alt-text="Diagram showing the Product Manager application and database with no API.":::

In this module, you build the layer that sits between the front end and the database, safely storing the connection string. This layer is the API. You're using Azure Functions, so it's serverless. This means that instead of paying for a full server or virtual machine, you deploy just your code and only pay when it's executed.

When you finish this module, you created the API that allows the front end and the back end to safely communicate. The Product Manager Application looks like this:

:::image type="content" source="../media/product-manager-all-parts.svg" alt-text="Diagram displaying the parts of the application: web site, the API using Azure Functions, and the database with the products data":::
