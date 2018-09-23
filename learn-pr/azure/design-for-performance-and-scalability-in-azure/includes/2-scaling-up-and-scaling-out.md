It's rare that we can exactly predict the load on our system: public facing applications might grow rapidly or an internal application might need to support a larger user base as the business grows. Even when we can predict load, it's rarely flat: retailers have more demand during the holidays and sports websites peak during playoffs. Here, we'll define _scaling up/down_ and _scaling out/in_, cover some ways Azure can improve your scaling capabilities, and look at how serverless and container technologies can improve your architecture's ability to scale.

## What is scaling?

_Scaling_ is the process of managing your resources to help your application meet a set of performance requirements.  When we have too many resources serving users, we won't be using it efficiently and we'll be wasting money. Too few available resources means that the performance of our application could be impacted. The goal is to meet our defined performance requirements while optimizing for cost. 

"_Resources_" can refer to anything we need to manage to run our applications. Memory and CPU for virtual machines are the most obvious resources, but some Azure services might require you to consider bandwidth or abstractions, like Cosmos DB Request Units.

In a world where application demand is constant, it's easy to predict the right amount of resources you'll need. In the real world, the demands of applications change over time, so the right amount of resources you'll need can be harder to predict. If you're lucky, that change will be predictable or seasonal, but that is not typical of all applications. Ideally, you want to provision the right amount of resources to meet demand and adjust as demand changes.

Scaling is difficult in an on-premises scenario, where you purchase and manage your own servers. Adding resources can be costly and often takes too much time to bring online, sometimes longer than your actual need for the increased capacity. It can be just as difficult to then reduce capacity during times of low demand on the system, so you may be stuck with the increased cost.

Easy scaling is a key benefit of Azure. Most Azure resources let you easily add or remove resources as demand changes, and many services have automated options so they monitor demand and adjust for you. This automatic scaling capability, commonly known as autoscaling, lets you set thresholds for the minimum and maximum level of instances that should be available, and will add or remove instances based upon a performance metric (for example, CPU utilization).

#### Scaling up and out

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yBWi]

## What is scaling up or down?

Scaling up is the process where we increase the capacity of a given instance. A virtual machine could be increased from 1 vCPU and 3.5 GB of RAM to 2 vCPUs and 7 GB of RAM to provide more processing capacity. On the other hand, scaling down is the process where we lower the capacity of a given instance. For example, reducing a virtual machine's capacity from 2 vCPUs and 7 GB of RAM to 1 vCPU and 3.5 GB of RAM, reducing both capacity and cost. The following illustration shows an example of changing the size of a virtual machine.

![An illustration showing scaling up and scaling down of a virtual machine to change the performance capabilities.](../media/2-ScaleUpDown.png)

Let's take a look at what scaling up or down means in the context of Azure resources:

- In Azure virtual machines, you scale based upon a virtual machine size. That size has a certain amount of vCPUs, RAM, and local storage associated with it. For example, we could scale up from a Standard_DS1_v2 virtual machine (1 vCPU and 3.5 GB of RAM) to a Standard_DS2_v2 virtual machine (2 vCPUs and 7 GB of RAM).
- Azure SQL Database is a platform as a service (PaaS) implementation of Microsoft SQL Server.  You can scale up a database based upon the number of database transaction units (DTUs) or vCPUs. DTUs are an abstraction of underlying resources and are a blend of CPU, IO, and memory. For instance, you could scale your Azure SQL database from a size of P2 with 250 DTUs up to a P4 with 500 DTUs to give the database more throughput and capacity.
- Azure App Service is a PaaS website-hosting service on Azure. Websites run on a virtual server farm, also known as an App Service plan. You can scale the App Service plan up or down between tiers and have capacity options within tiers. For example, an S1 App Service plan has 1 vCPU and 1.75 GB of RAM per instance. We could scale up to an S2 App Service plan, which has 2 vCPUs and 3 GB of RAM per instance.

To have these capabilities in an on-premises environment you typically have to wait for procurement of the needed hardware and installation before you can start using the new level of scale. In Azure, the physical resources are already deployed and available for you. You simply need to select the alternate level of scale that you are looking to use.

You may need to consider the impact of scaling up in your solution, depending upon the cloud services that you have chosen.

For example, if you choose to scale up in Azure SQL Database, the service deals with scaling up individual nodes and continues the operation of your service. Changing the service tier and/or performance level of a database creates a replica of the original database at the new performance level, and then switches connections over to the replica. No data is lost during this process, and there's only a brief interruption (typically less than four seconds) when the service switches over to the replica.

