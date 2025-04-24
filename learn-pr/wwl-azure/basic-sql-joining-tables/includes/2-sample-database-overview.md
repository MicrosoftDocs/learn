The sales database is designed to simulate a typical sales environment for a company that sells various products to customers. It's structured to store information about customers, products, suppliers, orders, employees, and shipping. This database allows us to:

* Track customer orders and purchase history.
* Manage product inventory and pricing.
* Analyze sales data and generate reports.
* Track which employee handled which order.
* Track which shipper was used for each order.

Key tables in this Database:

* customers: Stores customer details like names, addresses, and contact information.
* products : Contains product information, including names, prices, and categories.
* categories: Lists the categories to which the products belong.
* suppliers: Holds information about the companies supplying the products.
* orders: Records customer order details, including dates and customer IDs.
* order_details: Provides line-item details for each order, linking products and quantities.
* employees: Stores employee information.
* shippers: Contains details about shipping companies.

The tables are interconnected using foreign keys, allowing for comprehensive data analysis and reporting on sales activities.

Foreign keys are a concept in relational databases, used to establish and enforce a link between two tables. A foreign key is one table uniquely identifies a row in another table, creating relationships that enable data integrity and efficient cross-table queries.

![Sample Database Schema](learn-pr\wwl-azure\media\sampe-database.png)