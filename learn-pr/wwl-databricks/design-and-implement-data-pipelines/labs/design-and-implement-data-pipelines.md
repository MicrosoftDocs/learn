# Lab: Design and Implement Data Pipelines in Azure Databricks

In this hands-on lab, you build data pipelines using Azure Databricks. You create both notebook-based pipelines and Lakeflow Declarative Pipelines, implement the medallion architecture, configure task dependencies, add error handling, and apply data quality expectations.

## Objectives

By the end of this lab, you will be able to:

- Create sample datasets following the medallion architecture (bronze, silver, gold layers)
- Build a notebook-based pipeline with task dependencies in Lakeflow Jobs
- Design task execution patterns including serial and parallel processing
- Implement error handling strategies in notebooks
- Create a Lakeflow Declarative Pipeline with streaming tables and materialized views
- Apply data quality expectations to validate data integrity
- Configure job parameters and conditional task flows

## Prerequisites

- Access to an Azure Databricks Premium workspace
- Basic understanding of SQL and Python
- Familiarity with data engineering concepts

## Estimated duration

30-45 minutes

---

## Exercise 1: Set up the environment and create sample data

In this exercise, you create a schema and sample datasets that simulate a retail sales scenario. This data serves as the foundation for all subsequent exercises.

### Task 1: Create a new notebook for setup

1. In your Azure Databricks workspace, select **Workspace** in the sidebar.

2. Navigate to your user folder and select **Create** > **Notebook**.

3. Name the notebook `01_setup_environment` and select **Python** as the default language.

4. For **Compute**, select a serverless compute option if available, or attach to an existing cluster.

### Task 2: Create the schema and bronze layer tables

The bronze layer stores raw data in its original form. This preserves the source data for auditing and reprocessing if needed.

1. In the first cell of your notebook, run the following code to create a schema for this lab:

    ```python
    # Create a dedicated schema for this lab
    schema_name = "pipeline_lab"
    
    spark.sql(f"CREATE SCHEMA IF NOT EXISTS {schema_name}")
    spark.sql(f"USE {schema_name}")
    
    print(f"Schema '{schema_name}' created and selected.")
    ```

    **Expected output:**
    ```
    Schema 'pipeline_lab' created and selected.
    ```

2. In a new cell, create the bronze layer tables with raw customer and order data:

    ```python
    from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType, DateType
    from datetime import date
    
    # Define customer data (simulating raw ingested data)
    customers_data = [
        (1, "Alice Johnson", "alice@email.com", "US-East", "2026-01-15"),
        (2, "Bob Smith", "bob@email.com", "US-West", "2026-01-16"),
        (3, "Carlos Garcia", "carlos@email.com", "EU-Central", "2026-01-17"),
        (4, "Diana Chen", None, "US-East", "2026-01-18"),  # Missing email
        (5, "Eve Wilson", "eve@email.com", "US-West", "2026-01-19"),
        (6, "Frank Brown", "invalid-email", "EU-Central", "2026-01-20"),  # Invalid email
        (7, "Grace Lee", "grace@email.com", "US-East", "2026-01-21"),
        (8, None, "unknown@email.com", "US-West", "2026-01-22"),  # Missing name
    ]
    
    customers_schema = StructType([
        StructField("customer_id", IntegerType(), False),
        StructField("customer_name", StringType(), True),
        StructField("email", StringType(), True),
        StructField("region", StringType(), True),
        StructField("signup_date", StringType(), True)
    ])
    
    customers_bronze_df = spark.createDataFrame(customers_data, customers_schema)
    customers_bronze_df.write.mode("overwrite").saveAsTable("customers_bronze")
    
    print("Created customers_bronze table with", customers_bronze_df.count(), "records")
    customers_bronze_df.show()
    ```

    **Expected output:**
    ```
    Created customers_bronze table with 8 records
    +-----------+--------------+------------------+----------+-----------+
    |customer_id| customer_name|             email|    region|signup_date|
    +-----------+--------------+------------------+----------+-----------+
    |          1| Alice Johnson|   alice@email.com|   US-East| 2026-01-15|
    |          2|     Bob Smith|     bob@email.com|   US-West| 2026-01-16|
    |          3| Carlos Garcia|  carlos@email.com|EU-Central| 2026-01-17|
    |          4|    Diana Chen|              null|   US-East| 2026-01-18|
    |          5|    Eve Wilson|     eve@email.com|   US-West| 2026-01-19|
    |          6|   Frank Brown|     invalid-email|EU-Central| 2026-01-20|
    |          7|     Grace Lee|   grace@email.com|   US-East| 2026-01-21|
    |          8|          null|unknown@email.com |   US-West| 2026-01-22|
    +-----------+--------------+------------------+----------+-----------+
    ```