Alternatively, if you choose to scale up or down a virtual machine, you do so by selecting a different instance size. In most cases this requires a restart of the VM, so it's best to have the expectation that a reboot will be required and you'll need to account for when performing this activity.

Finally, you should always look for places where scaling down is an option. If your application can provide adequate performance at a lower price tier, your Azure bill could be significantly reduced.

## What is scaling out or in?

Where scaling up and down adjusts the amount of resources a single instance has available, scaling out and in adjusts the total number of instances.

_Scaling out_ is the process of adding more instances to support the load of your solution. For example, if our website front end were hosted on virtual machines, we could increase the number of virtual machines if the level of load increased.

_Scaling in_ is the process of removing instances that are no longer needed to support the load of your solution. If the website front ends have low usage, we may want to lower the number of instances to save cost. The following illustration shows an example of changing the number of virtual machine instances.


![An illustration showing scaling out the resources to handle demand and scaling in the resources to reduce costs.](../media/2-ScaleInOut.png)

Here are some examples of what scaling out or in means in the context of Azure resources:

- For the infrastructure layer, you would likely use virtual machine scale sets to automate the addition and removal of extra instances.
  - Virtual machine scale sets let you create and manage a group of identical, load balanced VMs.
  - The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.
- In an Azure SQL Database implementation, you could share the load across database instances by sharding. _Sharding_ is a technique to distribute large amounts of identically structured data across a number of independent databases.
- In Azure App Service, the App Service plan is the virtual web server farm hosting your application. Scaling out in this way means that you're increasing the number of virtual machines in the farm. As with virtual machine scale sets, the number of instances can be automatically raised or lowered in response to certain metrics or a schedule.

Scaling out is typically easily performed in the Azure portal, command-line tools, or Resource Manager templates, and in most cases is seamless to the end user.

### Autoscale

You can configure some of these services to use a feature called autoscale. With autoscale you no longer have to worry about scaling services manually. Instead, you can set a minimum and maximum threshold of instances and scale based upon specific metrics (queue length, CPU utilization) or schedules (weekdays between 5:00 PM and 7:00 PM). The following illustration shows how the autoscale feature manages instances to handle the load.

![An illustration showing how autoscale monitors the CPU levels of a pool of virtual machines and adds instances when the CPU utilization is above the threshold.](../media/2-autoscale.png)

### Considerations when scaling in and out

When scaling out, the startup time of your application can impact how quickly your application can scale. If your web app takes two minutes to start up and be available for users, that means each of your instances will take two minutes until they are available to your users. You'll want to take this startup time into consideration when determining how fast you want to scale.

You'll also need to think about how your application handles state. When the application scales in, any state stored on the machine is no longer available. If a user connects to an instance that doesn't have its state, it could force them to sign in or re-select data, leading to a poor user experience. A common pattern is to externalize state to another service like Redis Cache or SQL Database, making your web servers stateless. Now that our web front ends are stateless, we don't need to worry about which individual instances are available. They are all doing the same job and are deployed in the same way.

## Throttling

We've established that the load on an application will vary over time. This may be due to the number of active or concurrent users and the activities being performed. While we could use autoscaling to add capacity, we could also use a throttling mechanism to limit the number of requests from a source. We can safeguard performance limits by putting known limits into place at the application level, preventing the application from breaking. Throttling is most frequently used in applications exposing API endpoints.

Once the application has identified that it would breach a limit, throttling could begin and ensure the overall system SLA isn't breached. For example, if we exposed an API for customers to get data, we could limit the number of requests to 100 per minute. If any single customer exceeded this limit, we could respond with an HTTP 429 status code, including the wait time before another request can successfully be submitted.

## Serverless

Serverless computing provides a cloud-hosted execution environment that runs your apps but completely abstracts the underlying environment. You create an instance of the service, and you add your code; no infrastructure management or maintenance is required, or even allowed.

You configure your serverless apps to respond to events. This could be a REST endpoint, a timer, or a message received from another Azure service. The serverless app runs only when it's triggered by an event.

Infrastructure isn't your responsibility. Scaling and performance are handled automatically, and you are billed only for the exact resources you use. There's no need to even reserve capacity. Azure Functions, Azure Container Instances, and Logic Apps are examples of serverless computing available on Azure.

