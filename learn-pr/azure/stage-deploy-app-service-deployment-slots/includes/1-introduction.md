When you have a successful or business-critical web app, you need to update it to respond to business changes, user demands, or security issues, but you cannot permit interruptions in service.

Suppose you work for a company that runs a popular social media web platform. The user interface for this platform is implemented as an ASP.NET Core MVC web app hosted in Azure App Service. You make regular updates to the source code of this web app and roll them out to production. However, these updates have occasionally caused problems when bugs have not been spotted during testing. Also, when you roll out an update, there is a short interruption in service followed by a period of slow responsiveness while the code is deployed and compiled.

You want a way to ensure that a new version of the app can be deployed with zero downtime and no interruption in service. You also want to be able to rapidly roll back a new deployment to the previous version if it causes problems.

## Learning objectives

In this module, you will:

- Create a deployment slot as a staging environment in Azure App Service
- Deploy a new version of a web app to a slot by using git
- Configure which app settings are swapped and which are not swapped when you deploy a slot
- Swap slots to deploy a web app or roll back a deployment

## Prerequisites

- Basic experience deploying apps to Azure App Service