# Scaling up and scaling out

## Motivation

It's rare that we can exactly predict the load on our system: public facing applications might grow rapidly or an internal application might need to support a larger user base as the business grows. Even when we can predict load, it's rarely flat: retailers have more demand during the holidays and sports websites peak during playoffs. In this section, we'll: 

* Define _scaling up_ and _scaling out_
* Discuss why scaling out is preferred, and see how Azure implements scale out strategies
* Look at how so-called "serverless" and container technologies can mitigate much of the concern associated with scaling

## What is scaling?

_Scaling_ is the process of managing your resources to help your application meet a set of performance requirements.  When we have too many resources serving users, we won't be using it efficiently and wasting money. Too few resources available means that the performance of our application could be impacted. The goal is to meet our defined performance requirements while optimizing for cost.

In a world where application demand is constant, it's easy to predict the needed level of resource. In the real world, the demands of our applications change over time, so it can be harder to predict. If you're lucky, then that change will be predictable (or seasonal), but that is not typical of all applications. Ideally, you want to provision the right amount of resources to meet demand and adjust as demand changes. We could achieve this using an approach called autoscaling, which we will discuss later.

Scaling is difficult in an on-premises scenario, where you purchase and manager your own servers. More hardware can be costly, and may be needed in some scenarios to reach peak demand. However, there is no easy way to then reduce the level of resource provisioned during times of low-demand on the system.

Dynamic scaling is a key benefit of Azure. Most Azure resources let you add or remove instances as demand changes, though you can scale manually for any resource. Many resources have automated options so they monitor demand and adjust for you automatically. The automatic options let you set thresholds for the minimum and maximum level of instances that should be available, and will add or remove instances based upon a performance metric (for example, CPU utilization).

## What is scaling up?

Scaling up is the process where we increase the capacity of a given instance. A virtual machine could be increased from 1 vCPU and 3.5 GB of RAM to 2 vCPUs and 7 GB of RAM.

On the other hand, scaling down is the process where we lower the capacity of a given instance. For example, reducing a virtual machine's capacity from 2 vCPUs and 7 GB of RAM to 1 vCPU and 3.5 GB of RAM.

Imagine that you are running an on-premises application and you have a limited capacity for adding extra machines to support  growth. Instead of  adding more machines to solve the problem, you could increase the capability of the existing machines. If you are noticing high memory usage, then you may want to consider increasing the amount of RAM provisioned on your deployed boxes, as an example.

This idea of moving an application to a bigger physical server, or increasing the current level of resource could be considered in a cloud environment as well. Rather than scaling individual components, for example, RAM or CPU, you generally scale based upon a SKU. 

Here are some examples of what scaling up/down means in the context of Azure resources:

* In Azure virtual machines, you scale based upon a virtual machine size. That size has a certain amount of vCPUs, RAM, local storage associated with it. For example, we could scale up from a Standard_DS1_v2 virtual machine (1 vCPU and 3.5 GB of RAM) to a Standard_DS2_v2 virtual machine (2 vCPUs and 7 GB of RAM).
* Azure SQL DB is a Platform as a Service (PaaS) implementation of Microsoft SQL Server.  You can scale up a database based upon the number of Database Transaction Units (DTUs) or vCPUs. DTUs are an abstraction on underlying resource requirements and are a blend of CPU, IO, and memory. You could scale your database instance from 500 DTUs to 250 DTUs.
* Azure App Service is a Platform as a Service (PaaS) approach to hosting your websites on Azure. You host these sites on an underlying server farm, also known as an App Service Plan. You can scale the App Service Plan up or down between tiers and have options in those tiers. For example, an S1 app service plan has 1 vCPU and 1.75 GB of RAM per instance. We could scale to an S2 app service plan, which has 2 vCPUs and 3 GB of RAM per instance.

This would be much slower in an on-premises environment, as you would need to wait for hardware to be procured and installed. In Azure, the clusters are already deployed and available for you to use. You simply need to select the alternate level of scale that you are looking to use.

You may need to consider the use of scaling up in your solution, depending upon the cloud services that you have chosen.

For example, if you choose to scale up in Azure SQL Database (a PaaS offering), then the service deals with scaling up individual nodes and continues the operation of your service. If instead you are scaling up a virtual machine, then it may require a reboot, as a virtual machine could migrate across underlying hosts when rebooted or redeployed.

