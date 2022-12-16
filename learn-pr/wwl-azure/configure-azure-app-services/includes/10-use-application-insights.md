Azure Application Insights is a feature of Azure Monitor that lets you monitor your live applications. You can integrate Application Insights with your App Service configure to automatically detect performance anomalies in your apps. 

Application Insights is designed to help you continuously improve the performance and usability of your apps. The feature offers powerful analytics tools to help you diagnose issues and understand what users actually do with your apps.

### Things to know about Application Insights

Let's examine some characteristics of Application Insights for Azure Monitor.

- Application Insights works on various platforms including .NET, Node.js and Java EE.

- The feature can be used for configurations that are hosted on-premises, in a hybrid environment, or in any public cloud.

- Application Insights integrates with your Azure DevOps process, and has connection points to many development tools.

- You can monitor and analyze data from mobile apps by integrating with Visual Studio App Center.

:::image type="content" source="../media/app-insights-16629887.png" alt-text="Diagram that shows Azure Application Insights receiving information from web pages, client apps, and web services, which is transferred to Alerts, Power BI, and Visual Studio." border="false":::

### Things to consider when using Application Insights

Application Insights is ideal for supporting your development team. The feature helps developers understand how your app is performing and how it's being used. Consider monitoring the following items in your App Service configuration scenario.

- **Consider Request rates, response times, and failure rates**. Find out which pages are most popular, at what times of day, and where your users are. See which pages perform best. If your response times and failure rates go high when there are more requests, then perhaps you have a resourcing problem.

- **Consider Dependency rates, response times, and failure rates**. Use Application Insights to discover if external services are degrading your app performance.

- **Consider Exceptions**. Analyze the aggregated statistics, or pick specific instances and drill into the stack trace and related requests. Both server and browser exceptions are reported.

- **Consider Page views and load performance**. Collect the number of page views reported by your users' browsers and analyze the load performance.

- **Consider User and session counts**. Application Insights can help you keep track of the number of users and sessions connected to your app.

- **Consider Performance counters**. Add Application Insights performance counters from your Windows or Linux server machines. Monitor performance output for the CPU, memory, network usage, and so on.

- **Consider Host diagnostics**. Integrate diagnostics from Docker or Azure into your app Application Insights.

- **Consider Diagnostic trace logs**. Implement trace logs from your app to help correlate trace events with requests and diagnose issues.

- **Consider Custom events and metrics**. Write your own custom events and metric tracking algorithms as client or server code. Track business events such as number of items sold, or number of games won.