3. In a new cell, create the orders bronze table:

    ```python
    # Define order data (simulating raw ingested data)
    orders_data = [
        (101, 1, "2026-02-01", 150.00, "completed"),
        (102, 2, "2026-02-01", 89.50, "completed"),
        (103, 1, "2026-02-02", -25.00, "completed"),  # Negative amount (invalid)
        (104, 3, "2026-02-02", 200.00, "completed"),
        (105, 2, "2026-02-03", 75.25, "pending"),
        (106, 4, "2026-02-03", 320.00, "completed"),
        (107, 5, "2026-02-04", 0.00, "cancelled"),  # Zero amount
        (108, 1, "2026-02-04", 450.00, "completed"),
        (109, 3, "2026-02-05", 125.75, "completed"),
        (110, 99, "2026-02-05", 50.00, "completed"),  # Non-existent customer
        (111, 6, "2026-02-06", 180.00, "completed"),
        (112, 7, "2026-02-06", 95.00, "completed"),
    ]
    
    orders_schema = StructType([
        StructField("order_id", IntegerType(), False),
        StructField("customer_id", IntegerType(), True),
        StructField("order_date", StringType(), True),
        StructField("amount", DoubleType(), True),
        StructField("status", StringType(), True)
    ])
    
    orders_bronze_df = spark.createDataFrame(orders_data, orders_schema)
    orders_bronze_df.write.mode("overwrite").saveAsTable("orders_bronze")
    
    print("Created orders_bronze table with", orders_bronze_df.count(), "records")
    orders_bronze_df.show()
    ```

    **Expected output:**
    ```
    Created orders_bronze table with 12 records
    +--------+-----------+----------+------+---------+
    |order_id|customer_id|order_date|amount|   status|
    +--------+-----------+----------+------+---------+
    |     101|          1|2026-02-01| 150.0|completed|
    |     102|          2|2026-02-01|  89.5|completed|
    |     103|          1|2026-02-02| -25.0|completed|
    |     104|          3|2026-02-02| 200.0|completed|
    ...
    +--------+-----------+----------+------+---------+
    ```

4. Verify your bronze layer tables were created by running:

    ```python
    # List all tables in the schema
    spark.sql("SHOW TABLES").show()
    ```

    **Expected output:**
    ```
    +------------+----------------+-----------+
    |   namespace|       tableName|isTemporary|
    +------------+----------------+-----------+
    |pipeline_lab|customers_bronze|      false|
    |pipeline_lab|  orders_bronze|      false|
    +------------+----------------+-----------+
    ```

---

## Exercise 2: Build notebook-based pipeline tasks

In this exercise, you create individual notebooks that represent different stages of your data pipeline. Each notebook performs a specific task: cleaning customers, cleaning orders, and generating reports.

### Task 1: Create the customer cleaning notebook

The silver layer cleans and validates data. This notebook transforms raw customer data by handling null values and applying data quality rules.

1. Create a new notebook named `02_clean_customers` with Python as the default language.

2. Add the following code to accept parameters and process customer data:

    ```python
    # This notebook cleans customer data from bronze to silver layer
    # It accepts a parameter to specify the schema name
    
    # Create widget for parameter - this allows the notebook to receive input from a job
    dbutils.widgets.text("schema_name", "pipeline_lab", "Schema Name")
    schema_name = dbutils.widgets.get("schema_name")
    
    print(f"Processing customers in schema: {schema_name}")
    spark.sql(f"USE {schema_name}")
    ```

