Imagine you're an employee of a pizza company named Contoso Pizza. Your team maintains an internal application that's written in ASP.NET MVC 5 and running on .NET Framework 4.8. Your manager has asked you to evaluate whether you should upgrade the application to ASP.NET Core.

## Option 1: Stay as-is

ASP.NET MVC on .NET Framework continues to be supported and maintained by Microsoft. While it's not a good choice for new projects, you might decide that it's the best option for your existing project. As you weigh the costs and benefits of upgrading your applications, you should consider staying on .NET Framework as a valid option. You can still explore the benefits of migrating your existing ASP.NET application to Azure using the [Migrate an ASP.NET web application to Azure with Visual Studio](/training/paths/migrate-aspnet-web-application/) learning path.

## Option 2: Full upgrade to ASP.NET Core

If your project timeline and budget allow for a full upgrade to ASP.NET Core, you should consider this option. A complete upgrade will provide you with the full benefits of ASP.NET Core, and can simplify issues encountered on running in a mixed environment.

## Option 3: Incremental upgrade

In many cases, development teams decide to implement a phased update to ASP.NET Core. This migration strategy allows you to continue to use the existing ASP.NET MVC 5 application, but allows you to upgrade the .NET runtime in a series of smaller steps. You'll start by [dividing the application by either vertical slices or horizontal layers](https://github.com/dotnet-architecture/eBooks/blob/1ed30275281b9060964fcb2a4c363fe7797fe3f3/current/porting-existing-aspnet-apps/Porting-Existing-ASP.NET-Apps-to-.NET.pdf), then upgrade each as a separate step.

## Additional opportunities

Upgrading to ASP.NET Core provides you some new opportunities to host and deploy your application. You might want to consider these, either as part of your upgrade plan or as a follow-up to your upgrade plan.

## Migrate to the cloud

ASP.NET Core is optimized for cloud hosting, and you might consider migrating all or portions of your applications to the cloud either as part of or as a follow-up to your upgrade to ASP.NET Core. You can simplify the migration of your .NET Framework web apps to the cloud with minimal or no code changes with the [Azure App Service Migration Assistant](/azure/app-service/app-service-asp-net-migration#app-service-migration-tools-and-resources), a free and simple path to automatically migrate web applications from on-premises to the cloud.

## Update to container-based deployment

While ASP.NET MVC on .NET Framework was limited to running in IIS on Windows, ASP.NET Core apps have many deployment options, including containers. For more information on why and how to use container-based deployment with ASP.NET Core, see our [Microservices with .NET](https://dotnet.microsoft.com/apps/aspnet/microservices) guidance.
