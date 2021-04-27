The Apache Spark history server can be used to debug and diagnose completed and running Apache Spark applications. You can use the Apache Spark history server web UI from the Azure Synapse Studio environment. 
Once you launch it, there are several tabs that you can use in order to monitor the Apache Spark application:

* Jobs
* Stages
* Storage
* Environment
* Executors
* SQL 

The Apache Spark history server is the web user interface known as the Spark UI, and is used to view completed and running Apache Spark applications. If you want to navigate to the Apache Spark History server, you can navigate to the Azure Synapse Analytics Studio environment and go to the Monitor tab. 
In the Monitor tab, you can select 'Apache Spark Applications'.

[![Monitor Apache Spark Application Overview ](../media/monitor-spark-application-overview.png)](../media/monitor-spark-application-overview.png#lightbox)

If you are familiar with Apache Spark, you can find the standard Apache Spark history server UI by selecting Open Spark UI. 

Another way to open the Apache Spark History server is to navigate to the Data tab, where if you create a notebook and read a DataFrame you can go to the bottom of the page and find the Spark History Server known as the Spark UI.  

1. From your Azure Synapse Studio notebook, select **Open Spark UI** from the job execution output cell or from the status panel at the bottom of the notebook document. 

   [![Open Spark UI through Data Tab](../media/spark-interface-data-tab-server.png "Spark UI")](../media/spark-interface-data-tab-server.png#lightbox)

2. Select **Spark UI** from the slide out panel and you'll be redirected to the Spark monitoring tab where you will land in the Jobs tab. 

   [![Open Spark UI](../media/opened-spark-interface-inital-tab-jobs.png "Open Spark UI")](../media/opened-spark-interface-inital-tab-jobs.png#lightbox)

3. Within the Jobs tab of the Spark History server, you can see the Job ID, Description, the time when the job was submitted, the duration, the stages, and the task (for all stages). If you select a job ID and go to the description and select the url, you'll be redirected to this screen:

   [![DAG visualization](../media/graph-visualization-spark-interface.png)](../media/graph-visualization-spark-interface.png#lightbox)
 
   It will give you a DAG Visualization of the stage.

4. If you select the Stages tab, you'll find all the completed stages. If you want to dig deeper into the stages, you can select the description url as shown below:

   [![Stage Tab in Spark UI](../media/stages-tab-spark-interface.png)](../media/stages-tab-spark-interface.png#lightbox)

5. In the Storage tab, your Resilient Distributed Datasets (RDDs) will only be cached once you have evaluated it. A common way of forcing evaluation and populate a cache is, for example,  to call the 'count' command.

   demo_df.cache() 
   demo_df.count()

6. The image shows what you would see in the Storage tab of the Apache Spark UI:

   [![Storage tab Cache](../media/storage-tab-cache.png)](../media/storage-tab-cache.png#lightbox)

7. If you want to see more details, you can go into the RDD Name url where you'll be shown these details:

   [![RDD Storage Details](../media/resilient-storage-details.png)](../media/resilient-storage-details.png#lightbox)

8. If we move on to the Environment tab, you'll get the Runtime Information and the Spark Properties, System properties, and the class path entries. 

9. The next thing we will look at is the Executors tab. Here you can find all the information about the executors:

   [![Executors tab Spark UI](../media/spark-interface-executors-tab.png)](../media/spark-interface-executors-tab.png#lightbox)

10. Finally the SQL tab. Here you can find the completed queries and details within the IDs for the queries.

      [![SQL Tab Spark UI](../media/spark-interface-sql-tab-details-summary.png)](../media/spark-interface-sql-tab-details-summary.png#lightbox)

   Now we have been through all the different tabs, using the Spark UI, enabling you to optimize and baseline through the Apache Spark performance and settings.