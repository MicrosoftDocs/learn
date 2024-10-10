Your team lead asked you to publish your team's app in a few different ways. 

First, you published the app as a framework-dependent deployment. This means that the app requires the .NET Core runtime to be installed on the target machine. Next, you published the app as a self-contained deployment for Windows and again for Linux. The self-contained deployment, though, is much larger because it includes the .NET runtime with the app. Finally, you deployed the app to Azure.

Congratulations! You're now ready to deploy your app to various environments. You can deploy your app to a web server, a container, or to Azure. You can even deploy your app to a Raspberry Pi running Linux. The possibilities are endless!

> [!CAUTION]
> Make sure to clean up the Azure resources you created during this module to avoid incurring accidental charges. You can delete the Azure App Service web app you created using the Azure Tools extension for Visual Studio Code.

## Learn more

- [`dotnet publish` command](/dotnet/core/tools/dotnet-publish)
- [Kestrel web server in ASP.NET Core](/aspnet/core/fundamentals/servers/kestrel?view=aspnetcore-8.0&preserve-view=true)
- [ASP.NET Core Module (ANCM) for IIS](/aspnet/core/host-and-deploy/aspnet-core-module?view=aspnetcore-8.0&preserve-view=true)
- [Deploy ASP.NET Core apps to Azure App Service](/aspnet/core/host-and-deploy/azure-apps/?view=aspnetcore-8.0&preserve-view=true)
- [Run an ASP.NET Core app in Docker containers](/aspnet/core/host-and-deploy/docker/building-net-docker-images?view=aspnetcore-8.0&preserve-view=true)