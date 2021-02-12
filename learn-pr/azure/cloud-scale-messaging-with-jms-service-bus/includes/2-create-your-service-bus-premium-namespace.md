In this unit, you'll learn how to create your Azure Service Bus Premium namespace.

## Introduction to Azure Service Bus

Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics. Service Bus is used to decouple applications and services from each other, providing the following benefits:

   * Load-balancing work across competing workers
   * Safely routing and transferring data and control across service and application boundaries
   * Coordinating transactional work that requires a high-degree of reliability

## Create your Azure Service Bus Premium namespace using the Azure CLI

You can use the Azure CLI to create and manage Azure resources. The CLI allows adminsitrators and developers to run commands using a terminal or command-line promt (or script) instead of a web browser.

To utilize the Azure CLI to create an Azure Service Bus Premium namespace use the below commands:

### Login to Azure

```bash
az login
```

This will take you to a login process through the Azure browser where you must login. After login the Azure CLI will be authenticated to run your commands.

### Pick the appropriate subscription

To list your subscriptions, run the below command.

```bash
az account list --output table
```

To pick the specific subscription, run the below command.

```bash
az account set --subscription "<PICK YOUR SUBSCRIPTION>"
```

### Create a resource group

For the purpose of this course, we will proceed to place the Azure Service Bus namespace under the resource group `MSLearn_JMS_ServiceBus_Course` in the East US region.

```bash
az group create --name MSLearn_JMS_ServiceBus_Course --location eastus
```

### Create an Azure Service Bus namespace

We will then create an Azure Service Bus namespace in the resource group we just created.

```bash
az servicebus queue create --resource-group MSLearn_JMS_ServiceBus_Course --namespace-name "<PICK YOUR NAMESPACE NAME>" --sku Premium -- capacity 1
```

> [!IMPORTANT]
> Please be sure to delete the namespace and the resource group you created in the above steps to avoid being billed for the resources.
>
> The command to delete and clean up the resources are available on the Summary page, but they are available below if you are ending the course now.
>
>   ```bash
>   az servicebus namespace delete --resource-group MSLearn_JMS_ServiceBus_Course --namespace-name "<PICK YOUR NAMESPACE NAME>"
>   
>   az group create --name MSLearn_JMS_ServiceBus_Course --location eastus
>   ```
>