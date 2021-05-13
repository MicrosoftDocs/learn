Azure NetApp Files is a managed storage solution for various scenarios, including high-performance computing (HPC) infrastructure. The low latency and the high number of I/O operations per second (IOPS) are a great mixture for enterprises at scale.

Suppose you work for a semiconductor company. You're tasked with designing the company's integrated circuit chips, which need many electronic design automation (EDA) simulations. You don't have enough capacity on-premises for this project, so you'll use Azure for those HPC simulation needs.

Management wants this project to be completed in a timely and cost-effective way. You choose Azure NetApp Files as the back-end storage solution because it provides an on-premises-like experience and performance. You'll need to know the performance tips and best practices to improve Azure NetApp Files performance for your EDA applications.

In this module, we'll introduce performance suggestions for reference architecture, client virtual machines (VMs), and network. We'll then discuss performance tips, including mount options and client VM configurations. Finally, we'll examine the benchmark results to verify the performance tips that we discussed.

## Learning objectives

By the end of this module, you'll be able to:

- List the best practices that improve Azure NetApp Files performance.
- Describe the performance impact of the best practices on FIO and EDA benchmark suites.

## Prerequisites

- Understanding of the storage hierarchy for Azure NetApp Files, including NetApp accounts, capacity pools, and volumes
- Ability to set up Azure NetApp Files and create a volume
- Ability to mount the Azure NetApp Files volume from a virtual machine
