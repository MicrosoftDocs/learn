# Title

Optimizing tightly coupled HPC applications on HB and HC series

## Role(s)

- Solution-architect
- Developer
- Student

## Level

- Intermediate

## Product(s)

- HPC Compute SKUs (HB120rs_v2, HC44rs and HB60rs)
- CentOS-HPC marketplace image

## Prerequisites

- Basic knowledge of high performance computing (HPC).
- Can deploy VMs in Azure and have all VMs mount a shared filesystem.

## Summary

Provide guidance on HPC SKU selection, building and running highly optimized tightly coupled HPC applications.

## Learning objectives

1. Choose the best  (i.e., cost-performance) HPC SKU for each type of tightly coupled HPC application.
2. Optimally build and run each type of tightly coupled HPC applications on Azure HPC SKUs.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Selecting the right HPC SKU | Selecting the right HPC SKU | Knowledge | 1 | yes |
| Apply Process pinning/thread correctly | Running an HPC application optimally  | Exercise | 2 | yes |
| Which HPC image to use | Building/running an HPC application | Exercise | 2 | yes |
| Compilers and Math libraries | Building/running an HPC application | Knowledge | 2 | yes |
| Selecting the right MPI library | Build/running an HPC application | Knowledge | 2| yes |

## Outline the units

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice:

    *A car manufacturing R&D team will be working on designing/developing their new flagship sports car. They do not have sufficient compute capacity on premises for this project and so will be using Azure for all their simulation needs. The project will require running several HPC tightly coupled simulation applications, each having different performance characteristics. Management would like the team to complete this task in a timely and cost-effective manner. The team will need to figure out the most optimal/cost-effective way of building and running their HPC applications in Azure.*

1. **Selecting the right HPC SKU (HB120rs_v2, HC44rs or HB60rs)**

    List the content that will enable the learner to *Select the right HPC SKU*:

    - Why tightly coupled HPC applications need infiniband interconnect
    - Comparison of technical specifications of HPC SKUs
        - Detailed table comparing technical specifications, highlighting which SKU has the best  specification in each category.
    - Translate technical specifications into HPC application performance characteristics
        - Describe what type of HPC performance characteristic is suitable for each HPC SKU type.

    **Knowledge check**

    What types of questions will test *Selecting the right HPC SKU*?

    - Describe HPC application performance characteristic 1, pick the best HPC SKU for this application
    - Describe HPC application performance characteristic 2, pick the best HPC SKU for this application
    - Describe HPC application performance characteristic 3, pick the best HPC SKU for this application

1. **Process pinning considerations**

    List the content that will enable the learner to *apply process pinning correctly for optimal application performance*:

    - Why pin processes/threads when running tightly coupled HPC applications
    - When is it necessary to pin processes/threads
    - How and where do you pin processes/threads (what tools can you use)

    **Exercise - Determine the correct NUMA mapping topology for HPC SKU**

    List the steps that apply the learning content from previous unit:

    1. Install tool (lstopo-no-graphics)
    1. Run tool
    1. Interpret the tool output

1. **Which HPC image to use**

    List the content that will enable the learner to *Select the recommended HPC image*:

    - Why CentOS-HPC marketplace image is recommended
    - What is pre-installed (for convenience) on the CentOS-HPC marketplace image
    - How you can access and use the pre-installed MPI and numerical libraries
    - What are the other HPC image options

   **Exercise - See what pre-installed software exists on CentOS-HPC and how they are accessed**

    List the steps that apply the learning content from previous unit:

    1. Log-in to HPC SKU running CentOS-HPC 7.7
    1. Command to view all pre-installed software
    1. Command to access and use pre-installed software

1. **Compilers and Numerical Libraries**

    List the content that will enable the learner to *Select the correct Compiler and Numerical Library for their HPC application*:

    - Compiler selection
         - Provide compiler recommendation for each HPC SKU
         - What compiler arguments to use
    - Numerical Libraries
        - What should you use for each HPC SKU

    **Knowledge check**

    What types of questions will test *Selecting the right compiler and Numerical Libraries*?

    - For each HPC SKU type what is the recommended compiler
    - For each HPC SKU type what libraries are recommended to resolve BLAS and FFT build dependencies

1. **Selecting the right MPI Library**

    List the content that will enable the learner to *Select the correct MPI library*:

    - What are the MPI library options available
    - Recommended MPI library
    - Recommended MPI command-line arguments for all popular MPI libraries.

    **Knowledge check**

    What types of questions will test *Selecting the right MPI library*?

    - What MPI libraries will work on the HPC SKUs
    - What is the recommended MPI library
    - Which MPI library is ABI compatible with openmpi

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Able to choose the best HPC SKU based on HPC application performance characteristics
    - Understand the principles of process/thread pinning, why it improves performance and where to pin processes/threads
    - Know which compilers and numerical libraries to choose to build an optimal HPC application.
    - What are the recommended MPI (and command-line arguments) to maximize communication performance and to place/pin processes/threads in correct locations to optimize application performance.
