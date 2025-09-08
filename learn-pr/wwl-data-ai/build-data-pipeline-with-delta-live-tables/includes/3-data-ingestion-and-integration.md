Data ingestion and integration form the foundational layer for effective data processing in Lakeflow Declarative Pipelines within Azure Databricks. This ensures that data from various sources is accurately and efficiently loaded into the system for further analysis and processing. 

Lakeflow Declarative Pipelines facilitates data ingestion and integration through:

- **Multi-source ingestion**: allows you to collect data from various sources.
- **Stream and batch data processing**: enables you to process data either continuously or in grouped intervals.
- **Schema management**: ensures that your data is well-structured and easy to manage.
- **Data quality and governance**: helps you maintain the integrity and compliance of your data
- **Pipeline automation and orchestration**: streamlines and controls the sequence of your data processing tasks
- **Integration with Azure ecosystem**: allows you to interact smoothly with various Azure tools and services
- **Performance optimization**: enhances your ability to process data quickly and effectively
- **Monitoring and lineage tracking**: helps you track the data's journey and monitor its movement through the system.

## Create a pipeline

First, you create an ETL pipeline in Lakeflow Declarative Pipelines. Lakeflow Declarative Pipelines creates pipelines by resolving dependencies defined in notebooks or files (called source code) using Lakeflow Declarative Pipelines syntax. Each source code file can contain only one language, but you can add multiple language-specific notebooks or files in the pipeline. 

In your workspace, you can create a new ETL Pipeline from the **Jobs & Pipelines** section in the sidebar. You should assign a **name** to the pipeline, configure a **notebook** or **files** that contain the source code, and set the **destination** storage location and schema. 

![Screenshot showing Databricks Create Pipeline option.](../media/create-pipeline.png)

## Load from an existing table

In your notebook, you can load data from any existing table in Databricks. You can transform the data using a query, or load the table for further processing in your pipeline.

```sql
CREATE OR REFRESH MATERIALIZED VIEW top_baby_names_2021
COMMENT "A table summarizing counts of the top baby names for New York for 2021."
AS SELECT
  First_Name,
  SUM(Count) AS Total_Count
FROM baby_names_prepared
WHERE Year_Of_Birth = 2021
GROUP BY First_Name
ORDER BY Total_Count DESC
```

## Load files from Databricks File System

You can also load data into a materialized view by reading files from the Databricks File System (DBFS), and then further transform it in your pipeline.

The following example command creates (or refreshes) a materialized view named raw_covid_data that contains COVID-19 case data, extracted from a CSV file stored in DBFS.

```sql
CREATE OR REFRESH MATERIALIZED VIEW raw_covid_data
COMMENT "COVID sample dataset. This data was ingested from the COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University."
AS
SELECT
 Last_Update,
 Country_Region,
 Confirmed,
 Deaths,
 Recovered
FROM read_files('dbfs:/delta_lab/covid_data.csv', format => 'csv', header => true)
```

## Manage data quality with pipeline expectations

Optionally, you can use expectations to apply quality constraints that validate data as it flows through ETL pipelines. Expectations provide greater insight into data quality metrics and allow you to fail updates or drop records when detecting invalid records.

![Diagram showing Lakeflow Declarative Pipelines expectations.](../media/expectations.png)

Here's an example of a materialized view that defines a constraint clause. In this case, the constraint contains the actual logic for what is being validated: the Country_Region shouldn't be empty. When a record fails this condition, the expectation is triggered.

```sql
CREATE OR REFRESH MATERIALIZED VIEW processed_covid_data (
 CONSTRAINT valid_country_region EXPECT (Country_Region IS NOT NULL) ON VIOLATION FAIL UPDATE
)
COMMENT "Formatted and filtered data for analysis."
AS
SELECT
   TO_DATE(Last_Update, 'MM/dd/yyyy') as Report_Date,
   Country_Region,
   Confirmed,
   Deaths,
   Recovered
FROM live.raw_covid_data;
```

Examples of constraints:

```sql
-- Simple constraint
CONSTRAINT non_negative_price EXPECT (price >= 0) ON VIOLATION DROP ROW

-- SQL functions
CONSTRAINT valid_date EXPECT (year(transaction_date) >= 2020) ON VIOLATION FAIL UPDATE

-- CASE statements
CONSTRAINT valid_order_status EXPECT (
  CASE
    WHEN type = 'ORDER' THEN status IN ('PENDING', 'COMPLETED', 'CANCELLED')
    WHEN type = 'REFUND' THEN status IN ('PENDING', 'APPROVED', 'REJECTED')
    ELSE false
  END
)

-- Multiple constraints
CONSTRAINT non_negative_price EXPECT (price >= 0),
CONSTRAINT valid_purchase_date EXPECT (date <= current_date())

-- Complex business logic
CONSTRAINT valid_subscription_dates EXPECT (
  start_date <= end_date
  AND end_date <= current_date()
  AND start_date >= '2020-01-01'
)

-- Complex boolean logic
CONSTRAINT valid_order_state EXPECT (
  (status = 'ACTIVE' AND balance > 0)
  OR (status = 'PENDING' AND created_date > current_date() - INTERVAL 7 DAYS)
)
```

Retaining invalid records is the default behavior for expectations. Records that violate the expectation are added to the target dataset along with valid records. If you specify `ON VIOLATION DROP ROW`, then records that violate the expectation are dropped from the target dataset. Finally, if you specify `ON VIOLATION FAIL UPDATE`, then the system atomically rolls back the transaction.

## Apply transformations

You can transform the data using a query, just like with standard SQL commands. In the following example, we define another materialized view that aggregates data.

```sql
CREATE OR REFRESH MATERIALIZED VIEW aggregated_covid_data
COMMENT "Aggregated daily data for the US with total counts."
AS
SELECT
   Report_Date,
   sum(Confirmed) as Total_Confirmed,
   sum(Deaths) as Total_Deaths,
   sum(Recovered) as Total_Recovered
FROM live.processed_covid_data
GROUP BY Report_Date;
```

## Execute and monitor the ETL pipeline

After you defined the code in notebooks or source code files, you can start the ETL pipeline. There's a visual interface you can use to monitor the execution:

![Screenshot showing Databricks Pipeline execution.](../media/monitor-pipeline.png)

The pipeline graph appears as soon as an update to a pipeline has successfully started. Arrows represent dependencies between data sets in your pipeline. By default, the pipeline details page shows the most recent update for the table, but you can select older updates from a drop-down menu.

Lakeflow Declarative Pipelines support tasks such as:

- Observing the progress and status of pipeline updates.
- Alerting on pipeline events such as the success or failure of pipeline updates. 
- Viewing metrics for streaming sources like Apache Kafka and Auto Loader. 
- Receiving email notifications when a pipeline update fails or completes successfully.