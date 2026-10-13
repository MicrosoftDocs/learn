During the building of Mapping Data Flows, you can interactively watch how the data transformations are executing so that you can debug them. To use this functionality, it's first necessary to turn on the "Data Flow Debug" feature.

![Screenshot that shows the "Data Flow Debug" toggle being activated.](../media/start-data-flow-debug.png)

Selecting **Debug** provisions the Spark clusters required to interact with the Mapping Data Flow transformations. On turning on Debug, you're prompted to select the Integration Runtime that you require to use in the environment. If you select AutoResolveIntegrationRuntime, a cluster with eight cores and a default time to live (TTL) of 60 minutes starts. You can choose a higher TTL if you want to allow more idle time before the session times out.

> [!NOTE]
> It typically takes 5-7 minutes for the cluster to spin up. With this mode on and the Spark clusters running, you're able to build your data flow step by step and view the data as it runs through each transformation phase. 

A Data Preview tab is available in Debug mode that allows you to view the data at each stage of the pipeline. You can view the data after each transformation. The data previewer also provides the ability to perform actions on the data, such as viewing descriptive statistics, changing a column's data type, or removing a column.

[![Screenshot that shows the Data Preview tab displaying data at a transformation stage.](../media/data-previewer.png)](../media/data-previewer.png#lightbox)

Finally, you can use the debug settings to control the number of rows that are returned within the data previewer. 

> [!NOTE]
> It's recommended to limit the number of rows to enough to confirm that the data is correct. The bigger the data set, the longer it takes to return the results back. You can also use the Debug settings to specify any parameter values that should be used during the execution of the pipeline.
>
> You're charged hourly while a debug session is running, including the TTL time. Turn the debug switch off when you finish debugging so that the Spark cluster can terminate.