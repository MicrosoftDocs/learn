Azure HPC Cache is a managed service that accelerates Network File System (NFS) storage so that high-performance computing (HPC) workloads can finish faster. Caching data close to HPC clients in Azure allows the clients to run more efficiently and complete high-performance tasks faster.

Suppose you're a storage administrator at a digital animation studio. The studio is releasing a movie soon, and there are still several changes and reviews that the director needs to make. You're looking for ways to accelerate storage so that the studio can produce movie scenes faster for the director's approval.

Some studios use in-house clients to render their movies and scenes. Because they have limited clients, their output hits a ceiling. They can only produce a limited number of scenes with their resources.

When studios use cloud clients, they can use more processing power, which means that they can produce their scenes in a shorter time. Without cloud clients for video rendering, studios will miss deadlines for theatrical releases.

In this module, you'll learn how to create an Azure HPC Cache instance, configure the cache to accelerate a Linux-based file system, and attach clients to access the cache's storage.

> [!NOTE]
> Because HPC workloads use significant resources that exceed the limits of a free Azure account, this module performs knowledge checks only and does not include exercises. To practice the concepts in this module, use a paid account and monitor all charges.

## Learning objectives

By the end of this module, you'll be able to set up and configure Azure HPC Cache so that HPC clients can access its storage. You'll also be able to:

- Understand what Azure HPC Cache is.
- List the prerequisites for HPC Cache.
- Configure HPC Cache to accelerate a Linux-based file system.
- Attach virtual client machines to read from the cache.

## Prerequisites

- Familiarity with NFS storage concepts like mount, export, and namespace
- Familiarity with networking concepts like subnet, DNS, and TCP/UDP ports
- Familiarity with creating virtual machines in the Azure portal
