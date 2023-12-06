 
You've now ingested raw data in the Fabric lakehouse, also known as the bronze layer of a Medallion architecture. Before moving to the transformation and modeling steps, consider where to transform and how users interact with the data.

## Transform for different users

When you load data, it's a good idea to do some basic cleaning like removing duplicates, handling errors, converting null values, and getting rid of empty entries to ensure data quality and consistency. Also thinking about the different people who use the data is crucial.

Data scientists usually prefer fewer changes so they can explore wide tables. They would likely want access to the raw ingested data. Fabric's Data Wrangler then let's them explore the data and generate transformation code for their specific needs.

Whereas Power BI data analysts may require more transformation and modeling before they can use the data. While Power BI can transform data, starting with well-prepared data allows analysts to develop reports and insights more efficiently.

The [Use Apache Spark in Microsoft Fabric](/training/modules/use-apache-spark-work-files-lakehouse/) module teaches how to use Fabric notebooks to display, aggregate, and transform data with Spark.
