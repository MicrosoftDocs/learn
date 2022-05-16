# Module Design

## Title

Introduction to Azure Lab Services

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure Lab Services

## Prerequisites

- Basic familiarity with Azure compute services

## Summary

Discover how to create and run lab environments for learning in Azure.

## Learning Objectives

- Identify business scenarios when Azure Lab Services provides the best lab environments
- Design a classroom lab environment that is hosted in Azure Lab Services

## Chunk your content into subtasks

Identify the subtasks of *Introduction to Azure Lab Services*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| --- | --- | --- | --- | --- |
| Choose to use Azure Lab Services | "In this module, you will consider these environments and choose how to host them in Azure" | Knowledge check | Identify business scenarios when Azure Lab Services provides the best lab environments | Yes |
| Design a classroom lab environment in Azure Lab Services | "...and design the virtual machines, schedules, and other components of a lab environment." | Knowledge check | Design a classroom lab environment that is hosted in Azure Lab Services | Yes |
||||||

## Outline the units

1. **Introduction**

    You can use Azure Lab Services to create and manage classroom lab environments in the cloud.

    Suppose you work for an educational institution. You deliver training classes on development technologies including the .NET Framework, Visual Studio, Apache, Ruby, and Java. You also provide practice environments after each class, where students can develop and test code to consolidate their learning. Both classes and practice environments are currently hosted in your on-premises data center. You want to migrate these systems into the cloud. 

    In this module, you will consider these environments and choose how to host them in Azure.

    By the end of this module, you will be able to identify when Azure Lab Services is the best service for an environment and design the virtual machines, schedules, and other components of a lab environment.

1. **What is Azure Lab Services?**

    - Define Azure Lab Services: You use it to create managed classroom labs.
    - Key capabilities:
        - Automatic management of infrastructure and scale
        - Simple experience for lab users
        - Cost optimization
    - Contrast Azure Lab Services with Azure DevTest Labs. Make sure students understand these are different products with different purposes.

1. **How Lab Services works**

    Describe objects that administrators use to define and manage labs:

    - Quotas
    - Schedules
    - Template virtual machines
    - User profiles
        - Lab account owner
        - Professor
        - Student

1. **When to use Lab Services**

    - When to use Azure Lab Services and when to use Azure DevTest Labs
        - Managed lab types versus DevTest Labs
        - How administrators manage costs in Azure Lab Services and Azure DevTest Labs
        - Azure Lab Services only supports virtual machines created from Azure Marketplace images. For custom images, you must use Azure DevTest Labs

1. **Knowledge check**

    - An overview of the educational institution scenario. Enough details to choose whether to use Azure Lab Services, Azure DevTest Labs, or a set of Azure virtual machines. 
        - Include information in the scenario to indicate that the classroom environments should be hosted in Azure Lab Services
        - Include information in the scenario to indicate that the practice environments should be hosted in Azure DevTest Labs

    - Questions:
        - Your institution wants to maintain manual control over the resources used in each practice environment. Should you use Azure Lab Services, Azure DevTest Labs, or configure custom Azure virtual machines?
        - Your institution wants to minimize the administration time associated with running the course. Should you use Azure Lab Services, Azure DevTest Labs, or configure custom Azure virtual machines?
        - You want to enable the students to complete exercises outside of the class hours. Should you use quotas, schedules, or user profiles?
        - You want to make sure that all the VMs are running for the start of the class at 9:30am. Should you use quotas, schedules, or user profiles?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    In your educational institution, you wanted to host both classroom and practice environments in the cloud. Because you wanted to minimize the management time for classrooms you choose Azure Lab Services to host environments used in instructor-led training. For the practice environments, you wanted to maintain manual control over the virtual machines available to students, so you selected Azure DevTest Labs. 

    It's possible to host lab environments in Azure by using virtual machines alone. For example, you can create classrooms by using Resource Manager templates. However, with Azure Lab Services, many of the administration tasks associated with classroom environments are automated, and you can run classes with the minimum of work.

## Notes

Useful links:

- [An introduction to Azure Lab Services](https://docs.microsoft.com/azure/lab-services/lab-services-overview)
- [Classroom Labs concepts](https://docs.microsoft.com/azure/lab-services/classroom-labs/classroom-labs-concepts)
- [Class types](/azure/lab-services/class-types)