In this module, you learned the basics about reading and writing data in Azure Databricks. You now know how to read CSV, JSON, and Parquet file formats, and how to write Parquet files to the Databricks file system (DBFS) with compression options. Though you only wrote the files in Parquet format, you can use the same `DataFrame.write` method to output to other formats. Finally, you put your knowledge to the test by completing an exercise that required you to read a random file that you had not yet seen.

Now that you have concluded this module, you should know:

1. Read data from CSV files into a Spark Dataframe
1. Provide a Schema when reading Data into a Spark Dataframe
1. Read data from JSON files into a Spark Dataframe
1. Read Data from parquet files into a Spark Dataframe
1. Create Tables and Views
1. Write data from a Spark Dataframe

## Clean up

If you plan on completing other Azure Databricks modules, don't delete your Azure Databricks instance yet. You can use the same environment for the other modules.

### Delete the Azure Databricks instance

1. Navigate to the Azure portal.
1. Navigate to the resource group that contains your Azure Databricks instance.
1. Select **Delete resource group**.
1. Type the name of the resource group in the confirmation text box.
1. Select **Delete**.
