> [!CAUTION]
> If you're using **Windows nodes** then the Azure Sandbox is **not supported**. Please use your own Azure subscription to continue.
>
> You can still use this page to follow the tutorial, however, you **will not be able to create AKS clusters using the provided cloud shell.**

## Activate the Azure sandbox

>[!NOTE]
> The Learn sandbox system that enables you to complete these modules without using your own subscription is currently down for maintenance. This module can still be completed using a subscription you own, but please be aware that the steps might skip some instructions necessary for you to deploy, such as logging into your subscription or cleaning up the deployment at the end of the module. Let's go!

1. Start by **activating the Azure sandbox above.**
1. Once it's activated, sign into the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

1. Create variables for the configuration values you'll reuse throughout the exercises.

    ```bash
    export RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
    export CLUSTER_NAME=aks-contoso-video
    ```