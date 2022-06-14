# Title

Extend Microsoft Graph data using extensions

## Role(s)

developer

## Level

intermediate

## Product(s)

microsoft-graph

## Prerequisites

+ Access to an [Azure Active Directory tenant](/azure/active-directory/develop/quickstart-create-new-tenant) where you have the Global Administrator role for your account
+ Basic knowledge of REST APIs
+ Basic knowledge of Microsoft Graph and working with Microsoft Graph APIs

## Summary

Add custom properties to Microsoft Graph resources through Microsoft Graph extensions. Query, read, and write the custom properties and their associated data to build unique experiences for your applications using Microsoft Graph.

## Learning objectives

<!-- 
Pattern:
    - Prepare
    - Do
    - Validate
-->

1. Add custom properties to Microsoft Graph resources
2. Query custom properties and their associated data through Microsoft Graph
3. Use data in custom properties to extend your application

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify extension types available in Microsoft Graph | How to store lightweight information through Microsoft Graph without an external database | Knowledge check | 1 | Yes |
| Use Microsoft Graph extension attributes 1-15 | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1,2 | Yes |
| Use Microsoft Graph directory extensions | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1,2 | Yes |
| Use Microsoft Graph schema extensions | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1,2 | Yes |
| Use Microsoft Graph open extensions | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1,2 | Yes |


## Outline the units

Add more units as needed for your content

1. Introduction

    A multinational with subsidiaries across continents and hundreds of employees across each subsidiary uses Azure Active Directory (Azure AD) and Microsoft 365 for identity and access management, collaboration, and security. The company has deployed a team bonding mobile app that allows employees to discover each other and connect within and through their external social networks.

    The company wants to allow employees to share bits about themselves so their colleagues can discover them in public social networks. The company doesn’t want to invest in another database. Because of Microsoft Graph's extensibility options, the company will use Microsoft Graph to store this lightweight information and allow each employee the privilege to fully manage and own their data.

2. Microsoft Graph extension attributes 1-15
<!-- Conceptual unit -->


3. Extend Microsoft Graph data using extension attributes
<!-- Exercise unit -->


4. Microsoft Graph directory extensions
<!-- Conceptual unit -->


5. Extend Microsoft Graph data using directory extensions
<!-- Exercise unit -->


6. Microsoft Graph schema extensions
<!-- Conceptual unit -->


7. Extend Microsoft Graph data using schema extensions
<!-- Exercise unit -->


8. Microsoft Graph open extensions
<!-- Conceptual unit -->


9. Extend Microsoft Graph data using open extensions
<!-- Exercise unit -->


10. Knowledge check
<!--
    Guidance: https://review.docs.microsoft.com/en-us/help/learn/id-guidance-knowledge-check?branch=main
-->
11. Summary

    The company has extended employee profile information using Microsoft Graph and without using an external database. Through extension attributes, the company can extend the team bonding app with employee-supplied data.

    + Comparison of the extension types

## Notes

+ [Add custom properties to resources using extensions](https://review.docs.microsoft.com/en-us/graph/extensibility-overview?branch=pr-en-us-17209)
