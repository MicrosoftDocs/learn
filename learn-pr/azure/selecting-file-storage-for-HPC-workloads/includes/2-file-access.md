File access, in the context of running HPC workloads, involves ensuring that the required data is present on the HPC machines at the right time, and that any results from those individual machines are quickly saved, making that data available for further analysis.

Files can be a variety of data, including but not limited to:

- unstructured data such as images, documents, or media files
- time-series data from various sources
- pricing data (such as stock price history)
- assets used for computational analysis, such as genomic data, radiological imagery, or weather simulation

The data is assumed to reside in one or more storage solutions in your local environment. Storage solutions in this context include the following:

- Directly-attached disks; Each machine in the HPC cluster has their own local disks and storage
- Storage-Area Network (SAN) solution
- Network-attached Storage (NAS) solution

The data in question may be created locally by analysts, artists, researchers or scientists, or it may be periodically acquired from third parties and deposited in your local storage solution.

Files are accessed by machines participating in the HPC cluster via either a direct disk or network export/share. In both cases the files are presented as a local path (such as /mnt/data).

The code and scripts which make up the actual HPC job assume the files are accessible via a file system path, and will leverage the machine's file access capabilities to obtain the file. For example, a machine running Linux that needs to access a file located on a NAS would use the Network File System (NFS) protocol via NFS client packages.

## File Data and Metadata

Files refer to the actual file data (i.e., the image, the text), and a series of values known as **metadata**. Metadata is important to understand in the context of HPC file system performance.

Metadata refers to when a file was created, when it was last accessed, what sort of permissions it has, the user who owns that file, and which file system structures contain the actual data.

When a file is created, there are metadata operations that allocate the structures, and to update directory entries for that file. This occurs prior to a file's data being written.

## File Traffic Types

The general file traffic types we will discuss in this module are limited to the following activities:

- Loading and running job code on HPC cluster machines.  This might involve loading libraries and toolchains at the beginning of a job.
- Reading source data for the job. This would involve accessing domain-specific and unique data that may differ during each run of the job. Examples of this would be daily pricing data, genomic data or satellite data.
- Intermediate, or scratch, writes. Certain jobs require that initial data be processed, and the output of that processing become new input for downstream activity.
- Finally, writing out the results of the job. This involves placing the data in a desirable location for further consumption. For example, rendering a video and placing the rendered results in a shared volume for use.
