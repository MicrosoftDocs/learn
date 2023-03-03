Great work! In this module, we extended a release pipeline to add support for deploying an Azure Functions app. The single release pipeline now builds a multi-project solution and deploys different components to different cloud targets in Azure.

While this module specifically focused on an app that uses Azure App Service and Azure Functions, the fundamentals covered apply across a wide range of build and deployment targets. You can also see how Azure Pipelines can scale to support even the most sophisticated scenarios.

## Learn more

In this module, you worked with Azure Functions, which are one of the development models within the broader Azure serverless computing offerings. Azure Functions was a great solution for the Tailspin team, but your needs will vary, and it's important to understand which compute options are best for your scenario. Explore these resources to learn more.

There are quite a few serverless offerings under the Azure umbrella, and there's some overlap between various services. For a more in-depth review of some key serverless options, including Azure Functions, Microsoft Flow, Azure Logic Apps, and Azure App Service WebJobs, reference [Choose the right integration and automation services in Azure](/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs?azure-portal=true).

Azure Functions is also a great option for microservice solutions like the one the Tailspin team is evolving towards here. To understand the different options for microservices on Azure, including Azure Functions, Kubernetes, and Service Fabric, check out [Choosing an Azure compute option for microservices](/azure/architecture/microservices/design/compute-options?azure-portal=true).

However, serverless isn't always appropriate for every situation. Stateful applications, for example, aren't a good fit for serverless computing. Fortunately, Azure provides many different compute offerings that cover virtually every cloud scenario. For help with finding the right one for your application, reference [Choose an Azure compute service for your application](/azure/architecture/guide/technology-choices/compute-decision-tree?azure-portal=true).
