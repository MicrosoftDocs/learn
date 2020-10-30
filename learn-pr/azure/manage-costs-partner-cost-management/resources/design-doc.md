# Module design

## Title

Configure and manage costs as a Microsoft Partner by using Azure Cost Management 

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure Cost Management + Billing

## Prerequisites

- A basic understanding of the Microsoft Customer Agreement, Azure Plan, and Azure Cost Management configuration.
- You have confirmed your customers’ acceptance of the Microsoft Customer Agreement 
- You have transitioned your customers to Azure plan 
- You have enabled Azure Cost Management for your customers 
- Familiarity with Azure billing and invoicing 
- Familiarity with partner earned credits 

## Summary

Reconcile your bill and analyze costs across your customers and resources by using Azure Cost Management as a partner. Determine which of your resources do not receive discounted pricing and manage costs through budgets to ensure your spending stays within defined limits. Enable your customers to use Azure Cost Management as well with Pay As You Go rates.

## Learning objectives

1. List what scopes are applicable to partners and customers.
1. Apply the correct tools and techniques to analyze your costs across customers to reconcile your bill.
1. Describe how to determine which resources have partner earned credits applied. 
1. Describe how to enable ACM for customers at PAYG rates.
1. Create budgets for customers and subscriptions.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand partner billing scopes / Understand RBAC scopes for Partners and Customers |Understand the cost management scopes that apply to you. --> update, don’t use “understand”  | Knowledge check |1 |Combine  these two  |
| Reconcile your bill in Cost Analysis  | Analyze the customers and resources that are the primary drivers of your monthly bill. | Knowledge check| | 2 |  |
| Determine resources that do not have partner earned credit applied  | Identify the resources across your customers that do not have the partner earned credit applied  | Knowledge check | 3| TODO |
|Enable ACM for customers at PAYG rates / Manage costs for a subscription at PAYG rates   | Give your customers access to the subscription to be able to manage their costs at pay-as-you-go rates | Knowledge check | 4| Combine these two |
| Set budgets for customers as a partner / Set budgets for subscriptions as either a partner or customer  | Set thresholds on your customer’s expenses to stay within a budget  | Knowledge check | 5 | combine these two | 

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You are a global admin or an admin agent for Fabrikam, a CSP partner who consults with law firms to provide solutions for them to move their infrastructure presence to the cloud. You have begun receiving bills and want to use Azure Cost Management to better understand, manage, and optimize your costs to ensure that they are kept in line. Your CEO expressed concern about the bill last month, which was $15 K larger than the previous month. He has asked you to analyze your company’s customers and resources to determine the primary cost drivers on your bill.  You also are interested in maximizing the Partner Earned Credits (PEC) that Fabrikam receives by identifying the resources across your customers that do not have the credit applied.

    One of your firms, Contoso, also reached out to you this week and wants to set budgets and thresholds that can turn down and automate actions on VMs when certain cost thresholds are exceeded. You decide to enable cost management for them to enable them to set budgets and manage costs at pay as you go retail rates. 

    Notes from review: 

    Consider making more specific, what might be happening to the person and how would they solve the specific problem? 

    Ex: You had a customer who accused you of overcharging and you want to be able to show them the Azure costs as proof. 

    Ex: you run a business that handles the infra for x, y, z. You are hired to do x, run your software off of Azure, etc. 

    Make underlying units link to specifics of the intro somehow 

1. **Understand cost management scopes for partners**

    - Discuss partner-specific billing scopes 
      - Consider defining scopes or make this a pre-requisite
    - Discuss RBAC scopes nuance for partners and their customers
 
1. **Reconcile your bill and attribute the cost to the customer's resources**

   - Use invoice filter in cost analysis for billing scopes to reconcile bill 
     - Use an image of a bill with arrows a diagram 
     - Make it downloadable? (right-click ‘save as’) 

1. **Take advantage of applied partner earned credits for resources**

     - Briefly partner earned credits and point to documentation 
     - Determine the resources that do or do not have the partner earned credit applied 

1. **Enable cost management for your customers at retail pay-as-you-go rates**

     - Enable cost visibility policy for customers from the Azure portal 
     - Manage costs at subscription scope as an RBAC user 

1. **Set cost thresholds for customers and their subscription expenses to stay within budget**

    - Discuss how to set a budget for a customer as a partner 
    - Discuss how to set a budget for a subscription as either a partner or a customer 

1. **Knowledge check**

    Question for each of the previous units 

1. **Summary**

## Notes

## Resources
