# How does storage access impact HPC workloads?

Storage access is an important part of planning for HPC workload performance. You need to make sure that the required data gets to HPC cluster machines at the right time. You also need to make sure results from those individual machines are quickly saved and available for further analysis.

Files can be a variety of data, including but not limited to these:

- Unstructured data, such as images, documents, or media files.
- Time-series data from various sources.
- Pricing data (such as stock price history).
- Assets used for computational analysis, such as genomic data, radiological imagery, or weather simulation.

The data is assumed to reside in one or more storage solutions in your local environment. Storage architectures in this context include the following:

- Directly attached disks - that is, each machine in the HPC cluster has its own local storage disks.
- Storage area network (SAN) solutions.
- Network-attached storage (NAS) solutions.

![Three different Storage Architectures](../media/storage-architectures.png)

The data in question may be created locally by analysts, artists, researchers, or scientists, and it might also be periodically acquired from third parties and deposited in your local storage solution.

## Types of file access

The general file access use cases we will discuss in this module are limited to the following activities:

- Loading and running job code, libraries, and/or toolchains on HPC cluster machines.
- Reading source data for the job. Examples of this could be daily pricing data, genomic data, or satellite data.
- Intermediate,  or *scratch*, writes. Certain jobs require that initial data be processed, and the output of that processing become new input for downstream activity.
- Finally, writing out the results of the job. This involves placing the data in a desirable location for further consumption. For example, rendering a video and placing the rendered results in a shared volume for use.

## How do HPC machines get working set data?

Machines in the HPC cluster access files through either a directly attached disk or through a network export or share. In both cases, the files are presented in a local path (for example, `/mnt/data`).

The code and scripts that make up the actual HPC job assume the files are accessible on this file system, and leverage the machine's file access capabilities to obtain the file or files. For example, a machine running Linux that needs to access a file located on a NAS would use the Network File System (NFS) protocol and NFS client packages installed as part of the operating system.

## Understanding file metadata

While a file stores actual data (for example, an image or lines of text) and additional information known as **metadata**. This metadata exists either within the file data or a directory and is important to understand in the context of HPC file system performance.

Metadata is a set of values that describes attributes of the data, but is not part of the data. For example, metadata tells you when the file was created and modified, who created the file, and who has permissions to access it.

When a file is created, there are metadata operations that allocate the structures, and to update directory entries for that file. This happens before data is written to the file.