3. In a new cell, implement the cleaning logic with error handling:

    ```python
    from pyspark.sql.functions import col, when, regexp_extract, to_date
    from pyspark.errors import PySparkException
    
    try:
        # Read bronze data
        customers_bronze = spark.read.table("customers_bronze")
        initial_count = customers_bronze.count()
        print(f"Read {initial_count} records from customers_bronze")
        
        # Clean and validate customer data
        customers_silver = (
            customers_bronze
            # Filter out records with null customer_name (data quality rule)
            .filter(col("customer_name").isNotNull())
            # Validate email format using regex
            .withColumn(
                "email_valid",
                col("email").rlike("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")
            )
            # Convert signup_date to proper date type
            .withColumn("signup_date", to_date(col("signup_date")))
            # Add a cleaned timestamp
            .withColumn("processed_at", current_timestamp())
        )
        
        # Count records that passed validation
        valid_count = customers_silver.count()
        invalid_count = initial_count - valid_count
        
        print(f"Valid records: {valid_count}")
        print(f"Dropped records (null name): {invalid_count}")
        
        # Show email validation results
        customers_silver.select("customer_id", "customer_name", "email", "email_valid").show()
        
    except PySparkException as e:
        print(f"Error processing customer data: {e}")
        dbutils.notebook.exit(f"FAILED: {str(e)}")
    ```

    **Expected output:**
    ```
    Read 8 records from customers_bronze
    Valid records: 7
    Dropped records (null name): 1
    +-----------+--------------+------------------+-----------+
    |customer_id| customer_name|             email|email_valid|
    +-----------+--------------+------------------+-----------+
    |          1| Alice Johnson|   alice@email.com|       true|
    |          2|     Bob Smith|     bob@email.com|       true|
    |          3| Carlos Garcia|  carlos@email.com|       true|
    |          4|    Diana Chen|              null|      false|
    |          5|    Eve Wilson|     eve@email.com|       true|
    |          6|   Frank Brown|     invalid-email|      false|
    |          7|     Grace Lee|   grace@email.com|       true|
    +-----------+--------------+------------------+-----------+
    ```

4. Add a final cell to save the cleaned data and signal completion:

    ```python
    from pyspark.sql.functions import current_timestamp
    
    try:
        # Add processed timestamp and write to silver table
        customers_silver_final = customers_silver.withColumn("processed_at", current_timestamp())
        customers_silver_final.write.mode("overwrite").saveAsTable("customers_silver")
        
        final_count = customers_silver_final.count()
        print(f"Successfully wrote {final_count} records to customers_silver")
        
        # Signal success to the calling job
        dbutils.notebook.exit(f"SUCCESS: Processed {final_count} customer records")
        
    except Exception as e:
        dbutils.notebook.exit(f"FAILED: {str(e)}")
    ```

### Task 2: Create the orders cleaning notebook

1. Create a new notebook named `03_clean_orders` with Python as the default language.

2. Add the parameter handling and import statements:

    ```python
    # This notebook cleans order data from bronze to silver layer
    
    dbutils.widgets.text("schema_name", "pipeline_lab", "Schema Name")
    schema_name = dbutils.widgets.get("schema_name")
    
    print(f"Processing orders in schema: {schema_name}")
    spark.sql(f"USE {schema_name}")
    ```

3. Add the cleaning logic with data quality checks:

    ```python
    from pyspark.sql.functions import col, to_date, current_timestamp
    from pyspark.errors import PySparkException
    
    try:
        # Read bronze data
        orders_bronze = spark.read.table("orders_bronze")
        initial_count = orders_bronze.count()
        print(f"Read {initial_count} records from orders_bronze")
        
        # Clean and validate order data
        orders_silver = (
            orders_bronze
            # Filter out orders with non-positive amounts
            .filter(col("amount") > 0)
            # Convert order_date to proper date type
            .withColumn("order_date", to_date(col("order_date")))
            # Add processed timestamp
            .withColumn("processed_at", current_timestamp())
        )
        
        valid_count = orders_silver.count()
        dropped_count = initial_count - valid_count
        
        print(f"Valid records: {valid_count}")
        print(f"Dropped records (invalid amount): {dropped_count}")
        
        # Show the cleaned data
        orders_silver.show()
        
    except PySparkException as e:
        print(f"Error processing order data: {e}")
        dbutils.notebook.exit(f"FAILED: {str(e)}")
    ```

    **Expected output:**
    ```
    Read 12 records from orders_bronze
    Valid records: 10
    Dropped records (invalid amount): 2
    +--------+-----------+----------+------+---------+--------------------+
    |order_id|customer_id|order_date|amount|   status|        processed_at|
    +--------+-----------+----------+------+---------+--------------------+
    |     101|          1|2026-02-01| 150.0|completed|2026-...|
    |     102|          2|2026-02-01|  89.5|completed|2026-...|
    ...
    +--------+-----------+----------+------+---------+--------------------+
    ```

