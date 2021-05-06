The last time issues arose on your financial organization's application, customers couldn't access their accounts. Also, the issues with the application weren't resolved on time, so customer satisfaction was negatively affected. Your organization wants to avoid a repeat of these issues when it moves to Azure.

You'll detail how to integrate Azure Monitor Application Insights with your applications. You'll explore how to use it to check the health of applications, and resolve issues faster.

## Criteria for assessing Application Insights

You use Application Insights to:

- Analyze and address issues and problems that affect your application's health and performance.
- Improve your application's development lifecycle.
- Measure your user experience, and analyze users' behavior.

## Integrate Application Insights with your applications

To integrate Application Insights with your applications, you set up an Application Insights resource in the Azure portal. You also instrument your application with Application Insights. Instrumentation refers to enabling the collection of monitoring data from your app by using an agent or an SDK. Depending on your application’s language and platform, the approach to instrumentation will vary. In many cases, instrumentation can be performed without access to the source code using codeless attach in the Portal or using an agent.

For example, in your .NET and .NET Core applications hosted on Azure App Services, you can enable the collection of monitoring data with Application Insights with a toggle in the Azure portal.

![Screenshot of onboarding to Application Insights in Portal.](../media/4-application-insights-01.png)

Application Insights automatically collect data about your application’s performance and health. You can view this data in the Application Insights resource in the Azure portal. From there you can, for example, get a list of all failures that have been collected, and drill into each one.

![Screenshot of analyzing failures.](../media/4-application-insights-02.png)

To continue your investigation to the root cause of the error or exception, you can drill into one of the problematic transactions for a detailed end-to-end transaction view that includes dependencies and exception details.

![Screenshots of analyzing failure with en-to-end view.](../media/4-application-insights-03.png)

Application Insights also automatically detect app dependencies to support distributed tracing and create application topology views. You see this topology through the Application map option. View more details of each component in the map by selecting it. You can, among other things, view the slowest requests for an instance and investigate performance further. These detailed analytics help you understand the application better and respond to its needs.

![Screenshots of application map.](../media/4-application-insights-04.png)

## Monitor your applications' performance

You can further investigate slow transactions to identify slow requests and server-side dependencies. Drill down using the option to investigate performance from the application map, or using **Performance** on the left.

![Screenshot of analyzing performance.](../media/4-application-insights-05.png)

This view enables you to isolate slow transactions by selecting the time range, operation name, and durations of interest. You are also prompted with automatically identified anomalies and the commonalities across transactions. From here, you can drill into an individual transaction for an end-to-end view of transaction details with a Gantt chart of dependencies. You can also gain visibility into page views, and browser operations and dependencies if you instrument your web pages with Application Insights. Collecting this browser data requires adding some additional web page code to your pages. After the script is added, you access page views and their associated performance metrics via the Browser toggle.

## Analyzing user behavior

Instrumenting your web pages with Application Insights collects usage information to augment the server-side monitoring capabilities. Usage data includes number of users, sessions, events, browser version, OS version, and locations all coming from the same browser-side JavaScript instrumentation. Usage data answers questions such as which pages of your app are the most popular, where do users drop out, and what are the conversion and retention rates for specific pages.

![Screenshot of application events split by browser.](../media/4-application-insights-06.png)

The preceding example shows the most popular browser and versions. This type of information can be used to inform decisions for allocating functional and performance testing resources.

## Monitor your application’s availability

You can create availability tests to monitor the health of your applications continuously. Availability tests allow you to check the health of your application from different geographic locations.

![Screenshot of viewing application availability by locations over time.](../media/4-application-insights-07.png)

You can create an availability test in the Azure portal. You specify details like the frequency, the URL of your application, and locations from which to test it.

![Screenshot of availability test creation.](../media/4-application-insights-08.png)

The preceding example shows the configuration of a test that will send a request to an application every five minutes. The test is done from five geographic locations. When you've created your availability test, you'll see how your application is doing across different locations. Each dot in the earlier example represents a test that was run. A red dot means that a test failed. You can find more information about a failed test when you select a dot. You'll then see a detailed breakdown of the test failure, including information on what might have caused it. Use the information to respond appropriately.

## Receive notifications and take action

You also need to configure alert rules for your application’s performance and availability. Use alert rules to dictate how alerts should be handled. You specify the conditions that should trigger an alert. For example, Application Insights can send an alert if a specified number of locations are unavailable or if a certain number of exceptions are observed. And you specify who should be notified. Send notifications through email or text message. Or use runbooks and webhooks to respond to alerts in an automated way.

![Screenshot of alert creation.](../media/4-application-insights-09.png)