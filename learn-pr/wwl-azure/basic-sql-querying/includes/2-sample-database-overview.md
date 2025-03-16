# Sample Database Overview

The Sales database is designed to simulate a typical sales environment for a company that sells various products to customers. It's structured to store information about customers, products, suppliers, orders, employees, and shipping. This database allows us to:

* Track customer orders and purchase history.
* Manage product inventory and pricing.
* Analyze sales data and generate reports.
* Track which employee handled which order.
* Track which shipper was used for each order.

Key tables in this Database:

* Customers: Stores customer details like names, addresses, and contact information.
* Products: Contains product information, including names, prices, and categories.
* Categories: Lists the categories to which the products belong.
* Suppliers: Holds information about the companies supplying the products.
* Orders: Records customer order details, including dates and customer IDs.
* OrderDetails: Provides line-item details for each order, linking products and quantities.
* Employees: Stores employee information.
* Shippers: Contains details about shipping companies.

The tables are interconnected using foreign keys, allowing for comprehensive data analysis and reporting on sales activities.
