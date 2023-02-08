The Batch Explorer lets you view the status of jobs in the Azure Batch service.

As the solution architect, you'll need a way of visualizing the progress of large numbers of nodes and tasks being used to process water purification images in parallel.

Here, you'll execute a job in Azure Batch and then use the Batch Explorer to view its progress.

>[!IMPORTANT]
>The exercises in this module are optional. To complete the exercises, you'll need your own Azure subscription.

## Use the Batch Explorer to analyze a job

Using Azure Batch Explorer, you can see the Batch accounts you have in your account in the left-hand sidebar, and the status of pools, nodes, jobs, and tasks in the right.

For scenarios in which you may have hundreds or thousands of tasks running in various states of progress on hundreds or thousands of nodes, it will be crucial to visualize this information quickly and be able to drill down into the detail of any problems or areas of particular interest.

1. Sign into the [Azure portal](https://portal.azure.com/).

1. Open the Cloud Shell by clicking **>_** in the top menu.

1. Run the following command in the Cloud Shell to create a new Azure Batch job, using the Batch account and pool you created in the previous exercise:

    ```azurecli
    az batch job create \
     --id explorerjob \
     --pool-id mypool
    ```

1. In the portal, open your Batch account resource.

1. Go to the **Jobs** section under **Features**.

1. Select the active job.

    A panel opens up showing the status of the job. You haven't created any tasks and nothing is running so this panel will be empty.

1. Run the following command in the Cloud Shell to create new Azure Batch tasks, using the Batch account and pool you created in the previous exercise:

    ```azurecli
    for i in {1..100}
    do
       az batch task create \
        --task-id mytask$i \
        --job-id explorerjob \
        --command-line "/bin/bash -c 'printenv; sleep 5s'"
    done
    ```

    This job consists of more tasks, each of which outputs all environment variables, and then waits 5 seconds. Batch Explorer is  powerful for monitoring more numerous and longer-running tasks.

1. Go back to Batch Explorer. Notice, in the top-right corner, tasks being queued, an indication of progress, and the number of tasks that have succeeded or failed.

1. Select the refresh wheel to the right of the **Filter by task ID** box. As tasks complete, details of the task including the exit code appear here.