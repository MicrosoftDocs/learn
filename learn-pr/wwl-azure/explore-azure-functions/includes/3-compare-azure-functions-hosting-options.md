
When you create a function app in Azure, you must choose a hosting plan for your app. There are three basic hosting plans available for Azure Functions: Consumption plan, Functions Premium plan, and App service (Dedicated) plan. All hosting plans are generally available (GA) on both Linux and Windows virtual machines.

The hosting plan you choose dictates the following behaviors:

* How your function app is scaled.
* The resources available to each function app instance.
* Support for advanced functionality, such as Azure Virtual Network connectivity.

The following is a summary of the benefits of the three main hosting plans for Functions:

| Plan | Benefits |
|--|--|
| **Consumption plan** | This is the default hosting plan. It scales automatically and you only pay for compute resources when your functions are running. Instances of the Functions host are dynamically added and removed based on the number of incoming events. |
| **Premium plan** | Automatically scales based on demand using pre-warmed workers, which run applications with no delay after being idle, runs on more powerful instances, and connects to virtual networks. |
| **Dedicated plan** | Run your functions within an App Service plan at regular App Service plan rates. Best for long-running scenarios where Durable Functions can't be used. |

There are two other hosting options, which provide the highest amount of control and isolation in which to run your function apps.

Hosting option | Details
-- | --
**ASE** | [App Service Environment (ASE)](/azure/app-service/environment/intro) is an App Service feature that provides a fully isolated and dedicated environment for securely running App Service apps at high scale.
**Kubernetes** | Kubernetes provides a fully isolated and dedicated environment running on top of the Kubernetes platform. For more information visit [Azure Functions on Kubernetes with KEDA](/azure/azure-functions/functions-kubernetes-keda).


## Always on
If you run on a Dedicated plan, you should enable the **Always on** setting so that your function app runs correctly. On an App Service plan, the functions runtime goes idle after a few minutes of inactivity, so only HTTP triggers will "wake up" your functions. Always on is available only on an App Service plan. On a Consumption plan, the platform activates function apps automatically.


## Storage account requirements

On any plan, a function app requires a general Azure Storage account, which supports Azure Blob, Queue, Files, and Table storage. This is because Functions rely on Azure Storage for operations such as managing triggers and logging function executions, but some storage accounts don't support queues and tables. These accounts, which include blob-only storage accounts (including premium storage) and general-purpose storage accounts with zone-redundant storage replication, are filtered-out from your existing **Storage Account** selections when you create a function app.

The same storage account used by your function app can also be used by your triggers and bindings to store your application data. However, for storage-intensive operations, you should use a separate storage account.
