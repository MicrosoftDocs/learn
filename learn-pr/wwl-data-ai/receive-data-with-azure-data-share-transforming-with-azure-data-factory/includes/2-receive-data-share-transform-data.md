A common use with Azure Data Share is to take the data that is shared and use it as a source into Azure Data Factory pipelines to use with your own internal data.

It’s time to teach you how to receive data with Azure Data Share and transform this data with Azure Data Factory. 

The reason why it’s imperative to understand both Azure Data Share and Azure Data Factory for transforming data is that it can be a useful components to a modern data warehouse and analytics project. One common requirement is to gain access to external data, to gain insights and additional visibility of the data across your whole data landscape. You can improve and perform data integration and management in Azure when using Azure Data Factory as well as Azure Data Share. 

Azure Data Factory will give you the opportunity to perform code-free ETL/ELT, which will result in a comprehensive overview of your data pipelines. As a data engineer, this gives you the confidence to work with more data. 

When you are in the position of a data provider, you are enabled to share dataset with third parties or between departments within your organization.

You can share data from multiple resources like an Azure SQL Database.  You can also configure a snapshot schedule, such that your data consumers (the party that you want to share the data with) have an option to automatically get a refresh of the data that was shared with them. 

If you are in the position of a data consumer, you will get sent a dataset. On receiving a dataset, you need to accept an invitation that will be sent out by the data consumer.  In order to receive the data, you can configure a storage account where you’re going to land the data that is shared with you and map the datasets to, for example an ADLS Gen 2 account. It is also possible to trigger a snapshot in order to get a copy of the latest refresh of data that was shared with you in the set-up of the ADLS Gen 2 account. 

In the exercises to come during this learning path, the NYC Taxi Data will be used. You can import the dataset into a SQL Database by downloading the taxi-data bacpac file: https://github.com/djpmsft/ADF_Labs/blob/master/sample-data/taxi-data.bacpac
