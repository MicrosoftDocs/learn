In this module, we discuss two distributed file systems: the Hadoop Distributed File System (HDFS) and Ceph FS. Both HDFS and Ceph FS are designed to be big-data file systems, but have subtle differences. HDFS is designed for large files with write-once, read-many semantics. Ceph FS, on the other hand is geared towards being a general-purpose distributed file system that can be used for a variety of applications deployed on a virtualized cluster. Ceph FS is a file system layered on top of a distributed object store. This module elaborates on some of the design choices made by the developers of these file systems for their target applications.

## Learning objectives

In this module, you will:

- Review the design goals and architectural characteristics of Hadoop distributed file system (HDFS).
- Review the design goals and architectural characteristics of the Ceph file system (Ceph FS).
- Compare and contrast HDFS and the Ceph file system.

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers.
- Know the technologies that enable cloud computing.
- Understand how cloud service providers pay for and bill for the cloud.
- Know what datacenters are and why they exist.
- Know how datacenters are set up, powered, and provisioned.
- Understand how cloud resources are provisioned and metered.
- Be familiar with the concept of virtualization.
- Know what the different types of virtualization are.
- Understand CPU virtualization.
- Understand memory virtualization.
- Understand I/O virtualization.
- Know about the different types of data and how they are stored.
