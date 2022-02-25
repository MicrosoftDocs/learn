# Title

Set up your first development lab by using Azure DevTest Labs

## Role(s)

- administrator
- developer

## Level

Beginner

## Product(s)

Azure DevTest Labs

## Prerequisites

- Basic knowledge of the Azure DevTest Labs concepts of environments, artifacts, and virtual machines
- Experience creating and managing Azure virtual machine resources using the Azure portal at the beginner level
- Remote Desktop client installed. Get a [Remote Desktop client](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients).

## Summary

Create a development virtual machine from a base image and pre-install required software. You will use a Remote Desktop client to access the VM.

## Learning objectives

By the end of this module, you will be able to:

1. Configure a DevTest lab with a curated list of images by using the Azure portal.
1. Provision a pre-configured VM with all the required software, tools, and artifacts.
<!-- 1. Enable your development teams to self-serve Azure infrastructure -->
1. Claim and access a VM by using Remote Desktop client software.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: Exercise or Knowledge check? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create a DevTest Lab | TODO | Exercise | Objective 1 | Yes |
| Provision a VM in the lab and add artifacts | TODO | Exercise | Objective 2 | Yes |
| Access the VM by using a Remote Desktop client | TODO | Exercise | Objective 3 | No, combined with subtask 2 |

## Outline the units

Add more units as needed for your content

1. Introduction

    Provide a scenario of a real-world job task that shows how the technology is used in practice:

    Suppose you work at an e-commerce company that offers fashion and lifestyle products to consumers. Your company operates in a highly competitive market where you need to innovate rapidly to keep your customers engaged. As the development team expands rapidly, you need to configure the developer machines quickly. The test team validates the latest application build at the end of the weekly sprint in a separate test environment.

    <!-- don't run locally - install software, set up laptop

    with each sprint you want to test software build -> throw away environment after test
    support monthly release cadence

    development and test -> clear you need different environments -> better than frontend vs backend, which are both development activities -->

<!-- 1. Concepts about setting up a DevTest Lab resource -->
1. Understand Azure DevTest Labs

    List the content that will enable the learner to complete the subtask:

    - Create a DevTest Lab resource
        - What is a DevTest Lab?
        - What are public environments?
        - What is auto-shutdown?
        - What is an network isolation?

    - Configure virtual machine base images
        - What is a VM base image?

<!-- 1. Exercise - Set up DevTest Lab resource and configure settings -->
1. Exercise - Configure a company lab environment

    List the steps that apply the learning content from previous unit:

    1. Create a DevTest Lab resource, configure public environments and auto-shutdown.
    1. Configure Marketplace VM images

<!-- 1. Concepts about adding a VM to a lab and accessing it through RDP -->
1. Configure a lab VM and access it through RDP

    List the content that will enable the learner to complete the subtask:

    - Add a Windows Server 2019 virtual machine to the lab
        - What is a claimable VM?
        - What are artifacts?
        - What are saved secrets?
        - What are the different IP address types?

    - Access the VM by using a Remote Desktop client
        - How to use a Remote Desktop client

<!-- 1. Exercise - Set up a VM and access it -->
1. Exercise - Configure and claim a development VM

    List the steps that apply the learning content from previous unit:

    1. Add a non-claimable Windows Server 2019 Datacenter VM to the previously created DevTest Lab
    1. Add the Azure PowerShell artifact to the VM
    1. Download the RDP file for the VM and connect via a Remote Desktop client

1. Knowledge check

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

    - The database team uses a suite of DBA tools, which take 1 hour to install. What is the best approach to set up a lab for database administrators

    - development team, 3 people, that need developer machines. Front-end, backend, dba. 
        - 3 labs?
        - 1 lab, 3 lab vms
        - 1 lab, 1 claimable vm, 3 instances
    
    - Working on debugging an application in a lab VM. You have need another dev to help you.
        - Developer goes to Azure portal to connect to your lab VM
        - Developer claims a developer VM from claimable VMs
        - After you unclaim the VM, the other developer claim the VM

    - Your team decides to use node.js and react to develop a new web app. You already have a Linux based image.
        - Create a new base image with Node.js and React installed
        - Use Linux base image and add artifacts for Node.js and React development
        - Developers use Linux image and install Node.js and React after creating the VM
    
    - Code scanning
        - 
     
    
    - Difference lab vs VM: Multiple teams, each use different VM images - how to set up: 1 lab multiple VMs, multiple labs, create claimable VMs for each team
    - Artifacts vs VM images: dev need VS Code machine - select VM with VS Code, add VS Code artifact, create public environment with VS Code installed on VM

1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    Suppose you work for an e-commerce company that uses systems-enabling orders to be placed and processed by using many different technologies. Some of these systems are for offline processing and some are in real time. Your company wants to reduce the time and money it spends to onboard new developers by creating virtual machines that are set up with the developer tools for the different systems. The company wants to get started with creating a developer lab by using Azure DevTest Labs.

    In this module you wanted to use Azure DevTest Labs to create development virtual machines for quickly onboarding new developers onto the different systems.
    You've defined a curated list of VM images, provisioned a VM, and configured it with standard software artifacts. You then connected to the running VM by using a remote desktop client.

    Imagine how much work it would be to manually set up a development environment. We have to keep track of which software components are needed for each system, and each version. Before we can start working on a system, we have to sit through all the installation processes.

    With Azure DevTest Labs we created a development lab in minutes. By using a curated list of VM images and a standardized set of software artifacts, we can provision a VM in a predictable and repeatable manner and quickly onboard new developers.

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.

- Introduction Learn module: https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-devtest-labs/
- Azure DevTest Labs Docs: https://docs.microsoft.com/en-us/azure/devtest-labs