4. Add the final cell to save and signal completion:

    ```python
    try:
        orders_silver.write.mode("overwrite").saveAsTable("orders_silver")
        final_count = orders_silver.count()
        print(f"Successfully wrote {final_count} records to orders_silver")
        dbutils.notebook.exit(f"SUCCESS: Processed {final_count} order records")
    except Exception as e:
        dbutils.notebook.exit(f"FAILED: {str(e)}")
    ```

### Task 3: Create the gold layer aggregation notebook

The gold layer creates business-ready datasets. This notebook joins customer and order data to create aggregated views for reporting.

1. Create a new notebook named `04_create_gold_layer` with Python as the default language.

2. Add parameter handling:

    ```python
    # This notebook creates gold layer aggregations from silver data
    
    dbutils.widgets.text("schema_name", "pipeline_lab", "Schema Name")
    schema_name = dbutils.widgets.get("schema_name")
    
    print(f"Creating gold layer in schema: {schema_name}")
    spark.sql(f"USE {schema_name}")
    ```

3. Add the transformation logic to create the gold layer:

    ```python
    from pyspark.sql.functions import col, sum, count, avg, current_timestamp
    
    try:
        # Read silver layer tables
        customers = spark.read.table("customers_silver")
        orders = spark.read.table("orders_silver")
        
        print(f"Read {customers.count()} customers and {orders.count()} orders from silver layer")
        
        # Create customer order summary (gold layer)
        # This joins customers with their orders and calculates aggregates
        customer_summary = (
            customers
            .join(orders, on="customer_id", how="inner")
            .groupBy(
                customers["customer_id"],
                customers["customer_name"],
                customers["region"],
                customers["email_valid"]
            )
            .agg(
                count("order_id").alias("total_orders"),
                sum("amount").alias("total_spent"),
                avg("amount").alias("avg_order_value")
            )
            .withColumn("created_at", current_timestamp())
        )
        
        print("Customer Summary (Gold Layer):")
        customer_summary.show()
        
    except Exception as e:
        print(f"Error creating gold layer: {e}")
        dbutils.notebook.exit(f"FAILED: {str(e)}")
    ```

    **Expected output:**
    ```
    Read 7 customers and 10 orders from silver layer
    Customer Summary (Gold Layer):
    +-----------+--------------+----------+-----------+------------+-----------+---------------+-------------------+
    |customer_id| customer_name|    region|email_valid|total_orders|total_spent|avg_order_value|         created_at|
    +-----------+--------------+----------+-----------+------------+-----------+---------------+-------------------+
    |          1| Alice Johnson|   US-East|       true|           2|      600.0|          300.0|2026-...|
    |          2|     Bob Smith|   US-West|       true|           2|     164.75|         82.375|2026-...|
    |          3| Carlos Garcia|EU-Central|       true|           2|     325.75|        162.875|2026-...|
    ...
    +-----------+--------------+----------+-----------+------------+-----------+---------------+-------------------+
    ```

4. Add regional aggregation and final save:

    ```python
    try:
        # Create regional sales summary
        regional_summary = (
            customers
            .join(orders, on="customer_id", how="inner")
            .groupBy("region")
            .agg(
                count("order_id").alias("total_orders"),
                sum("amount").alias("total_revenue"),
                avg("amount").alias("avg_order_value"),
                countDistinct("customer_id").alias("unique_customers")
            )
            .withColumn("created_at", current_timestamp())
        )
        
        print("Regional Sales Summary (Gold Layer):")
        regional_summary.show()
        
        # Save gold layer tables
        customer_summary.write.mode("overwrite").saveAsTable("gold_customer_summary")
        regional_summary.write.mode("overwrite").saveAsTable("gold_regional_summary")
        
        print("Gold layer tables created successfully")
        dbutils.notebook.exit(f"SUCCESS: Created gold layer with {customer_summary.count()} customer summaries")
        
    except Exception as e:
        dbutils.notebook.exit(f"FAILED: {str(e)}")
    ```

---

## Exercise 3: Create a Lakeflow Job with task dependencies

In this exercise, you create a Lakeflow Job that orchestrates the notebooks you created in Exercise 2. You configure task dependencies to create a proper execution order following the medallion architecture.

### Task 1: Create a new job

1. In your Azure Databricks workspace, select **Jobs & Pipelines** in the sidebar.

2. Select **Create** > **Job**.

3. You are now in the job configuration view with an empty task.

### Task 2: Add the customer cleaning task

