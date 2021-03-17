# Introduction

Azure HPC Cache is a managed service that accelerates NFS storage so HPC workloads can finish faster. Caching data close to HPC clients allows the clients to run more efficiently and complete high-performance tasks faster.

Suppose you are a storage administrator at a digital animation studio. The studio is releasing a movie soon and there are still several changes and reviews that the director needs to make. You are looking for ways to accelerate storage so the studio can produce movie scenes faster for the director’s approval.

In this module, you will learn how to create an Azure HPC Cache, configure the cache to accelerate a Linux-based file system, and attach clients to access the cache’s storage.
> [!NOTE]
> Because HPC workloads use significant resources that exceed the limits of a free Azure account, this module performs knowledge checks only and does not include exercises. To practice the concepts in this module, use a paid account and monitor all charges.

By the end of this module, you will be able to create and configure an Azure HPC Cache so HPC clients can access its storage.

## Learning Objectives

By the end of this module the learner will be able to:

1. Create an Azure HPC Cache.
1. Configure an Azure HPC Cache to accelerate a Linux-based filesystem.
1. Configure (Attach) virtual client machines to read from the cache.
1. Read and process storage data using client machines.

## Prerequisites

- Familiarity with NFS storage concepts such as mount, export, and namespace.
- Familiarity with networking concepts such as subnet, DNS, and TCP/UDP ports.
- Familiarity with creating virtual machines in the Azure portal.
