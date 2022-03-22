This unit focuses on how you know your app is working correctly. 

## App Service runtime logs

The App Service stores files beyond your web app, including log files. These log files include:

|Log type|Purpose|
|--|--|
| Deployment, installation, and start up| This log ends in `_docker.log` and is how you debug your deployment and container start up issues. Every app runs in a container on App Service. When you pick the runtime, a container with that runtime is provided for you.|
|Running web app| This log ends in `_default_docker.log` and includes all the information your running web app provides for logging.|

Because your logs can grow beyond the file size limits provided, you can choose to use a process to offload the files to a service with more space or you can turn off logging at the host. 

Some popular npm logging modules allow you to continue to log errors and information and provides the infrastructure for the logs to use Application Insights or other logging services. This allows you to use the popular logging packages and have the data automatically managed on Azure. 
 
## Application Insights

Application Insights is part of Azure Monitor and integrates directly with the App Service providing monitoring and metrics. 

Without any code added to your application, you can see failures, exceptions, and other information about your web app. 

You added Application Insights to your App Service as part of the creation process. 
