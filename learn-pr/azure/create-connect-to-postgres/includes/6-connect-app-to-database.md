As you saw in the previous exercise, setting up an Azure Database for PostgreSQL instance is fairly straightforward. We can quickly create, develop, and manage databases through the Azure portal and Cloud Shell. With Azure taking care of the hosting and security, after you’re set up, you can focus on application development.

Another key feature of Azure Database for PostgreSQL is flexibility. It supports many different libraries and drivers that developers can use to develop applications. Nearly all popular programming languages have libraries to connect and develop PostgreSQL databases.

Most language client libraries used to connect to PostgreSQL server are external projects and are distributed independently. The libraries listed in the links in Unit 9 - Summary are supported on the Windows, Linux, and Mac platforms.

## Advantages of developing applications with PostgreSQL

:::row:::
:::column span="2":::

PostgreSQL is a great database choice for most applications - it’s easy to use, and it’s flexible enough to survive requirement changes. As you develop your application, you may need to store new types of data. You can count on PostgreSQL to support your data types that aren't available in other database solutions, such as MySQL. Some of these postgres-supported data types include timezone-aware timestamps, JSONB which can indexed, and network address types. You can also add your own data types, operators, and index types.

In our scenario, we’re rapidly developing our contactless payment app. Using Azure Database for PostgreSQL, we’ve done everything we need to set up the database for the app’s test deployment. We've hosted the database server and connected to it. Now we can quickly integrate our existing ASP.NET application with our database, and get back to developing the application, instead of spending time and money on managing the database. In the next exercise, we’ll walk you through how to close the loop - connecting your app to your PostgreSQL database.

:::column-end:::
:::column span="2":::

#### "If you're not tied to any legacy system and have the freedom to choose a database back-end, we recommend PostgreSQL, which achieves a fine balance between cost, features, speed and stability."

###### \- The Definitive Guide to Django
:::column-end:::
:::row-end:::
