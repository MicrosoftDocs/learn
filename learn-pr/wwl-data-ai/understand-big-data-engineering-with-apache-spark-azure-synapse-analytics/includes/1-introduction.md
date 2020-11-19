Learn how to differentiate between Apache Spark, Azure Databricks, HDInsight, and SQL Pools, as well as understanding the use-cases of data-engineering with Apache Spark in Azure Synapse Analytics.

After completing this module, you will be able to:

* Introduction to apache spark
* Differentiate between apache spark and spark pools
* Differentiate between azure databricks and spark pools
* Differentiate between HDInsight and spark pools
* Differentiate between spark pools and SQL pools
* Understand the use-cases of data engineering with apache spark in azure synapse analytics
* Exercise: Create a spark pool in azure synapse analytics

**Prerequisite**
Before taking this module, it is recommended that you complete the following modules:

* Data Fundamentals
* Introduction to Azure Data Factory
* Introduction to Azure Synapse Analytics

Examples:

Picture References:
![Sent Shares ](../media/azure-data-share-sent-shares.png)


Table:
| Connector | Data format | Authentication type |
|-|-|
| Azure Blob Storage | CSV, Parquet | Account Key |
| Azure Data Lake Storage Gen1 | CSV | Service Principal |
| Azure Data Lake Storage Gen2 | CSV, Parquet | Account Key, Service Principal |
| Azure SQL Database |  | SQL authentication |
| Azure Synapse Analytics |  | SQL authentication |

Code example:

    ```Python
    # Creating widgets for leveraging parameters, and printing the parameters

    dbutils.widgets.text("input", "","")
    dbutils.widgets.get("input")
    y = getArgument("input")
    print ("Param -\'input':")
    print (y)
    ```

    > [!Note] 
    > that the notebook path is **/adftutorial/mynotebook**

Note example:
> [!Note]
> It typically takes 5-7 minutes for the cluster to spin up. With this mode on and the Spark clusters running, you are able to build your data flow step by step and view the data as it runs through each transformation phase. 

