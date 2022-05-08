# Title

Introduction to Microsoft Defender for IoT

<<<<<<< HEAD
<!--original thought: keep this one module for both services. maybe use this same content and just add another unit in for enterprise even if it's not completely covered. final plan - keep learn module to current scope so as to keep within timeframe. it does represent current marketing strategy. plan to add more for enterprise later on.-->

## Role(s)

business-analyst
business-owner
security-engineer
security-operations-analyst
=======
## Role(s)

security-engineer
security-operations-specialist
>>>>>>> 7fa13a1f0a7dd81cbcd273e4b7045beb5ef80590
technology-manager

https://review.docs.microsoft.com/en-us/help/contribute/metadata-taxonomies?branch=master#role

## Level

beginner

## Product(s)

Microsoft Defender for IoT

## Prerequisites
List the prerequisites [(Prerequisite guidance)](/help/learn/id-guidance-prerequisites)

<<<<<<< HEAD
- An understanding of the importance of operational technology (OT) security in business-critical infrastructures
- Familiarity with OT security goals and concepts, such as the Purdue model of Industrial Control System (ICS) security
- Familiarity with the challenges in managing environments with OT and Internet of Things (IoT) devices

## Summary

Evaluate whether Microsoft Defender for IoT is the right service for your organization to secure OT networks. Understand the OT functionality provided by Defender for IoT and how Defender for IoT features integrate with other Microsoft services.

## Learning objectives
<!--keep these measurable -->

- Evaluate whether Microsoft Defender for IoT is right for unified asset discovery and security monitoring across your business-critical networks environments.
- Describe how Microsoft Defender for IoT provides asset discovery across business-critical network environments.
- Describe how Microsoft Defender for IoT can monitor your OT and IoT devices.
=======
- Knowledge of how operational technology security is used business-critical infrastructures
- Familiarity of operational technology security concepts like operational and network security goals
- Familiarity with the differences between operational technology and IT networks
- Familiarity with the challenges in managing environments with operational technology and IoT

## Summary

Add the summary [(Summary guidance)](/help/learn/id-guidance-introductory-summaries)

## Learning objectives

 - Evaluate whether Microsoft Defender for IoT can provide unified asset discovery and security monitoring across your business-critical network environments.
- Describe how the components of Microsoft Defender for IoT monitor IoT and operational technology devices

>>>>>>> 7fa13a1f0a7dd81cbcd273e4b7045beb5ef80590

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: Exercise or Knowledge check? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
<<<<<<< HEAD
| Understand whether Defender for IoT can support your network type (cloud, air-gapped, hybrid)  | Journey to the cloud | Knowledge check | Evaluate whether Microsoft Defender for IoT can meet your organization's security needs for OT networks | Own unit - what is Defender for IoT? |
| Understand the main components of the Defender for IoT service | Asset discovery | Knowledge check | Understand how Microsoft Defender for IoT can provide unified asset discovery across your business-critical network environments | Own unit - How does Defender for IoT work? |
| Understand the security monitoring tools available in Defender for IoT | Ongoing security monitoring and threat detection | Knowledge check | Describe how Microsoft Defender for IoT can monitor your OT and IoT devices | Own unit - When to use Defender for IoT? |
=======
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
>>>>>>> 7fa13a1f0a7dd81cbcd273e4b7045beb5ef80590

## Outline the units

Add more units as needed for your content

1. Introduction

<<<<<<< HEAD
    <!--Provide a scenario of a real-world job task that shows how the technology is used in practice. Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)-->

    You own a smart building management company that uses localized, separate, on-premises security management tools that have many gaps.

    You're looking to move to the cloud to increase efficiency and consistency across your network. Outline the needs of both your *operations* teams and OT *security* teams so that you can find a single solution to serve both sets of needs.

1. What is Microsoft Defender for IoT?

    Defender for IoT can provide end-to-end security services for your operational networks, from asset discovery across your network to ongoing threat detection and alert monitoring.

    Defender for IoT can be deployed in various environments, including cloud, air-gapped (fully on-premises), and hybrid.

    Defender for IoT features include:

    - Asset and device discovery
    - Advanced threat detection
    - Risk and vulnerability management
    - Alert response features
    - Sensor management from a central system

1. How does Microsoft Defender for IoT work with operational networks?

    Defender for IoT has a set of sensor machines that are each connected to your OT/IoT devices. Sensors detect all devices in the vicinity and on the network, and send reports and data back to a central management system for tracking and analysis.

    Defender for IoT uses machine learning engines and threat intelligence packages to track and alert on any vulnerability or risk detected.

1. When to use Microsoft Defender for IoT to secure operational networks?

    Use Defender for IoT when you want to secure your OT/IoT assets using a single pane of glass, with a solution that provides visibility across your network, machine learning for threat detection and vulnerability management, and automated response activities. Use Defender for IoT whether you need a fully on-premises, cloud, or hybrid solution.

    If you need to secure IoT devices in an enterprise organization, such as corporate printers or cameras, make sure to choose onboarding options for *Enterprise* IoT instead of *OT/IoT*. While Defender for IoT can secure both operational networks and enterprise networks, they have different deployment options and architectures.

1. Knowledge check

1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

=======
    Provide a scenario of a real-world job task that shows how the technology is used in practice:

    Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)
[What's in pages 5 & 6 under "Learn about a typical scenario" are ok for this though a bit long]
Suppose you own a smart building management company that is responsible for the daily, efficient functioning and safety of skyscraper services. Campuses in one city include 50 skyscrapers that total 5 million square feet of residential space and 3 million square feet of office space. 

The Chief Operations Officer is responsible for: (TBD)
- Reducing costs for maintaining skyscraper elevators 
- Increasing employee productivity 
- Increasing machine productivity 
- Increasing safety against unauthorized guests
- Enhancing services in conference rooms
- Providing operational data to network security and business teams 

To reach these goals, the Chief Operations officer installs new building access controls, CCTV cameras, conferencing equipment, elevator occupancy sensors, and TBD.

The Chief Operations Officer is approached by the Chief Security Officer who is required to meet network security goals.

The Chief Security  Officer  indicated that new technologies integrated with the current OT architecture have increased the security attack surface in the OT network.

[Rest in doc on page6 is ok but what are they using now? They have no monitoring solution so they need something to help them start monitoring all that got installed? ]

1. What is Microsoft Defender for IoT

    - Define Microsoft Defender for IoT
    - Features of like...try to keep these short like one paragraph each:
      - Flexible deployment
      - Device inventory
      - Protocol
      - Visibility
      - Risk and vulnerability management
      - ... 


1. How does Microsoft Defender for IoT work

    - Short intro like:
      "Defender for IoT connects both to the Azure cloud and to on-premises components. The solution is designed for scalability in large and geographically distributed environments with multiple remote locations. This solution enables a multi-layered distributed architecture by country, region, business unit, or zone."

    - Add sample diagram of environment with defender for IoT
    - Sensors
    - Engines

1. When to use Microsoft Defender for IoT

   What business use cases make Microsoft Defender for IoT a good choice? 
   Any similar use cases where it's not a good choice? (Ok to leave out if nothing obvious - maybe their airgapped or no access to cloud?)

   Loop back to your original scenario. Based on needs described in scenario is Microsoft Defender for IoT a good choice? Why?

1. Knowledge check
1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
>>>>>>> 7fa13a1f0a7dd81cbcd273e4b7045beb5ef80590
    Add your summary [(Summary guidance)](/help/learn/id-guidance-module-summary-unit)

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.