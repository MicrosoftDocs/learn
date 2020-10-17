# Module: Hunt for threats using Azure Sentinel

## Learner roles

- Administrator
- Auditor
- Risk practitioner
- Security engineer
- Solution architect
- Student
- Technology manager

## Learner level

- **Beginner**: Introductory and overview material that assumes little or no expertise with the topic. Covers topic concepts, functions, features, benefits. <!-- Can we replace this with "Provides a detailed overview of a topic&#39;s subareas."? Otherwise, I'd delete this last sentence as it doesn't apply to the heading - it doesn't respond to the implied question," What is the learner level?"  -->

## Products taught

- Microsoft Azure Sentinel
- Azure Log Analytics workspace
- Kusto Query Language (KQL)<!-- Kusto is no longer an approved term. Please s/r both Kusto Query Language and KQL with "Azure Data Explorer." -->

## Prerequisites

To get the best learning experience from this module, you should have:

- Familiarity with security operations in an organization.
- Basic experience with Azure services.
- Basic knowledge of operational concepts such as monitoring, logging, and alerting.
- Completed the introductory Azure Sentinel modules.<!-- Is the introductory module a single module? If so, change to singular "Azure Sentinel module." -->

## Module summary description

Threat hunting involves proactively seeking for and identifying threat behaviors in the early stages of an attack. Threat hunting is also for testing analytic rules to determine result quality and identify potential investigation areas. In this module, you’ll learn how to perform threat hunting using Azure Sentinel tools.<!-- In other mods, this section just has the "In this module, you'll learn..." sentence. If you agree to go with that, please delete the first two sentences.  -->

## Subtasks in this module

- Use queries to hunt threats.
- Save key findings with bookmarks.
- Observe threats over time with livestream.

## Lab exercise<!-- I added this section to avoid confusion.  -->

None

## Module learning objectives

After completing this module, you&#39;ll be able to:

- Hunt threats with built-in hunting queries.
- Create and edit hunting queries using KQL.
- Save key findings with bookmarks.
- Observe threats over time with livestream.

## Estimated module duration

60 minutes

## Module outline of units

1. Introduction
2. Explore Azure Sentinel hunting query management and creation<!-- Is this query creation? If so, consider changing this to "Explore query hunting creation and management in Azure Sentinel." If you agree to change it, don't forget to change it on line 78 as well (and possibly 86) as well. -->
3. Save key findings with bookmarks
4. Observe threats over time with livestream
5. Exercise unit
6. Summary

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 5 minutes

### Module scenario

Contoso, Ltd. is a midsize financial services company in London with a New York branch office. Contoso uses Microsoft 365, Azure Active Directory (Azure AD), Azure AD Identity Protection, Cloud App Security, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Endpoint Protection, and Microsoft Azure Information Protection.<!-- I added this second sentence from our scenario pgph that we use in all of the mods, for consistency. Feel free to delete it though. -->

As part of the Security Operations (SecOps) team, you've been tasked with using Azure Sentinel to identify specific account usage patterns for Contoso's Azure Active Directory (Azure AD) accounts.

## Second unit: Explore Azure Sentinel hunting query management and creation

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to describe Azure Sentinel hunting query management and creation. Unit topics include:

- Azure Sentinel queries and their purpose, including MITRE ATT&CK tactics
- Use built-in queries to hunt for threats
- Azure Sentinel community on GitHub
- Create queries to refine threat hunting

## Third unit: Save key findings with bookmarks

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to save key findings with bookmarks. Unit topics include:

- Bookmark Azure Sentinel events
- Integrate bookmarks with incidents
- Observe bookmarks using the investigation graph

## Fourth unit: Observe threats over time with livestream

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to observe threats over time with livestream. Unit topics include:

- Add events to livestream
- View livestream sessions
- Manage livestream events and alerts

## Fifth unit: Exercise&mdash;Hunt for threats using Azure Sentinel

**Type of unit:** Exercise unit

**Estimated unit duration:** 10 minutes

**Use of supplemental demo video:** Potentially

### Key content per learning objective

In this exercise, you&#39;ll learn to:

- Manage Azure Sentinel queries.
- Save key findings with bookmarks.
- Observe threats over time with livestream.

## Sixth unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 5 minutes

### Resolution of module problem

In this module you’ve learned how to perform threat hunting using the tools available in Azure Sentinel, including proactively identifying threat behaviors using Azure Sentinel queries. You've also continued the hunt using bookmarks and livestream to identify specific account usage patterns for Contoso's Azure AD accounts.
