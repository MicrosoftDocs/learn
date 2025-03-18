---
ms.custom:
  - ignite-2024
---
SQL Database in Microsoft Fabric is a versatile and developer-friendly transactional database built on the foundation of Azure SQL Database. It allows for the creation and management of operational databases within the Fabric environment.

Differently than Azure SQL Database, which is a Platform as a Service (PaaS), SQL Database in Microsoft Fabric is a Software as a Service (SaaS). This means that users can enjoy a low-maintenance solution, allowing them to focus even more on their core business activities.

One of its capabilities is the automatic replication of data into OneLake and conversion to Parquet in near real-time, which facilitates analytics without the need for complex ETL processes. This integration ensures that data is always up-to-date and accessible for various services within Fabric, such as Spark for analytics, notebooks for data engineering, and Power BI for visualization.

## Create a SQL Database

To create a new SQL database in Fabric, you need a new or existing workspace. Start by navigating to the Fabric portal and selecting **Databases**. Under the **New** section, select the SQL database tile. Enter a name for your new database and select **Create**. 

Once the database is provisioned, you see the **Explorer** pane on the **Home** page displaying the database objects.

:::image type="content" source="../media/2-new-database.png" alt-text="Screenshot showing the Explorer page of a newly created SQL database." lightbox="../media/2-new-database.png":::

To help you get started, there are three useful tiles under **Build your database**. The **Sample data** option allows you to import the *AdventureWorksLT* sample data into your empty database. The **T-SQL** option provides a web-editor for writing T-SQL to create database objects like schemas, tables, and views. The **Connection strings** option displays the SQL database connection string needed for connecting with SQL Server Management Studio or other external tools.

## Query a SQL Database

You can query a SQL database in Fabric using similar tools available for Azure SQL Database, with the added convenience of a web-based editor in the Fabric portal. This provides an end-to-end, integrated product that simplifies analytics and fosters collaboration.

:::image type="content" source="../media/2-query.png" alt-text="Screenshot showing how to query a SQL database in Microsoft Fabric." lightbox="../media/2-query.png":::

The **Open in** option allows you to launch Visual Studio Code and SQL Server Management Studio (SSMS) with the connection properties prefilled, making it easier to connect and start working immediately.

## Source control

Source control is an essential aspect of managing SQL databases in Microsoft Fabric. It allows you to track changes, collaborate with team members, and maintain a history of modifications. When you integrate your SQL database with a source control system, you ensure that all changes are documented and can be reverted if needed. This practice enhances the reliability and consistency of your database development process.

If you're familiar with source control, you notice that there's no major difference when committing changes to a SQL database in Microsoft Fabric compared to other code repositories. 

- **Commit to source control:** You can commit database objects to source control, converting the live database into code. This process reads object definitions from the database and writes them to the repository.
- **Update from source control:** You can update database objects from the contents of source control. The code is validated before applying a differential change to the database.
- **History tracking:** Users can view the history of database objects in the source control system, providing a clear record of changes and facilitating collaboration.

## Explore performance capabilities

SQL Database in Fabric offers intelligent performance capabilities like monitoring, and automatic index creation and tuning. 

### Monitor with performance dashboard

The Performance Dashboard in Fabric SQL Database simplifies the user experience by removing the complexities of monitoring and operation. It allows users to fully use the SQL database engine's capabilities, catering to various workloads in Fabric. 

The dashboard offers different levels of metrics visibility to accommodate users with varying SQL expertise. Beginners can access basic query performance metrics, while intermediate and advanced users can view more detailed information. 

You can access the performance dashboard by navigating through artifacts in the Fabric portal workspace, and then selecting the three dots icon, and then select **Open performance summary**.

Alternatively, you can access the home toolbar in the **Query Editor** window, and select **Performance summary**.

:::image type="content" source="../media/2-performance.png" alt-text="Screenshot showing the performance dashboard option in a query editor in Microsoft Fabric." lightbox="../media/2-performance.png":::

The performance dashboard helps users understand their database performance and receive alerts for any issues. It's designed to assist application developers in detecting and resolving performance bottlenecks early, ensuring an intuitive and efficient user experience.

### Explore automatic tuning

Automatic tuning is a built-in capability that applies machine learning to optimize your query performance. It automatically identifies tuning opportunities and implements them to enhance your database's efficiency.

In SQL database in Fabric, indexes are managed dynamically, with a graph showing the count of created, dropped, and reverted indexes over time, and a table listing the indexes created by the tool, including details like schema name, table name, index name, status, key columns, included columns, and creation and drop dates.

You can monitor automatic indexing on the **Automatic index** tab in the performance dashboard. 
