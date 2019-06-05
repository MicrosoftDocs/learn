Azure App Service diagnostics provides an intelligent and interactive interface that helps you troubleshoot your app with no configuration required. 

As an IT admin for a resort and hotel company, you need to be prepared to handle issues on your web applications starting from 500 errors or page startup errors or site down issues.

In this unit, you'll learn how kudu console can help you diagnose the different app startup errors. 

## What is kudu console?

Kudu is a troubleshooting and analysis tool for capturing memory dump using logs and configuration parameters on Microsoft Azure Web Apps. Kudu Console provides both command line and file browser access to your sites. You can access the kudu console of the web page, use *{yoursite}.scm.azurewebsites.net* URL and click on **Debug Console**.

Some of the things you can do with kudu console:

1. Run commands - Use it to do most standard console operations: changing folder, copy/rename/delete files, and so on. You can also run git commands like git log, git status to diagnose some issues.

1. Navigate folder UI - You can access the site folder and the console window simultaneously navigates to the same folder, so the two halves of the kudu console work together. 

1. Download files and folder - For files and folders, you can download the file or a zip file containing the contents of the folder, respectively. 

1. Upload files and folder - Use drag and drop into the Kudu Console's file explorer UI.

1. Upload and expand zip file - Dragging and dropping a zip file into Kudu Console, will copy the content of the expanded zip file. It is an efficient way to upload a large number of small files and folders.

1. View and edit text files - You can edit files through Kudu Console using Ace for in-browser editing. Editor provides an interface to investigate and identify issues.You can also use it to edit the web.config file, with syntax checking and highlighting.

## App startup errors

Some ASP.NET Core app startup errors are: 502.5 Process Failure, 500 Internal Server Error, and Connection reset.

### 502.5 Process Failure 

The worker process of the ASP.NET Core Module fails to start. This failure is caused when there are configuration errors in the app. This can be diagnosed using the Application Event Log.

### 500 Internal Server Error

The 500 internal server error occurs with the app's code during startup or while creating a response. The application event log states that the app started normally, which means that the app did start, but it cannot generate a valid response. You can run the app in Kudu Console to troubleshoot the issue.

### Connection reset

Connection reset error occurs after the headers are sent and it is too late for the server to send 500 Internal Server Error. This error will occur when the complex objects of the response are not serialized in the right order. Application logging will help resolve this issue.