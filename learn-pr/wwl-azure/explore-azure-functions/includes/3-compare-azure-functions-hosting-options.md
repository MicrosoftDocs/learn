When you create a function app in Azure, you must choose a hosting plan for your app. Azure provides you with these hosting options for your function code:

| Hosting option | Service | Availability | Container support |
|--|--|--|--|
| **[Consumption plan](/azure/azure-functions/consumption-plan)** | Azure Functions | Generally available (GA) | None |
| **[Flex Consumption plan](/azure/azure-functions/flex-consumption-plan)** | Azure Functions | Preview | None |
| **[Premium plan](/azure/azure-functions/functions-premium-plan)** | Azure Functions | GA | Linux |
| **[Dedicated plan](/azure/azure-functions/dedicated-plan)** | Azure Functions | GA | Linux |
| **[Container Apps](/azure/azure-functions/functions-container-apps-hosting)** | Azure Container Apps | GA | Linux |

Azure App Service infrastructure facilitates Azure Functions hosting on both Linux and Windows virtual machines. The hosting option you choose dictates the following behaviors:

* How your function app is scaled.
* The resources available to each function app instance.
* Support for advanced functionality, such as Azure Virtual Network connectivity.
* Support for Linux containers.

The plan you choose also impacts the costs for running your function code.

## Overview of plans

Following is a summary of the benefits of the various hosting options:

### Consumption plan

The Consumption plan is the default hosting plan. Pay for compute resources only when your functions are running (pay-as-you-go) with automatic scale. On the Consumption plan, instances of the Functions host are dynamically added and removed based on the number of incoming events.

### Flex Consumption plan

Get high scalability with compute choices, virtual networking, and pay-as-you-go billing. On the Flex Consumption plan, instances of the Functions host are dynamically added and removed based on the configured per instance concurrency and the number of incoming events.

You can reduce cold starts by specifying the number of pre-provisioned (always ready) instances. Scales automatically based on demand.

### Premium plan

Automatically scales based on demand using prewarmed workers, which run applications with no delay after being idle, runs on more powerful instances, and connects to virtual networks.

Consider the Azure Functions Premium plan in the following situations:

* Your function apps run continuously, or nearly continuously.
* You want more control of your instances and want to deploy multiple function apps on the same plan with event-driven scaling.
* You have a high number of small executions and a high execution bill, but low GB seconds in the Consumption plan.
* You need more CPU or memory options than are provided by consumption plans.
* Your code needs to run longer than the maximum execution time allowed on the Consumption plan.
* You require virtual network connectivity.
* You want to provide a custom Linux image in which to run your functions. 

### Dedicated plan

Run your functions within an App Service plan at regular App Service plan rates. Best for long-running scenarios where Durable Functions can't be used. 

Consider an App Service plan in the following situations:
 
* You must have fully predictable billing, or you need to manually scale instances.
* You want to run multiple web apps and function apps on the same plan
* You need access to larger compute size choices.
* Full compute isolation and secure network access provided by an App Service Environment (ASE).
* High memory usage and high scale (ASE).

### Container Apps

Create and deploy containerized function apps in a fully managed environment hosted by Azure Container Apps.

Use the Azure Functions programming model to build event-driven, serverless, cloud native function apps. Run your functions alongside other microservices, APIs, websites, and workflows as container-hosted programs.

Consider hosting your functions on Container Apps in the following situations:

* You want to package custom libraries with your function code to support line-of-business apps.
* You need to migration code execution from on-premises or legacy apps to cloud native microservices running in containers.
* You want to avoid the overhead and complexity of managing Kubernetes clusters and dedicated compute.
* You need the high-end processing power provided by dedicated CPU compute resources for your functions.

## Function app timeout duration

The `functionTimeout` property in the *host.json* project file specifies the timeout duration for functions in a function app. This property applies specifically to function executions. After the trigger starts function execution, the function needs to return/respond within the timeout duration.

The following table shows the default and maximum values (in minutes) for specific plans:

| Plan | Default | Maximum<sup>1</sup> |
| --- | --- | --- |
| Consumption plan | 5 | 10 |
| Flex Consumption plan | 30 | Unlimited<sup>3</sup> |
| Premium plan | 30<sup>2</sup> | Unlimited<sup>3</sup> |
| Dedicated plan | 30<sup>2</sup> | Unlimited<sup>3</sup> |
| Container Apps | 30<sup>5</sup> | Unlimited<sup>3</sup> |

1.  Regardless of the function app timeout setting, 230 seconds is the maximum amount of time that an HTTP triggered function can take to respond to a request.
1.  The default timeout for version 1.x of the Functions runtime is *unlimited*.
1.  Guaranteed for up to 60 minutes. OS and runtime patching, vulnerability patching, and scale in behaviors can still cancel function executions.
1.  In a Flex Consumption plan, the host doesn't enforce an execution time limit. However, there are currently no guarantees because the platform might need to terminate your instances during scale-in, deployments, or to apply updates.
1.  When the minimum number of replicas is set to zero, the default timeout depends on the specific triggers used in the app.
