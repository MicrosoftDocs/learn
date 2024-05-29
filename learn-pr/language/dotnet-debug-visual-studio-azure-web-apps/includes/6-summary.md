In this module, you learned how to troubleshoot and debug ASP.NET Core applications running on Azure App Service using Visual Studio. You explored how Visual Studio can provide a debugging experience similar to local development for remote apps, which can be useful for tracking down difficult issues. Troubleshooting issues directly with the debugger can often provide faster results than browsing logs or using monitoring tools. Along the way, you also learned about debugging symbols and basic considerations around environment configurations.

In this module, you learned how to:

- Use the Visual Studio debugger to debug an app hosted in Azure App Service.
- Work with debugging symbols in Visual Studio.
- Inspect and troubleshoot configuration values for apps running in different environments.

## Clean up resources

The sandbox environment you activated will dispose of resources automatically. However, if you created resources in your own Azure subscription and you don't want to continue to use this application, make sure to delete the Azure App Service instance and the associated services to avoid undesired costs. You can delete the top-level resource group to remove all of the resources you created at the same time.

Follow these steps in the Azure portal to delete the resource group:

1. In the Azure portal search bar, search for the `mslearn-github-browser` resource group you created, then select it from the results.
1. On the `mslearn-github-browser` resource group Overview page, select the **Delete resource group** button at the top.
1. Enter the resource group name `mslearn-github-browser` in the confirmation dialog and select **Delete**.
1. Select **Delete** again to confirm deletion.

The process to delete the resource group can take a few minutes to complete.

## Next steps

Continue learning more about .NET debugging with:

- [Tutorial: Debug a .NET Core console application using Visual Studio](/dotnet/core/tutorials/debugging-with-visual-studio)
