## What is Node.js?

**Node.js** is an open-source JavaScript runtime environment. Designed for server-side execution, it runs outside the context of a web browser. You can learn more about the details on the [official Node.js site](https://nodejs.org?azure-portal=true).

## Node.js and Azure

Azure provides first-class support for Node.js. This means that developers can take their existing codebase and, in most cases, deploy it to Azure as-is. As far as Azure is concerned, hosting Node.js solutions is comparable to hosting .NET solutions, assuming that the proper dependencies are configured. Azure also provides the means to configure environment variables for application settings, which means you can continue to load settings and secrets using standard Node.js mechanisms.

Once deployed to Azure, Node.js applications can connect to resources within Azure, across VPN connections, and anywhere else accessible via the internet. This includes consuming databases, document stores, and all the other resources and services Node.js developers rely on to be successful.

## Node.js and Azure DevOps

Node.js developers will find a welcoming environment in Azure DevOps. Although it provides a wide range of features for managing the entire software lifecycle, developers can optionally cherry pick the features desired to make their process as efficient as possible. Even if just using Azure Pipelines to build and deploy source code pulled in from GitHub or another repo, Node.js is supported via a variety of build, test, and deploy tasks. And if those aren't available, you can always execute arbitrary scripts to fill gaps as needed.