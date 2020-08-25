Azure compute is an on-demand computing service for running cloud-based applications. It provides computing resources such as disks, processors, memory, networking and operating systems. The resources are available on-demand and can typically be made available in minutes or even seconds. You pay only for the resources you use, and only for as long as you're using them.

Azure supports a wide range of computing solutions for development and testing, running applications, and extending your datacenter, including Linux, Windows Server, Microsoft SQL Server, Oracle, IBM, and SAP. Azure also has many services that can run virtual machines, each providing different options depending on your requirements. Some of the most prominent services are Virtual Machines, Container Instances, App Services, and Functions (or _serverless computing_).

![Screenshot of the portal compute services page including virtual machines and containers.](../media/compute-services.png)

:::row:::
  :::column span="3":::

## Virtual machines

Virtual machines (VMs) are software emulations of physical computers. They include a virtual processor, memory, storage, and networking resources. VMs host an operating system, and you're able to install and run software just like a physical computer. When using a remote desktop client, you can use and control the virtual machine as if you were sitting in front it.

[Azure virtual machines](https://azure.microsoft.com/services/virtual-machines/) let you create and use virtual machines in the cloud. It provides IaaS and can be used in a variety of different ways. When you need total control over an operating system and environment, Azure VMs are an ideal choice. Just like a physical computer, you're able to customize all the software running on the VM. This ability is helpful when you are running custom software or custom hosting configurations. 

  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-virtual-machine.png" border="false":::
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/icon-scale-sets.png" border="false":::
  :::column-end:::
  :::column span="3":::

## Virtual machine scale sets

[Virtual machine scale sets](https://azure.microsoft.com/services/virtual-machine-scale-sets) are an Azure compute resource that you can use to deploy and manage a set of identical VMs. With all VMs configured the same, virtual machine scale sets are designed to support true autoscale; no pre-provisioning of VMs is required; and as such makes it easier to build large-scale services targeting big compute, big data, and containerized workloads. So, as demand goes up more virtual machine instances can be added, and as demand goes down virtual machines instances can be removed. The process can be manual, automated, or a combination of both. 

  :::column-end:::
:::row-end:::

:::row:::
  :::column span="3":::

## Containers and Kubernetes

[Azure Container Instances](https://azure.microsoft.com/services/container-instances) and [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/services/kubernetes-service) are Azure compute resources that you can use to deploy and manage containers, which are lightweight, virtualized application environments that are designed to be quickly created, scaled out, and stopped dynamically. You can run multiple instances of a containerized application on a single host machine.

  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-container-instance.png" border="false":::
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/icon-app-service.png" border="false":::
  :::column-end:::
  :::column span="3":::

## App services

With [App services](https://azure.microsoft.com/services/app-service), you can quickly build, deploy, and scale enterprise-grade web, mobile, and API apps running on any platform. You can meet rigorous performance, scalability, security, and compliance requirements while using a fully managed platform to perform infrastructure maintenance. App Services is a platform as a service (PaaS) offering. 

  :::column-end:::
:::row-end:::

:::row:::
  :::column span="3":::

## Functions

[Azure Functions](https://azure.microsoft.com/services/functions) are ideal when you're concerned only about the code running your service and not the underlying platform or infrastructure. They're commonly used when you need to perform work in response to an event (often via a REST request), timer, or message from another Azure service, and when that work can be completed quickly, within seconds or less. 

  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-functions.png" border="false":::
  :::column-end:::
:::row-end:::
