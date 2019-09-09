# Title

Introduction to Docker containers

## Role(s)

- developer
- devops-engineer
- solution-architect

## Level

- beginner

## Product(s)

- azure

## Prerequisites

- Familiarity with command-line based applications

## Summary

Modern organizations must release apps quickly to attract and keep business. This requirement forces software development and support teams to always looking at solutions that save time and reduces costs. An ideal solution has to reduce the time spent on the creation and configuration of deployment environments and the simplification of the software deployment process.

The idea of using containerization technology as a time-saving and cost reduction solution is popular. One of the primary propositions of containerization is that you don't have to configure hardware and spend time installing operating systems and software to host a deployment. Also, multiple apps can run in their isolated containers on the same device.

Here, you'll see how the Docker is used to create containers. You'll also learn a bit how the Docker infrastructure work behind the scenes. The goal is to help you decide if Docker containers are the right choice for your business.

## Learning objectives

1. Describe when to use a container
1. Contrast the difference between software, packages, and images as used in containers
1. Describe the Docker container infrastructure with regards to the operating system, storage, and networking

## Chunk your content into subtasks

Identify the subtasks of *Introduction to Docker containers*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Docker? | Understand Docker technology. | Knowledge check | 1 | Yes |
| What is a Docker container? | Understand Docker technology. | Knowledge check | 2 | Yes |
| How Docker containers work | Understand Docker technology. | Knowledge check | 3 | Yes |
| When to use Docker containers | Decide if Docker is the correct technology to use. | Knowledge check | 1 | Yes |

## Outline the units

1. **Introduction**

    Suppose you work for an online clothing retailer that is planning the development of several internal apps. Your team develops and tests all applications on-premises and then deployment them to Azure for pre-production testing and final production hosting.  You're looking for maximum compatibility in each environment with little or no configuration changes, and using Docker as a containerization solution seems an ideal choice.

1. **What is Docker**

    - Contrast Docker against the available Azure compute options to run a compute workload
    - Overview of Docker
            - Describe the Docker platform
            - List the benefits:
                    - Portability
                    - Easy management
                    - Consistent delivery [Use Image]
                    - More workloads same hardware [Use Image]

    - Describe the Docker architecture using a diagram
            - Components in Docker
                    - Docker daemon
                    - Docker client
                    - Docker registries
    - Describe Docker support for Linux, Windows, and Mac


1. **How Docker containers work**

    1. What is a Docker container?

            1. Describe base on software vs. packages vs. images. Use a diagram that shows multiple layers.
            - What is an image?
            - What is a container?

    1. What is a Base image?

            1. Describe the concept of a base image
            1. Describe the Union File System [Use Image]

    1. What is a Dockerfile? 

            We're not going to dive deep into the Dockerfile specification; however, discuss the concept of staged builds when creating a container. Cover the following topics :

            1. File definition is text
            1. FROM (base image)
            1. ARGs and ENV (can set environment)
            1. CMD and ENTRYPOINT (some app that is executed when container executes)

    1. What is the Docker Runtime?

            Describe how Docker provides the user a runtime to interact with commands.
            There are multiple commands, however we'll focus on:

            1. list available containers
            1. start and restart containers
            1. stop containers
            1. list running containers
            1. remove containers

    1. Container Storage

            1. Discuss why storage is separate. Explain how data stored in the container's file system will be lost once the container is removed.
            1. Discuss the data storage options available:
                    - Mount
                    - Volumes

    1. Container Networking

            1. Describe why there is a separate network implementation to think about with regards to container isolation.
            1. Describe the three network options available
                    - bridge
                    - host
                    - none
            1. Explain that you can create custom networks
                   - Bridge network driver
                   - Overlay network driver
                   - MACVLAN network driver
                   - none
            1. Explain that you have management over these networks, that is, inspect, connect, and disconnect, remove

1. **When to use Docker containers**

    1. Physical server vs. virtual machine vs. serverless vs. containers
            1. Describe the difference with an image
            1. Recap the benefits
                    - Portability
                    - Easy management
                    - Consistent delivery [Use Image]
                    - More workloads same hardware [Use Image]
    1. Describe how Docker containers are used in AKS

1. **Knowledge check**


1. **Summary**

    Our goal was to help you evaluate whether Docker containers would be the right choice for your business process. We looked at the benefits that Docker containers introduce:

    - Portability
    - Ease of management
    - Consistent delivery
    - More workloads same hardware

    We saw that when we use Docker containers, we have to think about the container's runtime infrastructure. We discussed both storage and network configuration. These two aspects are changing in nature because of the portability of containers. As a result, both impact the software running in a container.

    You were looking for a containerization solution that provides maximum compatibility in each environment with little or no configuration changes. We found that Docker is a good solution that enables us to create a snapshot of our application and all its dependencies.  We then deploy this same snapshot in development, testing, and production.

    Finally, Azure provides various deployment options to host Docker containers. In Azure, containers can be integrated with other Azure services to extend your product or exchange data with other services.
