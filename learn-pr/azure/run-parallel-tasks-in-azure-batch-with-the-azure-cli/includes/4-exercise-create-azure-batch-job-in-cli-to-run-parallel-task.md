Azure CLI lets you create and deploy Azure Batch resources from the command line.

As the solution architect for the non-profit, you want to start creating a Batch solution for the OCR scenario on Azure. As a first step, you're going to test creating a Batch account, a pool of worker nodes, a job, and tasks, all using the Azure CLI.

The Azure CLI is a cross-platform command line for creating and managing Azure resources. It uses a consistent ```az noun verb --properties``` syntax. CLI commands to manage Azure Batch follow this convention, and so all commands take the form of ```az batch verb --properties```.

>[!IMPORTANT]
>The exercises in this module are optional. To complete the exercises, you will need your own Azure subscription.

## Create the Azure Batch resources

First, you'll create the Azure Batch account and pool of worker nodes for your test scenario. You'll then create a Batch job and tasks to run in the pool.

1. Sign into the [Azure portal](https://portal.azure.com/).

### Create a new resource group

1. Click **Resource groups** in the left menu.

1. Click **+ Add**.

1. Complete the form to create a new resource group for the exercise and note the name.

### Create the Azure Batch account

1. In portal, open the cloud shell by clicking **>_** in the top menu.

1. Create environment variables for your resource group and batch resource.
    ```azurecli
    RESOURCE_GROUP=<your resource group>
    BATCH_ACCOUNT=batchaccount$RANDOM
    ```

1. Run the following command in the Cloud Shell to create an Azure Batch account. Choose from one of the following locations:
    ```
    westeurope,eastus,eastus2,westus,northcentralus,brazilsouth,northeurope,centralus,eastasia,japaneast,australiasoutheast,japanwest,koreasouth,koreacentral,southeastasia,southcentralus,australiaeast,southindia,centralindia,westindia,canadacentral,canadaeast,uksouth,ukwest,westcentralus,westus2,francecentral,southafricanorth
    ```

    ```azurecli
    az batch account create \
     --name $BATCH_ACCOUNT \
     --resource-group $RESOURCE_GROUP \
     --location <choose a location from the list above>
    ```

1. Run the following command to sign in to your Azure Batch account:

    ```azurecli
    az batch account login \
     --name $BATCH_ACCOUNT \
     --resource-group $RESOURCE_GROUP \
     --shared-key-auth
    ```

1. Create a pool of three Standard A1 v2 VMs running Ubuntu 16.04:

    ```azurecli
    az batch pool create \
     --id mypool --vm-size Standard_A1_v2 \
     --target-dedicated-nodes 3 \
     --image canonical:ubuntuserver:16.04-LTS \
     --node-agent-sku-id "batch.node.ubuntu 16.04"  
    ```

1. Run the following command to periodically determine whether the nodes are ready:

    ```azurecli
    az batch pool show --pool-id mypool \
     --query "allocationState"
    ```

    When this query shows that the nodes are "steady", they are ready to work. While they show as "resizing", they are being provisioned. You can use the up arrow key to repeat the most recent command in the Cloud Shell if you want to query the status of the nodes more than once.
    
1. Run the following command to create a "Batch job", a logical grouping for all the tasks that will run on your nodes:

    ```azurecli
    az batch job create \
     --id myjob \
     --pool-id mypool
    ```

1. Run the following command to create Batch tasks:

    ```azurecli
    for i in {1..10}
    do
       az batch task create \
        --task-id mytask$i \
        --job-id myjob \
        --command-line "/bin/bash -c 'echo \$(printenv | grep \AZ_BATCH_TASK_ID) processed by; echo \$(printenv | grep \AZ_BATCH_NODE_ID)'"
    done
    ```

    This loop creates a series of numbered Batch tasks, each of which outputs information about the task ID and node ID involved. By examining what's happening here closely, you can see quite a few characteristics of the way Azure Batch works. Tasks get automatically scheduled onto nodes with available capacity. However, the environment variables we're using (AZ_BATCH_TASK_ID and AZ_BATCH_NODE_ID), to show information about which task is being run on which node, are only available in the context of the 'task user', a default account created on each node in order to run tasks. Also, the --command-line argument does not directly run under a shell, so you have to explicitly invoke the shell using "/bin/bash -c" in order to use commands like printenv and grep.

    This loop completes the Azure Batch job implementation. We will leave the Azure Batch account and pool of worker nodes in place for use in the next module, but we will delete the Batch job. Because the Batch job acts as a container for its Batch tasks, the tasks are also deleted.

1. Run the following command in the Cloud Shell in order to delete the Batch job:

    ```azurecli
    az batch job delete --job-id myjob -y
    ```
