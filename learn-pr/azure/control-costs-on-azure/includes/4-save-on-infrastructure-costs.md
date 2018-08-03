So we've looked through how you can get estimates for environments you'd like to build, and walked through some tools that can be used to get detailed information on how we're currently spending money and project future expenses. What are some best practices that you can leverage today to reduce the cost you're incurring in your cloud environment? Let's take a look through some ways to reduce infrastructure costs.

## Use Reserved Instances

What are reserved instances

**from blog** - We recently announced the general availability of reserved instances on Azure, and this was great to see come to fruition. For VM workloads that are static and predictable in nature, this is a fantastic offer that can save upwards of 70% depending on the VM size. For workloads that are up and running 24x7x365 and are unlikely to change in VM size this certainly an option that should be looked at. Reserved instances are purchased in 1 or 3 year terms, with payment required for the full term up front. Once purchased, we match up the reservation to running instances, and decrement the hours from your reservation. Reservations can be purchased through the Azure Portal and since reserved instances are a compute discount, they are available for both Windows and Linux VMs. For more information take a look at the following documentation.

## Right-size underutilized virtual machines

**from blog** One of the things that Cost Management and Advisor may recommend is right-sizing or shutting down VMs. Changing VM size is easy on Azure, and if you have VMs that typically sit idle, this is a great way you can reduce your costs. Shutting down unused systems is important as well, as often times VMs are created for a test environment or a project that maybe never took off, but nobody went back and cleaned up the environment afterwards. Identifying these systems is important, as they drive up your bill unnecessarily. It's also important to take a look at the usage patterns of your systems. If you have systems that are primarily used during business hours (or another regular time period) you should evaluate if you can shut them down when they are not being used. I've had customers succefully use Azure Automation to run scripts that will stop/start VMs on a schedule. Below are a couple examples of this (both of which are avialble in Azure Automatin), you can use these scripts or modify them as appropriate. Bottom line, it's important to evauluate the size, usage and usage patterns of your VMs to ensure they are as cost effective as possible.

What is server size
How do we change instance sizes
What is the impact to costs

## Deallocate virtual machines in off hours

Use auto-shutdown
Use the new stop/start automation release


## Delete unused virtual machines

This may sound obvious...

## Migrate to PaaS or SaaS services

**from blog** Lastly, as you move workloads to the cloud, a natural evolution is to start with IaaS services and them move them to PaaS as appropriate, and in an iterative process. PaaS services typically provide a substantial savings in both resource and operational costs. The challenge is that, depending on the type of service, varying levels of effort will be required to move to these servcies from both a time and resource perspective. You may be able to easily move a SQL Server databse to Azure SQL DB, but it may take substantially more effort to move your multi-tier application to a container or serverless based architecture. It's a good practice to continuously evaluate the architecture of your applications to determine if there are efficiences to be gained through PaaS services. Azure makes it easy to test these out with little risk, giving you the ability to try out new architecture patterns relatively easily. That said, it's typically a longer journey and may not be of immediate help if you're looking for quick wins from a cost savings perspective. The Azure Architecture Center is a great place to get ideas for transforming your application, as well as best practices across a wide array of architectures and Azure services.

## Summary