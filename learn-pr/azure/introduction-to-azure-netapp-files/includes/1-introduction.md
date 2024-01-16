Implementing enterprise-scale workloads and applications requires enterprise-grade storage performance and high availability. Historically, most organizations could only achieve this level of performance by using a highly tuned configuration in an on-premises datacenter. However, such configurations tend to be inflexible, complex, and expensive. A cloud service such as Azure offers flexibility, simplicity, and cost savings for regular workloads.

:::image type="content" source="../media/1-introduction-before.png" alt-text="Diagram depicting a web server cluster running in an on-premises datacenter and accessing a network access storage device that uses the NFS protocol." lightbox="../media/1-introduction-before.png":::

How do you migrate mission-critical enterprise workloads to the cloud without sacrificing performance, security, or availability? Azure NetApp Files provides datacenter-quality performance, robust security, and high availability with all the advantages of the cloud.

:::image type="content" source="../media/1-introduction-after.png" alt-text="Diagram depicting a virtual web server cluster running in an Azure virtual network and accessing NFS file storage by using Azure NetApp Files." lightbox="../media/1-introduction-after.png":::

## Example scenario

Suppose you work for an energy company that's transitioning from fossil fuels to sustainable energy sources such as wind and solar. Your IT department runs a datacenter with infrastructure to run the company's web content, virtual desktops, and the high-performance computing (HPC) applications of the research and development department. The web content, virtual desktops, and HPC apps are all crucial to the company's operation, profits, and future growth. These resources use massive storage and throughput, which in turn require a finely tuned datacenter configuration. However, the downsides of such a configuration are high costs, increasing complexity, and a lack of agility. You've been tasked to investigate whether any or all of these enterprise workloads can be migrated to Azure without modifications or new code. Here, you learn that Azure NetApp Files' low latency and high throughput enable you to match your datacenter performance. You also learn how its built-in data management features provide resilient and elastic cloud workloads.

## What will we be doing?

We examine Azure NetApp Files from several angles to help you decide if you can migrate your enterprise workloads to the cloud:

- Performance. What latencies, throughput, and Network Attached Storage (NAS) protocols are supported in Azure NetApp Files?
- Resiliency. How available are your workloads in Azure NetApp Files?
- Data management. What tools does Azure NetApp Files offer to manage and protect your data?

## What is the main goal?

By the end of this module, you're able to evaluate whether Azure NetApp Files is a viable choice for migrating and running your organization's file-based workloads.
