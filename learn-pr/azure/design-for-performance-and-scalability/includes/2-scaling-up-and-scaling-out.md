# Scaling up and scaling out

## Motivation

It's rare that we can exactly predict the load on our system: public facing applications might go viral or an internal application might need to support a larger user base as the business grows. Even when we can predict load, it's rarely flat: retailers have more demand during the holidays and sports websites peak during playoffs. In this section, we'll talk about why requirements are important, define _scaling up_ and _scaling out_, discuss why scaling out is usually preferred, and see how Azure implements scale out strategies. We'll also look at how so-called "serverless" and container technologies can mitigate much of the concern associated with scaling.

## What is scaling?

_Scaling_ is the process of managing your resources to ensure your application matches a set of performance requirements. These requirements should have been identified and confirmed before you start designing a solution.

When designing a solution, we should consider how individual components within our application scale and where the bottle necks may lie. For example, computationally intensive workloads require CPU cycles, low-latency in-memory processing may require higher memory and very high throughput or chatty applications may require additional bandwidth.

Scaling is the process of increasing or decreasing the level or amount of resource provisioned. If we have too many resources provisioned, then we will not be utilizing it efficiently and wasting money. If we have too few resources provisioned, then the performance of our application is impacted. The goal is to meet our defined performance requirements while optimizing for cost.

If demand was constant you could provision to meet that demand, but scaling is difficult because the demands of our application will change over time. If you're lucky that change will be predictable (or seasonal), but that is not typical of all applications.  Ideally, you want to provision the right amount of resources to meet demand and adjust as demand changes. We could achieve this using an approach called autoscaling, which we will discuss later.

Scaling is difficult in an on-premises scenario, where you purchase and manager your own servers. Investing in more hardware can be costly, and may be needed in some scenarios to reach peak demand. However, there is no easy way to then reduce the level of resource provisioned during times of low-demand on the system.

Dynamic scaling is a key benefit of Azure. Most Azure resources let you increase or decrease instances as demand changes and you can do this manually for any resource. Many resources have automated options so they monitor demand and adjust for you automatically. The automated options generally let you set thresholds for the minimum and maximum level of instances to be provisioned, and will add/remove instances based upon a performance metric (e.g. CPU utilization).

## What is scaling up?

Scaling up is the process where we increase the capability of a given instance. For example, in a virtual machine we could increase the virtual machine from 1 vCPU and 3.5 GB of RAM to 2 vCPUs and 7GB of RAM. 

Conversely, scaling down is the process where we decrease the capability of a given instance. For example, decreasing a virtual machine's level of resource from 2 vCPUs and 7GB of RAM to 1 vCPU and 3.5GB of RAM.

Consider that you are running an on-premises application and you have a limited capacity for adding extra machines to support  growth. Rather than adding more machines to solve the problem, you could  increase the provisioned resource for those machines already created. For example - If you are noticing high memory usage, then you may want to consider increasing the amount of RAM provisioned on your deployed boxes.

This idea of moving an application to a bigger physical server, or increasing the current level of resource could be considered in a cloud environment as well. Rather than scaling individual components, e.g. RAM or CPU, you generally scale based upon a SKU. 

Here are some examples of what scaling up/down means in the context of Azure resources:

* In Azure virtual machines, you scale based upon a virtual machine size. That size has a certain amount of vCPUs, RAM, local storage associated with it. For example, we could scale up from a Standard_DS1_v2 virtual machine (1 vCPU and 3.5GB of RAM) to a Standard_DS2_v2 virtual machine (2 vCPUs and 7GB of RAM).
* Azure SQL DB is a Platform as a Service (PaaS) implementation of Microsoft SQL Server. You scale up the level of resource provisioned at the database instance level.  You have the option to scale up based upon the number of Database Transaction Units (DTUs) or vCPUs. DTUs are an abstraction on underlying resource requirements and are a blend of CPU, IO and memory. You could scale your database instance from 500 DTUs to 250 DTUs.
* Azure App Service is a Platform as a Service (PaaS) approach to hosting your websites on Azure. You host these sites on an underlying server farm, also known as an App Service Plan. You can scale the App Service Plan up or down between tiers and have options inside of those tiers. For example an S1 app service plan has 1 vCPU and 1.75GB of RAM per instance, or we coudl scale up to an S2 app service plan, which has 2 vCPUs and 3GB of RAM per instance.

To handle this scenario in an on-premises environment, you would typically have to wait for procurement of the needed hardware and installation before you can start using the new level of scale. In Azure, the clusters are already deployed and available for you to use. You simply need to select the alternate level of scale that you are looking to use.

You may need to consider the use of scaling up in your solution, depending upon the cloud services that you have chosen.

For example, if you choose to scale up in Azure SQL Database (a PaaS offering), then the service deals with scaling up individual nodes and continues the operation of your service.

Alternatively, if you choose to scale up a Virtual Machine, then the Virtual Machine will potentially be redeployed and require a reboot if you happen to migrate across different underlying hosts.

