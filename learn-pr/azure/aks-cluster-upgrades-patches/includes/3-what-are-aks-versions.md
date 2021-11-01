Changes such as updates and upgrades often happen especially in the software development world. By the time Nod Publishers were ready to deploy the containerized applications to Azure Kubernetes Service clusters, the cluster versions they had set up is now out of support. Azure Kubernetes Services tends to follow the **N-2** rule when it comes to supporting Kubernetes versions. 

## What is the N-2 rule? 

Think of **N** as the current latest stable version that Kubernetes has released. And **-2** as the previous two minor versions from **N**.

That means if Kubernetes released version *1.20.x* today, Azure Kubernetes Service will provide support for version *1.20.x* and *1.19.x* and *1.18.x*. However, version *1.17.x* will go out of support which means within 30 days of the release of version *1.20.x*, support for version *1.17.x* will become deprecated so you have 30 days to upgrade your clusters to ensure they stay in support.

 :::image type="content" source="../media/3-n-minus-2-example.png" border="false" alt-text="An image that shows when Kubernetes releases version 1.20, Azure Kubernetes Service will deprecate support for version 1.17 because it is out of scope of the N-2 version support rule.":::

For each minor version that Azure Kubernetes Service maintains cluster support for, only the latest stable two patch versions for each minor version will be supported.

This means if Kubernetes decided to release patch version 1.19.9 and 1.18.10, the current patch versions supported by Azure Kubernetes Services will change to:

| Current supported versions | New supported versions | 
| :------------------------- | :--------------------- | 
| 1.20.2 | 1.20.2 | 
| 1.20.1 | 1.20.1 | 
| 1.19.8 | 1.19.9 | 
| 1.19.7 | 1.19.8 | 
| 1.18.9 | 1.18.10 | 
| 1.18.8 | 1.18.9 | 

## What is the AKS cluster version release and deprecation process?

There are several ways Azure Kubernetes Service will announce cluster version updates. These include the AKS release calendar, email notification, Azure Advisor, Azure Event Grid and preview versions.

#### AKS Release Calendar 
 :::image type="content" source="../media/3-aks-release-calendar.png" border="false" alt-text="An image that shows Azure Kubernetes Services announcing upcoming Kubernetes version releases and deprecation through the AKS Release Calendar.":::

Azure Kubernetes Service announces the upcoming Kubernetes versions it will support and deprecate through the [AKS Release Calendar](/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar) with details about the new releases on [GitHub](https://github.com/Azure/AKS/releases) to keep AKS users informed and up to date.

These announcements are a great way to plan ahead to avoid using Azure Kubernetes Service cluster versions that go out of support.

#### Email Notification 
Azure Kubernetes Service will also send out email notification and service health notification to the AKS cluster owners that are impacted by the latest version updates to notify them that they have 30 days to upgrade their existing AKS cluster versions. 

 :::image type="content" source="../media/3-service-health-and-email-notification.png" border="false" alt-text="An image that shows Azure Kubernetes Services announcing new Kubernetes version releases that could impact existing AKS clusters to AKS users through Azure Service Health issues and email notification to notify them that they have 30 days to upgrade their AKS clusters versions before it goes out of support.":::

#### Azure Advisor 
Azure Kubernetes Service will also announce to users who are impacted by the latest Kubernetes version updates through Azure Advisor particularly if the AKS cluster versions they are currently running will go out of support. 

 :::image type="content" source="../media/3-azure-advisor-announcement.png" border="false" alt-text="An image that shows Azure Kubernetes Services announcing new Kubernetes version releases that could impact existing AKS clusters to AKS users through Azure Advisor.":::

#### Preview versions
Before a new minor version of Kubernetes becomes supported by Azure Kubernetes Service, it often is released as a preview version. A preview version allows you to assess the next version ahead of its release. This gives you time to test your existing AKS cluster workloads with the next release and prepare to upgrade when the version becomes generally available.

