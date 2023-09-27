As you saw in the previous exercise, setting up an Azure Database for PostgreSQL instance is fairly straightforward. You can quickly create, develop, and manage databases through the Azure portal and Cloud Shell. With Azure taking care of the hosting and security, you can focus on application development.

Another key feature of Azure Database for PostgreSQL is flexibility. It supports many different libraries and drivers that developers can use to develop applications. Nearly all popular programming languages have libraries to connect and develop PostgreSQL databases.

Most language client libraries used to connect to PostgreSQL server are external projects and are distributed independently. The libraries listed in the links in the summary in unit 9 are supported on the Windows, Linux, and Mac platforms.

## Advantages of developing applications with PostgreSQL

:::row:::
:::column span="2":::

PostgreSQL is a great database choice for most applications. It's easy to use, and it's flexible enough to survive requirement changes. As you develop your application, you might need to store new types of data. You can count on PostgreSQL to support data types that aren't available in other database solutions, such as MySQL. Some of these postgres-supported data types include timezone-aware timestamps, JSONB that can be indexed, and network address types. You can also add your own data types, operators, and index types.

In this scenario, you're rapidly developing a contactless payment app. Using Azure Database for PostgreSQL, you've done everything needed to set up the database for the app's test deployment. You hosted the database server and connected to it. Now you can quickly integrate the existing ASP.NET application with the database, and get back to developing the application, instead of spending time and money on managing the database. In the next exercise, you walk you through how to close the loop by connecting your app to your PostgreSQL database.

:::column-end:::
:::column span="2":::

### "If you're not tied to any legacy system and have the freedom to choose a database back-end, we recommend PostgreSQL, which achieves a fine balance between cost, features, speed and stability."

\- *The Definitive Guide to Django*
:::column-end:::
:::row-end:::
