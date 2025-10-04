<!-- markdownlint-disable MD041 -->
In this exercise, you'll get hands-on experience with Unity Catalog by creating data objects and exploring the metastore structure. You'll learn to populate the metastore using the three-level namespace concept and navigate through catalogs, schemas, tables, views, and user-defined functions using both SQL commands and the Catalog Explorer interface.

## Provision an Azure Databricks workspace

> **Note**: If you already have an Azure Databricks workspace, you can skip this task and use your existing workspace.

This exercise requires an Azure Databricks workspace in a subscription with sufficient quota for a single-node cluster and Unity Catalog enabled.

1. In the [Azure portal](https://portal.azure.com), create a new **Azure Databricks** resource with the following settings:
   - **Subscription**: *Your Azure subscription*
   - **Resource group**: *Create a new resource group*
   - **Region**: *Any available region*
   - **Name**: *A unique name for your workspace*
   - **Pricing tier**: *Premium (required for Unity Catalog)*

2. When deployment is complete, go to your Azure Databricks resource and select **Launch Workspace**.

## Create a cluster

Azure Databricks is a distributed processing platform that uses Apache Spark *clusters* to process data in parallel on multiple nodes. Each cluster consists of a driver node to coordinate the work, and worker nodes to perform processing tasks. In this exercise, you'll create a *single-node* cluster to minimize the compute resources used in the lab environment (in which resources may be constrained). In a production environment, you'd typically create a cluster with multiple worker nodes.

> **Tip**: If you already have a cluster with a 13.3 LTS or higher runtime version in your Azure Databricks workspace, you can use it to complete this exercise and skip this procedure.

1. In the Azure Databricks workspace, in the sidebar on the left, select **(+) New** and then select **Cluster**.

2. In the **New Cluster** page, create a new cluster with the following settings:
    - **Cluster name**: *User Name's* cluster (the default cluster name)
    - **Policy**: Unrestricted
    - **Cluster mode**: Single Node
    - **Access mode**: Single user (*with your user account selected*)
    - **Databricks runtime version**: 13.3 LTS (Spark 3.4.1, Scala 2.12) or later
    - **Use Photon Acceleration**: Selected
    - **Node type**: Standard_D4ds_v5
    - **Terminate after** *20* **minutes of inactivity**

3. Wait for the cluster to be created. It may take a minute or two.

> **Note**: If your cluster fails to start, your subscription may have insufficient quota in the region where your Azure Databricks workspace is provisioned. See [CPU core limit prevents cluster creation](https://docs.microsoft.com/azure/databricks/kb/clusters/azure-core-limit) for details. If this happens, you can try deleting your workspace and creating a new one in a different region.

## Create a notebook

You'll run code that uses the Spark MLlib library to train a machine learning model, so the first step is to create a new notebook in your workspace.

1. In the sidebar, use the **(+) New** link to create a **Notebook**.

2. Change the default notebook name (**Untitled Notebook *[date]***) to **Unity Catalog Lab** and in the **Connect** drop-down list, select your cluster if it is not already selected. If the cluster is not running, it may take a minute or so to start.

## Task 1: Create and manage catalogs

In this task, you'll create a catalog and learn to work with the three-level namespace structure that Unity Catalog provides.

1. In the first cell of the notebook, enter the following code to create a new catalog:

    ```sql
    %sql
    -- Create a new catalog for this lab
    CREATE CATALOG IF NOT EXISTS unity_lab_catalog
    COMMENT 'Catalog for Unity Catalog lab exercises';
    ```

2. Run the cell using the **â–·** button to the left of the cell, or press **SHIFT + ENTER**.

3. Add a new cell and run the following code to set the catalog as your default:

    ```sql
    %sql
    -- Set the catalog as default for this session
    USE CATALOG unity_lab_catalog;
    ```

4. Add another cell to verify your current catalog:

    ```sql
    %sql
    -- Verify the current catalog
    SELECT CURRENT_CATALOG() as current_catalog;
    ```

5. Run the cell to confirm you're now using your new catalog.

## Task 2: Create and manage schemas

Now you'll create schemas (databases) within your catalog to organize your data objects.

1. Add a new cell and run the following code to create a schema:

    ```sql
    %sql
    -- Create a new schema within our catalog
    CREATE SCHEMA IF NOT EXISTS sales_data
    COMMENT 'Schema for sales-related data objects';
    ```

2. Add a new cell to set this schema as your default:

    ```sql
    %sql
    -- Set the schema as default for this session
    USE SCHEMA sales_data;
    ```

3. Add another cell to verify your current schema:

    ```sql
    %sql
    -- Verify current catalog and schema
    SELECT CURRENT_CATALOG() as current_catalog, CURRENT_SCHEMA() as current_schema;
    ```

## Task 3: Create and populate data objects

You'll now create tables and populate them with sample data to demonstrate the three-level namespace.

1. Add a new cell and run the following code to create a managed table:

    ```sql
    %sql
    -- Create a managed table with sample sales data
    CREATE TABLE IF NOT EXISTS customers (
        customer_id INT,
        customer_name STRING,
        email STRING,
        country STRING,
        registration_date DATE
    )
    COMMENT 'Customer information table';
    ```

2. Add a new cell to populate the table with sample data:

    ```sql
    %sql
    -- Insert sample customer data
    INSERT INTO customers VALUES
    (1, 'John Smith', 'john.smith@email.com', 'USA', '2023-01-15'),
    (2, 'Maria Garcia', 'maria.garcia@email.com', 'Spain', '2023-02-20'),
    (3, 'Chen Wei', 'chen.wei@email.com', 'China', '2023-03-10'),
    (4, 'Anna Mueller', 'anna.mueller@email.com', 'Germany', '2023-04-05'),
    (5, 'Ahmed Hassan', 'ahmed.hassan@email.com', 'Egypt', '2023-05-12');
    ```

3. Add a new cell to query the table using the three-level namespace:

    ```sql
    %sql
    -- Query the table using full three-level namespace
    SELECT * FROM unity_lab_catalog.sales_data.customers
    ORDER BY registration_date;
    ```

4. Add another cell to show that you can also query without the full namespace since you've set defaults:

    ```sql
    %sql
    -- Query using shortened namespace (catalog and schema are defaults)
    SELECT country, COUNT(*) as customer_count
    FROM customers
    GROUP BY country
    ORDER BY customer_count DESC;
    ```

## Task 4: Create and work with views

Views in Unity Catalog work similarly to traditional SQL views but benefit from the unified governance model.

1. Add a new cell to create a view:

    ```sql
    %sql
    -- Create a view that filters customers by region
    CREATE VIEW IF NOT EXISTS european_customers AS
    SELECT customer_id, customer_name, email, country, registration_date
    FROM customers
    WHERE country IN ('Spain', 'Germany')
    ORDER BY registration_date;
    ```

2. Add a new cell to query the view:

    ```sql
    %sql
    -- Query the view
    SELECT * FROM european_customers;
    ```

## Task 5: Create user-defined functions

Unity Catalog also supports user-defined functions (UDFs) that can be shared across your organization.

1. Add a new cell to create a SQL user-defined function:

    ```sql
    %sql
    -- Create a user-defined function to format customer display names
    CREATE FUNCTION IF NOT EXISTS format_customer_name(name STRING, country STRING)
    RETURNS STRING
    COMMENT 'Formats customer name with country suffix'
    RETURN CONCAT(name, ' (', country, ')');
    ```

2. Add a new cell to use the function in a query:

    ```sql
    %sql
    -- Use the user-defined function
    SELECT 
        customer_id,
        format_customer_name(customer_name, country) as formatted_name,
        email
    FROM customers
    ORDER BY customer_id;
    ```

## Task 6: Navigate the metastore with SQL commands

Unity Catalog provides powerful SQL commands to explore and understand your metastore structure.

1. Add a new cell to explore catalogs in your metastore:

    ```sql
    %sql
    -- Show all catalogs in the metastore
    SHOW CATALOGS;
    ```

2. Add a new cell to explore schemas in your catalog:

    ```sql
    %sql
    -- Show all schemas in the current catalog
    SHOW SCHEMAS IN unity_lab_catalog;
    ```

3. Add a new cell to explore tables and views in your schema:

    ```sql
    %sql
    -- Show all tables and views in the current schema
    SHOW TABLES IN unity_lab_catalog.sales_data;
    ```

4. Add a new cell to explore functions:

    ```sql
    %sql
    -- Show all functions in the current schema
    SHOW FUNCTIONS IN unity_lab_catalog.sales_data;
    ```

5. Add a new cell to get detailed information about a table:

    ```sql
    %sql
    -- Describe table structure and properties
    DESCRIBE TABLE EXTENDED unity_lab_catalog.sales_data.customers;
    ```

6. Add a new cell to get detailed information about a function:

    ```sql
    %sql
    -- Describe function details
    DESCRIBE FUNCTION unity_lab_catalog.sales_data.format_customer_name;
    ```

## Task 7: Explore system catalogs and information schema

Unity Catalog includes system catalogs that provide metadata about your entire metastore.

1. Add a new cell to explore the system catalog:

    ```sql
    %sql
    -- Query the system catalog to see information about catalogs
    SELECT catalog_name, catalog_owner, comment
    FROM system.information_schema.catalogs
    WHERE catalog_name = 'unity_lab_catalog';
    ```

2. Add a new cell to explore schema information:

    ```sql
    %sql
    -- Query schema information from information_schema
    SELECT schema_name, schema_owner, comment
    FROM system.information_schema.schemata
    WHERE catalog_name = 'unity_lab_catalog';
    ```

3. Add a new cell to explore table information:

    ```sql
    %sql
    -- Query table information from information_schema
    SELECT table_name, table_type, comment
    FROM system.information_schema.tables
    WHERE catalog_name = 'unity_lab_catalog' 
    AND schema_name = 'sales_data';
    ```

## Task 8: Use the Catalog Explorer interface

Unity Catalog also provides a graphical interface for exploring your metastore structure.

1. In the Azure Databricks workspace sidebar, select **Catalog**.

2. In the Catalog Explorer, expand your **unity_lab_catalog** to see the schema structure.

3. Expand the **sales_data** schema to see the tables, views, and functions you created.

4. Click on the **customers** table to see its details, including:
   - Schema information (columns and data types)
   - Sample data preview
   - Properties and comments
   - Permissions (if configured)

5. Click on the **european_customers** view to see how views are displayed differently from tables.

6. Click on the **format_customer_name** function to see function details and usage information.

7. Use the search functionality at the top of the Catalog Explorer to search for "customer" and see how Unity Catalog helps with data discovery.

## Task 9: Understand data lineage (optional)

If data lineage is available in your environment, you can explore how Unity Catalog tracks data relationships.

1. In the Catalog Explorer, select your **customers** table.

2. Look for a **Lineage** tab or section to see how data flows through your objects.

3. If lineage information is available, explore how Unity Catalog automatically tracks the relationship between your table, view, and function.

## Clean up resources

If you've finished exploring Unity Catalog, you can delete the resources you created to avoid unnecessary costs.

1. In the Azure Databricks workspace, in the **Compute** page, select your cluster and select **Delete** to delete it.

2. Optionally, delete the catalog and its contents:

    ```sql
    %sql
    -- Clean up the lab catalog (this will delete all objects within it)
    DROP CATALOG IF EXISTS unity_lab_catalog CASCADE;
    ```

3. Close the browser tab containing the Azure Databricks workspace. Then, in the Azure portal, delete the resource group you created for this exercise.

## Summary

In this exercise, you've gained hands-on experience with Unity Catalog by:

- Creating catalogs and schemas to organize your data
- Building tables, views, and user-defined functions using the three-level namespace
- Populating objects with sample data and querying them
- Using SQL commands (SHOW, DESCRIBE) to navigate and inspect metastore components
- Exploring the Catalog Explorer interface for visual metastore navigation
- Understanding system catalogs and information schema for metadata queries
- Learning about data lineage capabilities for governance and impact analysis

These skills form the foundation for implementing comprehensive data governance using Unity Catalog in Azure Databricks, enabling you to create secure, organized, and discoverable data assets that can be shared across your organization.

