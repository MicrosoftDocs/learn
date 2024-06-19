If you've created a Kubernetes cluster to host containers for your .NET Aspire application, both your microservices and their supporting services benefit from automated configuration and can respond rapidly to changes in demand. However, Azure provides Platform-as-a-Service (PaaS) implementations of common cloud-native services such as databases and caches. Using them instead of managing your own containers for them can reduce your administrative load and improve your application's availability.

Imagine you're employed by an outdoor equipment retailer. You have deployed your new customer-facing eShop, which uses .NET Aspire, to production and you record increasing user demand. Your administration team responds to changes in demand by changing the number of containers. Now you want to investigate whether using Azure cloud services can improve the service you provide to customers.

In this module, you'll learn how to take advantage of Azure cloud services to host database and cache services outside of your deployment cluster. You'll also see the daily benefits that such an approach can realize.

## Learning objectives

At the end of this module, you'll be able to:

- Migrate database, cache, and other resources from containers to cloud services.
- Configure connection strings for deployment by editing .NET Aspire manifest files.
- Send telemetry data to Azure Application Insights.
- Deploy resources to Azure by creating Bicep files with the Azure Developer CLI.
