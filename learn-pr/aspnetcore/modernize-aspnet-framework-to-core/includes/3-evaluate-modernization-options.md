Imagine you're an employee of a pizza company named Contoso Pizza. Your manager has asked you to evaluate whether you should upgrade an existing internal application written in ASP.NET MVC 5 running on .NET Framework 4.8 to ASP.NET Core.

## Option 1: Stay as-is

ASP.NET MVC on .NET Framework continues to be supported and maintained by Microsoft. While it's not a good choice for new projects, you may decide that it's the best option for your existing project. As you weigh the costs and benefits of upgrading your applications, you should consider this as a valid option. You can still explore the benefits of migrating your existing ASP.NET application to Azure using the [Migrate an ASP.NET web application to Azure with Visual Studio](/learn/paths/migrate-aspnet-web-application/) learning path.

## Option 2: Full upgrade to ASP.NET Core

If your project timeline and budget allow for a full upgrade to .NET Core, you should consider this option. This will provide you the full benefits of .NET Core, and can simplify issues encountered on running in a mixed environment.

## Option 3: Incremental Upgrade

In a large number of cases, development teams decide to implement a phased update to .NET Core. This will allow you to continue to use the existing ASP.NET MVC 5 application, but will allow you to upgrade the .NET Core runtime in a series of smaller steps. This is generally approached by [dividing the application by either vertical slices or horizontal layers](/dotnet/architecture/porting-existing-aspnet-apps/incremental-migration-strategies), and approaching each upgrade as a separate step.

## Additional opportunities

ASP.NET Core provides you some additional opportunities, which you may want to consider either in as part of your upgrade plan or as a follow-up to your upgrade plan.

## Migrate to the cloud

ASP.NET Core is optimized for cloud hosting, and you may consider migrating all or portions of your applications to the cloud either as part of or as a follow-up to your upgrade to ASP.NET Core. You can simplify the migration of your .NET Framework web apps to the cloud with minimal or no code changes with the [Azure App Service Migration Assistant](https://azure.microsoft.com/services/app-service/migration-assistant/), a free and simple path to automatically migrate web applications from on-premises to the cloud.

## Update to container-based deployment

While you were previously constrained to IIS hosting for ASP.NET MVC 5, you may now deploy your ASP.NET Core application to a container-based deployment model. See our [Microservices with .NET](https://dotnet.microsoft.com/apps/aspnet/microservices) guidance for more information on why and how to use container-based deployment with ASP.NET Core.