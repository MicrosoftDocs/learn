<!--- The content here is really interesting, but I think it could use a bit more structure/story. I kept getting surprised as I went through it with what came next (e.g. the Non-functional section, the 'scenario' that introduced new learning content instead of applying previously discussed content, then the container stuff that seemed tacked on at the end.) Is there some structure we could put around this, like different levels of control (fine control like VMs, abstract control like App Service, no need to control like serverless, etc. --->

# Scaling up and scaling out

## Motivation

It's rare that we can exactly predict the load on our system: public facing applications might go viral or an internal application might need to support a larger user base as the business grows. Even when we can predict load, it's rarely flat: retailers have more demand during the holidays and sports websites peak during playoffs. In this section, we'll define _scaling up_ and _scaling out_, discuss why scaling out is usually preferred, and see how Azure implements scale out strategies. We'll also look at how so-called "serverless" technologies can mitigate much of the concern associated with scaling.

<!--- not sure this fits here. we don't address these issues anywhere in the Unit. this could be cool stuff if we showed how to use scaling to handle these cases. We could use this as framing for this topic (i.e. organize this Unit around different demand patterns and how to handle each in Azure) but I think that's too tasky/practical because I believe this module is spec'ed as theory only --->
## Non-functional requirements

Before engaging in any kind of architectural considerations, you should ensure that you and your team have a clear view of your non-functional requirements. From a performance and scalability point of view;

* How many users does your system need to support (both total and concurrently)?
* What is the expected growth of your platform? How does this line up with business demand?
* How many operations/messages must the platform handle (per second/minute/etc.)?
* Is there any seasonality to the load of your platform?
* What is the load profile of your platform? Is it bursty, or is it predictable?

There are many more questions that we could ask ourselves here, though this begins to set some boundaries and guidance into how your application should scale and drives technical design decisions. 

## What is scaling?

<!--- Maybe start with a fundamental definition. For example: --->
_Scaling_ is the process of managing your resources to ensure you meet demands....

<!--- Then describe which resources are typically scaled. --->
<!--- Maybe a simple graphic listing the resource types that are subject to scaling? --->
The resources you need to scale depend on your application. For example, computationally intensive workloads require CPU cycles, database intensive tasks require ..., ...disks..., ...network bandwidth..., etc....

<!--- Then discuss increase/decrease --->
Scaling can mean an increase or a decrease in resources.
Too many resources wastes money....
Too few and perf suffers...
Goal is meet perf goals without wasting money....

<!--- Introduce dynamic scaling by tying this back to the Motivation --->
If demand was constant you could provision to meet that demand, but scaling is difficult because demand changes over time.... If you're lucky it's predictable change, but that's not always true.... Ideally, you want to provision the right amount of resources to meet demand and adjust as demand changes....

<!--- Contrast with on-prem --->
This is difficult when purchasing and managing your own servers. You can buy more hardware to meet peak demand but there's no easy way to reduce resources during periods of low demand.

<!--- Finish with key cloud benefit --->
Dynamic scaling is a key benefit of Azure. Most Azure resources let you increase or decrease as demand changes. You can do this manually for any resource. Many resources have automated options so they monitor demand and adjust for you automatically. The automated options generally let you set cost/capacity floors/ceilings....

## What is scaling up?

<!--- should include a precise definition --->
_Scaling up_ is ....

<!--- I wonder if we should explain what "scale up" means for each common resource type? VM, DB, etc? --->

Consider that you are running an on-premises application and you have a limited capacity for adding extra machines to support  growth. Rather than adding more machines to solve the problem, you could  increase the provisioned resource for those machines already created. For example - If you are noticing high memory usage, then you may want to consider increasing the amount of RAM provisioned on your deployed boxes.

<!--- This next paragraph would be a fun thing to expand on if we can. Personally, I don't have much intuition about what scale-up means for anything except VMs. Could we describe what it means for several key Azure resource types? The difficult part is that using App Service and saying S1/S2 doesn't give much intuition. --->
This idea of moving an application to a bigger physical server, or increasing the current level of resource could be considered in a cloud environment as well. Rather than scaling individual components, e.g. RAM or CPU, you generally scale based upon a SKU. For example, in Azure App Service you could scale up from a set of S1 instances to a set of S2 instances, or you could scale up a Virtual Machine from a Standard_D2s_v3 to a Standard D4s_v3 SKU.

To handle this scenario in an on-premises environment, you would typically have to wait for procurement of the needed hardware and installation before you can start using the new level of scale. In Azure, the clusters are already deployed and available for you to use. You simply need to select the alternate level of scale that you are looking to use.

You may need to consider the use of scaling up in your solution, depending upon the cloud services that you have chosen.

For example, if you choose to scale up in Azure SQL Database (a PaaS offering), then the service deals with scaling up individual nodes and continues the operation of your service.

Alternatively, if you choose to scale up a Virtual Machine, then the Virtual Machine will potentially be redeployed and require a reboot if you happen to migrate across different underlying hosts.

Equally, you can consider scaling down as an option (provisioning fewer resources than currently required). This can lead to cost optimisations in your solution, though you should always consider this in line with the non-functional requirements of your project.

## What is scaling out?

<!--- I might lead with the formal definition --->
_Scaling out_ is adding more instances to support the load of your solution.

<!--- I wonder if we should explain what "scale out" means for each common resource type? VM, DB, etc? --->

<!--- VMSS seems to come out of nowhere here - was that introduced earlier? If you add some content above talking generally about scale-out with VMs then this might be fine. If not, I would talk about scale-out with VMs here first, then say "In Azure, scale-out for VMs is supported via VMSS..." --->
For example, consider that we are running the front end of our website using Virtual Machine Scale Sets (VMSS). We may suddenly see an increase in traffic due to a new offer being provided on our website. In that scenario, we may consider increasing the number of instances from 3 to 5 to cope with the increased amount of load on the web front ends.

Scaling out is an easy approach to handling extra amounts of load in your system. When scaling out a Platform as a Service (PaaS) resource, they are generally configurable as a property in the Azure Portal, using command line tools or ARM Templates.

You can configure some of these resources to use a feature called [Autoscale][what-is-autoscale]. This means you no longer have to worry about scaling resources manually. Instead, you can set a minimum and maximum threshold of instances and scale based upon certain metrics (e.g. queue length, CPU utilisation) or schedules (e.g. week days between 5pm - 7pm).

When opting for a scale out approach, the startup time of your application can make a significant difference to the rate at which your application can scale. If your web app takes 2 minutes to start up and be available for users, then that means each of your instances will take 2 minutes until they are available to your users.

Also consider how your application handles state. When your application scales in (i.e. removes instances to serve your users), then those machines will be removed and any state stored on the machine is no longer available. This is why a common pattern is to externalise state to another source (e.g. a Redis Cache or SQL Database), which makes those instances stateless. As the instance is now stateless, this means we do not to need worry about which individual instances are available, they are all performing the exact same function and are deployed in the same way.

## Scenario: Scaling on Azure

Lamna Healthcare operate a patient management and booking system. The management system is responsible for the booking of appointments and patient records across dozens of hospitals and local doctors surgeries. The local health service is running at full capacity, and no growth is expected at the moment. The system itself is running on a PHP Website hosted in Azure App Service.

<!--- The specificity of the company is fun, but has less impact if we don't tie it to the scaling needs explicitly (i.e. don't make the learner do it). For example,  my guess is that because this is booking/management for a 9-5 M-F business, that's what generates the pattern described below and makes it predictable? --->
The load on the system is fairly predictable. From Tuesday through  to Friday, the system averages at 1,200 transactions per hour across the entire system. During the weekend, it handles 500 transactions per hour. After the quiet of the weekend, Mondays are busy with an average of 2,000 transactions per hour.

