A web app down scenario could be caused by several issues such as an HTTP server error. Recall the ‘Cheesecake’ app example, there are a few potential issues which would cause this application to crash and become unresponsive. To narrow down the potential causes, use App Service Diagnostics to diagnose and troubleshoot. Here, you will review the functionalities of App Service Diagnostics, troubleshoot a HTTP 503 server error, and identify an application crash event.

## App Service Diagnostics Functionalities

App Service Diagnostics is a power tool available in the Azure Portal that can help you troubleshoot your app with no configuration required. When you run into issues with your app, App Service Diagnostics points out what’s wrong to guide you to the right information to troubleshoot and resolve issues more easily. 

App Service Diagnostics monitors the functionality of the custom apps you create using Azure App Service. It gives your valuable insights into your web app and helps you discover patterns that cause your app not to work properly.

## Troubleshoot an HTTP Server Error with Web App Down

Web App Down is a troubleshooting feature within App Service Diagnostics that runs resource specific checks on your app service to identify issues causing your app service to experience downtimes. To locate Web App Down, first navigate to the overview page of your App Service resource. Then, click on Diagnose and Solve Problems found in the left navigation menu. This will open App Service Diagnostics. Immediately, you will be presented with different troubleshooting categories to choose from. From here, navigate to ‘Availability and Performance’ where you will find the Web App Down feature.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4QU13]

Once you are there, you can monitor your application availability and the platform availability. This will help you determine whether the issue you are experiencing is due to your application or the platform. You will also notice several diagnostic checks have been run on your application to call out any issues. These checks are authored by domain experts and point out issues specific to your App Service in the form of insights. 

The following table describes the 4 statuses used to indicate the gravity of each insight.

| Status| Description |
| - | - |
| Successful| Successful insight indicates that no issue is detected. |
| Informational| Informational insight may share additional information that does not impact the health of your App Service. |
| Warning| Warning insight is associated with a potential problem. |
| Critical| Critical insight means an issue has been detected and it needs your immediate action to resolve. |


In this scenario, the issue is related to a HTTP 503 Server Error. You can click on the insight to view thorough diagnostics information regarding the HTTP Server Error. For this example, in the image below, you will notice there is ‘x’ number of 503s detected on this App Service. Also, in the additional details, it points out exactly where this error is coming from, the rewrite module. 

:::image type="content" source="../media/asd-module-troubleshoot-web-app-down-scenarios-with-app-service-diagnostics-clean-copy-22-01.png" alt-text="<Screenshot of a HTTP 503 Server Error detected.>"::: 

## Identify an Application Crash Event with Application Crashes

Before we go into details on how to identify an application crash and configure a tool to collect rich information for troubleshooting, letâ€™s first understand why these crashes happen and their impact on the workloads. A crash happens when an exception in your code goes un-handled and reaches system default handler which terminates the process. These unhandled exceptions are also known as second chance exceptions. Unlike first chance exceptions, these exceptions are NOT caught by app code or ASP.NET runtime. Therefore, when your application crashes, all the in-flight requests are aborted, and an end user may experience an HTTP 502 error for those requests.

Application Crashes is a troubleshooting feature within App Service Diagnostics. Like Web App Down, it runs checks authored by domain experts on your application to identify an application crash event in the last 24 hours. You can locate it in the left navigation of the Availability and Performance page. 

Once you are there, you will see an insight indicating the status of your application regarding application crashes in the last 24 hours. In this scenario, the issue is related to an application crash with the exception code 0xE0434352 â€“ CLR Exception. Also, paired with this information, you can see the 24-hour timeline on application crash events, helping you identify the exact time when a crash event occurred. You can also check more details on un-handled ASP.NET Exceptions table. However, if this is not enough information, you can enable crash monitoring to capture memory dumps at the time of your application crash to collect more information to root cause your unhandled exceptions.

:::image type="content" source="../media/asd-module-troubleshoot-web-app-down-scenarios-with-app-service-diagnostics-clean-copy-22-02.png" alt-text="<Screenshot of an application crash event with exception code 0xE0434352 - CLR Exception detected.>":::

