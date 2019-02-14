Runtime instrumentation, the type of Application Insights instrumentation that does not require modifying an app's code, can be enabled when the app is first created or at any time afterwards.

In the scenario involving the video application, the developers want to start gathering instrumentation data about the application quickly, without having to modify it.

Here, you will learn about what Application Insights is capable of, and how to enable it.

## What is Application Insights?

Application Insights is an Azure service that helps you to monitor the performance and behavior of web applications.

<!-- TODO move the bit about runtime/sdk/client here -->

It primarily captures two kinds of data: **events** and **metrics**. Events are individual data points that can represent any kind of event occurring in your application, including both technical events occurring within the application runtime, as well as events related to the business domain of the application or actions taken by users. Metrics are measurements of values, typically taken at regular intervals, that are not tied to specific events. Like events, metrics may be related to the application's runtime or infrastructure (such as the length of a queue), or related to the application's business domain or users (such as how many videos are viewed in an hour).

### Application Insights resources

Application Insights is represented in Azure as a resource deployed to one of your subscriptions. Each Application Insights resource you create is a repository for application telemetry data and includes the various displays and configuration tools viewable from the Azure portal. To send telemetry data to an Application Insight resource from an app, the app must be configured with the *instrumentation key* of the Application Insights resource. Once the resource starts to receive telemetry data, you can use the Azure portal to explore and analyze it.

### Visualizations

Navigating to an Application Insights resource in the Azure portal lets you visualize the telemetry captured from an application in a variety of ways.

- **Live metrics streams:** Charts that display performance values as they vary in near real time.
- **Metrics Explorer:** Shows how metrics have varied over time.
- **Alerts** Messages automatically sent to app administrators when target metrics exceed specified thresholds. You can use alerts to ensure that your team is aware of critical issues immediately.
- **Profiler:** Shows how a set of requests, such as those for a single web page, were delivered. You can use these profiles, for example, to see which page elements load slowly.
- **Application Map:** Displays the components of your application and how they link to each other. You can use the data shown with each component to diagnose performance bottlenecks and failure hotspots.
- **Usage Analysis:** Information about your app's users. For example, you can see numbers of unique users and sessions, as well as information about user retention.

These tools are all available in the Azure portal and in Microsoft Visual Studio. You can also view Application Insights data in Microsoft Power BI, which you may already be using for business intelligence.

![Application Insight Architecture](../media/2-app-insights-architecture.png)

### Run-time instrumentation and build-time instrumentation

There are two methods that you can use to configure your app to send data to Application Insights:

- **Runtime instrumentation:** Runtime instrumentation captures telemetry without requiring any modification to the web app's source code. This turnkey solution can be quickly enabled from the Azure portal when the web app is first created or anytime afterwards. Use this method when you want to set up Application Insights without involving developers or when code management policies prevent you from modifying the app's source code. Note that some advanced data displays are not available when you use runtime instrumentation exclusively.
- **Build-time instrumentation.** In this method, a server-side SDK is added to the web app's code by developers. For example, in an ASP.NET Core app, developers reference a NuGet package to access the SDK. When you instrument your app with the Application Insights SDK, you can enable full functionality and the richest set of displays in Application Insights. Furthermore, you can add custom events and telemetry to your code to monitor unusual or unique behavior.

Additionally, you can enable **client-side instrumentation** for an app by including a standard Application Insights JavaScript library in pages delivered to your apps users. Client-side instrumentation captures information about the experience of the app from the perspective of your users, such as page load times, details of browser exceptions, and performance data about AJAX calls. Azure App Service web apps can be configured to automatically inject the client SDK and capture many client-side metrics, and additional JavaScript code can be added by app developers to capture data about specific events. Client-side instrumentation enables displays such as usage analysis.

In this module, you will enable runtime instrumentation and client-side instrumentation to begin quickly gathering telemetry about your app without having to modify it.

### Web App requirements

Enabling runtime instrumentation and automatic client-side instrumentation techniques requires the use of a Windows web app. These features rely on capabilities of IIS, the web server technology that powers Windows-based apps on App Service. The use of Application Insights within Linux apps is fully supported, but you must modify the application's code to reference the Application Insights SDK.

Any Windows App Service web app can benefit from the run-time instrumentation techniques described in this module. However, web apps created with the ASP.NET or ASP.NET Core frameworks have the best integration with Application Insights: they automatically record framework-specific data in Application Insights such as stack traces and dependency information.

## Enabling runtime instrumentation

You can enable runtime instrumentation for a Windows App Service web app at two times:

- When you create the web app, in the web app **Create** blade, click on **Application Insights** and then click **Enable**.
    ![Enable Application Insight at web app creation](../media/2-enable-app-insights-at-web-app-creation.png) 
- If you chose to create a web app without enabling Application Insights, you can enable it at any later time on the **Application Insights** page of the web app's blade.

The wizard that both of these options present you with will help you to create a new Application Insights resource if you don't already have one in your subscription.

## Enabling automatic client-side telemetry

To automatically inject the JavaScript SDK and necessary configuration into pages served by your web app, add a new application setting named **APPINSIGHTS_JAVASCRIPT_ENABLED** and setting the value to **true**. <!-- TODO note about windows-only here as well -->