<!--- S1 / S2 doesn't give me much intuition, is this a lot? how would I know that's what I should do? This scenario is mildly interesting, but not really giving me actionable info (not sure if that's a goal for this intro module though). For example, how would I know what "high" CPU utilization is? How would I decide to go from S1 to S2? All I'm taking away from this is that S2 is more powerful than S1. I'm not even sure if this is scale up or scale out, and since we just spent a long time making that distinction, it might be good to discuss that? --->
The application is currently operating on an S1 App Service Plan, though the operations team have noticed a high level of CPU utilisation across all instances. The operations team increase the App Service Plan SKU from S1 to S2 to provide extra resource, required for the Web front end activities. The team easily achieve this by [scaling out using the Azure portal][app-service-cli-scale], though could have achieved the same thing using a single command in the [Azure CLI][app-service-cli-scale], Azure PowerShell or using ARM Templates.

<!--- I don't think Autoscale should be introduced in the middle of the scenario, should probably be covered earlier, then here you can show how it applies to the scenario --->
It is very easy to achieve this scale manually. However, the operations team decide to evolve their practices and let the Azure platform scale on their behalf. They achieve this using an approach called [Autoscale][app-service-autoscale].

The team are able to setup rules based upon multiple schedules, ensuring that the number of instances deployed in the App Service Plan are suitable for the time of the week. For example, let's assume 2 instances sufficiently handles 500 transactions per hour. Based upon this, the team could then scale to 6 instances for Tuesday - Friday and 8 instances for a Monday to meet the requirements (based upon insight and monitoring from load tests).

Autoscale could also provided an added benefit, preparing for those unforeseen scenarios. The team may suddenly encounter some higher than expected load on the weekend (perhaps more appointments in the winter season due to colds and flu). They do not need to worry about scaling up manually, as they have already configured autoscale to increase the number of instances dependent upon the current metrics in relation to some threshold. For example, they may have a rule to Scale out by 1 instance when CPU percentage is above 70%, and decrease by 1 instance when CPU percentage is below 30%.

## Scaling via alternate services

You need to consider scaling differently, depending upon the Azure service that you choose to implement. In this section, we will consider some of the additional options available.

### Serverless

Imagine a scenario where you could spend your time building and deploying apps, and not having to manage underlying servers or even worry which service to run. That's effectively the aim of serverless computing. Serverless computing is typically event driven, meaning some code, workflow or operation will trigger as a reaction to some event happening in near-real time.

Some typical characteristics of serverless computing are that you only pay for the resources you use (i.e. consumption based), and is typically designed for large amounts of scale. [Azure Functions][azure-functions-overview], [Azure Container Instances][azure-container-instances-overview] and [Logic Apps][azure-logicapps-overview] could be considered as examples of serverless computing in Azure. 

Think about services like Azure Storage, Event Grid and Data Lake. Those services are considered consumption-based services as you pay for the amount of storage per GB or number of events routed through the component. You do not worry about the underlying configuration or what servers are provisioned to help you achieve the activity, you just use the service and build your solution. Sometimes these types of services are also referred to as serverless. 

Let's revisit the Lamna Healthcare example above. There could be some potential for cost saving and ease of management. Instead of handling the transaction processing in an API App, the team could process transactions (patient appointments / information updates) in an Azure Function App using a consumption based plan. This would enable them to only pay for the resources required to process transactions, and scale would be directly in line with the number of transactions in the system.

## Containers

A container is a way of hosting application code in a virtualised environment, that is consistent across all instances of its deployment. The difference between a virtual machine and a container is that a virtual machine is virtualised at the hardware level, so you will see a virtual network interface card, virtual cpu, etc. Instead, a container is virtualised at the operating system level.

Containers are naturally suited to scale out scenarios, particularly because you do not need to wait for a VM to boot up. Their characteristics also allow for a consistent environment (i.e. all container instances will be deployed alike), they can be run anywhere and have good portability and have predictable performance due to resource isolation at the operating system level.

Let's consider the above Lamna Healthcare example once again. Rather than running Azure App Service or Azure Functions, we could use containers to host our web front end and API end points. Those containers would be hosted on a number of worker machines called nodes, and each of those nodes can have many containers running on top of them. You would likely have many instances of a particular container (for example, the front end website) to accomodate for higher volume of load in the system.

There are two primary options for scaling containers in Azure;

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
