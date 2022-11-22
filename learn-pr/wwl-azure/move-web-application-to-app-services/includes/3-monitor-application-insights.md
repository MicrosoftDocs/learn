Being able quickly to detect and address issues in your web application is made possible by [Azure Monitor](/azure/azure-monitor/overview), which is a set of services that give you insights into how your app is running and its relationship to other services in your solution. One service, Application Insights, is the topic of this unit since it provides the most direct and actionable data for your newly deployed web app.

## What is Application Insights

Application Insights is a software application that runs in your app and captures telemetry data that is used to produce dashboards, alerts, and integrations to help you keep your app running at its best. The performance impact of Application Insights is minimal and the advantage of using the service can outweigh any resource usage in your app.

The chart below shows how data flows from web pages and client apps, web services, and background services to Application Insights. From Application Insights, the data can be used in various endpoints like alerts, Power BI, Visual Studio, a Rest API, or exported for later analysis.

## How to use Application Insights

Once you've set Application Insights up on your application, you can monitor many aspects of your application and dig deep into the performance of your application. Application Insights have four categories of tools that perform many different functions. 

### Investigate

The tools in this section enable you to capture metrics on performance, any failures that may have occurred, your app's availability in percent on a per-hour basis, and other metrics in these categories. The Application Insights overview gives you similar insights, but these tools allow you to go deep.

### Monitoring

You can define alerts and the metrics you want to track. Some of the tools are flexible, so you can customize the items you want to monitor to provide the type of insights specific to your needs. For example, this section includes Azure Monitor Workbooks. Microsoft Docs describes Workbooks as follows, "Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. They allow you to tap into multiple data sources from across Azure, and combine them into unified interactive experiences."

### Usage

As the category name implies, these data give you insights into who is using your application and how. You can get insights into user funnels, flows, and user cohorts. With these insights you can adjust your application to fit your users needs better and gain insights into how your users flow through your application.

### Configure

While this section doesn't contain all the configuration options for Application Insights, tools here enable you to view application usage and costs at a high level, you also are able to set up work items, things you want to accomplish with your application, and view your Application Insight's high-level properties.

Application Insights is a powerful set of tools that will help you understand how your application is performing, where you can make improvements, and how your users are active on your app.