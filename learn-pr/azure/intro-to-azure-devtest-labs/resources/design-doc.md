# Module Design

## Title

Introduction to Azure DevTest Labs

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure DevTest Labs
- Azure Virtual Machines

## Prerequisites

- Basic familiarity with Azure Virtual Machines

## Summary

Discover the services available on Azure for IT administrators to manage Dev machines and Test environments whilst minimizing cost

## Learning objectives

- Identify the need for DevTest Labs
- Understand Azure DevTest Labs concepts
- Identify the scenarios where DevTest Labs is a fit

## Chunk your content into subtasks

Identify the subtasks of *Introduction to Azure DevTest Labs*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Identify the need for DevTest Labs | Identify the need for DevTest Labs | Knowledge check | 1 | Yes |
| Understand Azure DevTest Labs concepts | Understand Azure DevTest Labs concepts | Knowledge check | 2 | Yes |
| Creating Azure DevTest Labs for DEV machines | Identify the scenarios where DevTest Labs is a fit | Knowledge check | 3 | Yes |
| Creating Azure DevTest Labs for test environments | Identify the scenarios where DevTest Labs is a fit | Knowledge check | 4 | Yes |
||||||

## Outline the units

1. **Introduction**

    Some companies have complex technology stacks and systems, which often require large setups and expensive environments, during development and testing.

    Suppose you work for an e-commerce company that has systems that enable orders to be placed and processed by using many different technologies. Some of these systems are offline processing and some are real time. They want to reduce the time and money spent on-boarding new developers, by creating virtual machines that are set up with the systems already configured and installed. They want to look at Azure and explore the options available.  

    In this module, you will learn about the Azure technologies that enable you to create your own dev machines test environments to simplify this procedure.

    By the end of this module, you'll be able to create Azure DevTest Labs.

1. **What is Azure DevTest Labs?**

    - Define Azure DevTest Labs: It enables teams of developers to manage VMs and PaaS resources without waiting for approvals.
    - Key capabilities:
        - Cost control and governance
        - Quickly get to ready-to-test
        - Create once, use everywhere
        - Worry-free self-service
        - Use IaaS and PaaS resources
    - Contrast Azure DevTest Labs with Azure Lab Services. Make sure students understand these are different products with different purposes.

1. **How Azure DevTest Labs works**

    - Describe the concepts of Azure DevTest Labs
        - Environment, base images, artifacts.
        - Discuss best practices for scenario discussed
        - Template your DevTools
    - Using the original scenario, describe how to create a DevTest Labs dev machine
        - Base images to get going quickly
        - Artifacts for installing required dev resources
        - Formulas for automation

1. **When to use Azure DevTest Labs**

    - Explain issues with on-premises v Azure DevTest solutions
        - Delays provisioning, cost and effort to provision, dependency on IT/System admin
        - Explain different use cases for DevTest Labs, like onboarding developers and/or test environments
        - Explain the cost saving measures like automatic shutdown
    - Describe benefits of dev machines in the cloud
        - Work from anywhere
        - A fresh dev machine
        - preinstalled libraries
    - Describe benefits of Test environments in Azure DevTest Labs
        - test servers, build servers, other....
        - quick to spin up
        - performance test and only pay while up
        - integrate with Azure DevOps

1. **Knowledge check**

    Questions:

    - What are the benefits of using Azure DevTest Labs?
    - What is automatic shutdown?
    - What is an artifact?
    - What is a best practice for setting up a DEV machine?
    - What is an example of a formula?
    - What is an example of a base image?
    - What enables quick setup of Test environment? (base images)
    - What provides the install of required resources?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
    - Explained the problems with on-premises solutions
    - Identified the scenarios where DevTest Labs is a fit

## Notes

Concepts - https://docs.microsoft.com/en-gb/azure/lab-services/devtest-lab-concepts

DevTest Labs Overview - https://docs.microsoft.com/en-gb/azure/lab-services/devtest-lab-overview 

This module will likely not have hands-on interactivity outside of knowledge checks, due to the resource requirements and unique use cases for Virtual machines.
