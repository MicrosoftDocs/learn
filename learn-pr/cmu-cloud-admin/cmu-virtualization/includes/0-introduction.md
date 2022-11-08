Virtualization is at the core of the cloud computing paradigm. It lies on top of the cloud infrastructure or data center. In comparison, virtual resources such as virtual CPUs, memory, disks, and networks are constructed from the underlying physical resources and act as proxies to them. Similar to cloud computing being introduced in the 1960's, virtualization dates back to the 1970s. 

40 years ago, the mainframe computer systems were large and expensive. In 1970, the IBM 370 architecture was announced to address expanding user needs and costly machine ownership. It offered complete virtual machines (VMs) to different programs running on the same computer hardware. Over time, computer hardware became less expensive, and users started migrating to low-priced desktop machines. This migration drove the adoption of the virtualization technology to fade for a while.

Today, virtualization is everywhere, and a number of research projects and commercial systems provide virtualization solutions for home PCs, servers, and the cloud. Even companies who run their own data centers have turned to virtualization to increase server utilization, decrease costs, and adapt more nimbly to changing environments. In 2016, Gartner reported that a majority of firms has virtualized 75% or more of their servers<sup>[1][^1]</sup>.

In this module, you'll learn about virtualization in general and understand the key motivations behind virtual machines. We'll discuss the two types of virtual machines and explore an alternative virtualization technology known as *containers*. We'll also discover virtual networking and some of the technologies that enable it. Virtual networks are just as important to cloud computing as virtual machines. Without virtual networks, VMs wouldn't be able to communicate and users wouldn't be able to connect remotely to the VMs they create.

## Learning objectives

- Identify the two main types of virtual machines and provide examples of each
- Identify major reasons that virtualization is an essential technology for cloud computing
- List the key advantages that containers have over virtual machines
- Understand key terms such as Docker containers, container images, and container registries
- Identify some of the ways in which major cloud platforms support containers
- Recall key design considerations for data-center networks and describe the need for network virtualization to support multiple tenants

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers
- Recognize cloud service models such as IaaS, PaaS, and SaaS and differentiate between them
- Understand how cloud resource provisioning works

Interested readers can refer to this popular book on virtual machines<sup>2</sup> to be a fairly comprehensive reference for all virtualization-related concepts.

### References

1. _Information Week (2016). *Virtualization Market Now \'Mature,\' Gartner Finds*. <https://www.informationweek.com/infrastructure-as-a-service/virtualization-market-now-mature-gartner-finds/>._

2. _JE Smith and Nair (2005). \"Virtual Machines: Versatile Platforms for Systems and Processes.\" Morgan Kaufmann._

[^1]: <https://www.informationweek.com/infrastructure-as-a-service/virtualization-market-now-mature-gartner-finds>  "Information Week (2016). *Virtualization Market Now \'Mature,\' Gartner Finds*."