Equally, you can consider scaling down as an option (provisioning fewer resources than currently required). This can lead to cost optimizations in your solution, though you should always consider this in line with the non-functional requirements of your project.

## What is scaling out?

_Scaling out_ is the process of adding more instances to support the load of your solution. For example, if our website frontend was hosted on virtual machines, then we could increase the number of virtual machines to serve the level of load on the system.

In contrast, _scaling in_ is the process of removing instances that are no longer needed to support the load of your solution. For example, if the website front ends have a low utilization, then we may want to decrease the number of instances to save cost.

<!--- I wonder if we should explain what "scale out" means for each common resource type? VM, DB, etc? --->

Here are some examples of what scaling out/in means in the context of Azure resources:

* For the infrastructure layer, you would likely use virtual machine scale sets to automate the addition and removal of extra instances. Azure virtual machine scale sets let you create and manage a group of identical, load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.
* In an Azure SQL DB implementation, you could share the load across multiple database instances by sharding. _Sharding_ is a technique to distribute large amounts of identically structured data across a number of independent databases.
* In Azure App Service, the App Service Plan could be considered as the underlying web server farm hosting your content. Scaling out in this context means that you are increasing the number of virtual machines in this farm. Similarly to virtual machine scale sets, the number of instances can automatically increase or decrease in response to certain metrics or a schedule.

Scaling out is an easy approach to handling extra amounts of load in your system. When scaling out a Platform as a Service (PaaS) resource, they are generally configurable as a property in the Azure Portal, using command line tools or ARM Templates.

Throughout this unit, we have eluded to the fact that you can automate scaling in/out (adding or removing instances) of your deployment. This is known as a platform feature called [Autoscale][what-is-autoscale]. This means you no longer have to worry about manually adding or removing instances. Instead, you can set a minimum and maximum threshold of instances and scale based upon certain demands (e.g. queue length, CPU utilization) or schedules (e.g. week days between 5pm - 7pm).

## Considerations when adding or removing instances

When opting for a scale out approach, the startup time of your application can make a significant difference to the rate at which your application can scale. If your web app takes 2 minutes to start up and be available for users, then that means each of your instances will take 2 minutes until they are available to your users.

Also consider how your application handles state. When your application scales in (i.e. removes instances to serve your users), then those machines will be removed and any state stored on the machine is no longer available. This is why a common pattern is to externalize state to another source (e.g. a Redis Cache or SQL Database), which makes those instances stateless. As the instance is now stateless, this means we do not to need worry about which individual instances are available, they are all performing the exact same function and are deployed in the same way.

## Scenario: Scaling on Azure

Lamna Healthcare operate a patient management and booking system. The management system is responsible for the booking of appointments and patient records across dozens of hospitals and local doctors surgeries. The local health service is running at full capacity, and no growth is expected at the moment. The system itself is running on a PHP Website hosted in Azure App Service.

The load pattern of the application is predictable, as they primarily operate Monday to Friday between the hours of 9 to 5.  From Tuesday through to Friday, the system averages at 1,200 transactions per hour across the entire system. During the weekend, it handles 500 transactions per hour. After the quiet of the weekend, Mondays are busy with an average of 2,000 transactions per hour.

The application is currently operating on an S1 App Service Plan, though the operations team have noticed a very high level of CPU utilization (over 95%) across all instances is having an impact on the processing and loading times of the application. In a cloud environment, having highly utilized resources is not necessarily a bad thing. It means that you are gaining value for your money, as the resources provisioned are being well used. You need to balance this against the performance of your application.

As the Lamna Healthcare team have observed a number of processing timeout errors in the application, they decide to _scale up_ the App Service Plan level for the deployed instances from S1 (1 vCPU and 1.75GB of RAM) to S2 (2 vCPUs and 3GB of RAM). The team easily achieve this by [scaling out using the Azure portal][app-service-cli-scale], though could have achieved the same thing using a single command in the [Azure CLI][app-service-cli-scale], Azure PowerShell or using ARM Templates.

The team decide that they want to automate the number of instances deployed based upon a schedule, as their load profile is very predictable. Therefore, they configure the app service plan's autoscale schedule. Let's assume 2 instances sufficiently handles 500 transactions per hour. Based upon this, the team could then scale to 6 instances for Tuesday - Friday and 8 instances for a Monday to meet the requirements (based upon insight and monitoring from load tests).

Autoscale could also provided an added benefit, preparing for those unforeseen scenarios. The team may suddenly encounter some higher than expected load on the weekend (perhaps more appointments in the winter season due to colds and flu). For example, they may could setup a rule to Scale out by 1 instance when CPU percentage is above 90% for a certain period of time, and decrease by 1 instance when CPU percentage is below 15% over a given period of time.

## Scaling via alternate services

You need to consider scaling differently, depending upon the Azure service that you choose to implement. In this section, we will consider some of the additional options available.

### Serverless

