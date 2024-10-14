
**Estimated time:** 35 minutes.

## Scenario

Remember this module’s scenario in which you work for a software development company in the retail industry that is experiencing frequent downtime and performance issues with their new online store application. Since you have decided to enhance workload and test resiliency using Traffic Manager and Azure Chaos Studio respectively, this lab gives you the opportunity to implement a Traffic Manager profile and validate Traffic Manager functionality, configure Azure Chaos Studio environment, and implement and validate an experiment.

In the previous lab, you deployed two instances of a .NET web app into two Azure regions. In this lab, you will first create a resilient configuration that implements the load balancing functionality of Azure Traffic Manager between the two web app instances. Next, you will use Azure Chaos Studio to trigger a failure in one of the apps to test the resiliency of the load balancing implementation.

## Objectives

In this lab, you will:

 -  Prepare the Azure subscription for the lab
 -  Enhance workload resiliency by using Traffic Manager
 -  Test workload resiliency by using Azure Chaos Studio
 -  Remove the resources used in the labs

## Prerequisites

 -  Complete the first lab in this series, [Lab 01 - Agile Planning and Management using GitHub](https://go.microsoft.com/fwlink/?linkid=2261093).
 -  Use the same GitHub account you created for the purpose of the [first lab](https://go.microsoft.com/fwlink/?linkid=2261093).
 -  Complete the second lab in this series, [Lab 02 - Implement Flow of Work with GitHub](https://go.microsoft.com/fwlink/?linkid=2261094).
 -  Complete the third lab in this series, [Lab 03 - Implement CI/CD with GitHub Actions and IaC with Bicep](https://go.microsoft.com/fwlink/?linkid=2261725).

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **GitHub account:** If you don't already have a GitHub account that you can use for this lab, create one by following the instructions available in the article [Creating an account on GitHub](https://docs.github.com/get-started/quickstart/creating-an-account-on-github).
 -  An **Azure subscription** to which you have at least the **Owner-level access**. If you do not have an Azure subscription, you can sign up for a [free trial](https://azure.microsoft.com/free).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Prepare the Azure subscription for the lab
 -  Exercise 1: Enhance workload resiliency by using Traffic Manager
 -  Exercise 2: Test workload resiliency by using Azure Chaos Studio

[:::image type="content" source="../media/launch-exercise-25d42425-89186225-a01e310c.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
 ](https://go.microsoft.com/fwlink/?linkid=2261726)
