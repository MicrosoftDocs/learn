In this unit, we'll review the potential challenges that you might encounter when migrating web applications hosted on-premises in your own server at a high level. We'll provide context on the kinds of dependencies that web applications have on features of Internet Information Services (IIS) and why this causes a problem. This critical background information provides the context that you might need to better understand the need for an assessment.

## Why move a web application to Azure App Service?

Azure App Service is a fully managed platform for your web apps. You can use it to run and scale your web apps with minimal setup. Microsoft manages the infrastructure, operating system updates, load balancing, and scale-up/scale-down logic as needed. 

You can configure settings in a simplified user interface and can explore the performance of the application as it runs, but there's little else to do on your part. This makes Azure App Service an attractive alternative to running your applications in your own server environment. In your own server environment, you must deal with hardware costs, setup, operating system installation, update and configuration, server software installation, updates and configuration, and more.

Several features make working with Azure App Service powerful.  

The autoscale feature allows an administrator to set the maximum number of instances that the web app should be allowed to scale to, as well as the traffic thresholds. Then, the decision-making logic in App Service decides whether to scale up or scale back down.

Deployment slots allow operations or DevOps to deploy a new version of the web application to a live testing or staging environment, where manual or automated integration tests can be performed. After the new version passes all tests, operations can "swap the slots" to move the staged app into production. If problems arise after the deployment, operations can once again "swap the slots" to move the previous version back into production.

App Service diagnostics provide an interactive interface where the troubleshooter can answer a few questions. The interface produces a full diagnostic report that's specific to the type of problem that your application is encountering. Additionally, tools like health check-up, Application Insights, and Navigator (the interactive dependency diagram), will help you understand where problems lie.

## What is the Azure App Service Migration Assistant?

The Azure App Service Migration Assistant is part of a larger suite of applications that help organizations with their transition to the cloud. The Migration Assistant provides a guided wizard-like user experience that performs two tasks:

1. It performs an assessment of a specific web app installed on Windows Server. It evaluates the dependencies of the web app to determine whether a migration to Azure App Service is possible without modification to the web app.
2. If the assessment proves that the web app can be migrated, the Migration Assistant performs the migration. You'll need to give the Migration Assistant access to your Azure account, select which resource group you want to use, and select a name for the web app, among other details.

Alternatively, the Azure App Service Migration Assistant generates an Azure Resource Manager template that you can use to migrate the web application in a more automated and repeatable way.

## Why perform an assessment?

In some organizations, web applications were originally built with the assumption that the applications would always have access to low-level features of IIS. For example, some developers built features like monitoring, logging, and security on top of ISAPI filters. The filters provided access to incoming requests before they were passed to the ASP.NET application. They also provided access to outgoing responses that the ASP.NET application generated.

However, one of the benefits of using a platform as a service (PaaS) offering like Azure App Service is that the cloud provider (Microsoft, in this case) manages the hardware and software so you don't have to. That's where the cost and time savings come from. But this means that your applications will have access to fewer of the lower-level features of Windows Server and IIS. If your applications depend on these lower-level features, you might not be able to take advantage of Azure App Service without modifications.  

### What types of problems does the assessment check for?

The Migration Assistant looks for specific features of a web application to ensure that Azure App Service can accommodate that feature, or that the Migration Assistant can automatically migrate that feature. The following table gives some insight into the checks that the Migration Assistant does:

| Readiness check | Explanation |
|---|---|
| Port bindings | Because Azure App Service allows for only standard web traffic, this readiness check ensures that the web app listens on only ports 80 (for HTTP traffic) and 443 (for HTTPS traffic). |
| Protocols | Because Azure App Service works with only HTTP and HTTPS protocols, this readiness check ensures that the web app handles only HTTP-based protocols. For example, if your web app depends on Windows Communication Foundation, it won't pass this readiness check. |
| Certificates | Azure App Service can handle security certificates, but this readiness check will warn you that the Migration Assistant won't migrate the certificate automatically for you. |
| Location tags | Location tags allow you to keep configuration for all web apps hosted on a server in a single file rather than hosted in individual web.config files for each web app. Azure App Service apps use a preconfigured IIS applicationhost.config file and don't support the location tags feature. The settings for each web app you'll migrate should be moved into individual web.config files. This readiness check identifies the use of location tags.  |
| ISAPI filters | Azure App Service provides some support for ISAPI filters, but it depends on how the ISAPI filter was implemented. The Migration Assistant won't migrate an application that depends on an ISAPI filter. You first must remove the ISAPI filter from your application, migrate, and then add the ISAPI filter manually in Azure App Service. |
| Application pools | Because Azure App Service supports one application pool per app, this readiness check ensures that your web app relies on only a single application pool. |
| Application pool identity | Azure App Service apps are hosted in an IIS worker process that runs in a system-managed account associated with the application pool. This is also the default identity used by on-premises installations of IIS. This readiness check ensures that the web app is configured to run in the default identity. |
| Authentication type | Azure App Service apps support a different set of authentication types than apps hosted on IIS running on-premises. This readiness check ensures that a web app is configured to use anonymous authentication. After migration, you can manually configure the authentication type on Azure App Service. |
| Application settings | This readiness check warns you of custom application settings in the web.config file that should be moved to **Azure App Service** > **Configuration** > **Application settings** instead. |
| Connection strings | This readiness check determines if database connection strings stored in the web.config file are pointing to on-premises databases. If so, the Migration Assistant will give you the option to set up hybrid connections. |
| Frameworks | The Migration Assistant supports only ASP.NET and PHP. If your app uses a different framework, you'll be unable to perform the automatic migration. |
| Configuration error | The Migration Assistant ensures that your on-premises IIS instance is configured correctly and does not return an error when scanned. This readiness check ensures that there are no underlying problems with the web app before migration. |
| Virtual directories | Azure App Service stores all files in a fixed directory structure. The Migration Assistant will move files into the appropriate subdirectories. But it can't migrate applications with virtual directories that are backed by UNC shares. |

The information in this table was summarized from the [Azure App Service Migration Assistant wiki](https://github.com/Azure/App-Service-Migration-Assistant/wiki/Readiness-Checks).


### What if the assessment finds a problem?

If the Azure App Service Migration Assistant finds problems when assessing your web application, you can:

- Update the application to replace features that are dependent on lower-level extensibility features of IIS. This task can be relatively simple depending on the functionality in question. For example, you can replace the custom logging features that were dependent on an ISAPI filter with Azure Application Insights. Application Insights requires only a few lines of code to be added to an application and provides a wealth of actionable reports.
- Update the application by temporarily disabling the feature that's blocking the migration. The Migration Assistant can guide you to do this.
- Deploy the application as is to an Azure virtual machine. Although you wouldn't gain the benefits of using Azure App Service and would be required to maintain the operating system, you would no longer need to maintain the hardware. You would also have a single point of management for all your web services.

The [Azure App Service Migration Assistant wiki](https://github.com/Azure/App-Service-Migration-Assistant/wiki/Readiness-Checks) contains potential remediation steps for many of the problems found during an assessment.

## Recap

Here are the most important takeaways from this unit:

- The Azure App Service Migration Assistant will look for incompatibilities between your on-premises web apps and what's supported on Azure App Service. If there's a problem, there's usually a way to fix (or disable the feature that's causing) the problem on-premises. You can then retry the Migration Assistant. 
- If there are no blocking problems, the Migration Assistant will migrate your web app to Azure App Service for you.
