# Title

Introduction to Docker containers

## Role(s)

- developer
- administrator
- devops-engineer
- solution-architect

## Level

- beginner

## Product(s)

- docker
- azure

<!-- Instructional Design review 10 September 2019 
We need to specify the exact product name. Is it Docker on Azure? -->

## Prerequisites

- Basic knowledge of operating system virtualization concepts
- Basic knowledge of command-line based applications

<!--Based on MS Learn guidelines, please avoid using the word ‘Familiarity’ because it is ambiguous. 
It will be helpful for the learners if this section includes the specific skills that are required to understand the content and apply learning.
I think, this prerequisite seems unclear. 
We can add specific skills for example: 

-	 Ability to use Powershell, python, and bash
-	 Ability to use GitHub at a novice level 
-	 Ability to configure …
-	 Basic knowledge of networking concepts such as routing, IP protocol, bridges, socket, virtual networks, ports, web and database servers, and so on
-	…
(Please also list specific tasks of system administrator, that are expected here and the system requirements such as GitHub account, Azure account, Docker account) 
Note: The examples are not intended to be technically accurate. Examples are used for explaining the idea.-->

## Summary

Modern organizations must release apps quickly to attract and keep business. This requirement forces software development and support teams to always looking at solutions that save time and reduces costs. An ideal solution has to reduce the time spent on the creation and configuration of deployment environments and the simplification of the software deployment process.

The idea of using containerization technology as a time-saving and cost reduction solution is popular. One of the primary propositions of containerization is that you don't have to configure hardware and spend time installing operating systems and software to host a deployment. Also, multiple apps can run in their isolated containers on the same device.

Here, you'll see how the Docker is used to create containers. You'll also learn a bit how the Docker infrastructure work behind the scenes. The goal is to help you decide if Docker containers are the right choice for your business.

## Learning objectives

- Evaluate whether Docker is an appropriate containerization platform for you
- Describe how the components of Docker containers support compute implementations

<!--The objectives look like enabling objectives, more appropriate for a unit. Module level objectives need to be the objectives that you want your learners to achieve by the end of the module. Please add high level module objectives.-->

## Chunk your content into subtasks

Identify the subtasks of *Introduction to Docker containers*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Define Docker and Docker container | xxx | Knowledge check | 2 | Yes |
| Describe the Docker container architecture | xxx | Knowledge check | 2 | Yes |
| Define the Docker runtime | xxx | Knowledge check | 2 | Yes |
| Define the Docker container storage considerations | xxx | Knowledge check | 2 | Yes |
| Define the Docker container network considerations | xxx | Knowledge check | 2 | Yes |
| Evaluate the suitability of Docker containers | Decide if Docker is the correct technology to use. | Knowledge check | 1 | Yes |

<!-- Column 2- we need to specify the parts of the scenario that the subtask fulfills. Currently column 2 does not specify the part of the scenario that can be mapped to the subtask. 

Column 1- In the subtask column, we need to specify the subtasks that will help meet the objectives. Then in column 4, we can list the exact objective that is fulfilled by the subtask. 
Each subtask needs to have learning content around it. The subtask can start with a verb in presence tense. For example: 
-	 Define docker and docker container 
-	 Describe the Docker architecture
-	 Evaluate the requirement and suitability of Docker 
Note: The examples are not intended to be technically accurate. Examples are used for explaining the idea.

Based on MS Learn guidelines, we need to consider:
-	 What subtasks are required for the learner to complete the whole module?
-	 What is the learning objective for each unit?
-	 Center your learning objective around what they’ll do and why that has value.
-->

## Outline the units

1. **Introduction**

    Suppose you work for an online clothing retailer that is planning the development of several internal apps. Your team develops and tests all applications on-premises and then deployment them to Azure for pre-production testing and final production hosting.  You're looking for maximum compatibility in each environment with little or no configuration changes, and using Docker as a containerization solution seems an ideal choice.

<!--It will be helpful if we could consider adding the following to the introductory scenario: How containerization is going to help the app developers/client, how the time and efforts for config changes are saved, and how apps are going to run quickly, securely, and reliably as all dependencies are packaged up. We can weave this into the story/scenario.-->

1. **What is Docker**

    - Contrast Docker against the available Azure compute options to run a compute workload
    - Overview of Docker
            - Describe the Docker platform
            - Describe Docker support for Linux, Windows, and Mac
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

<!--Please add knowledge check questions relevant for each unit.-->

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

           <!-- Please add knowledge check questions relevant for each unit.This unit contains a lot of concepts and content around those concepts. Please check if we can chunk the content and logically distribute it amongst units. Maybe, storage and networking concepts could be covered in a separate unit. -->

1. **When to use Docker containers**

    1. Physical server vs. virtual machine vs. serverless vs. containers
            1. Describe the difference with an image
            1. Recap the benefits

            <!--In this unit, please check if it is required to list the benefits again. It may make the unit redundant, as the benefits are listed in the previous unit. If it is necessary to add benefits again, please ensure that they are mentioned briefly. -->

                    - Portability
                    - Easy management
                    - Consistent delivery [Use Image]
                    - More workloads same hardware [Use Image]
                    - 
   1. Describe how Docker containers are used in AKS

1. **Knowledge check**

    <!--Please add knowledge check questions relevant for each unit.-->

1. **Summary**

    Our goal was to help you evaluate whether Docker containers would be the right choice for your business process. We looked at the benefits that Docker containers introduce:

    - Portability
    - Ease of management
    - Consistent delivery
    - More workloads same hardware

    <!-- Please check if we need to list the benefits again, as they have been mentioned earlier as well. -->

    We saw that when we use Docker containers, we have to think about the container's runtime infrastructure. We discussed both storage and network configuration. These two aspects are changing in nature because of the portability of containers. As a result, both impact the software running in a container.

    You were looking for a containerization solution that provides maximum compatibility in each environment with little or no configuration changes. We found that Docker is a good solution that enables us to create a snapshot of our application and all its dependencies.  We then deploy this same snapshot in development, testing, and production.

    Finally, Azure provides various deployment options to host Docker containers. In Azure, containers can be integrated with other Azure services to extend your product or exchange data with other services.

    <!-- Pease check. I could not find a unit that explains the deployment options.-->