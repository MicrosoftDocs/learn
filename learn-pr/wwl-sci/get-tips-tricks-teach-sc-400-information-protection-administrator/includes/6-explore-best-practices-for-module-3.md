


SC-400: Module 3 Implement data lifecycle and records management with Microsoft Purview

Module 3 Overview

As you begin to teach this module, get familiar with what students learn during the module. In this module, students learn how to manage content lifecycles by using the different solutions to import, store, and classify business critical data to keep what's needed and delete what's not.

This module consists of three lessons:

- Lesson 1 – Data lifecycle management in Microsoft Purview
- Lesson 2 – Manage data retention in Microsoft 365
- Lesson 3 – Implement records management in Microsoft 365
 
> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWXhNL]  

Module 3 Tips and Tricks

- Explain retention label configuration for data lifecycle and records management:
	- Retention labels must be created and then published (or autoapplied)
	- Retention label names can't be changed after they're created
	- Only one retention label can be assigned to content (like and email or document) at a time
	- Autoapplied retention labels can be replaced by a manual assignment 
	- Retention label policies can trigger a disposition review at the end of a retention period, retention policies can't
- Describe how to retain or delete content based on:
	- When content was created
	- When content was last modified
	- When content was labeled
	- An event occurs
- Clarify when a retention policy or a retention label policy is locked:
	- No one can disable the policy or delete it
	- Locations can be added but not removed
- Differentiate when a retention policy is locked: **the retention period can be extended but not decreased,** and when a retention label policy is locked: **labels can be added but not removed**

Module 3 Demos

- Choose one or two of the labs to demo to expose learners to the environment 

Module 3 Labs

- Lab 3.1: [Configure retention policies](https://github.com/MicrosoftLearning/SC-400T00A-Microsoft-Information-Protection-Administrator/blob/master/Instructions/Labs/LAB_AK_03_Lab1_Ex1_retention_policies.md)
- Lab 3.2: [Implement retention labels](https://github.com/MicrosoftLearning/SC-400T00A-Microsoft-Information-Protection-Administrator/blob/master/Instructions/Labs/LAB_AK_03_Lab1_Ex2_retention_labels.md)
- Lab 3.3: [Configure service-based retention](https://github.com/MicrosoftLearning/SC-400T00A-Microsoft-Information-Protection-Administrator/blob/master/Instructions/Labs/LAB_AK_03_Lab1_Ex3_service_based_retention.md)
- Lab 3.4: [Configure event-based retention](https://github.com/MicrosoftLearning/SC-400T00A-Microsoft-Information-Protection-Administrator/blob/master/Instructions/Labs/LAB_AK_03_Lab1_Ex4_event_based_retention.md)
- Lab 3.5: [Use eDiscovery for recovery](https://github.com/MicrosoftLearning/SC-400T00A-Microsoft-Information-Protection-Administrator/blob/master/Instructions/Labs/LAB_AK_03_Lab1_Ex5_eDiscovery_recovery.md)
- Lab 3.6: [Configure records management](https://github.com/MicrosoftLearning/SC-400T00A-Microsoft-Information-Protection-Administrator/blob/master/Instructions/Labs/LAB_AK_03_Lab1_Ex6_records_management.md)