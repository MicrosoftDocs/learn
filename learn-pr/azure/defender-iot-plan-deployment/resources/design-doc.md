# Title

Plan to deploy a Microsoft Defender for IoT monitoring system for OT networks

## Role(s)

solution-architect (OT architect)

## Level

intermediate
Add the level  [Level guidance](https://review.learn.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)

## Product(s)

defender-for-iot

## Prerequisites
List the prerequisites [(Prerequisite guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-prerequisites)

- Knowledge of what Defender for IoT is and how it works at a beginner level
- Knowledge of operational technology (OT) networks and networking concepts at an intermediate level (ie – they'll need to be able to understand the sample diagram, they’ll need to understand the point of proxies, and the purdue model)
- Familiarity with the Purdue networking model like the device types that are included in each networking level
- Knowledge of what Azure roles and role-based access controls (RBAC) are and how they work at a beginner level

## Summary

Add the summary [(Summary guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-introductory-summaries)



## Learning objectives

By the end of this module, you'll be able to:

1. Describe the stages and the roles involved to deploy Microsoft Defender for IoT
1. Organize the locations and systems across your network into sites and zones
1. Choose a sensor connection method to use for my organization to manage my OT security deployment
1. Identify the users and roles your teams will use with Defender for IoT

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

Add more units as needed for your content

1. Introduction

    Provide a scenario of a real-world job task that shows how the technology is used in practice:
    Suppose you work for a car manufacturer that has offices and production sites across the globe. You're tasked with implementing a system to monitor traffic and secure your manufacturing automation systems from the access panels to the pneumatic and packaging systems. To take the organization's operational technology (OT) security visibility to the next level, your team chooses to use Microsoft Defender for IoT.

    You need to create a plan for your deployment so that your organization can monitor traffic from various systems, across several sites in different geographic areas around the world. You’ll need to decide on how you’re going to connect your network sensors to the cloud, and what users and user roles assignment to provision.

    Add your scenario [(Scenario guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-scenarios)

1. Describe the process to deploy Microsoft Defender for IoT

    List the content that will enable the learner to complete the subtask:
    - List the stages to deploy Defender for IoT (include organizer illustration)
    - Briefly mention the steps involved in each stage
    - Discuss roles involved in each stage

      See https://www.youtube.com/watch?v=iwEAHiN6BOI - community video on deployment
    **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-knowledge-check)

    - What’s one step that’s different in the stages between onboarding a sensor and deploying a sensor?
    - Identify the phase where you’d choose a traffic mirroring method
    - Describe what a technology manager (or whatever role does deployment) would do in the deployment phase.

1. Identify the sites and zones for your network topology
 
    - Define what sites and zones are - in the context of D4IoT planning
    - Identify when you’d put things in different sites or zones -e.g. recurring IP ranges

1. Exercise - Organize the locations and systems across a network into sites and zones

   Based on a provided diagram that represents our scenario company’s geo-locations, organize the network locations into sites and zones.

   PG/CxE: Let’s base this on a sample network diagram that we get from the PG/CxE.
   Let’s make sure that the same diagram includes some recurring IP ranges so that we can teach how to handle those (separate them by zone).

1. Identify cloud connection options for an OT network sensor

   - List and describe the cloud connection types
   - Provide illustration of each type
   - Identify when you’d choose between the types

1. Exercise - Choose the best cloud connection option for an OT network sensor

    For a given scenario or scenarios (provide diagram): Choose the best cloud connection option for the OT network sensor
1. Identify Azure and on-premises roles to assign to users

   Azure roles:
   - List the built-in roles that apply to Defender for IoT (are these all required to be assigned)?
   - Summarize the differences between these roles.
   - Explain what technical roles might be assigned these roles (as it related to deploy & operate D4IoT)

   On-premises accounts and roles:
   - List the default privileged on-premises users (accounts)
   - Briefly explain what these are
   - Summarize the differences between these user accounts.
   - Explain what technical roles might use these user accounts(as it related to deploy & operate D4IoT)

   - List the on-premises user roles
   - Briefly explain what these are
   - Summarize the permission differences between these roles for:
   - OT network sensors
   - on-premises management console

   - Explain what technical roles might use these user roles

   Active directory integration/connection
   - Discuss support for an integration between an on-premises management console and Active Directory to allow Active Directory users or groups to sign into sensors.
   - Identify when you’d choose to do this

   - Identify the on-premises OT sensors users required for each site

   Active directory integration/connection to allow users to sign into sensor and console.
   - Discuss support for an integration between an on-premises management console and Active Directory to allow Active Directory users or groups to sign into sensors.
   - Identify when you’d choose to do this

   Create user access groups
   To manage your on-premises Defender for IoT users, use a global business topology that's based on business units, regions, and sites, and then define user access permissions around those entities.

   Create user access groups to establish global access control across Defender for IoT on-premises resources. Each access group includes rules about the users that can access specific entities in your business topology, including business units, regions, and sites.

   Knowledge check 
   For a given scenario or scenarios:
   - Identify the Azure users required for each site (Is it required to have all related built-in roles assigned per subscription??) 
   OR (Batami’s question): Real world scenario: List a series of Active Directory groups. Which sensor user roles would you apply to each one? Same with Azure users. 
  
 

1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
    Add your summary [(Summary guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-module-summary-unit)

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.

- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/concept-zero-trust#zero-trust-with-defender-for-iot
- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/best-practices/plan-corporate-monitoring#plan-ot-sites-and-zones 
- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/roles-azure 
- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/roles-on-premises 
- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/manage-users-overview#active-directory-support-on-sensors-and-on-premises-management-consoles
- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/architecture-connections
