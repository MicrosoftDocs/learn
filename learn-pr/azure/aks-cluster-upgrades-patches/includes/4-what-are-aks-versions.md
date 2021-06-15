
Changes such as updates and upgrades often happen especially in the software development world. The deployment team at Songify decided to set up the Azure Kubernetes Service clusters prior to learning [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/), the language that is used to deploy containers to a Kubernetes cluster. By the time they were ready to deploy the containerized applications to Azure Kubernetes Service clusters, the cluster versions they had set up is now out of support. Azure Kubernetes Services tends to follow the **N-2** rule when it comes to supporting Kubernetes versions. 

## What is the N-2 rule? 

Think of **N** as the current latest stable version that Kubernetes has released. And **-2** as the previous two minor versions from **N**.

That means if Kubernetes released version *1.20.x* today, Azure Kubernetes Service will provide support for version *1.20.x* and *1.19.x* and *1.18.x*. However, version *1.17.x* will go out of support which means within 30 days of the release of version *1.20.x*, support for version *1.17.x* will become deprecated so you have 30 days to upgrade your clusters to ensure they stay in support.

 :::image type="content" source="../media/draft/3-n-minus-2-example.png" border="false" alt-text="An image that shows when Kubernetes releases version 1.20, Azure Kubernetes Service will deprecate support for version 1.17 because it is out of scope of the N-2 version support rule.":::

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

There are several ways Azure Kubernetes Service will announce cluster version updates. These include the AKS release calendar, email notification, and Azure Advisor. 

#### AKS Release Calendar 
 :::image type="content" source="../media/draft/3-aks-release-calendar.png" border="false" alt-text="An image that shows Azure Kubernetes Services announcing upcoming Kubernetes version releases and deprecation through the AKS Release Calendar.":::

Azure Kubernetes Service announces the upcoming Kubernetes versions it will support and deprecate through the [AKS Release Calendar](https://docs.microsoft.com/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar) with details about the new releases on [GitHub](https://github.com/Azure/AKS/releases) to keep AKS users informed and up to date.

These announcements are a great way to plan ahead to avoid using Azure Kubernetes Service cluster versions that go out of support.

#### Email Notification 
Azure Kubernetes Service will also send out email notification and service health notification to the AKS cluster owners that are impacted by the latest version updates to notify them that they have 30 days to upgrade their existing AKS cluster versions. 

 :::image type="content" source="../media/draft/3-service-health-and-email-notification.png" border="false" alt-text="An image that shows Azure Kubernetes Services announcing new Kubernetes version releases that could impact existing AKS clusters to AKS users through Azure Service Health issues and email notification to notify them that they have 30 days to upgrade their AKS clusters versions before it goes out of support.":::
#### Azure Advisor 
Azure Kubernetes Service will also announce to users who are impacted by the latest Kubernetes version updates through Azure Advisor particularly if the AKS cluster versions they are currently running will go out of support. 

 :::image type="content" source="../media/draft/3-azure-advisor-announcement.png" border="false" alt-text="An image that shows Azure Kubernetes Services announcing new Kubernetes version releases that could impact existing AKS clusters to AKS users through Azure Advisor.":::

## How to safely upgrade an AKS cluster? 

Suppose the Songify deployment team has already deployed their containerized applications onto an AKS cluster version that will go out of support within the next 30 days. They must upgrade to the latest Kubernetes version supported by Azure Kubernetes Service while ensuring the applications do not suffer from any downtime during the upgrade.

### The Blue/Green deployment method

The Blue/Green deployment method requires two production environments, a blue environment and a green environment that are almost identical. The router responsible for directing traffic will route all traffic to one environment. This will be the live environment. The other environment is kept offline where new features and patches could be tested. When testing is complete, the router switches and routes traffic to the other environment. This brings the offline environment online and takes the online environment offline.

For example, the Songify deployment team following a Blue/Green deployment methodology will need to create two identical AKS cluster environments, a blue environment that is currently live and a green environment that is currently offline.

 :::image type="content" source="../media/draft/3-route-traffic-to-blue-environment.png" border="false" alt-text="An image that shows all traffic routed by a router to the AKS cluster in the blue environment.":::

When they upgrade their AKS clusters to the latest supported version, they make the upgrade to the AKS cluster in the green environment and test the green environment to ensure no issues arise from the upgrade. 

 :::image type="content" source="../media/draft/3-upgrading-aks-cluster-in-green-environment.png" border="false" alt-text="An image that shows the AKS clusters in the green environment are being upgraded.":::

Once the green environment is ready to go, they can switch the router to direct all user traffic to the green environment and take the blue environment offline. 

 :::image type="content" source="../media/draft/3-route-traffic-to-green-environment.png" border="false" alt-text="An image that shows the router has switched to route traffic to the AKS clusters in the green environment.":::

One of the benefits of Blue/Green deployment is that if Songify detected an issue with the upgraded ASK cluster versions in the green environment, they can roll back to the blue environment by switching the router and thereby minimizing application downtime.

 :::image type="content" source="../media/draft/3-rollback-to-blue-environment.png" border="false" alt-text="An image that shows the rollback process by making a switch at the router level back to the blue environment.":::
