Azure App Service diagnostics provides an intelligent and interactive interface that helps you troubleshoot your app with no configuration required. The 500 errors experienced when running a web application can be diagnosed using App Service diagnostics.

## Azure App Service Diagnostics

The **Diagnose and Solve problems** in the Azure App Service web app provides the options to choose the options that best describe the issue with your app. This module helps you to diagnose ASP.NET Core app startup issue when hosting with **Internet Information Services (IIS)**.

In Visual Studio, an ASP.NET Core project defaults to IIS Express hosting during debugging. IIS Express is a light-weight self contained version of IIS optimized for developers. It makes it easy to use the current version of IIS to develop and test websites. 

The common errors seen when hosting ASP.NET Core Apps on Azure App Service and IIS are:
-**Web App Down**
-**Web App Slow**
-**High CPU Usage**
-**High Memory Usage**
-**Web App Restarted**

To debug these errors you can collect the information from following sources:

- **Browser behavior**: Status code and error messages
- **Application event log entries**
- **ASP.NET Core Module stdout and debug log entries**

This module will particularly deal with application startup errors.

## App startup errors

Some ASP.NET Core app startup errors are: 500.30 In-Process Start Failure, 502.5 Process Failure, 500 Internal Server Error, and Connection reset.

### 500.30 In-Process Start Failure

Some of the common causes for this error are that the application failed to start, or that it started and then stopped. The error can be identified by checking the system event log or enable logging through the application process stdout messages. You can also troubleshoot this error by attaching a debugger to the application process. 

### 502.5 Process Failure 

The worker process of the ASP.NET Core Module fails to start. This failure is caused when there are configuration errors in the app. This can be diagnosed using the Application Event Log.

### 500 Internal Server Error

The 500 internal server error occurs with the app's code during startup or while creating a response. The application event log states that the app started normally, which means that the app did start, but it cannot generate a valid response. You can run the app in Kudu Console to troubleshoot the issue.

### Connection reset

Connection reset error occurs after the headers are sent and it is too late for the server to send 500 Internal Server Error. Application logging will help resolve this issue.

The hands-on labs in this module will help diagnose startup errors using the Application Event Log through Kudu console.