<!-- NOTE: I changed the title of the module from "Using Azure Arc to Enable Windows Server Extended Security Updates" to "Enable Windows Server Extended Security Updates by using Azure Arc", which adheres to the training guidelines at https://review.learn.microsoft.com/en-us/help/learn/id-guidance-title?branch=main. -->

<!-- NOTE: You have inconsistent capitalization for "extended security updates;" it should be either always title capitalized or all lowercase, depending on what the actual product name is. (Which looks like title capitalization according to the FAQ at https://learn.microsoft.com/lifecycle/faq/extended-security-updates. -->

Imagine that you work in IT Operations at Tailwind Traders. You're responsible for managing 150 servers running the Windows Server 2012 R2 operating system that host important workloads. The Windows Server 2012 R2 operating system is beyond the end of Microsoft's extended support period. Your organization presently doesn't have the resources to migrate the workloads hosted on Windows Server 2012 R2 to new servers running Windows Server 2022. As a stopgap measure, you'd like to take advantage of the extended security update (ESU) program for the Windows Server operating system. When you enable extended security updates, your organization will have access to several years of update support beyond Microsoft's existing extended support window. Enabling ESUs provides your organization with time to migrate workloads to a newer Windows Server platform.

<!-- NOTE: You do not need the following "Learning objectives" and "Prerequisites" sections in the Introduction unit because they're already in the index.yml, where they'll be displayed on the module's landing page. You need to combine these learning objectives and prerequisites with the lists in the index.yml and then delete these. (Note that this is a change from the past, where we used to have learning objectives and prerequisites in the Introduction unit, so you're following an established content pattern, albeit a pattern that has since been phased out. -->

## Learning objectives

In this module, you'll:

- Understand the purpose of Extended Security Updates (ESU) for Windows Server
- Know the different methods of obtaining ESUs
- Enable ESUs for on-premises servers using Azure Arc
- Use Multiple Activation Keys to enable ESUs for non-Arc-enabled servers
- Activate ESU licenses for Arc-enabled servers.

## Prerequisites:

Understand how to use Azure Arc to configure and manage extended security updates for versions of Windows Server that are no longer covered by mainstream or extended support.