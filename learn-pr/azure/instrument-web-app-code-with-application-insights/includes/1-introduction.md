You can use the Application Insights SDK in your web app's code to track custom events and metrics, and automatically capture detailed telemetry about performance and behavior.

Imagine you work for a company that makes easy-to-use digital video cameras. Your ASP.NET Core web app is deployed to Azure App Service, and enables your users to upload and share videos with the community. You've enabled Application Insights in App Service, but your app doesn't have any code in place to make use of Application Insights.

Business stakeholders are looking for more information about how customers are using the videos displayed by the app. For example, how often do users watch a video to its end, and how often do they interrupt it in the middle? How often do they choose to *Like* a video? This kind of information isn't captured by Application Insights with your current setup.

In this module, you'll add the server-side Application Insights SDK to an app and take advantage of the extra functionality that this approach enables.

## Learning objectives

In this module, you will:

- Learn the benefits of adding the Application Insights SDK to the source code for an Azure App Service web app
- Install the Application Insights SDK in an ASP.NET Core web app
- Instrument a web app with code to gather information about custom events

## Prerequisites

- Knowledge of the basic features and benefits of Application Insights
- Ability to create and deploy Azure App Service web apps
- Basic knowledge of web application development