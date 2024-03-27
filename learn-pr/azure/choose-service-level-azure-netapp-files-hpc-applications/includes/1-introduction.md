Azure NetApp Files is widely used as the underlying shared file-storage service in various scenarios, which include high-performance computing (HPC) infrastructure. Azure NetApp Files supports three service levels: Ultra, Premium, and Standard. The allowed maximum throughput differentiates the service levels.

In this module, you learn how to choose the best service level of Azure NetApp Files for your HPC applications.

## Scenario

Suppose you're a member of a semiconductor company who's been tasked with designing their IC chips, which need numerous electronic design automation (EDA) simulations. You don't have sufficient capacity on-premises for this project, so you want to use Azure for those HPC simulation needs.

Management wants this project to be completed in a timely and cost-effective manner. You choose Azure NetApp Files as the back-end storage solution because it provides an on-premises-like experience and performance.

You need to figure out the most optimal and cost-effective way of building and running your HPC applications in Azure.

## What will we be doing?

In this module, we examine the decision criteria that determine Azure NetApp Files performance. Then, you learn how to map your throughput or IOPS requirements to choose the most cost-effective service level.

## Learning objectives

By the end of this module, you're able to:

- Describe the factors that determine throughput limits of Azure NetApp Files volume.
- Choose the best service level of Azure NetApp Files for HPC applications.

## Prerequisites

- Understand the concepts of storage hierarchy of Azure NetApp Files, which includes Azure NetApp Files accounts, capacity pools, and volumes.
- Ability to set up Azure NetApp Files and create a volume.
