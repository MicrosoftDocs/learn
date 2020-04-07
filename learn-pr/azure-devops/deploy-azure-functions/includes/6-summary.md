Great work! In this module, we extended a release pipeline to add support for deploying an Azure Functions app. The single release pipeline now builds a multi-project solution and deploys different components to different cloud targets in Azure.

While this module specifically focused on an app that uses Azure App Service and Azure Functions, the fundamentals covered apply across a wide range of build and deployment targets. You can also see how Azure Pipelines can scale to support even the most sophisticated scenarios.

## Learn more

In this module, you worked with Azure Functions, which are one of the development models within the broader Azure serverless computing offerings. Azure Functions was a great solution for the Tailspin team, but your needs will vary, and it's important to understand which compute options are best for your scenario. Explore these resources to learn more.

There are quite a few serverless offerings under the Azure umbrella, and there is some overlap between various services. For a more in-depth review of some key serverless options, including Azure Functions, Microsoft Flow, Azure Logic Apps, and Azure App Service WebJobs, see [Choose the right integration and automation services in Azure](https://docs.microsoft.com/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs?azure-portal=true).

Azure Functions is also a great option for microservice solutions like the one the Tailspin team is evolving towards here. To understand the different options for microservices on Azure, including Azure Functions, Kubernetes, and Service Fabric, see [Choosing an Azure compute option for microservices](https://docs.microsoft.com/azure/architecture/microservices/design/compute-options?azure-portal=true).

However, serverless isn't always appropriate for every situation. Stateful applications, for example, are not a good fit for serverless computing. Fortunately, Azure provides many different compute offerings that cover virtually every cloud scenario. For help finding the right one for your application, see [Choose an Azure compute service for your application](https://docs.microsoft.com/azure/architecture/guide/technology-choices/compute-decision-tree?azure-portal=true).

## Learning path summary

Congratulations. You've completed the final module in the _Deploy applications with Azure DevOps_ learning path. The main focus of this learning path is deploying applications by using Azure Pipelines.

In this learning path, you accomplished a lot, including:

* Building a basic release pipeline that deploys a web application to App Service.
* Expanding your basic release pipeline to a multistage pipeline that deploys to various development, test, and staging environments.
* Running both functional and nonfunctional tests in the pipeline.
* Implementing a blue-green deployment that updates the application and requires minimal downtime.
* Extending pipelines to add support for different deployment targets, such as Azure Functions.

You can apply what you've learned to the applications and services that you work on.

## Continue the journey

This learning path focused on deploying applications by using Azure Pipelines. You know that you can use the Azure portal, the Azure CLI, or Azure PowerShell to provision resources on Azure. But how will you scale out your deployments to meet global demand?

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines/?azure-portal=true), you'll help the Tailspin team answer this question. There, you learn how to use _infrastructure as code_ to describe and automatically provision the infrastructure that you need for your application.

For more self-paced, hands-on learning related to Azure DevOps, also check out [Azure DevOps Labs](https://www.azuredevopslabs.com?azure-portal=true).