Scaling down can lead to cost optimizations in your solution, though you should be sure that you are meeting the performance requirements of your solution.

## What is scaling out?

_Scaling out_ is the process of adding more instances to support the load of your solution. For example, if our website frontend was hosted on virtual machines, then we could increase the number of virtual machines to serve the level of load on the system.

_Scaling in_ is the process of removing instances that are no longer needed to support the load of your solution. If the website front ends have low usage, then we may want to lower the number of instances to save cost.

Here are some examples of what scaling out/in means in the context of Azure resources:

* For the infrastructure layer, you would likely use virtual machine scale sets to automate the addition and removal of extra instances.
  * Virtual machine scale sets let you create and manage a group of identical, load balanced VMs.
  * The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.
* In an Azure SQL DB implementation, you could share the load across  database instances by sharding. _Sharding_ is a technique to distribute large amounts of identically structured data across a number of independent databases.
* In Azure App Service, the App Service Plan could be considered as the underlying web server farm hosting your content. Scaling out in this way means that you're increasing the number of virtual machines in the farm. As with virtual machine scale sets, the number of instances can be automatically raised or lowered in response to certain metrics or a schedule.

You can normally scale Platform as a Service (PaaS) resources by using either a property in the Azure portal, command-line tools or Resource Manager templates.

## Autoscale

We've hinted that you can automate scaling in/out (adding or removing instances for) your deployment. This platform feature is known as [Autoscale][what-is-autoscale]. With autoscale you no longer have to worry about manually adding or removing instances. Instead, you can set a high and low threshold of instances and scale based upon certain demands (for example, queue length or CPU utilization) or schedules (for example, weekdays between 5pm - 7pm).

## Considerations when adding or removing instances

When you use a scale-out approach, the startup time of your application can make a large difference to the rate that your application can scale. A web application with a start up time of two minutes means that each new instance will take two minutes until they are available to serve users.

Think about how your application handles state. When the application scales in (removes instances), any state stored on the machine is no longer available. A common pattern is to externalize state to another source (for example, a Redis Cache or SQL Database), helping to offload state from those instances stateless. A stateless instance means we don't need to worry about which individual instances are available. They are all doing the same job and are deployed in the same way.

## Throttling

We've established that the load on an application will vary over time. This may be due to the number of active or concurrent users and the activities being performed. Autoscale could be one approach, throttling may be another. We can safeguard performance limits by putting known limits into place at the application level, preventing the application from breaking.

Once the application has identified that it would breach a limit, throttling could begin and ensure the overall system SLA isn't breached.

Examples on how to implement the [throttling pattern][throttling-pattern] are discussed on the architecture center.

## Scenario: Scaling on Azure

Lamna Healthcare operates a patient management and booking system. The management system handles appointment bookings and patient records across dozens of hospitals and local doctors surgeries. The local health service is running at full capacity and no growth is expected at the moment. The system is running on a PHP Website hosted in Azure App Service.

The load pattern of the application is predictable, as they primarily operate Monday to Friday between the hours of 9 to 5.  From Tuesday through to Friday, the system averages at 1,200 transactions per hour across the entire system. During the weekend, it handles 500 transactions per hour. After the quiet of the weekend, Mondays are busy with an average of 2,000 transactions per hour.

The application's hosted on an S1 App Service Plan, but the operations team have noticed a high level of CPU utilization (over 95%) across all instances. The high usage is having an impact on the processing and loading times of the application. In a cloud environment, having highly utilized resources is not necessarily a bad thing. It means that you are gaining value for your money, as the resources deployed are being well used. Balance cost management against the desired performance of your application.

The team decide to _scale up_ the App Service Plan level for the deployed instances from S1 (1 vCPU and 1.75 GB of RAM) to S2 (2 vCPUs and 3 GB of RAM). They easily achieve this by [scaling out using the Azure portal][app-service-cli-scale], but could have achieved the same thing using a single command in the [Azure CLI][app-service-cli-scale], Azure PowerShell, or using Resource Manager templates.