1. In the task configuration panel, enter the following details:
   - **Task name**: `clean_customers`
   - **Type**: Notebook
   - **Source**: Workspace
   - **Path**: Browse to your `02_clean_customers` notebook

2. Under **Parameters**, select **Add** and configure:
   - **Key**: `schema_name`
   - **Value**: `pipeline_lab`

3. For **Compute**, select **Serverless** if available, otherwise select an appropriate cluster.

4. Select **Create task**.

### Task 3: Add the orders cleaning task

Now add a second task that runs in parallel with the customer cleaning task. Since these tasks don't depend on each other, they can execute simultaneously.

1. Select **Add task** (the plus icon or button) in the job DAG.

2. Configure the new task:
   - **Task name**: `clean_orders`
   - **Type**: Notebook
   - **Source**: Workspace
   - **Path**: Browse to your `03_clean_orders` notebook

3. Under **Parameters**, add:
   - **Key**: `schema_name`
   - **Value**: `pipeline_lab`

4. **Important**: In the **Depends on** field, remove any default dependency. This task should have no dependencies, allowing it to run in parallel with `clean_customers`.

5. Select **Save task**.

Observe the DAG visualization. Both `clean_customers` and `clean_orders` should appear as independent starting tasks, indicating parallel execution.

### Task 4: Add the gold layer task with dependencies

1. Select the `clean_customers` task in the DAG view.

2. Select **Add task** to create a new task that depends on the selected task.

3. Configure the task:
   - **Task name**: `create_gold_layer`
   - **Type**: Notebook
   - **Source**: Workspace
   - **Path**: Browse to your `04_create_gold_layer` notebook

4. Under **Parameters**, add:
   - **Key**: `schema_name`
   - **Value**: `pipeline_lab`

5. In the **Depends on** field, ensure both `clean_customers` AND `clean_orders` are selected. This configures the gold layer task to wait for both silver layer tasks to complete.

6. Select **Save task**.

Your DAG should now show:
```
clean_customers ─┐
                 ├─→ create_gold_layer
clean_orders ────┘
```

### Task 5: Name and run the job

1. At the top of the job configuration, select the job name (likely "Untitled") and rename it to `Sales_Pipeline_Lab`.

2. Select **Run now** to execute the job.

3. Monitor the job execution in the **Runs** tab. Observe:
   - `clean_customers` and `clean_orders` start simultaneously (parallel execution)
   - `create_gold_layer` starts only after both preceding tasks complete
   - Each task shows its execution status and duration

4. Once the job completes, select a task to view its output. The task output shows the value passed to `dbutils.notebook.exit()`.

---

## Exercise 4: Add error handling and conditional logic

In this exercise, you enhance your pipeline with error handling capabilities including retry policies, timeouts, and a conditional notification task.

### Task 1: Configure retry policies

Retry policies help your pipeline recover from transient failures like temporary network issues or resource constraints.

1. Navigate to your `Sales_Pipeline_Lab` job.

2. Select the `clean_customers` task.

3. Expand the **Advanced options** section (or look for the retry configuration).

4. Configure the retry policy:
   - **Retries**: 2 (the task will be attempted up to 3 times total)
   - **Retry interval**: 60 seconds (wait time between retries)

5. Select **Save task**.

6. Repeat the same retry configuration for the `clean_orders` and `create_gold_layer` tasks.

### Task 2: Configure timeouts

Timeouts prevent tasks from running indefinitely and consuming resources.

1. Select the `create_gold_layer` task.

2. In the **Advanced options** section, locate the timeout settings.

3. Configure:
   - **Expected duration**: 300 seconds (5 minutes) - triggers a warning if exceeded
   - **Maximum duration**: 600 seconds (10 minutes) - terminates the task if exceeded

4. Select **Save task**.

### Task 3: Add a notification task for failures

Create a task that runs only when the pipeline encounters failures. This demonstrates conditional task dependencies.

1. Create a new notebook named `05_notify_failure` with the following content:

    ```python
    # This notebook handles pipeline failure notifications
    # In a real scenario, this would send alerts via email, Slack, or other channels
    
    dbutils.widgets.text("failed_task", "unknown", "Failed Task Name")
    failed_task = dbutils.widgets.get("failed_task")
    
    print("=" * 50)
    print("PIPELINE FAILURE NOTIFICATION")
    print("=" * 50)
    print(f"A task in the pipeline has failed: {failed_task}")
    print("Review the job run logs for details.")
    print("=" * 50)
    
    # Log the failure for monitoring systems
    # In production, you would integrate with your alerting system here
    
    dbutils.notebook.exit("Failure notification sent")
    ```

