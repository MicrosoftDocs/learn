# Title

Prepare to deploy Microsoft Defender for IoT to monitor operational technology (OT) networks

## Role(s)

solution-architect

## Level

intermediate

## Product(s)

defender-for-iot

## Prerequisites

- Knowledge of what Defender for IoT is and how it works at a beginner level
- Knowledge of operational technology (OT) networks and networking concepts at an intermediate level
- Familiarity with the Purdue networking model like the device types that are included in each networking level


## Summary

To prepare for the deployment of Microsoft Defender for IoT, identify what to monitor, choose a traffic mirroring method, and review the appliance options.


## Learning objectives

1. Analyze a network diagram to identify devices and subnets to monitor with Defender for IoT.
1. Choose a traffic mirroring method for each sensor.
1. Compare the appliance options available for use with Defender for IoT network sensors.

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

    Suppose you work for a car manufacturer that has offices and production sites across the globe. You're tasked with implementing a system to monitor traffic and secure your manufacturing automation systems (Operational Technology), from the access panels to the pneumatic and packaging systems. Taking the organization’s OT security visibility to a whole new level, your team chooses to use Microsoft Defender for IoT.

   You’ve already created an overall plan for your deployment, and now you need to prepare each site. You’ll review a network diagram, identify where you want to place your sensors, and create a list of the devices and subnets you want to monitor. You’ll also choose a traffic mirroring method for your network sensor and compare appliances for each sensor you plan to deploy.


    Add your scenario [(Scenario guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-scenarios)

1. Identify devices and subnets to monitor with Defender for IoT

    - Provide a sample network diagram, and show how it’s divided into Purdue levels, and what sorts of devices are included and why. Touch on questions from here:
    https://learn.microsoft.com/azure/defender-for-iot/organizations/best-practices/plan-prepare-deploy#create-a-network-diagram 
    - And include Purdue level information from here: https://learn.microsoft.com/azure/defender-for-iot/organizations/best-practices/understand-network-architecture#the-purdue-model-of-networking-architecture. 


    **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-knowledge-check)

    For a given scenario and network diagram (with interesting traffic hinted at or mentioned?):
•	- List the devices and subnets to monitor
•	- List which to filter out that are not in focus


1. Determine traffic mirroring methods to use

    - Briefly describe what is traffic mirroring and its importance in monitoring network traffic for security purposes.
    - Describe and illustrate the types of traffic mirroring methods for OT sensors
    - Explain the differences between the methods and the advantages and disadvantages of each.
    - Explain how to choose a traffic mirroring method for each sensor based on factors such as the type of sensor, the network topology, and the available resources. (I got this suggestion from Azure AI but not sure that we have this info but would be good!)
    Resource: [Choose a traffic mirroring method for OT sensors](https://learn.microsoft.com/azure/defender-for-iot/organizations/best-practices/traffic-mirroring-methods)
    **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-knowledge-check)

     Types of questions: For a given scenario or scenarios, which traffic mirroring method would you use for each of these types of sensors? I got this long winded Q&A from Azure AI but this in the vein of what I'm thinking but shorter: "Here's a scenario question to test that students have acquired the ability to choose a traffic mirroring method for each sensor based on the key learning points:
     Scenario: You are the security administrator for a large organization that has multiple sensors deployed across your network. You want to monitor the network traffic from each sensor to detect any security threats. You have decided to use traffic mirroring to accomplish this.
     Question: What factors should you consider when choosing a traffic mirroring method for each sensor? Provide an example of a sensor and the traffic mirroring method you would choose for it based on these factors.
     Answer: When choosing a traffic mirroring method for each sensor, you should consider factors such as the type of sensor, the network topology, and the available resources. For example, if you have a sensor that is connected to a switch, you could use port mirroring to mirror the traffic from that sensor to a monitoring device. On the other hand, if you have a sensor that is connected to a hub or a span port, you could use a network tap to mirror the traffic. Another factor to consider is the available resources, such as the number of available ports on the switch or the amount of bandwidth required for the traffic mirroring. For example, if you have limited resources, you may need to use a network tap instead of port mirroring. Based on these factors, you could choose a traffic mirroring method such as port mirroring or a network tap for each sensor to monitor the network traffic and detect any security threats."

1. Review appliance options
   - List the “general” appliance options available for use with Defender for IoT network sensors
     Will need to summarize key points in these article to fit into a unit:
	[Supported hardware profiles](https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-appliance-sizing)
o	[Pre-configured appliances](https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-pre-configured-appliances)
o	[Virtual appliance support](https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-virtual-appliances) 
   - Describe when you’d use each
   - Per Vishakha Gosh: this is most commonly used hardware profile and purchased applicance: https://learn.microsoft.com/azure/defender-for-iot/organizations/appliance-catalog/hpe-proliant-dl20-plus-enterprise
   **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-knowledge-check)
   
    For a given scenario (sensor, bandwidth that sensor needs, etc), which appliance would you use? Why would you pick option > over option B? (We’d likely need to provide a list of options as we can’t list all in the training module.)


1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
    Add your summary [(Summary guidance)](https://review.learn.microsoft.com/help/learn/id-guidance-module-summary-unit)

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.