The team decide that they want to automate the number of instances deployed based upon a schedule, as their load profile is predictable. They configure the app service plan's autoscale schedule. Let's assume two instances sufficiently handle 500 transactions per hour. The team could then scale to six instances for Tuesday - Friday and eight instances for a Monday to meet the requirements (based upon insight and monitoring from load tests).

Autoscale could also provide an added benefit, preparing for those unforeseen scenarios. The site may suddenly take higher than expected load on the weekend (more appointments in the winter season because of colds and flu). The team can set up autoscale to increase by one instance when CPU percentage is above 90% and reduce by one instance when usage is below 15%.

The team have used the throttling pattern inside of the patient booking logic. This helps prevent the system breaking by only allowing a certain volume of throughput through the system.

## Serverless

Imagine if you could spend your time building and deploying apps, not having to manage underlying servers or even worry which service to run. That's the aim of serverless computing. Serverless computing is typically event driven, meaning some code, workflow, or operation will trigger as a reaction to some event happening in near-real time.

Typical features of serverless computing are:

* You only pay for the resources you use (that is, consumption based)
* They are typically designed for large amounts of scale.

[Azure Functions][azure-functions-overview], [Azure Container Instances, and [Logic Apps][azure-logicapps-overview] could be considered as examples of serverless computing in Azure.

Think about services like Azure Storage, Event Grid, and Data Lake. Those services are considered consumption-based services, as you pay for the amount of storage per GB or the number of events routed through the resource. You don't worry about the underlying configuration or what servers are deployed to help you achieve the activity. You just use the service and build your solution. Sometimes these types of services are also referred to as serverless.

Let's revisit the Lamna Healthcare example. There could be some potential for cost saving and ease of management. Consider an API endpoint, or some function that does not run frequently. Instead of hosting thE API in Azure app service or a virtual machine, they could use an Azure Function App using a consumption-based plan. Azure functions would enable the team to only pay for the resources required to process transactions, and scale would be directly in line with the number of transactions in the system.

## Containers

A container is an approach to hosting applications in a virtualized environment. The difference between a virtual machine and a container is that a virtual machine is virtualized at the hardware level, so you will see a virtual network interface card and virtual cpu. Instead, a container is virtualized at the operating system level, so you don't worry about the virtual hardware.

Containers are naturally suited to scale out scenarios as you don't need to wait for a VM to boot up. Containers also allow for a consistent environment (all instances of a container are deployed alike). They can be run anywhere, have good portability and have predictable performance due to resource isolation at the operating system level.

Let's consider the above Lamna Healthcare example. Instead of running Azure App Service or Azure Functions, they could use containers to host the web front-end website and backend API endpoints. Those containers would be hosted on a number of worker machines called nodes. Each of those nodes can have many containers running on top of them. They host many instances of their front-end website and back-end API to allow for higher volume of load in the system.

There are two primary options for deploying and scaling containers in Azure;

* **Azure Kubernetes Service (AKS)**

  Azure Kubernetes Service allows you to set up virtual machines to act as your nodes. Azure hosts the Kubernetes management plane, so you will only be charged the cost of running your worker nodes (those hosting your container workloads).

  To increase the number of nodes (your worker VMs in Azure), you could use the [Azure CLI to increase that manually][aks-scale]. At time of writing, there is a preview [Cluster Autoscaler on AKS][aks-cluster-autoscaler] available to enable auto-scaling of your worker nodes. On your Kubernetes cluster, you could use the [Horizontal Pod Autoscaler][kubernetes-horizontal-pod-autoscaler] to scale up the number of instances of the container to be deployed.

* **Azure Container Instances (ACI)**
  
  [Azure Container Instances][aci-overview] is a serverless approach that lets you create and execute containers on-demand. You're charged only for the execution time **per second**!

  You can use [Virtual Kubelet][virtual-kubelet] to connect Azure Container Instances into your Kubernetes environment. Azure Container Instances could allow for extra bursting scale, as you wouldn't have to  wait for extra worker nodes (VMs) to be provisioned. At time of writing, the Virtual Kubelet is described as experimental software and should not be used in production scenarios.

We've briefly covered the subject of containers, though they could be an entire series of topics in their own right. Continue further reading elsewhere if you are interested! The main point here is that containers lend themselves well towards a scalable architecture.

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