2. In your job, add a new task:
   - **Task name**: `notify_on_failure`
   - **Type**: Notebook
   - **Path**: Your `05_notify_failure` notebook

3. In the **Depends on** field, select `create_gold_layer`.

4. Configure the **Run if** condition by selecting **At least one failed** from the dropdown. This ensures the notification task only runs if the upstream task fails.

5. Select **Save task**.

Your complete DAG now includes error handling paths:
```
clean_customers ─┐
                 ├─→ create_gold_layer ─→ notify_on_failure (runs if failed)
clean_orders ────┘
```

---

## Exercise 5: Create a Lakeflow Declarative Pipeline

In this exercise, you create a declarative pipeline that demonstrates the Lakeflow Declarative Pipelines approach. This pipeline uses SQL to define streaming tables and materialized views with data quality expectations.

### Task 1: Create the pipeline

1. In your Azure Databricks workspace, select **Jobs & Pipelines** in the sidebar.

2. Select **Create** > **ETL pipeline**.

3. Name the pipeline `Sales_Declarative_Pipeline`.

4. For the **Catalog**, select your catalog (typically `hive_metastore` or your Unity Catalog).

5. For the **Target schema**, enter `pipeline_lab_declarative`.

6. Leave other settings at their defaults and select **Create**.

### Task 2: Create the bronze layer streaming table definition

The Lakeflow Pipelines Editor opens. You'll now create SQL definitions for your pipeline tables.

1. In the pipeline editor, create a new SQL file or use the provided template file.

2. Add the following SQL to define the bronze layer. This simulates streaming ingestion:

    ```sql
    -- Bronze layer: Raw customer data
    -- In a real scenario, this would use Auto Loader to read from cloud storage
    -- For this lab, we create a streaming table from existing data
    
    CREATE OR REFRESH STREAMING TABLE customers_bronze_stream
    COMMENT "Raw customer data ingested from source"
    AS SELECT 
        customer_id,
        customer_name,
        email,
        region,
        signup_date,
        current_timestamp() as ingested_at
    FROM STREAM read_files(
        '/databricks-datasets/retail-org/customers/',
        format => 'csv',
        header => true
    );
    ```

    > **Note**: Since we're using sample data, we'll use a different approach. Replace the above with this alternative that works with our existing tables:

    ```sql
    -- Bronze layer: Simulated streaming table from existing data
    CREATE OR REFRESH MATERIALIZED VIEW customers_bronze_dlt
    COMMENT "Raw customer data for declarative pipeline"
    AS SELECT 
        customer_id,
        customer_name,
        email,
        region,
        signup_date,
        current_timestamp() as ingested_at
    FROM pipeline_lab.customers_bronze;
    ```

3. Add the orders bronze definition:

    ```sql
    -- Bronze layer: Raw orders data
    CREATE OR REFRESH MATERIALIZED VIEW orders_bronze_dlt
    COMMENT "Raw order data for declarative pipeline"
    AS SELECT 
        order_id,
        customer_id,
        order_date,
        amount,
        status,
        current_timestamp() as ingested_at
    FROM pipeline_lab.orders_bronze;
    ```

### Task 3: Create silver layer with data quality expectations

Now add the silver layer definitions with EXPECT constraints for data quality validation.

1. Add the following SQL for the cleaned customers table:

    ```sql
    -- Silver layer: Cleaned customer data with data quality expectations
    CREATE OR REFRESH MATERIALIZED VIEW customers_silver_dlt (
        -- Define expectations: warn but keep records
        CONSTRAINT valid_customer_name EXPECT (customer_name IS NOT NULL) ON VIOLATION DROP ROW,
        CONSTRAINT valid_region EXPECT (region IS NOT NULL)
    )
    COMMENT "Cleaned customer data with quality rules applied"
    AS SELECT
        customer_id,
        customer_name,
        email,
        region,
        CASE 
            WHEN email RLIKE '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$' 
            THEN true 
            ELSE false 
        END as email_valid,
        TO_DATE(signup_date) as signup_date,
        current_timestamp() as processed_at
    FROM customers_bronze_dlt;
    ```

    This definition includes two expectations:
    - `valid_customer_name`: Drops rows where customer_name is null
    - `valid_region`: Warns (but keeps) rows where region is null

