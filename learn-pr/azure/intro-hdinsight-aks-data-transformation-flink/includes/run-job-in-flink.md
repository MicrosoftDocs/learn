Users can submit jobs using one of the below options: 

- **Portal**: With the native integration of Apache Flink in the Azure portal, users no longer require extensive knowledge of Flink clusters to submit, manage, and monitor jobs. 

- **Rest API**: HDInsight on AKS provides user friendly ARM Rest APIs to submit and manage Apache Flink jobs. Users can submit Apache Flink jobs from any Azure service using these Rest APIs. 

- **Apache Flink UI**: Apache Flink features a web UI to inspect, monitor, submit, and debug running applications. 

- **Secure shell (SSH)**: Secure shell (SSH) allows you to submit jobs and queries to your cluster directly. You can enable or disable SSH using "Secure shell" blade in the Azure portal. 

 
> [!Note]
> There are some prerequisites before submitting and managing jobs from portal or Rest APIs. 
> - Create a directory in the primary storage account of the cluster to upload the job jar. 
> - If the user wants to take savepoints, then create a directory in the storage account for job savepoints. 

 

In the following sections, you learn how to submit your first job from the portal, Apache Flink UI, SSH pod, and Postman (REST API). 

 

## Exercise: Submit a job in the Azure portal 

