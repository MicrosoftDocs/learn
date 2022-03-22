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

![Graphical user interface, application, Word

Description automatically generated](../media/asd-module-troubleshoot-web-app-down-scenarios-with-app-service-diagnostics-clean-copy-22-01.png)

[Alt text: Screenshot of a HTTP 503 Server Error detected.]