2. Add the cleaned orders table with expectations:

    ```sql
    -- Silver layer: Cleaned orders with data quality expectations
    CREATE OR REFRESH MATERIALIZED VIEW orders_silver_dlt (
        -- Critical constraint: fail if amount is negative
        CONSTRAINT positive_amount EXPECT (amount > 0) ON VIOLATION DROP ROW,
        -- Warning constraint: log but allow null customer_id
        CONSTRAINT valid_customer EXPECT (customer_id IS NOT NULL),
        -- Critical constraint for completed orders
        CONSTRAINT valid_status EXPECT (status IN ('completed', 'pending', 'cancelled'))
    )
    COMMENT "Cleaned order data with quality rules"
    AS SELECT
        order_id,
        customer_id,
        TO_DATE(order_date) as order_date,
        amount,
        status,
        current_timestamp() as processed_at
    FROM orders_bronze_dlt;
    ```

### Task 4: Create gold layer aggregations

Add the business-ready aggregation views:

1. Add the customer summary gold view:

    ```sql
    -- Gold layer: Customer order summary
    CREATE OR REFRESH MATERIALIZED VIEW gold_customer_summary_dlt
    COMMENT "Customer-level aggregations for reporting"
    AS SELECT
        c.customer_id,
        c.customer_name,
        c.region,
        c.email_valid,
        COUNT(o.order_id) as total_orders,
        SUM(o.amount) as total_spent,
        AVG(o.amount) as avg_order_value,
        current_timestamp() as created_at
    FROM customers_silver_dlt c
    INNER JOIN orders_silver_dlt o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.region, c.email_valid;
    ```

2. Add the regional summary gold view:

    ```sql
    -- Gold layer: Regional sales summary
    CREATE OR REFRESH MATERIALIZED VIEW gold_regional_summary_dlt
    COMMENT "Regional aggregations for executive reporting"
    AS SELECT
        c.region,
        COUNT(DISTINCT c.customer_id) as unique_customers,
        COUNT(o.order_id) as total_orders,
        SUM(o.amount) as total_revenue,
        AVG(o.amount) as avg_order_value,
        current_timestamp() as created_at
    FROM customers_silver_dlt c
    INNER JOIN orders_silver_dlt o ON c.customer_id = o.customer_id
    GROUP BY c.region;
    ```

### Task 5: Validate and run the pipeline

1. Select **Dry run** to validate your pipeline code without processing data. This checks for syntax errors and missing dependencies.

2. Review the DAG visualization that appears. The pipeline should show:
   - Two bronze materialized views at the top
   - Two silver materialized views depending on the bronze views
   - Two gold materialized views depending on the silver views

3. If validation succeeds, select **Start** to run the pipeline.

4. Monitor the pipeline execution:
   - Observe the dependency-based execution order
   - View data quality metrics in the **Data quality** tab
   - Check record counts at each layer

5. Once complete, examine the data quality results:
   - Navigate to the **Data quality** tab
   - Review how many records were dropped due to constraint violations
   - See warning counts for soft constraints

### Task 6: Preview the data

1. In the pipeline DAG, select the `gold_customer_summary_dlt` node.

2. Select **Preview data** to see sample output from the materialized view.

3. Verify the aggregations match your expectations.

---

## Exercise 6: Compare approaches and clean up

In this final exercise, you compare the results from both pipeline approaches and clean up the resources created during the lab.

### Task 1: Compare pipeline results

1. Create a new notebook named `06_compare_results` with SQL as the default language.

2. Compare the notebook pipeline results:

    ```sql
    -- Review notebook-based pipeline results
    USE pipeline_lab;
    
    SELECT 'Notebook Pipeline' as source, 'customers_silver' as table_name, COUNT(*) as record_count 
    FROM customers_silver
    UNION ALL
    SELECT 'Notebook Pipeline', 'orders_silver', COUNT(*) FROM orders_silver
    UNION ALL
    SELECT 'Notebook Pipeline', 'gold_customer_summary', COUNT(*) FROM gold_customer_summary
    UNION ALL
    SELECT 'Notebook Pipeline', 'gold_regional_summary', COUNT(*) FROM gold_regional_summary;
    ```

