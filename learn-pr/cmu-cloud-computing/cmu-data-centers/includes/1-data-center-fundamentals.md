Datacenters include a room or building, IT equipment, and facilities to securely house, power, and cool that equipment. Over the years, datacenters have evolved from a location of concentrated IT equipment to modular, agile, and highly virtualized compute centers. With growing use of web-based services, explosion of mobile devices, and ever-increasing rates of data generation (and consumption), the demand for new datacenters continues to grow. One of the main contributors to this growth has been the advent of the cloud computing paradigm, in which cost effectiveness is directly linked to economies of scale and the efficiencies gained with new datacenter design. All layers of cloud software and services run on top of physical resources (servers, storage, and networking equipment), and all of these require power. This equipment also generates heat and so requires cooling. A small datacenter might fit in one specialized room, while a large installation might be a dedicated, warehouse-sized facility.
<br>

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4pNcV]

A datacenter's design requirements depend on its size and use. Cloud-centric datacenters could come in two varieties. An infrastructure as a service (IaaS) cloud provider offers a variety of machine types, and the customers pick and choose to build their own applications. Software as a service (SaaS) and platform as a service (PaaS) providers typically use large-scale (many thousands) homogenous compute nodes with custom applications that are presented to end users directly. Other types of datacenters include enterprise/traditional IT, which houses computers to support functions for day-to-day business operations, and high-performance computing (HPC) datacenters, which house large clusters for scientific applications.

In the last 5 years, specific attention has been paid to the efficiency of datacenters, dramatically decreasing their operational costs and carbon footprint. This increase in efficiency has led to a fast evolution of datacenter design, and these trends are likely to continue.

Effective use of cloud resources and development of large-scale, dynamic applications for the cloud require an understanding of the physical resources that make up the cloud. In this module, we start with trends in datacenters, present components that make up a datacenter, and discuss datacenter design considerations and requirements.

## Why study datacenters?

If you think of the cloud as a massive computer,<sup>[1][^1]</sup> you can still break it down into its constituent parts—processors, memory, and switch.<sup>[2][^2]</sup> When you are programming for the cloud, you are writing programs that solve a problem or provide a service but with the ability to scale.

A few decades ago, to be a computer **user** meant to be a **programmer**. Early programmers knew the instruction set architecture (ISA) well and, because hardware resources were scarce, had to optimize in assembly language. With the advent of high-level languages, such as C/C++, Java, and Python, why do students still have to learn computer organization, caching, and assembly language? When you know what the compiler is doing for you, it makes you a better programmer because you understand what is going on behind the scenes. Similarly, you become better at debugging.

Today, when you are developing applications on the cloud, there does **not yet exist** a compiler that allocates massive virtualized resources automatically to solve your specific problem. It is up to you, the cloud programmer, to do the management and to make your applications cost efficient at scale. Analogous to understanding the components within a single computer, knowing the underlying components of a datacenter will improve your abilities to program and debug your cloud-based applications.

Most of you will never go on to design and build your own large-scale datacenter, but understanding what goes into implementing the underlying infrastructure will help you appreciate all of things that cloud providers are doing for you.
<br>
***
### References

1. _Barroso, Luiz André, and Urs Hölzle (2009). [The datacenter as a computer: An introduction to the design of warehouse-scale machines](https://dl.acm.org/doi/book/10.5555/1643608) Synthesis Lectures on Computer Architecture - PDF_
2. _Gordon Bell and Allen Newell (1970). [The PMS and ISP descriptive systems for computer structures Joint Computer Conference - PDF](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.140.9098&rep=rep1&type=pdf)_

[^1]: <https://dl.acm.org/doi/book/10.5555/1643608> "Barroso, Luiz André, and Urs Hölzle (2009). *The datacenter as a computer: An introduction to the design of warehouse-scale machines* Synthesis Lectures on Computer Architecture - PDF"
[^2]: <http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.140.9098&rep=rep1&type=pdf> "Gordon Bell and Allen Newell (1970). *The PMS and ISP descriptive systems for computer structures Joint Computer Conference - PDF*"
