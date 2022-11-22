There are several different approaches you could take to host virtual machines for training purposes in Azure. You need to know the limitations and advantages of Azure Lab Services to help decide whether it's the right fit.

In your educational institution, you run simple lab setups for classes. Your primary interest is to reduce administrative and running costs. You want to be sure that Azure Lab Services is the best solution for your classes.

## Ease of administration

An educator can create and manage the labs within the guard rails that the administrator has set up, such as what virtual machine images are allowed. An educator doesn't typically need to talk to an IT administrator to create and manage individual labs. The administrator role is simple enough that an educator can act in the administrator role if it makes sense to do so.

Azure Lab Services makes it easy to set up and run classes. For example, you can:

- Quickly provision a lab VM and use the VM repeatedly across a lab.
- Provision and scale to hundreds of lab VMs with minimal effort.

Azure Lab Services also provides:

- Cloud-based infrastructure to enable remote learning.
- Simple sign-on for invited users; users get access to all their VMs from a single page, even VMs for different classes.
- Optional Canvas integration for schools that use Canvas.
- Optional Teams integration.
- Resiliency against infrastructure failures, and automatic handling of errors.

Use Azure Lab Services when you want to create training labs in Azure with the minimum of administration, based on images from the Azure Marketplace or your own custom images.

Azure takes care of setting up and configuring all the necessary resources when the lab starts.  

## Flexible cost management

Although Lab Services makes it easy to set up and run classes, you also get full control over resource usage through schedules, quotas, and policies. Specifically, Azure Lab Services provides:

- Scheduling and quotas allow you to easily configure available time slots for usage, and/or maximum usage times for students.
- Policy features that allow your administrator to configure automatic shutdown based on user inactivity and/or resource usage. Make sure that VM inactivity shutdowns are neither too short nor too long.

If you are comparing Azure Lab Services with Azure DevTest Labs, be aware that Azure DevTest Labs does not support the same cost management features.

## Training or testing

Azure Lab Services is typically used for training but can be used for other group events such as Hackathons. For purposes such as app development or testing, investigate whether a different service, such as Azure DevTest Labs, is more appropriate for your lab environment. For example, if you want to create a test environment for a custom software package, Azure Lab Services may not be flexible enough for your requirements.

If you need to create more complex and flexible labs than are supported in Azure Lab Services, and you don't mind the extra administrative work that may be required, consider Azure DevTest Labs as an alternative.

## Resources

Azure Lab Services now supports Azure Resource Manager templates, which provision different types of resources within the lab. These templates are text files in JSON format that define and configure a set of virtual machines and other Azure resources.

If you need Azure cloud-based resources for your labs that aren't supported in Azure Resource Manager, you may need a different solution such as Azure DevTest Labs.
