# Module design

## Title

Add the working title [(Title guidance)](/help/learn/id-guidance-title)

- Getting started with Azure command-line tools

## Role(s)

Add the role(s) [Role guidance](/help/contribute/metadata-taxonomies?branch=main#role)

- Administrator
- DevOps Engineer
- Solution Architect

## Level

Add the level  [Level guidance](/help/contribute/metadata-taxonomies?branch=main#level)

- beginner

## Product(s)

Add the product(s)

- CLIs
- Azure PowerShell

## Prerequisites

List the prerequisites [(Prerequisite guidance)](/help/learn/id-guidance-prerequisites)

- Basic knowledge of Azure.

## Summary

Add the summary [(Summary guidance)](/help/learn/id-guidance-introductory-summaries)

In this module, you’ll be introduced to some of the benefits that command line utilities offer.
You'll learn the difference between imperative and declarative configurations.
You’ll learn how to automate the administration, provisioning, and management of Azure resources by
using Azure PowerShell, Azure CLI, Bicep, ARM templates, and Terraform.


## Learning objectives

1. Understand the difference between imperative and declarative tools.
1. Introduce the options when managing Azure resources with command-line tools.
1. Compare basic techniques for creating a storage account with each tool.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the summary does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Explain Infrastructure as code | imperative vs declarative | Knowledge Check | 1 | No|
| Choose the right command line tool | use cases | Knowledge Check | 2 | Yes |
| Azure CLI | basic script | Knowledge Check | 3 | Yes |
| Azure PowerShell | basic script | Knowledge Check | 3 | Yes |
| Terraform | basic script | Knowledge Check | 3 | Yes |
| Bicep | basic script| Knowledge Check | 3 | Yes |
| ARM template | basic script | Knowledge Check | 3 | Yes |

## Outline the units

Add more units as needed for your content

1. Introduction

    Provide a scenario of a real-world job task that shows how the technology is used in practice:

    Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)

    You have been tasked to administer Azure resources, and to begin your learning journey you used
    the Azure Portal. However, now you need a solution that allows you to create and edit resources
    in volume.

    The Azure command-line tools are designed to provide methods for data-driven batch management of
    Azure resources. There are several environments and tools to choose from. This module will help
    you decide which is the best solution for you.

1. What is Infrastructure as code

    List the content that will enable the learner to complete the subtask:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

    - Question type
    - Question type

1. Choosing a command-line tool

    List the content that will enable the learner to complete the subtask:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

    - Question type
    - Question type

1. Azure CLI script
   - Create a resource group
   - Verify the RG exists
   - Create a storage account
   - Expected azCLI output
   - Verify the storage account exists
   - Remove the storage account and/or resource group
     + explain how removing the RG removes the storage account

1. Azure PowerShell script
   - Create resource group
   - Verify the resource exists
   - Create storage account
   - Verify the storage account exists
   - Remove storage account and resource group

1.  Terraform script
    - Create a template
    - Apply the template
    - Remove resources
      + explain why you would want to use the azCLI or azPS to do this

1.  Bicep script
    - Create a template
    - Apply the template
    - Remove resources

1.  ARM template script
    - Create a template
    - Apply the template
    - Remove resources

1.  Scripting knowledge check

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

    - Question type
    - Question type

1.  Summary

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.