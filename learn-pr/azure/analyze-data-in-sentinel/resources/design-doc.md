# Module: Create and manage rules in Azure Sentinel Analytics

## Learner roles

- administrator
- auditor
- data analyst
- risk practitioner
- security engineer
- solution architect
- student

## Learner level

- **Beginner** : Introductory and overview material that assumes little or no expertise with topic and covers topic concepts, functions, features, benefits.

## Products taught

- Azure Sentinel
- Azure Log Analytics workspace

## Prerequisites

- Basic knowledge of Azure services
- Basic knowledge of operational concepts, such as monitoring, logging, and alerting

## Module summary description

This module introduces you to Azure Sentinel Analytics and describes the various types of rules. You can create rules for detecting suspicious events either by using predefined templates or writing your custom queries using Kusto Query Language.

## Subtasks in this module

- How to create a rule from custom template
- How to create a rule using your own KQL query
- How to manage the rules including editing and deleting

## Lab exercise

- Draft lab exercise title: Create analytics rule from templates and with custom KQL code
- In the first lab students will create an Analytic rule from predefined rule templates. Second lab will describe the process of creating an Analytic rule from wizard using own KQL code.

## Module learning objectives

- Explain the importance of Azure Sentinel Analytics
- Explain different types of analytic rules.
- Create rules from templates
- Create new rules and queries using the wizard
- Manage rules with modifications

## Estimated module duration

45 minutes

## Module outline of units

1. Introduction
2. What is Azure Sentinel Analytics?
3. Types of Analytic rules
4. Create an Analytics rule from templates
5. Create an Analytics rule from wizard
6. Managing analytics rules
7. Exercise unit
8. Summary

## 1st unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 mins

### Module scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Contoso has moved aggressively to Azure services, and it currently uses Microsoft 365 and Azure Active Directory (Azure AD). It also uses Azure AD Identity Protection, Cloud App Security, Azure Advanced Threat Protection (Azure ATP), Microsoft Defender Advanced Threat Protection (Microsoft Defender ATP), Microsoft Office 365 Advanced Threat Protection, Endpoint Protection, and Microsoft Azure Information Protection. Contoso is also using the paid version of Azure Security Center for threat protection for resources that are running on Azure and on-premises. Additionally, Contoso has other non-Microsoft assets to monitor and protect.
The IT director at Contoso realizes that its security analysts face a huge triage burden. They not only deal with a high volume of alerts, but they also must correlate alerts from different product dashboards manually or by using a traditional correlation engine.

The IT director believes that Azure Sentinel could provide a means to address Contoso's pain points:

- Alerts are from multiple products.
- Too many alerts are triaged across dashboards.
- The time spent setting up and maintaining IT infrastructure takes the security operations (SecOps) team away from its security tasks.

The IT director believes that Azure Sentinel Analytics will help the security analysts save time performing complex investigations and improve their SecOps.
As Contoso's lead system engineer and Azure administrator, you've been asked to set up a Azure Sentinel Analytics rules to improve the operation of SecOps team to identify and stop cyberattacks.


## 2nd unit: What is Azure Sentinel Analytics

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 mins

### Key content per learning objective

After completing this unit, you&#39;ll be able to explain the importance of Azure Sentinel Analytics

- Understand the importance of Analytics for security
- Understand Analytic rules
- Explore Analytic home page


## 3rd unit: Types of Analytics rules

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 mins

### Learning objectives

After completing this unit, you&#39;ll be able to understand the following types of Analytics rules:

- Scheduled
- Microsoft Security
- Machine Learning
- Fusion


## 4th unit:Create an analytics rule from templates

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 mins

### Key content per learning objective

After completing this module, you&#39;ll be able to create analytic rule from existing templates.

- Explore templates
- Create analytics rules from templates


## 5th unit: Create an Analytics rule from Wizard

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 mins

### Key content per learning objective

After completing this unit, you&#39;ll be able to create new rules and queries using the wizard

- Scheduled query rule
- Microsoft incident rule


## 6th unit: Manage analytics rules

**Type of unit:** Learning content unit

**Estimated unit duration:** 4 mins

### Key content per learning objective

After completing this unit, you&#39;ll be able to manage rules with modifications

- Edit existing rules
- Duplicate the rule
- Disable the rule
- Delete the rule


## 7th unit: Exercise: Create analytics rule from templates and with custom KQL code

**Type of unit:** Exercise unit

**Estimated unit duration:** 10 mins

**Use of supplemental demo video:** Potentially

### Key content per learning objective

In this exercise, you will learn to:

- Create an action rule from template
- Create an action rule using your own KQL code

Review the steps for this Exercise: Create analytics rule from templates and with custom KQL code.

If you want to repeat these steps, get a free trial Azure subscription.

After completing the steps, delete any resource groups you created.


## 8th unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 2 mins

### Resolution of module problem

Contoso was looking to improve the operation of their SecOps team in investigation of the security incidents. With Azure Sentinel Analytics, SecOps team can now more effectively look for potential threats.
In this module, you&#39;ve learned about analytic rules in Azure Sentinel. You&#39;ve also learned how to create an analytic rule both from templates and by using your own KQL code.
