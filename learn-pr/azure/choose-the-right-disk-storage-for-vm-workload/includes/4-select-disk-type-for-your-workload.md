Let's examine in detail the disk type choices architects must make for a proposed Azure application.

In your healthcare organization, you have a business-critical system that manages stocks of prescription drugs and ensures that practitioners have them available at all times in their local clinics. You want to migrate the system into Azure with as little modification as possible. You want to create a set of virtual machines in Azure that match the current physical servers, then migrate the system. Before the migration, you want to select the right disk types for each virtual machine.

In this unit, you'll examine the requirements for each virtual server in the proposed Azure infrastructure and see why a particular disk type is optimal.

![Diagram of on-premises servers for the prescription drugs stocks database.](../media/4-on-premises-servers.png)

## Production database server

First, you want to architect the virtual machine that will host the production database for your prescription-drug stocks system. This system is business critical. It's used by the majority of your employees all around the world to do their jobs. The database server in the on-premises system is heavily utilized. The physical disks run close to their capacity in terms of IOPS and throughput.

You've monitored and analyzed the performance of your on-premises system both during typical periods and during periods of peak demand, such as during a successful marketing campaign. This study shows that fast disks and low latency underpin the system and that any drop in performance will affect all your users. To ensure that your current good performance continues after the migration to the cloud, you want the disks that store the databases to support 50,000 IOPS and throughputs up to 1,000 :::no-loc text="MBps":::.

This requirement makes the decision simple. The maximum size for premium SSD managed disks is P80, but this size supports maximum IOPS of 20,000 and a maximum throughput of 900 :::no-loc text="MBps":::. Only the largest sizes of Ultra Disks support the performance you need.

Remember that Ultra Disks can only be attached to virtual machines in availability zones. This requirement provides high availability because the virtual servers aren't vulnerable to a datacenter-wide hardware failure. It also means that you should use managed disks, which Azure automatically replicates across the availability zones where virtual machines are hosted.

## Data warehouse servers

Next, you want to consider the servers that host the prescription-drug data warehouse. Data from the production database is regularly exported to this data warehouse and restructured to make it easier to analyze long-term trends. These servers also host data cubes that are designed to support your complex reporting needs.

In your on-premises system, there's a data warehouse server in your main datacenter, and also several in regional offices. You've created a virtual-machine image for these data warehouse servers, and you'll use it to simplify the deployment of multiple instances of the virtual machine in multiple Azure regions. Your analysis indicates that these servers require high-performance disks, but not the extreme performance required by the production database server.

The highest performance disks in Azure are premium SSD v2 managed disks, premium SSD managed disks, and Ultra Disks. However, Ultra Disks and premium SSD v2 managed disks don't currently support virtual-machine images. As a result, premium SSD managed disks are the optimal disk type for data disks in this workload.

## Standby database server

In your on-premises system, you have a standby server that runs a replica of the main prescription-drug stocks database. On the rare occasions when the main server fails, database queries are redirected to this server so that users experience no interruption in service. You want a similar standby virtual machine in your cloud-based system.

Because this virtual machine won't be used most of the time, you've been asked to implement it within a limited budget. Your architects consider that a drop in performance is acceptable during rare failures of the primary virtual machine.

You find that the budget is unlikely to stretch to premium SSD managed disks or premium SSD v2 managed disks. In these circumstances, standard SSDs that use managed disks are the best choice, because they have equal or better performance than the equivalent size of standard hard disk drives (HDDs) and more consistent performance.

## Administrative web interface

The on-premises system includes a set of stored procedures that implement maintenance routines on the data. There's also a set of data views that administrators use to monitor the performance of the database. To make life easier for administrators, there's a web server in your on-premises system that hosts a site that administrators can use to run these stored procedures and view performance reports. You want to migrate this server into the cloud and host it on an Azure virtual machine.

Again, you want to minimize costs. The site is used only by the team of 20 administrators and places low load on its disk drives, which are used only to store the web application's code files. This server doesn't have strict availability requirements, because it's not a business-critical system.

In this case, you can minimize costs by using Standard HDDs in the web server. To minimize administrative requirements, you can use managed disks.
