Your research team has collected massive amounts of image data that might lead to a discovery on Mars. They need to perform computationally intense data processing but don't have the equipment to do the work. Let's see why Azure is a good choice to do the data analysis.

## What is Azure compute?

Azure compute is an on-demand computing service for running cloud-based applications. It provides computing resources like multi-core processors and supercomputers via virtual machines and containers. It also provides serverless computing to run apps without requiring infrastructure setup or configuration. The resources are available on-demand and can typically be created in minutes or even seconds. You pay only for the resources you use and only for as long as you're using them.

There are four common techniques for performing compute in Azure:

- Virtual machines
- Containers
- Azure App Service
- Serverless computing

## What are virtual machines?

**Virtual machines**, or VMs, are software emulations of physical computers. They include a virtual processor, memory, storage, and networking resources. They host an operating system (OS), and you're able to install and run software just like a physical computer. And by using a remote desktop client, you can use and control the virtual machine as if you were sitting in front of it.

## What are containers?

Containers are a virtualization environment for running applications. Just like virtual machines, containers run on top of a host operating system. But unlike VMs, containers don't include an operating system for the apps running _inside_ the container. Instead, containers bundle the libraries and components needed to run the application and use the existing host OS running the container. For example, if five containers are running on a server with a specific Linux kernel, all five containers and the apps within them share that same Linux kernel.

## What is Azure App Service?

Azure App Service is a platform-as-a-service (PaaS) offering in Azure that is designed to host enterprise-grade web-oriented applications. You can meet rigorous performance, scalability, security, and compliance requirements while using a fully managed platform to perform infrastructure maintenance.

## What is Serverless Computing?

Serverless computing is a cloud-hosted execution environment that runs your code but completely abstracts the underlying hosting environment. You create an instance of the service, and you add your code; no infrastructure configuration or maintenance is required, or even allowed.

## Which computing strategy is right for me?

You don't need to take an "all or nothing" approach when choosing a cloud computing strategy. Virtual machines, containers, App Service, and serverless computing each provide benefits as well as tradeoffs against other options.

For example, although serverless computing removes the need for you to manage infrastructure, serverless computing expects work to be completed quickly; usually within seconds or less. Therefore, you might run your core application on a virtual machine or container but offload some of the data processing onto a serverless app.

Let's look at each option more closely to help you decide when to use each service.
