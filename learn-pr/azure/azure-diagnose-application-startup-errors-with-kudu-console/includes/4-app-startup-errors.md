Azure App Service diagnostics provides an intelligent and interactive interface that helps you troubleshoot your app with no configuration required. The 500 errors experienced when running a web application can be diagnosed using App Service diagnostics.

## App startup errors

Some ASP.NET Core app startup errors are: 500.30 In-Process Start Failure, 502.5 Process Failure, 500 Internal Server Error, and Connection reset.

### 500.30 In-Process Start Failure

You can verify this error using the Application Event Log. Some of the common causes for this error are that the application failed to start, or that it started and then stopped. The error can be identified by checking the system event log or enable logging through the application process stdout messages. You can also troubleshoot this error by attaching a debugger to the application process. 

### 502.5 Process Failure 

The worker process of the ASP.NET Core Module fails to start. This failure is caused when there are configuration errors in the app. This can be diagnosed using the Application Event Log.

### 500 Internal Server Error

The 500 internal server error occurs with the app's code during startup or while creating a response. The application event log states that the app started normally, which means that the app did start, but it cannot generate a valid response. You can run the app in Kudu Console to troubleshoot the issue.

### Connection reset

Connection reset error occurs after the headers are sent and it is too late for the server to send 500 Internal Server Error. This error will occur when the complex objects of the response are not serialized in the right order. Application logging will help resolve this issue.

## Web project development

To diagnose the application startup errors, you will need to build a ASP.NET Core Model-View-Controller (MVC) web app. The ASP.NET Core MVC framework is a lightweight, open source, highly testable presentation framework optimized for use with ASP.NET Core.

ASP.NET Core MVC provides a patterns-based way to build dynamic websites that enables a clean separation of concerns.