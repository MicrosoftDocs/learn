# Title

HPC Storage Considerations

## Role(s)

- Solution Architect
- Developer
- Students

## Level

- Intermediate

## Product(s)

- Azure
- Azure Storage
- Azure HPC Cache
- Azure NetApp Files

## Prerequisites

- Basic familiarity with Azure compute services
- Basic knowledge of high performance computing (HPC) concepts
- Familiarity with basic network-attached storage (NAS) concepts
- Familiarity with basic filesystem concepts

## Summary

Discuss the various high-level considerations when choosing storage for your Azure High-Performance Computing solution 

## Learning objectives

1. Discuss the various file access considerations
2. Discuss the various high-level performance considerations
3. Discuss the various traffic considerations
4. Review file system authentication and authorization considerations
5. Discuss hybrid file access scenarios
6. Consolidate the various considerations into a general requirement checklist

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| File access overview | Review of HPC file access | Knowledge | 1 |  |
| Performance considerations | Review of performance-specific considerations| Knowledge | 1 |  |
| Traffic considerations | Review of file system traffic considerations | Knowledge | 1  | Yes |
| Authentication and Authorization considerations| Review of authentication and authorization considerations | Knowledge | 1 | Yes |
| Hybrid file access scenarios | Overview of hybrid file system | Knowledge | 1 | Yes |
| Consolidating your file system requirements| Building your requirements | Exercise | 1 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **File access overview**

    File access, in the context of running HPC workloads, involves ensuring that the required data is present on the HPC machines at the right time, and that any results from those individual machines are quickly saved, making that data available for further analysis.

    The scenario you are seeking to solve involves the following: Customer wishes to run their High-Performance Compute (HPC) environment in Azure and needs to figure out the right file system to meet their needs. What are the main considerations when trying to choose and size the best file system solution?


2. **Performance considerations**

    User will review those aspects of file systems that most impact performance. 


    **Knowledge check**

    What types of questions will test *Awareness of performance characteristics of a file system*? *[(Knowledge check guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-knowledge-check)*

    - What are the top three performance considerations that impact file system operation?
    - How do combinations of these performance considerations impact performance?

3. **Traffic considerations**

    User will review types of file traffic and how they may affect performance

    1. Discuss the differences between traffic types
    2. Discuss checkpointing and snapshots and how they might impact performance
    3. Discuss scaling concerns with file systems

4. **Authentication and authorization considerations*

    1. Review authentication/authorization mechanisms most often used with file systems
    2. Discuss impact of moving data between security domains
    3. Discuss performance concerns with authentication/authorization systems

5. **Hybrid file access architectures**

    User will review basic hybrid file access architectures and how they are applied to Azure HPC use cases  

    1. Discuss data location considerations
    2. Review pseudo file system usage across multiple file systems
    3. Discuss the use of Blob-based file system solutions

6. **Consolidating your requirements**

    The user will consolidate all of the considerations discussed in previous units to build their requirements checklist

    1. Building the checklist
    2. Populating the checklist

    **Exercise -- Build an example checklist**



7. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - 
    *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)*

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, etc.