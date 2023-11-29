In this module, you learned about Azure App Service plans and how they're used to define the compute resources for running applications in Azure App Service. These plans can be configured with a specific region, number of virtual machine instances, and size of virtual machine instances. The pricing tier of the App Service plan determines the features and cost. Pricing tiers include Free and Shared plans for development and testing purposes. Pricing tiers also include Isolated plans for mission-critical workloads.

You learned about scaling in Azure App Service. Scale up involves increasing the CPU, memory, and disk space by changing the pricing tier. Scale out increases the number of virtual machine instances running the application. Autoscaling allows you to automatically adjust the number of resources based on the load on your application. Autoscale can be configured with metric-based or time-based rules.

The main takeaways from this module are:
- Azure App Service plans are used to define the compute resources for running web applications in Azure App Service.
- The pricing tier of the App Service plan determines the features and cost, with options ranging from Free and Shared plans to Isolated plans.
- Scaling in Azure App Service can be done through scale up (changing the pricing tier) or scale out (increasing the number of virtual machine instances).
- Autoscaling allows for automatic adjustment of resources based on application load, with metric-based and time-based rules.

## Learn more with documentation

- [Azure App Service plans](/azure/app-service/overview-hosting-plans). This article provides an overview of App Service plans. 

- [Manage an App Service plan in Azure](/azure/app-service/app-service-plan-manage). This guide shows how to create and manage an App Service plan.

- [Scale up an app in Azure App Service](/azure/app-service/manage-scale-up). This article shows you how to scale your app in Azure App Service. 

## Learn more with self-paced training

- [Scale apps in Azure App Service](/training/modules/scale-apps-app-service/). Learn how autoscale operates in App Service. Learn to identify autoscale factors, enable autoscale, and create autoscale conditions.

- [Scale an App Service web app to efficiently meet demand with App Service scale up and scale out](/training/modules/app-service-scale-up-scale-out/). Learn how to respond to changing demand by incrementally increasing the resources available.