Fourth Coffee created a Cheesecake application to provide its consumers a variety of cheesecake flavours, recipes, and consumer order history. Unfortunately, during the beta test launch, the application crashed.

Using various features within App Service Diagnostics, you were able to resolve all the issues and get it back to a working state. First, you identified that there is a spike in 503 errors using Web App Down. Then, you were able to nail down on the cause of a recent code change you made in the Rewrite module. Also, you identified that there is an application crash event. You set up Crash Monitoring to automatically monitor the application for future crashes and to collect stack trace info and memory dump upon another crash event for further investigation. By inspecting the collected memory dump, you were able to root cause the crash to a function that started on a new thread. Later, you used Ask Genie to find relevant set of diagnostics and documentation from credible sources by describing the issue using your own words.

Imagine how much work it would have been if you had to troubleshoot without the help of various features in App Service Diagnostics. You would need to set up your own logging and monitoring solutions to identify the problem. Then, spend numerous hours searching the web for what might be a related issue. Then you will need to manually trigger a memory dump hoping that it would capture the right set of information to find out the root cause of the crash.

By leveraging App Service Diagnostics, you can access resource-specific diagnostics that have been authored by domain experts with little to no configuration. You are now able to troubleshoot your application and get it into production more quickly. 

 
