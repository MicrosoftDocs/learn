# Title

Add custom data to your app using extensions in Microsoft Graph

## Role(s)

developer

## Level

intermediate

## Product(s)

learning-graph

## Prerequisites

1. Access to an [Azure Active Directory tenant](/azure/active-directory/develop/quickstart-create-new-tenant) where you have the Global Administrator role for your account
2. Basic knowledge of working with REST APIs and how to use the create, read, update, and delete (CRUD) REST API operations
3. Basic knowledge of working with data in Azure AD and Microsoft 365 using Microsoft Graph

## Summary

Add custom properties to Microsoft Graph resources through Microsoft Graph extensions. Query and update the custom properties and their associated data to build unique experiences for your applications.

## Learning objectives

<!-- 
Pattern:
    - Prepare
    - Do
    - Validate
-->

1. Choose extension options for adding custom properties to Microsoft Graph
2. Add, query, and update custom properties and their associated data through Microsoft Graph
3. Use data in custom properties to extend your application

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify extension types available in Microsoft Graph | Evaluate Microsoft Graph extension options for storing lightweight information without an external database | Knowledge check | 1 | Yes |
| Use Microsoft Graph extension attributes 1-15 | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1, 2, 3 | Yes |
| Use Microsoft Graph directory extensions | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1, 2, 3 | Yes |
| Use Microsoft Graph schema extensions | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1, 2, 3 | Yes |
| Use Microsoft Graph open extensions | Store lightweight information through Microsoft Graph without an external database | Knowledge check | 1, 2, 3 | Yes |


## Outline the units

Add more units as needed for your content

1. Introduction

    Suppose you're a developer at a multinational organization with subsidiaries and hundreds of employees across continents. Your organization uses Azure Active Directory (Azure AD) and Microsoft 365 for identity and access management, collaboration, and security. Your team wants to deploy a team bonding mobile app that will allow employees to discover each other and connect within and through their external social networks. Through the app, employees will add data about themselves and they'll discover each other, their interests, and their social networks.

    The organization doesn't want to invest in another database and has identified extension options available in Microsoft Graph as suited for the data needs of the app. You want to evaluate the available extension options and how to use them in the team bonding app.

2. Choose extension attributes for Microsoft Graph data
<!-- Conceptual unit -->


3. Exercise - Add custom data using extension attributes
<!-- Exercise unit -->


4. Examine directory extensions for Microsoft Graph data
<!-- Conceptual unit -->


5. Exercise - Add custom data using directory extensions
<!-- Exercise unit -->


6. Consider schema extensions for Microsoft Graph data
<!-- Conceptual unit -->


7. Exercise - Add custom data using schema extensions
<!-- Exercise unit -->


8. Choose open extensions for Microsoft Graph data
<!-- Conceptual unit -->


9. Exercise - Add custom data using open extensions
<!-- Exercise unit -->


10. Knowledge check
<!--     Guidance: https://review.docs.microsoft.com/en-us/help/learn/id-guidance-knowledge-check?branch=main  -->

11. Summary

    The company has extended employee information using Microsoft Graph and without using an external database. Through the team bonding app and the underlying Microsoft Graph extension attributes, employees can supply data about themselves. Through the app, employees can exercise curiosity about their colleagues and connect with them internally and through external social networks.

    + Comparison of the extension types

## Notes

+ [Add custom properties to resources using extensions](https://review.docs.microsoft.com/en-us/graph/extensibility-overview?branch=pr-en-us-17209)