3. Compare with declarative pipeline results (if the pipeline completed successfully):

    ```sql
    -- Review declarative pipeline results
    USE pipeline_lab_declarative;
    
    SELECT 'Declarative Pipeline' as source, 'customers_silver_dlt' as table_name, COUNT(*) as record_count 
    FROM customers_silver_dlt
    UNION ALL
    SELECT 'Declarative Pipeline', 'orders_silver_dlt', COUNT(*) FROM orders_silver_dlt
    UNION ALL
    SELECT 'Declarative Pipeline', 'gold_customer_summary_dlt', COUNT(*) FROM gold_customer_summary_dlt
    UNION ALL
    SELECT 'Declarative Pipeline', 'gold_regional_summary_dlt', COUNT(*) FROM gold_regional_summary_dlt;
    ```

4. Add a Python cell to summarize the comparison:

    ```python
    # Summary comparison of both approaches
    print("=" * 60)
    print("PIPELINE APPROACH COMPARISON")
    print("=" * 60)
    print()
    print("NOTEBOOK-BASED PIPELINE:")
    print("  ✓ Full control over execution flow")
    print("  ✓ Custom error handling with try-except")
    print("  ✓ Flexible for complex business logic")
    print("  ✓ Parameters passed via dbutils.widgets")
    print("  - Requires manual orchestration")
    print("  - Data quality checks coded manually")
    print()
    print("LAKEFLOW DECLARATIVE PIPELINE:")
    print("  ✓ Automatic dependency management")
    print("  ✓ Built-in data quality expectations")
    print("  ✓ Visual DAG and monitoring")
    print("  ✓ Automatic retry and recovery")
    print("  - Less flexibility for complex logic")
    print("  - SQL-centric approach")
    print()
    print("RECOMMENDATION:")
    print("  Use notebooks for: Prototyping, complex transformations, ML pipelines")
    print("  Use declarative for: Production ETL, standardized patterns, data quality")
    print("=" * 60)
    ```

### Task 2: Clean up resources

To leave the environment clean, remove all resources created during this lab.

1. Create a new notebook named `07_cleanup` with Python as the default language.

2. Run the following code to remove all lab resources:

    ```python
    # Clean up all resources created in this lab
    
    print("Starting cleanup...")
    
    # Drop the notebook pipeline schema and all its tables
    try:
        spark.sql("DROP SCHEMA IF EXISTS pipeline_lab CASCADE")
        print("✓ Dropped schema: pipeline_lab")
    except Exception as e:
        print(f"✗ Error dropping pipeline_lab: {e}")
    
    # Drop the declarative pipeline schema (if created)
    try:
        spark.sql("DROP SCHEMA IF EXISTS pipeline_lab_declarative CASCADE")
        print("✓ Dropped schema: pipeline_lab_declarative")
    except Exception as e:
        print(f"✗ Error dropping pipeline_lab_declarative: {e}")
    
    print()
    print("Cleanup complete!")
    print()
    print("Manual cleanup required:")
    print("  1. Delete the 'Sales_Pipeline_Lab' job from Jobs & Pipelines")
    print("  2. Delete the 'Sales_Declarative_Pipeline' from Jobs & Pipelines")
    print("  3. Delete the notebooks created during this lab (optional)")
    ```

3. Manually delete the jobs and pipeline:
   - Navigate to **Jobs & Pipelines**
   - Find and delete `Sales_Pipeline_Lab`
   - Find and delete `Sales_Declarative_Pipeline`

4. Optionally, delete the notebooks created during this lab:
   - `01_setup_environment`
   - `02_clean_customers`
   - `03_clean_orders`
   - `04_create_gold_layer`
   - `05_notify_failure`
   - `06_compare_results`
   - `07_cleanup`

---

## Summary

In this lab, you completed the following tasks:

- **Created sample datasets** following the medallion architecture with bronze (raw), silver (cleaned), and gold (aggregated) layers

- **Built a notebook-based pipeline** with:
  - Individual notebooks for each processing stage
  - Parameter passing using dbutils.widgets
  - Error handling with try-except blocks
  - Success/failure signaling with dbutils.notebook.exit()

- **Created a Lakeflow Job** with:
  - Task dependencies for execution order
  - Parallel execution of independent tasks
  - Retry policies and timeouts
  - Conditional task flows for failure handling

- **Created a Lakeflow Declarative Pipeline** with:
  - Materialized views for each layer
  - Data quality expectations (EXPECT constraints)
  - ON VIOLATION DROP ROW for critical constraints
  - Automatic dependency management

- **Compared both approaches** to understand when to use notebooks versus declarative pipelines

These skills enable you to design and implement robust data pipelines in Azure Databricks that handle errors gracefully, enforce data quality, and follow best practices for production workloads.