Let's revisit the Lamna Healthcare example. There could be some potential for cost saving and ease of management. Consider an API endpoint. Instead of hosting the API in Azure App Service, where they must pay for reserved capacity, they could use an Azure Function App triggered by an HTTP request. Azure functions would enable the team to pay only for the resources required to process each transaction. The cost and scale would be directly in line with the number of transactions in the system.

## Containers

A container is a method running applications in a virtualized environment. A virtual machine is virtualized at the hardware level, where a hypervisor makes it possible to run multiple virtualized operating systems on a single physical server. Containers take the virtualization up a level. The virtualization is done at the OS level, making it possible to run multiple identical application instances within the same OS.

Containers are well suited to scale out scenarios. They are meant to be lightweight and are designed to be created, scaled out, and stopped dynamically as environment and demand change.

A benefit of using containers is the ability to run multiple isolated applications on each virtual machine. Since containers themselves are secured and isolated at a kernel level, you don't necessarily need separate VMs for separate workloads.

While you can run containers on virtual machines, there are a couple of Azure services that focus on easing the management and scaling of containers:

- **Azure Kubernetes Service (AKS)**

  Azure Kubernetes Service allows you to set up virtual machines to act as your nodes. Azure hosts the Kubernetes management plane and only bills for the running worker nodes that host your containers.

  To increase the number of your worker nodes in Azure, you could use the Azure CLI to increase that manually. At time of writing, there is a preview of Cluster Autoscaler on AKS available that enables autoscaling of your worker nodes. On your Kubernetes cluster, you could use the Horizontal Pod Autoscaler to scale out the number of instances of the container to be deployed.

  AKS can also scale with the Virtual Kubelet described below.

- **Azure Container Instances (ACI)**
  
  Azure Container Instances is a serverless approach that lets you create and execute containers on demand. You're charged only for the execution time per second.

  You can use Virtual Kubelet to connect Azure Container Instances into your Kubernetes environment, including AKS. With Virtual Kubelet, when your Kubernetes cluster demands additional container instances, those demands can be met from ACI. Since ACI is serverless, there is no need to have reserved capacity. You can therefore take advantage of the control and flexibility of Kubernetes scaling with the per-second-billing of serverless. At time of writing, the Virtual Kubelet is described as experimental software and should not be used in production scenarios.

## Scaling at Lamna Healthcare

Lamna Healthcare operates a patient management and booking system. The management system handles appointment bookings and patient records across dozens of hospitals and medical facilities. The local health service is running at full capacity, and no growth is expected at the moment. The system is running on a PHP website hosted in Azure App Service.

The load pattern of the application is predictable, as they primarily operate Monday to Friday between the hours of 9 to 5.  From Tuesday through to Friday, the system averages 1,200 transactions per hour across the entire system. During the weekend, it handles 500 transactions per hour. After the quiet of the weekend, Mondays are busy with an average of 2,000 transactions per hour.

The application is hosted on an S1 App Service plan, but the operations team have noticed a high level of CPU utilization (over 95%) across all instances. The high usage is having an impact on the processing and loading times of the application. In a cloud environment, having highly utilized resources is not necessarily a bad thing. It means that they are getting value for their money, as the resources deployed are being well used. 

The team decide to _scale up_ the App Service plan level for the deployed instances from S1 (1 vCPU and 1.75 GB of RAM) to S2 (2 vCPUs and 3 GB of RAM). They easily achieve this using the Azure portal, but could have achieved the same thing using a single command in the Azure CLI, Azure PowerShell, or using Resource Manager templates.

The team decide that they want to automate the number of instances deployed based upon a schedule, as their load profile is predictable. They configure the App Service plan's autoscale schedule. Let's assume two instances sufficiently handle 500 transactions per hour. The team could then scale to six instances for Tuesday - Friday and eight instances for a Monday to meet the requirements (based upon insight and monitoring from load tests).

Autoscale also gives them an added benefit, preparing for those unforeseen scenarios. The site may suddenly take higher than expected load on the weekend (more appointments in the winter season because of colds and flu). The team can set up autoscale to increase by one instance when CPU percentage is above 70% and reduce by one instance when usage is below 15%.

The team have used the throttling pattern inside of the patient booking API they have exposed behind an Azure API Management instance. This helps prevent the system from performing poorly by only allowing a certain volume of throughput through the system.

We've talked about scaling up and down and scaling in and out, and how you can leverage these options in your architecture. We've also looked at how serverless technologies and containers can help evolve your scaling capabilities.