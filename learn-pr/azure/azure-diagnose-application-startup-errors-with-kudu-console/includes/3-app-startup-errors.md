Azure App Service diagnostics provide an intelligent and interactive interface to help you troubleshoot your app. No configuration is required. You can use Azure App Service diagnostics to diagnose error code 500 errors that occur when you run a web application.

## Azure App Service diagnostics

In the **Diagnose and Solve problems** option in an Azure App Service web app, you can choose the options that best describe the issue with your app. This unit helps you diagnose an ASP.NET Core app startup issue when you host by using Internet Information Services (IIS).

In Visual Studio, an ASP.NET Core project defaults to IIS Express hosting during debugging. IIS Express is a lightweight, self-contained version of IIS that's optimized for developers. IIS Express makes it easy to use the current version of IIS to develop and test websites. 

Here are common error categories when ASP.NET Core apps are hosted on Azure App Service and IIS:

- **Web App Down**
- **Web App Slow**
- **High CPU Usage**
- **High Memory Usage**
- **Web App Restarted**

To debug these errors, you can collect information from the following sources:

- **Browser behavior** (status code and error messages)
- **Application event log entries**
- **ASP.NET Core Module stdout and debug log entries**

The following sections focus on application startup errors.

## App startup errors

Common ASP.NET Core app startup errors include:

- 500.30 In-Process Start Failure
- 502.5 Process Failure
- 500 Internal Server Error
- Connection reset

### 500.30 In-Process Start Failure

Common causes of this error are that the application failed to start, or the application started and then stopped. You can identify the error by checking the system event log or by enabling logging through the application's process stdout messages. You also can troubleshoot this error by attaching a debugger to the application process.

### 502.5 Process Failure

The worker process of the ASP.NET Core Module fails to start. This failure occurs when the app has configuration errors. You can diagnose this error by using the application event log.

### 500 Internal Server Error

The 500 Internal Server Error occurs with the app's code during startup or while creating a response. The application event log states that the app started normally, which means that the app did start, but it can't generate a valid response. You can run the app in the Kudu console to troubleshoot the issue.

### Connection reset

A connection reset error occurs after the headers are sent and it's too late for the server to send a 500 Internal Server Error message. View the application logs to help resolve this issue.

The exercises in the following units can help you diagnose startup errors by using the Kudu console and the application event log in the Azure portal.
