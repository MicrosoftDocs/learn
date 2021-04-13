Once you have verified that an ADF pipeline run works through the debug feature in ADF, you are able to publish it in the ADF service. 

If you publish all, you publish all the changes and updates you have made in the pipeline itself. 

Azure Data factory will then first run a validation check in order to validate that all the resources (that is, the data flow mapping, the storages settings, and so forth) meet the requirements. 
If it doesn’t meet the requirements, then you’ll see a side panel that will explain in detail what the error is and how to fix it. 

If the validation check succeeds, you are able to trigger the pipeline. 
Trigger now, will start one manual pipeline run, however it is also possible to create a schedule, or event-based trigger to operationalize the pipeline in Azure Data Factory.  
If you triggered the data flow, data flow will start a just-in-time Spark cluster, which will terminate once the pipeline is finished and the job is concluded. 
However, since it’s a just-in-time Spark cluster, the data flow activity might take 5-7 minutes since the Spark cluster has to be activated.  

Once you start developing more pipelines, it is important to keep track of the pipelines that you have created. 
In order to do so, there is a monitor tab in Azure Data Factory, which will store by default all the run information for 45 days. 
If you want to persist the metrics for longer, then the default time, you can configure Azure Data Factory with Azure monitor. 

In the activity runs view, you are able to check the details of the pipeline run just like the debug run. 
