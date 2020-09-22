##Multiple Choice
What is a logical grouping of activities in Azure Data Factory
() Linked Service. {{Incorrect, Linked services define the connection information for data factory to the external resources you want to connect with for example an Azure SQL Database or Azure Data Lake Storage.}}
(x) Pipeline. {{Correct, A pipeline in Azure Data Factory is a logical grouping of activities such as copy in order to perform a task. The activity defines the operation that you’re performing on the data ( therefore, a copy means copying the same data to another data store).}}
() Sink. {{It’s an Azure Data Factory, Data Flows transformation functionality where ach sink transformation is associated with exactly one Azure Data Factory dataset object or linked service. The sink transformation determines the shape and location of the data you want to write to.}}
##Multiple Choice
Statement: It is not possible to add or remove datasets after they have been created with Azure Data Share:
() True. {{Incorrect. It is possible to add or remove datasets after it has been created in Azure Data Share.}}
(x) False. {{Correct. It is possible to add or remove datasets after it has been created in Azure Data Share.}}



##Multiple Choice
What should you do when a connector in data factory is not supported in mapping data flow in order to transform data from one of these sources?
You may notice many of the connectors in data factory are not supported in mapping data flow. To transform data from one of these sources, ingest it into a supported source using the copy activity.
() Use an aggregate transformation in Dataflow. {. {Incorrect. An aggregate transformation in Mapping dataflow can only be used once the data has landed in a supported data source in mapping dataflow, therefore you first need to copy the data into a supported source.}}
() Use a group by activity in Dataflow. {Incorrect. A group by activity in Mapping dataflow can only be used once the data has landed in a supported data source in mapping dataflow, therefore you first need to copy the data into a supported source.}}
(x) Ingest the data into a supported source using the copy activity. {{ Correct. If a connector in Data factory is not supported, create a copy activity of the source data into a supported data source in mapping dataflow and continue the transformations from there.}}
