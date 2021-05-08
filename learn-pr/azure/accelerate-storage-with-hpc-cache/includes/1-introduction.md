Azure HPC Cache is a managed service that accelerates NFS storage so HPC workloads can finish faster. Caching data close to HPC clients in Azure allows the clients to run more efficiently and complete high-performance tasks faster.

Suppose you are a storage administrator at a digital animation studio. The studio is releasing a movie soon and there are still several changes and reviews that the director needs to make. You are looking for ways to accelerate storage so the studio can produce movie scenes faster for the director’s approval.

Some studios use in-house clients to render their movies and scenes. Because they have limited clients, their output hits a ceiling. They can only produce a certain number of scenes with their given resources.

When studios leverage cloud clients, they are able to use more processing power. This means their scenes can be produced in a shorter time. Without cloud clients for video rendering, studios will miss deadlines for theatrical releases.

In this module, you will learn how to create an Azure HPC Cache, configure the cache to accelerate a Linux-based file system, and attach clients to access the cache’s storage.

> [!NOTE]
> Because HPC workloads use significant resources that exceed the limits of a free Azure account, this module performs knowledge checks only and does not include exercises. To practice the concepts in this module, use a paid account and monitor all charges.

By the end of this module, you will be able to create and configure an Azure HPC Cache so HPC clients can access its storage.

## Learning objectives

By the end of this module the learner will be able to:

- Understand what an Azure HPC Cache is.
- List the pre-requisites for an Azure HPC Cache.
- Create an Azure HPC Cache.
- Configure an Azure HPC Cache to accelerate a Linux-based filesystem.
- Attach virtual client machines to read from the cache.

## Prerequisites

- Familiarity with NFS storage concepts such as mount, export, and namespace.
- Familiarity with networking concepts such as subnet, DNS, and TCP/UDP ports.
- Familiarity with creating virtual machines in the Azure portal.