# Azure Purview Workshop

## What is Azure Purview?

Azure Purview is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS) data as well as multicloud (Azure, GCP, AWS, and many more cloud providers converged into a holistic unified Data Governance experience). Easily create a comprehensive, up-to-date map of your data landscape with automated data discovery, sensitive data classification, end-to-end data lineage, insights reports, business glossary, and approval workflows support. Empower data consumers, CDOs, data stewards, experts, BI and analytics admins to find valuable, trustworthy data and where it is located.

### How does Azure Purview benefit a CDO ?

Azure Purview helps CDOs, data analysts, BI engineers, data stewards, givernance experts and admins to answer these kinds of questions - 

- What data does my org have? 
- Where did this data originate?
- Where is data stored? 
- What’s my exposure to risk?
- Is my usage compliant? 
- How do I control access & use?
- What is required by regulation X (read GDPR, CELA, HIPAA) etc.?
- What data is being collected? 
- For what business purpose?
- Where is the sensitive data?   


## What is the main goal?
By the end of this session, you'll be able to understand and appreciate the salient features of Azure Purview service and how it encompasses a wide range of data sources across on-prem, multi-cloud (Azure, GCP, AWS), and 30+ varieties of databases and 10+ different file types including JSON, CSV, TSV, TXT, Parquet etc.

Goal: This learn module will walk you through the steps to set up Azure Purview and highlight the salient features supported by Azure Purview Data Catalog as we go along.

## Example Scenario
Scenario: The CDO (Chief Data Officer) of Fabrikam Corp Inc. wants to set up a daily dashbaord view of what percentage of data across the company's data estate is classified as "Sensitive" and "Confidential".

Problem: "Suppose you work at an athletic shoe company named Fabrikam Corp Inc as a business intelligence and analytics engineer. The CDO of your company has assigned to you the task of setting up a daily dashbaord view of what percentage of data across the company's data estate is classified as "Sensitive" and "Confidential".

Purview Solutioning: "During Purview's scanning process, Purview's classification engine will determine and apply classifications on each table or schema level hosted in the data estate. The Insights feature will help you build reports to view detailed analytics on each of the classified data sources, databases or files as well as what classifications and sensitivity labels were applied. You may even use Purview Insights APIs to build custom reports using and data visualization tools such as Power BI or Tableau etc."


<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->

<!-- whhender: This data upload part needs to be somewhere here in set up. Please feel free to modify! -->

# Module 00 - Lab Environment Setup

**[Home](../README.md)** - [Next Module >](../modules/module01.md)

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* Owner permissions within a Resource Group to create resources and manage role assignments.
* The subscription must have the following resource providers registered.
    * Microsoft.Authorization
    * Microsoft.DataFactory
    * Microsoft.EventHub
    * Microsoft.KeyVault
    * Microsoft.Purview
    * Microsoft.Storage
    * Microsoft.Sql
    * Microsoft.Synapse

## :loudspeaker: Introduction

In order to follow along with the Azure Purview lab exercises, we need to provision a set of resources.

## :test_tube: Lab Environment Setup

1. Right-click or `Ctrl + click` the button below to open the Azure Portal in a new window.

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftayganr%2Fpurviewlab%2Fmain%2Ftemplate%2Fazuredeploy.json)

2. Beneath the **Resource group** field, click **Create new** and provide a unique name (e.g. `purviewlab-rg`), select a [valid location](https://azure.microsoft.com/en-us/global-infrastructure/services/?products=purview&regions=all) (e.g. `West Europe`), and then click **Review + create**.

    ![Deploy Template](../images/module00/00.01-deploy-lab.png)

3. Once the validation has passed, click **Create**.

    ![Create Resources](../images/module00/00.02-deploy-create.png)

4. The deployment should take approximately 10 minutes to complete. Once you see the message **Your deployment is complete**, click **Go to resource group**.

    ![Deployment Complete](../images/module00/00.03-deploy-complete.png)

5. If successful, you should see a set of 15 resources, similar to the screenshot below.

    ![Resource Group](../images/module00/00.04-deploy-resources.png)

Note: The Azure Purview account resource has been purposely **excluded** from the template so that participants have an opportunity to understand how to deploy an Azure Purview account via the Azure Portal.

## :tada: Summary

By successfully deploying the Azure Purview lab template, you have the Azure resources needed to follow along with the learning exercises.

[Continue >](../modules/module01.md)