In this exercise, we submit a job from the Azure portal. We run a word count application to count the number of words in the Apache Flink LICENSE file. This application can be found under the **examples/ directory** which contains sample applications that can be used as is with Apache Flink. You can also download the jar [here](https://microsofteur-my.sharepoint.com/:u:/g/personal/nasalvac_microsoft_com/EQ3S1LL1tlNLrHJxh_3LXjQBEJRX35hJr-Tx5g6KmU0Tuw?e=YbM1i0).  

1. Upload the jar into a storage account. In this example, we uploaded it to the jars folder of the flinkdemo ADLS gen 2 account. 

1. Navigate to your cluster page in the Azure portal. Select the Apache Flink Jobs blade. 

    :::image type="content" source="../media/submit-job.png" alt-text="Screenshot shows Submit a job in the Azure portal." border="true" lightbox="../media/submit-job.png":::

 
1. To submit a job, provide the following information: 

    **Job Details**

    |	Property 	|	Description 	|	Default Value 	|	Mandatory 	|
    |	-	|	-	|	-	|	-	|
    |	Job name 	|	Unique name for job. This value is displayed on portal. Job name should be in small latter. 	|		|	Yes 	|
    |	Jar path 	|	Storage path for job jar. Users should create directory in cluster storage and upload job jar. 	|	 	|	Yes	|
    |	Entry class 	|	Entry class for job from which job execution starts. 	|		|	Yes 	|
    |	Args 	|	Argument for main program of job. Separate all arguments with spaces. 	|		|  |

    Apache Flink job configuration 
  
    |	Property 	|	Description 	|	Default Value 	|	Mandatory 	|
    |	-	|	-	|	-	|	-	|
    | parallelism | Job Apache Flink Parallelism | 2 | Yes |
    | savepoint.directory | Savepoint directory for job. It is recommended that users should create a new directory for job savepoint in storage account. | `abfs://<container>@<account>/<deployment-ID>/savepoints` | No |

 

1. After submitting the job, you can check its status in the Azure portal. After the job is launched, the job status in the portal is RUNNING. If the job succeeds, it changes to Success. In the portal, you can start or stop the job. Relaunch it, update it, perform a Stateless update. Take a savepoint, cancel, or delete the job. Learn more about the options to [manage jobs in  on AKS](/azure/hdinsight-aks/flink/flink-job-management#options-to-manage-jobs-in-hdinsight-on-aks). 

    :::image type="content" source="../media/check-status.png" alt-text="Screenshot shows check  status in the Azure portal." border="true" lightbox="../media/check-status.png":::

 


 

1. You can also Navigate to the Apache Flink UI and monitor the Running or Completed jobs. 

    :::image type="content" source="../media/monitor-jobs.png" alt-text="Screenshot shows monitor the running or completed jobs." border="true" lightbox="../media/monitor-jobs.png":::

 

Visit our documentation to learn about [job management from the Azure portal](/azure/hdinsight-aks/flink/flink-job-management#job-management-from-azure-portal). 

 

## Exercise: Submit a job in Apache Flink UI 

In this section, you learn how to submit and monitor a job in the Apache Flink UI. 

 
1. Navigate to the Apache Flink UI, to the “Submit New Job” tab. Upload the jar downloaded in the previous section and provide the following information: 

    | Property	| Description |
    | - | - |
    | entryClass |    Entry class for job from which job execution starts |
    | Parallelism |     Apache Flink Job Parallelism |
    |  Program arguments |     job-related arguments |
    |   Savepoint Path |     Savepoint path for job. It is recommended that users should create a new directory for job savepoint in storage account. |

    >[!Note]
    > You need to supply the  --output argument with the path of the file that contains the job output. In this example we’ve saved the output of the WordCount application in a text file stored in the ADLS Gen2 storage account. 

    :::image type="content" source="../media/submit-new-jobs.png" alt-text="Screenshot shows submit new job." border="true" lightbox="../media/submit-new-jobs.png":::

1. After filling the details, click the “Submit” button. The job shows as “Running”. 

1. Users can monitor their jobs in the Running Jobs tab. 

    :::image type="content" source="../media/view-run-jobs.png" alt-text="Screenshot shows users can monitor their jobs in the Running Jobs tab." border="true" lightbox="../media/view-run-jobs.png":::

1. After the job is completed, you can review the job information in the “Completed Jobs” tab. If any job fails, users can get the relevant job logs for troubleshooting. 

    :::image type="content" source="../media/review-job-information.png" alt-text="Screenshot shows users can review the job information in the Completed Jobs tab." border="true" lightbox="../media/review-job-information.png":::

 
## Exercise: Submit a job using Secure Shell (SSH) 

In this exercise, you learn how to submit jobs from SSH pods.  

1. Open a new ssh session by navigating into the Secure Shell blade of your cluster. If you haven’t enable SSH yet, check the box and click save. You can configure the number of nodes to create, up to a maximum of 5. Once the endpoints are displayed, click in one of the nodes to open a web ssh session. 

   :::image type="content" source="../media/open-new-ssh-session.png" alt-text="Screenshot shows open a new ssh session by navigating into the Secure Shell blade of your cluster." border="true" lightbox="../media/open-new-ssh-session.png":::
 


1. Once in the ssh pod, navigate into the examples folder and run the Apache Flink wordcount job using the below command: 
    ```
    cd examples/batch/ 

    flink run WordCount.jar --input /opt/flink/LICENSE 
    ```
 

    >[!Note]
    > Input file '/opt/flink/LICENSE' is the file path on flink task manager, not local file path. 
    
    This jar is already present in the Apache Flink example directory. 

    
    :::image type="content" source="../media/run-flink-wordcount-job.png" alt-text="Screenshot shows run the Apache Flink wordcount job." border="true" lightbox="../media/run-flink-wordcount-job.png":::

 

1. You see the output of your job in the console. Navigate to the Apache Flink UI to monitor the cluster and running job. 

1. You can also check the logs directly in the pod under the logs/ directory: 

    ```
    tail log/flink*.log 
    ```

## Exercise: Submit a job using Postman 

Postman is an API platform for building and using APIs. It can be used to submit and manage jobs. Using this Apache Flink REST API, you can seamlessly integrate Apache Flink job operations into your Azure Pipeline. Users can initiate new jobs, stop jobs, start jobs, create savepoints, cancel jobs, and delete jobs. The current API_VERSION is 2023-06-01-preview. 

In this example, we demonstrate how to submit an Apache Flink Job using Postman.  

>[!Important]
> Use the following URL for rest API. Replace subscription, resource group, cluster pool, cluster name and  on AKS API version in this before using it.  
```
https://management.azure.com/subscriptions/{{USER_SUBSCRIPTION}}/resourceGroups/{{USER_RESOURCE_GROUP}}/providers/Microsoft.HDInsight/clusterpools/{{CLUSER_POOL}}/clusters/{{FLINK_CLUSTER}}/runjob?api-version={{API_VERSION}} 
```
 
1. Open Postman and paste the request URL.  

    :::image type="content" source="../media/postman-page.png" alt-text="Screenshot shows  open postman and paste the request URL." border="true" lightbox="../media/postman-page.png":::

 
1. In the Authorization tab, paste the Bearer token. To authenticate Apache Flink ARM Rest API users, need to get the bearer token or access token. Follow [these steps](/azure/hdinsight-aks/flink/flink-job-management#rest-api-authentication). 

 
    :::image type="content" source="../media/postman-authorization-tab.png" alt-text="Screenshot shows authorization tab." border="true" lightbox="../media/postman-authorization-tab.png":::

1. On the body tab, paste the following information:
   
    |	Property 	|	Description 	|	Default Value 	|	Mandatory 	|
    |		-|-		|-		|-		|
    |	jobType 	|	Type of Job. It should be “FlinkJob” 	|		|	Yes 	|
    |	jobName 	|	Unique name for job. This value displayed on portal. Job name should be in small latter. 	|		|	Yes 	|
    |	action 	|	It indicates operation type on job. It should be “NEW” always for new job launch. 	|		|	Yes 	|
    |	jobJarDirectory 	|	Storage path for job jar directory. Users should create directory in cluster storage and upload job jar. 	|	 |Yes 	|		
    |	jarName 	|	Name of job jar. 	|		|	Yes 	|
    |	entryClass 	|	Entry class for job from which job execution starts. 	|		|	Yes 	|
    |	args 	|	Argument for main program of job. Separate arguments with space. 	|		|	No 	|
    |	parallelism 	|	Job Apache Flink Parallelism. 	|	2 	|	Yes 	|
    |	savepoint.directory 	|	Savepoint directory for job. It is recommended that users should create a new directory for job savepoint in storage account. 	|	`abfs://<container>@<account>/<deployment-ID>/savepoints` 	|	No 	|
    

 

   :::image type="content" source="../media/paste-attribute.png" alt-text="Screenshot shows enter the attributes." border="true" lightbox="../media/paste-attribute.png":::

 

1. After completing these steps, click “Send”. You can monitor your Job in Apache Flink dashboard. 

 

 

 

 
