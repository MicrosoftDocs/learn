# Title

*Setting up an AKS deployment pipeline using GitHub Actions*

## Role(s)

- *solution-architect*
- *developer*
- *devops-engineer*

## Level

- *Beginner*

## Product(s)

- *Azure Kubernetes Service*
- *Azure Container Registry*
- *GitHub*

## Prerequisites

- Access to an Azure subscription
- Access to a GitHub account
- Basic knowledge of executing commands using Azure CLI
- Basic knowledge of Kubernetes and its concepts
- Basic knowledge of AKS and its concepts
- Basic knowledge of Git and GitHub

## Summary

*Easily set up an automation pipeline using GitHub Actions to build and deploy containerized applications to an AKS cluster*

## Learning objectives

By the end of this module the learner will be able to:

1. Describe a continuos integration (CI) and continuos deployment (CD) process using GitHub Actions
1. Create a deployment pipeline using GitHub Actions and Azure
1. Deploy a cloud-native application to Azure Kubernetes service (AKS) by using GitHub Actions

## Chunk your content into subtasks

Identify the subtasks of *Setting up an AKS deployment pipeline using GitHub Actions*

ID | Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1 | Understand CI & CD concepts | Introductory concepts | Knowledge Check | 1 | yes |
| 2 | CI & CD with GitHub Actions | Introductory concepts | Knowledge Check | 1 | No, joined with 1 |
| 3 | Design the pipeline | Problem evaluation and analysis | Knowledge Check | 1,2 | yes |
| 4 | Set up the project | Build base assets | Exercise | 1,2 | yes |
| 5 | Create the first workflow | Build base assets | Exercise | 2 | joined with 6  |
| 6 | Build the application image using GH Actions | Integrate with ACR | Exercise | 3,5 | yes |
| 7 | Push the application image to the ACR using GH Actions | Integrate with ACR | Exercise | 3,5 | no, joined with 6 |
| 8 | Finish the build workflow | Integrate with ACR | Exercise | 3,5 | no, joined with 6 |
| 9 | Create deploy workflow | Integrate with AKS | Exercise | 4,5 | yes |
| 10 | Test the pipeline | Pipeline creation | Exercise | 3,4,5 | joined with 9 |
| 11 | Clean up | Project conclusion | Exercise | - | yes |

## Outline the units

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice:

    *Imagine you work for a video company. After a few months of planning, your team could successfully migrate all the company's technology stack to use AKS.*

    *In the beginning everything was fine. However you began to notice that the team was spending too much time in image builds and application deployments. As a solution, you could use a deployment pipeline. You heard that was a technique other companies were using for years. When you brought this idea up to the management, they asked you to create a proof of concept using the company's new website.*

1. **Understand the Concepts**

    List the content that will enable the learner to *Understand CI & CD Concepts*:

    - Understand what is CI/CD
        - How applications were deployed before CI
        - What is CI
        - What is a CI pipeline
        - What is CD
    - GitHub actions as a CI pipeline provider

    **Knowledge check**

    What types of questions will test *learning objective*? *[(Knowledge check guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-knowledge-check)*

    - What is the difference between CI and CD?
    - What are the primary gain when using CI/CD pipelines?
    - Why use GitHub actions as a CI provider?

1. **Design the Deployment Pipeline**

    List the content that will enable the learner to *Design the pipeline*:

    - Design the pipeline
        - Understand the problem
        - Picture the final pipeline goals
        - Evaluate the steps to get to the pipeline
        - Build the pipeline

    **Knowledge check**

    I don't think this section should have a knowledge check because it's just an overview on what we'll do

1. **Exercise - Set Up the Project**

    List the steps which apply the learning content from previous unit:

    1. Create or log in the azure account
    1. Execute the script to create the base Azure resources that will enable the learner to create the pipeline
    1. Create or log in into the gitHub Account
    1. Fork the project

1. **Application images**

    - What is a Docker image (shortly)
    - How can we build and push an image through a CI pipeline

    **Knowledge check**

    1. What is a Docker Image?
    1. Why use images?

1. **Exercise - Build the application image**

    List the steps which apply the learning content from previous unit:

    1. Create or log in into the gitHub Account
    1. Create the first workflow file
    1. Use GH Action to build the docker image
    1. Use GH image to push the docker image to ACR

1. **Deployment using helm**

    - Steps to be done in order to deploy an application to AKS
    - Manifest files using helm (short explanation, possible link to Helm module)

    **Knowledge check**

    1. What is helm?
    1. Why is helm useful in a CI pipeline?

1. **Exercise - Create the deploy workflow**

    List the steps which apply the learning content from previous unit:

    1. Create or log in into the gitHub Account
    1. Create the second workflow file
    1. Use GH Action to connect to AKS
    1. Use GH Action to deploy to AKS
    1. Test the pipeline

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    *You were successfully able to create a working proof of concept integrating the existent AKS cluster, and Azure Container Registry with GitHub Actions. When management saw your ideia and how all the team would not need to be aware of all actions and execute tests and deployments by hand, they were instantly amazed by the amount of time this could save to a single person, not alone for a team.*

## Notes

Other learn modules that could be linked to this one:

- https://docs.microsoft.com/en-us/learn/modules/introduction-to-github/
- https://docs.microsoft.com/en-us/learn/modules/github-actions-automate-tasks/
- https://docs.microsoft.com/en-us/learn/modules/github-actions-ci/
- https://docs.microsoft.com/en-us/learn/modules/github-actions-automate-tasks