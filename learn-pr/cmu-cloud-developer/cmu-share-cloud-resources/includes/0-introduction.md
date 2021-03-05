You already know about datacenters, their components, and related design decisions. To build a cloud requires more than just building a datacenter. We need some mechanism to manage and share datacenter resources over multiple clients (or tenants). This sharing of resources must be done in a safe, efficient, and isolated manner. This is where resource sharing technologies come in. 

Now we'll go into some depth about various resource sharing techniques, but we'll focus on the big one: virtualization. Previously, you learned about the evolution of cloud computing and the surprising fact that the ideas about utility computing actually date back to the 1960s. You also learned that the evolution and combination of multiple technologies led to the emergence of the cloud today. Virtualization is arguably one of the most important of those technologies. Virtualization acts like a kind of glue that holds everything together. 

This module is more systems-focused than the previous modules, but a thorough understanding of virtualization will help those who intend to take systems-focused roles in the industry. It also will help those who have research inclinations in this space. 

In this module, we'll look at virtualization in general and understand some of the key motivations behind virtual machines.  We'll also look at the limitations of general-purpose operating systems that led to the emergence of virtualization, and take a whirlwind tour of the interfaces and abstractions in a modern computer system. We'll then look at the bigger picture of resource sharing and what it means to share a resource in time and space. 

The material presented here should contain sufficient detail for the course, but interested readers can refer to the popular book _Virtual Machines: Versatile Platforms for Systems and Processes_<sup>[1][^1]</sup> as a fairly comprehensive reference for all virtualization-related concepts. 

## Learning objectives

In this module, you will:
- Identify major reasons that virtualization is becoming essential, especially on the cloud.
- Identify some of the main limitations of traditional operating systems to enable the cloud computing paradigm.
- Indicate how system complexity can be managed in terms of levels of abstractions and well-defined interfaces, and specify their applicability to virtualization and the cloud.
- Define resource sharing, explain why it is needed, discuss its two main implementations, and indicate its applicability to virtualization.
- Outline the main differences between sharing uniprocessor and multiprocessor systems and the pros and cons of sharing multiprocessor systems in time and space.

## Prerequisites
- Understand what cloud computing is, including cloud service models, and common cloud providers.
- Know the technologies that enable cloud computing.
- Understand how cloud service providers pay for and bill for the cloud.
- Know what datacenters are and why they exist.
- Know how datacenters are set up, powered, and provisioned.
- Understand how cloud resources are provisioned and metered.

<br>

***

### References

1. _JE Smith and Nair (2005). [Virtual Machines: Versatile Platforms for Systems and Processes](https://dl.acm.org/citation.cfm?id=1204009) Morgan Kaufmann_

[^1]:<https://dl.acm.org/citation.cfm?id=1204009> "JE Smith and Nair (2005). *Virtual Machines: Versatile Platforms for Systems and Processes* Morgan Kaufmann"
