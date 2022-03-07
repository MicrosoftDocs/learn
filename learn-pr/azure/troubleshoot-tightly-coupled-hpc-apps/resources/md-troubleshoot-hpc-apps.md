# Title

 Troubleshooting tightly coupled HPC applications on HB and HC series

## Role(s)

- Solution-architect
- Developer
- Student

## Level

- Intermediate

## Product(s)

- HPC Compute SKU's (HB120rs_v2, HC44rs and HB60rs)
- CentOS-HPC marketplace image

## Prerequisites

- Can run tightly coupled HPC applications on Azure HPC SKU's

## Summary

Provide guidance on troubleshooting run-time failures and under performing tightly coupled HPC applications.

## Learning objectives

1. Troubleshoot tightly coupled HPC applications run-time failures
1. Troubleshoot underperforming tightly coupled HPC applications

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| HPC VM health checks | Troubleshooting a HPC application runtime failure | knowledge | 1 | yes |
|Debugging performance bottlenecks | Troubleshooting slow running HPC application | knowledge | 2 | yes |

## Outline the units

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice:

    *A car manufacturing R&D team are working on designing/developing their new flagship sports car in Azure. They have built and ported their tightly coupled HPC applications on Azure HPC SKU's. Unfortunately, they observed a few problems executing their HPC jobs in Azure. Some tightly coupled jobs failed to run correctly and some others were performing slower than expected. The R&D team will need to troubleshoot why some of their HPC applications had run-time failures and other HPC applications were performing below expectations*

1. **HPC VM health checks**

    List the content that will enable the learner to *troubleshoot HPC application runtime errors*:

    - When to run HPC VM health checks
    - What tests/tools to use and what do they test
    - How to interpret the test results and when to take action on a HPC VM

    **Knowledge check**

    What types of questions will test *Selecting health check tools*?

    - What test/tool is recommended to check Infiniband interconnect health
    - What test/tool is recommended to check HPC VM memory health
    - What test/tool is recommended to check Storage health

1. **Debugging performance bottlenecks**

    List the content that will enable the learner to *troubleshoot HPC application performance problems*:

    - Recommendations for preparing and running tightly coupled HPC applications at scale
    - How to check that you are running the correct number of parallel processes/threads and that they are running/pinned in optimal locations
    - How to check and correct I/O performance issues

    **Knowledge check**

    What types of questions will test *how to troubleshoot slow running HPC applications*?

    - What tool to use to check that the correct number of processes/threads are running
    - What tool to use to check that the processes/threads are running on the correct cpu cores.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - How to troubleshoot tightly coupled HPC application run-time failures.
    - How to troubleshoot underperforming tightly coupled HPC applications.
