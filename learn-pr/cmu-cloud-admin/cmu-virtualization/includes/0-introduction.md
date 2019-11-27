---
title: Module Introduction
---

Virtualization is at the core of the cloud computing paradigm. It lies on top of the cloud infrastructure (or the data center) whereby virtual resources such as virtual CPUs, memory, disks, and networks are constructed from the underlying physical resources and act as proxies to them. As is the case with the idea of cloud computing, which was first introduced in the 1960s, virtualization can be traced back to the 1970s. Forty years ago, the mainframe computer systems were extremely large and expensive. To address expanding user needs and costly machine ownership, the IBM 370 architecture, announced in 1970, offered complete virtual machines (VMs) to different programs running on the same computer hardware. Over time, computer hardware became less expensive, and users started migrating to low-priced desktop machines. This migration drove the adoption of the virtualization technology to fade for a period of time.

Today, virtualization is ubiquitous, with a number of research projects and commercial systems providing virtualization solutions for commodity PCs, servers, and the cloud. Even companies who run their own data centers have turned to virtualization to increase server utilization, decrease costs, and adapt more nimbly to changing environments. In 2016, Gartner reported that a majority of firms has virtualized 75% or more of their servers[^1].

In this module, we will look at virtualization in general and understand some of the key motivations behind virtual machines. We will discuss the two types of virtual machines and explore an alternative virtualization technology known as *containers*. We will also discuss virtual networking and some of the technologies that enable it. Virtual networks are just as important to cloud computing as virtual machines in part because without them, VMs wouldn't be able to communicate and users wouldn't be able to connect remotely to the VMs that they create.

The material presented in this module should contain sufficient detail for the course, but interested readers can refer to this popular book on virtual machines[^2] to be a fairly comprehensive reference for all virtualization-related concepts.

[^1]: Information Week (2016). *Virtualization Market Now \'Mature,\' Gartner Finds*. <https://www.informationweek.com/cloud/infrastructure-as-a-service/virtualization-market-now-mature-gartner-finds/d/d-id/1325529>

[^2]: JE Smith and Nair (2005). \"Virtual Machines: Versatile Platforms for Systems and Processes.\" Morgan Kaufmann.
