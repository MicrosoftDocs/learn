Once you are familiar with your data, you can define the metadata objects inside of serverless SQL pool so the clients connecting to it can discover them and query the data in the lake. The first metadata object you will create is a database.

To create a new database as an Azure Synapse serverless SQL pool, go to the **Data** hub, click **+** button and select **SQL database**.  
  
![Create a Synapse SQL Database in Azure Synapse Studio](../media/create-synapse-sql-database.png)

Choose one of the following two pool type options: 

- Serverless
- Dedicated

Select **Serverless** if it isn’t already selected, type in a **database name** and press the button **Create**. 
  

![Choosing a Synapse SQL pool type in Azure Synapse Studio](../media/choose-synapse-sql-pool-type.png)

In addition to using the Azure Synapse Studio user interface to create a database, you can execute the following Transact-SQL statement in the serverless SQL pool: 

```sql
CREATE DATABASE [YourDatabaseName] 
```

