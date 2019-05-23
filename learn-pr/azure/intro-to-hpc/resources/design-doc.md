# Module Design

## Title

Introduction to high performance computing (HPC) on Azure

## Role(s)

- Solution architect

## Level

- Beginner

## Product(s)

- Azure Batch
- Azure virtual machine HPC instances
- Microsoft HPC Pack

## Prerequisites

- Basic familiarity with Azure compute services

## Summary

Discover the services available on Azure for your high performance computing workloads.

## Learning objectives

- Identify the HPC and batch solutions available on Azure
- Identify the scenarios where HPC and batch technologies are a fit

## Chunk your content into subtasks

Identify the subtasks of *Introduction to high performance computing (HPC) on Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Identify the HPC and batch solutions available on Azure | Understand the HPC solutions available on Azure | Knowledge check | 1 | Yes |
| Identify the scenarios where HPC and batch technologies are a fit | Leverage Azure for HPC modernization efforts | Knowledge check | 2 | Yes |
||||||

## Outline the units

1. **Introduction**

    Some companies have complex mathematical tasks that require high performance compute resources. In Azure you can choose from several technologies to perform these tasks.

    Suppose you work for an engineering organization that has an application that creates 3D models of the facilities they design. The company also has another system that stores a large amount of statistical data related to their projects. They want to modernize the aging high performance compute platforms that support these applications, and would like to leverage Azure for their modernization efforts. They need understand the solutions available on Azure and how they can fit into their plans.

    In this module, you will learn about the Azure technologies that you use to execute intensive computing tasks.

    By the end of this module, you will be able to choose the right Azure technology to use for any high performance computing project.

1. **Azure Batch**

    List the content that will enable the learner to *Identify the HPC and batch solutions available on Azure*:

    - Explain Azure Batch and its benefits
        - Describe the Azure Batch service, its components and some typical use cases
        - Explain how Azure Batch handles scheduling, management, autoscale
        - Explain why Azure Batch is well-suited for large-scale parallel workloads

   **Knowledge check**

    What types of questions will test *Identify the HPC and batch solutions available on Azure*?

    - What are the benefits of using Azure Batch?
    - What high-level component acts as a container for tasks in Azure Batch?

1. **Azure VM HPC Instances**

    List the content that will enable the learner to *Identify the HPC and batch solutions available on Azure*:

    - Describe Azure virtual machine HPC instances and their benefits
        - H-Series VMs and their unique performance and scalability advantages
        - Ultra-low latency and high-bandwidth networking capabilities
        - Large memory and HPC-class CPU SKUs
        - The ways in which these features are particularly well-suited for HPC workloads  

   **Knowledge check**

    What types of questions will test *Identify the HPC and batch solutions available on Azure*?

    - Which CPU type does the HB-series VM rely on?
    - Identify a potential hurdle in deploying H-Series VMs

1. **Microsoft HPC Pack**

    - Describe HPC Pack, what it is, and what it is for
        - HPC Pack allows for the creation and management of VMs in HPC clusters
        - Can be on-premises, hybrid, or cloud-only
        - Both Windows and Linux flavours (and some sample use cases)
        - Can be combined with the H-Series VM instances previously described

   **Knowledge check**

    What types of questions will test *Identify the HPC and batch solutions available on Azure*?

    - Which of the following components are mandatory prerequisites for a cloud deployment of HPC Pack
    - How can jobs be submitted to an HPC Pack cluster on Azure without connecting to the head node?

1. **Scenarios for HPC and Batch technologies**

    List the content that will enable the learner to *Identify the scenarios where HPC and batch technologies are a fit*:

    - Learn about sample use cases for HPC and Batch technologies:
        - Explicit and implicit finite element analysis
        - Weather modeling
        - 3D Rendering
        - Financial risk modeling
        - Engineering design and simulation
        - Genomics research
        - CAD engineering
        - Computational fluid dynamics
    - Azure Batch (which if any of the above use cases are particularly suitable, and also in relation to the intro scenario)- Azure HPC Instances (which if any of the above use cases are particularly suitable, and also in relation to the intro scenario)
    - Microsoft HPC Pack

   **Knowledge check**

    What types of questions will test *Identify the scenarios where HPC and batch technologies are a fit*?

    - What of the following use cases are well-suited for Azure Batch?
    - Which HPC Option on Azure would work well for implicit finite element analysis?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
    - Explained some options for HPC on Azure
    - Identified the scenarios where HPC and batch technologies are a fit

## Notes

Big compute landing page - https://azure.microsoft.com/solutions/big-compute/

Batch documentation - https://docs.microsoft.com/azure/batch/ 

This module will likely not have hands on interactivity outside of knowledge checks, due to the resource requirements and unique use cases for HPC services.
