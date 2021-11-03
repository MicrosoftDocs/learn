# Module: Threat Detection with Azure Sentinel Analytics

## Learner roles

- Administrator
- Auditor
- Data analyst
- Risk practitioner
- Security engineer
- Solution architect
- Student

## Learner level

- **Beginner**: Introductory and overview material that assumes little or no expertise with the topic. It covers topic concepts, functions, features, and benefits.

## Products taught

- Microsoft Azure Sentinel
- Azure Monitor Logs

## Prerequisites

- Basic knowledge of Azure services
- Basic knowledge of operational concepts, such as monitoring, logging, and alerting

## Module summary description
<!--LM: Global comment: The document contains variations on "Azure Sentinel Analytics" (often abbreviated to Analytics) and analytics rules, with varying capitalization and plural forms. This term is not available in our resources but based on similar terms, it might be Microsoft Azure Sentinel Analytics, with Azure Sentinel Analytics as the abbreviated form. It's not clear if you can use Sentinel Analytics or Analytics when referring to the service but I recommend including "Azure" for branding. When referring generically to analytics, please don't capitalize it and do use the plural form.-->
This module introduces you to Azure Sentinel Analytics and describes the various types of rules. You can create rules for detecting suspicious events either by using predefined templates or writing custom queries using Azure Data Explorer. There are a range of predefined analytics rules based on Machine Learning, Fusion, derived from the security products and you can also pull a community written rules from Security Community in GitHub.
<!--LM: Kusto Query Language and KQL are not approved terms. I replaced the term instances with Azure Data Explorer. Please update all instances of KQL.-->
## Subtasks in this module

- How to create a rule from custom template
- How to create a rule using your own Azure Data Explorer query
- How to manage the rules including editing and deleting

## Lab exercise

- Draft lab exercise title: Threat detection with Azure Sentinel Analytics <!--LM: I suggest "Detect threats with..."-->
  - Task 1: Create an incident analytics rule from existing template
  - Task 2: Create a scheduled query rule

## Module learning objectives

- Explain the importance of Azure Sentinel Analytics
- Explain different types of analytics rules
- Create rules from templates
- Create new rules and queries using the wizard
- Manage rules with modifications

## Estimated module duration

45 minutes

## Module outline of units
<!--LM: Note the capitalization differences in "analytics". Please resolve, referring to my previous comments.-->
1. Introduction
2. What is Azure Sentinel Analytics?
3. Exercise Setup
4. Types of Analytic rules
5. Create an Analytics rule from templates
6. Create an Analytics rule from wizard
7. Manage analytics rules
8. Exercise unit
9. Summary

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 minutes

### Module scenario

Contoso, Ltd. is a midsize financial services company in London with a New York branch office. Contoso uses Microsoft 365, Azure Active Directory (Azure AD), Azure AD Identity Protection, Cloud App Security, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office 365, System Center Endpoint Protection, and Microsoft Azure Information Protection. Contoso provides threat protection for its Azure-based and on-premises resources by using the paid version of Azure Security Center. The company also monitors and protects other non-Microsoft assets.
Security analysts at Contoso face a huge triage burden. They deal with a high volume of alerts from multiple products. They correlate alerts in the following ways:

- Manually from different project dashboards
- By using a traditional correlation engine

Additionally, the time spent to set up and maintain IT infrastructure takes the security options (SecOps) team away from its security tasks.

The IT director believes that Azure Sentinel Analytics will help the security analysts perform complex investigations faster and improve their SecOps.

As Contoso's lead system engineer and Azure administrator, you've been asked to set up analytics rules in Azure Sentinel so that the SecOps team can identify and stop cyberattacks.

## Second unit: Exercise unit - Prepare the environment for exercise unit

**Type of unit:** Exercise unit

**Estimated unit duration:** 5 minutes

**Use of supplemental demo video:** Potentially

### Key content per learning objective

In this exercise, you'll setup:

- Create an Azure Sentinel instance
- Create resources needed for exercise units.

## Thirth unit: What is Azure Sentinel Analytics?

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to explain the importance of Azure Sentinel Analytics. Topics include:

- Understand the importance of Analytics for security
- Understand Analytics rules
- Explore the Analytics home page
- Map analytics rules to MITRE ATT&CK Tactics

## Fourth unit: Types of Analytics rules

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 minutes

### Learning objectives

After you complete this unit, you&#39;ll be able to understand the following types of analytics rules:

- Scheduled
- Microsoft Security
- Machine Learning
- Fusion

## Fifth unit: Create an analytics rule from templates

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 minutes

### Key content per learning objective

After you complete this module, you&#39;ll be able to create an analytics rule from existing templates:

- Explore templates
- Create an analytics rule from templates

## Sixth unit: Create an analytics rule from Wizard

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to create new rules and queries using the wizard. Topics include:

- Scheduled query rule
- Microsoft incident rule

## Seventh unit: Manage analytics rules

**Type of unit:** Learning content unit

**Estimated unit duration:** 4 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to manage rules with modifications. Topics include:

- Edit existing rules to change severity and MITRE Att&ck Tactics
- Duplicate the rule
- Disable the rule
- Delete the rule

## Eight unit: Detect threats with Azure Sentinel Analytics

**Type of unit:** Exercise unit

**Estimated unit duration:** 10 minutes

**Use of supplemental demo video:** Potentially

### Key content per learning objective

In this exercise, you'll learn to:

- Create an incident rule from an existing template.
- Create a scheduled query rule using your own KQL code.
- Adjust KQL from an existing analytic rule.

Review the steps from **Exercise&mdash;Create an analytics rule from templates** and with a custom KQL code.

If you want to repeat these steps, sign up for a free trial Azure subscription.

After you complete the steps, delete any resource groups you created.

## Ninth unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 2 minutes

### Resolution of module problem

Contoso wanted to improve the operation of their SecOps team's investigation of the security incidents. With Azure Sentinel Analytics, the SecOps team was able to find potential threats more effectively.

In this module, you learned about analytic rules in Azure Sentinel. You also learned how to create an analytics rule from templates and with your own KQL code.
