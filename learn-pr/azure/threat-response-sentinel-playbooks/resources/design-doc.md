# Module: Respond to threats using Azure Sentinel playbooks

## Learner roles

- Administrator
- Auditor
- Risk practitioner
- Security engineer
- Solution architect
- Student
- Technology manager

## Learner level

- **Intermediate**: Material that assumes some knowledge, but little in-depth understanding of the topic. Provides a detailed overview of a topic&#39;s subareas.

## Products taught

- Microsoft Azure Sentinel
- Azure Log Analytics workspace
- Azure Logic Apps

## Prerequisites

To get the best learning experience from this module, you should have knowledge of:

- Automation and monitoring
- Azure Monitor and its Log Analytics workspace
- Azure Logic Apps

## Module summary description

In this module, you'll learn about the Security Orchestration, Automation, and Response (SOAR) capabilities within Azure Sentinel.

## Subtasks in this module

- Create a playbook to automate a response.
- Provide real-time automation.<!-- We also use "near real-time." Should this be consistent? If so, please search & replace (s/r) just "real-time." -->
- Call a playbook from an incident on-demand.<!-- Can we change this to "Initiate a playbook on demand from an incident?" -->

## Lab exercise

- Draft lab exercise title: Create an Azure Sentinel playbook<!-- This isn't in Term Studio or MS Style. When I search the internet, it's mostly "Azure Sentinel Playbook." If you agree to change it, please s/r. -->
  - Task 1. Add a playbook from Logic Apps
  - Task 2. Add an Azure Sentinel connector<!-- Same comment about not being able to find this term in TS or MS Style. On the internet, capitalization varies. Please review. --> in Logic Apps
  - Task 3. Add a trigger to Azure Sentinel Connection<!-- I cannot find a product named "Azure Sentinel Connection." Should this be "Azure Sentinel connector?"-->
  - Task 4. Add an action
  - Task 5. Test the playbook result
- The lab demonstrates how to create an Azure Sentinel playbook to automatically respond to a security threat.
- Feasibility questions or concerns?

## Module learning objectives

After completing this module, you&#39;ll be able to:

- Explain Azure Sentinel SOAR capabilities.
- Explore the Azure Sentinel Logic Apps connector.<!-- We also have an Azure Sentinel connector. Are they two different things? If so, perhaps we can use just "Logic Apps connector". If you agree, please s/r. -->
- Create a playbook to automate an incident response.
- Run a playbook on demand in response to an incident.

## Estimated module duration

 45 minutes

## Module outline of units

1. Introduction
2. Exercise Setup
3. What are Azure Sentinel playbooks?
4. Trigger playbooks in real time
5. Run playbooks on demand
6. Exercise unit Create an Azure Sentinel playbook
7. Summary

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 minutes

### Module scenario

Contoso, Ltd. is a midsize financial services company in London with a New York branch office. Contoso uses Microsoft 365, Azure Active Directory (Azure AD), Azure AD Identity Protection, Cloud App Security, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Endpoint Protection, and Microsoft Azure Information Protection. Contoso uses the paid version of Azure Security Center as threat protection for resources that run on Azure and on-premises. The company also monitors and protects other non-Microsoft assets.

The Contoso Security Operations (SecOps) team didn't respond quickly enough to the organization's latest security incident. Contoso's IT director wants them to implement Azure Sentinel playbooks to help them more quickly identify and stop potential security threats.

As Contoso's lead security engineer and Azure administrator, you've been tasked with setting up an Azure Sentinel playbook to respond to security incidents.

In this module, you will learn about Azure Sentinel playbooks, including how to write and edit them, configure their workflow, and manage them.

## Second unit: Prepare the environment for exercise unit

**Type of unit:** Exercise unit

**Estimated unit duration:** 5 minutes

**Use of supplemental demo video:** Potentially

### Key content per learning objective

In this exercise, you'll set up:

- Create an Azure Sentinel instance
- Create resources needed for exercise units.

## Third unit: What are Azure Sentinel playbooks?

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to use SOAR for incidents by leveraging playbooks. Unit topics include:

- Understand Azure Sentinel playbooks
- Describe Azure Logic Apps
- Explain the Azure Sentinel Logic Apps connector
- Use playbooks to orchestrate or automate actions

## Fourth unit: Trigger playbooks in near real time <!-- On line 69, we have "3. Trigger a playbook in real-time." Can we make these consistent? -->

**Type of unit:** Learning content unit

**Estimated unit duration:** 12 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to create an incident response automation playbook. Unit topics include:

- Create a playbook to respond to an incident in near real time
- Work with Azure Sentinel connections in Logic Apps
- Automate a response to an analytic<!-- To a Log Analytics rule? --> rule with playbooks

## Fifth unit: Run playbooks on demand

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 minutes

### Key content per learning objective

After completing this unit, you&#39;ll be able to run a playbook on demand from incident details. Unit topics include:

- Explore the incident page<!-- If the name of the page is "Incident." it should be capitalized and bold. Otherwise, in what app/program is this page located? Should it be the Incident page in Logic Apps? -->
- Run a playbook on demand

## Sixth unit: Create an Azure Sentinel playbook

**Type of unit:** Exercise unit

**Estimated unit duration:** 10 minutes

**Use of supplemental demo video:** Possibly

### Key content per learning objective

- Draft lab exercise title: Create an Azure Sentinel playbook
  - Task 1. Add a playbook from Logic Apps
  - Task 2. Add an Azure Sentinel connector in Logic Apps<!-- See previous comment about Azure Sentinel connector vs. Logic Apps connector. -->
  - Task 3. Add a trigger to Azure Sentinel Connection<!-- Suggest changing to "Add a trigger to a playbook? or "to an Azure Sentinel connector." -->
  - Task 4. Add an action
  - Task 5. Test the playbook result
  
In this exercise, you'll learn to:

- Create a new playbook.
- Use the Logic Apps Designer.
- Use the Azure Sentinel Logic Apps connector.

Review the steps for this exercise, Create an Azure Sentinel playbook using the portal<!-- "using the Azure portal?" If not, then which portal? Also, online 142, the lab title is just "Create an Azure Sentinel playbook."-->.

To repeat these steps, sign up for a free trial Azure subscription.

After completing the steps, delete any resource groups you created.

## Seventh unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 2 minutes

### Resolution of module problem

Contoso SecOps can now react more quickly to security incidents by using Azure Sentinel SOAR capabilities and Sentinel playbooks based on Logic Apps with an Azure Sentinel connector<!-- "based on Azure Sentinel connector with/and Logic Apps?" -->, and provide near real-time responses.