Imagine a scenario where you could spend your time building and deploying apps, and not having to manage underlying servers or even worry which service to run. That's effectively the aim of serverless computing. Serverless computing is typically event driven, meaning some code, workflow or operation will trigger as a reaction to some event happening in near-real time.

Some typical characteristics of serverless computing are that you only pay for the resources you use (i.e. consumption based), and is typically designed for large amounts of scale. [Azure Functions][azure-functions-overview], [Azure Container Instances][azure-container-instances-overview] and [Logic Apps][azure-logicapps-overview] could be considered as examples of serverless computing in Azure.

Think about services like Azure Storage, Event Grid and Data Lake. Those services are considered consumption-based services, as you pay for the amount of storage per GB or number of events routed through the component. You do not worry about the underlying configuration or what servers are provisioned to help you achieve the activity, you just use the service and build your solution. Sometimes these types of services are also referred to as serverless.

Let's revisit the Lamna Healthcare example. There could be some potential for cost saving and ease of management. Consider an API endpoint, or some function that does not run frequently. Instead of hosting this in Azure app service or a virtual machine (where the team have to pay for the resources that you have provisioned), they could use an Azure Function App using a consumption based plan. This would enable the team to only pay for the resources required to process transactions, and scale would be directly in line with the number of transactions in the system.

## Containers

A container is a way of hosting application code in a virtualized environment, that is consistent across all instances of its deployment. The difference between a virtual machine and a container is that a virtual machine is virtualized at the hardware level, so you will see a virtual network interface card, virtual cpu, etc. Instead, a container is virtualized at the operating system level.

Containers are naturally suited to scale out scenarios, particularly because you do not need to wait for a VM to boot up. Their characteristics also allow for a consistent environment (i.e. all container instances will be deployed alike), they can be run anywhere and have good portability and have predictable performance due to resource isolation at the operating system level.

Let's consider the above Lamna Healthcare example once again. Rather than running Azure App Service or Azure Functions, they could use containers to host the web front end website and any backend API endpoints. Those containers would be hosted on a number of worker machines called nodes, and each of those nodes can have many containers running on top of them. They would likely have many instances of a particular container (for example, the front end website) to accommodate for higher volume of load in the system.

There are two primary options for deploying and scaling containers in Azure;

* **Azure Kubernetes Service (AKS)**

  Azure Kubernetes Service allows you to setup Azure Virtual Machines to act as your nodes. Azure also hosts the Kubernetes management plane on your behalf, so you will only be charged the cost of running your worker nodes (i.e. those hosting your containers).

  To increase the number of nodes (your worker VMs in Azure), you could use the [Azure CLI to increase that manually][aks-scale]. At time of writing, there is a preview [Cluster Autoscaler on AKS][aks-cluster-autoscaler] available to enable auto-scaling of your worker nodes. Inside of your Kubernetes cluster, you could consider utilising the [Horizontal Pod Autoscaler][kubernetes-horizontal-pod-autoscaler] to scale up the number of containers that you have deployed.

* **Azure Container Instances (ACI)**
  
  [Azure Container Instances][aci-overview] is a serverless model that allows you to create and execute containers on-demand. You are charged only for the time that the server is executing **per second**!

  If you are using Kubernetes to orchestrate your containers, then you can connect Azure Container instances to your environment using the [Virtual Kubelet][virtual-kubelet]. This could be an option to add additional containers to your Azure Kubernetes Service deployment without having to wait for extra worker nodes (VMs) to be provisioned. However, at time of writing, the Virtual Kubelet is described as experimental software and should not be used in production scenarios.

This section has briefly covered the topic of containers, though they could be an entire series of topics in their own right. This could include range from a containers overview through to container orchestrator options, and you should certainly continue further reading elsewhere if you are interested! The main point here is that containers lend themselves well towards a scalable architecture.

<!-- links -->
[aci-overview]: https://docs.microsoft.com/en-gb/azure/container-instances/container-instances-overview
[aks-scale]: https://docs.microsoft.com/en-us/azure/aks/scale-cluster]
[aks-cluster-autoscaler]: https://docs.microsoft.com/en-us/azure/aks/autoscaler
[app-service-autoscale]: https://docs.microsoft.com/en-gb/azure/monitoring-and-diagnostics/monitoring-autoscale-get-started
[app-service-cli-scale]: https://docs.microsoft.com/en-us/azure/app-service/scripts/app-service-cli-scale-manual
[app-service-portal-scale]: https://docs.microsoft.com/en-us/azure/app-service/web-sites-scale#scale-up-your-pricing-tier
[azure-container-instances-overview]: https://docs.microsoft.com/en-gb/azure/container-instances/container-instances-overview
[azure-functions-overview]: https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview
[azure-logicapps-overview]: https://docs.microsoft.com/en-gb/azure/logic-apps/logic-apps-overview
[kubernetes-horizontal-pod-autoscaler]: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
[virtual-kubelet]: https://github.com/virtual-kubelet/virtual-kubelet
[what-is-autoscale]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-autoscale
