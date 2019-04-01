In this module, you learned how you can use deployment slots in Azure App Service to test and stage new versions of your apps. You also learned how to swap those deployment slots. You swap slots both to deploy a tested app to production and to roll back a deployed app, when there are unexpected problems.

When you consider using deployment slots, remember that Azure warms up an app before a swap and that traffic redirection is instantaneous. The result is that your app is deployed with no interruption in service or drop in performance.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

- [Set up staging environments in Azure App Service](https://docs.microsoft.com/azure/app-service/deploy-staging-slots)
- [Azure subscription and service limits, quotas, and constraints](https://docs.microsoft.com/azure/azure-subscription-service-limits)
- [Azure App Service Static IP Restrictions](https://docs.microsoft.com/azure/app-service/app-service-ip-restrictions)