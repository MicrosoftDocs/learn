Implementing enterprise-scale workloads and applications requires enterprise-grade storage performance and high availability. Historically, most organizations could only achieve this level of performance by using highly tuned configurations in on-premises data centers. However, such configurations tend to be inflexible, complex, and expensive. A cloud service such as Azure offers flexibility, simplicity, and cost savings for regular workloads.

:::image type="content" source="../media/1-introduction-anf-before.png" alt-text="A web server cluster running in an on-premises data center and accessing a Network Attached Storage (NAS) device that uses the Network File System (NFS) protocol.":::
<!-- NOTE: global -- in images and elsewhere "data center," not "datacenter" -->
<!-- NFS not spelled-out anywhere so spelled it out in the alt-text. However, since not spelled-out in this intro might want to spell out on the slide too -->


How do you migrate mission-critical enterprise workloads to the cloud without sacrificing performance, security, and availability? Azure NetApp Files provides data center-quality performance, robust security, and high availability with all the advantages of the cloud.

:::image type="content" source="../media/1-introduction-anf-after.png" alt-text="A virtual web server cluster running in an Azure virtual network and accessing NFS file storage by using Azure NetApp Files.":::

## Example scenario

Suppose you work for an energy company that's transitioning from fossil fuels to sustainable energy sources, such as wind and solar. Your IT department runs a data center with infrastructure that runs the company's web content, virtual desktops, and high-performance computing (HPC) applications for the research and development department. The web content, virtual desktops, and HPC apps are crucial to the company's operation, profits, and future growth. These resources use massive storage and throughput, so they require a finely tuned data center configuration. The downsides of such a configuration are high costs, increasing complexity, and inflexibility.

You've been asked to investigate whether you can migrate any or all of these enterprise workloads to Azure without modifications or new code. Here<!-- ?? How about saying something like, "During your investigation, you'll learn ... "? -->, you'll learn that Azure NetApp Files' low latency and high throughput enable you to match your data center performance, and its built-in data management features provide resilient and elastic cloud workloads.

## What will we be doing?

We'll examine Azure NetApp Files from several angles to help you decide if you can migrate your enterprise workloads to the cloud:

- Performance: What latencies, throughput, and Network Attached Storage (NAS) protocols does Azure NetApp Files support?
- Resiliency: How available are your workloads in Azure NetApp Files?
- Data management: What tools does Azure NetApp Files offer to manage and protect your data?

## What is the main goal?

By the end of this session, you'll be able to evaluate whether Azure NetApp Files is a viable choice for migrating and running your organization's file-based workloads.
