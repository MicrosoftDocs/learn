**Estimated time:** 60 minutes.

## Scenario

**Azure Load Testing** is a fully managed load-testing service that enables you to generate high-scale load. The service simulates traffic for your applications, regardless of where they’re hosted. Developers, testers, and quality assurance (QA) engineers can use it to optimize application performance, scalability, or capacity. Quickly create a load test for your web application by using a URL, and without prior knowledge of testing tools. Azure Load Testing abstracts the complexity and infrastructure to run your load test at scale. For more advanced load testing scenarios, you can create a load test by reusing an existing Apache JMeter test script, a popular open-source load and performance tool. For example, your test plan might consist of multiple application requests, you want to call non-HTTP endpoints, or you’re using input data and parameters to make the test more dynamic.

In this lab, you’ll learn about how you can use Azure Load Testing to simulate performance testing against a live-running web application with different load scenarios. Lastly, you’ll learn how to integrate Azure Load Testing into your CI/CD pipelines.

## Objectives

After completing this lab, you'll be able to:

- Deploy Azure App Service web apps.
- Compose and Run a YAML-based CI/CD pipeline.
- Deploy Azure Load Testing.
- Investigate Azure web app performance by using Azure Load Testing.
- Integrate Azure Load Testing into your CI/CD pipelines.

## Requirements

- This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
- **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).
- Identify an existing Azure subscription or create a new one.
- Verify that you have a Microsoft account or a Microsoft Entra account with the Owner role in the Azure subscription and the Global Administrator role in the Microsoft Entra tenant associated with the Azure subscription. For details, refer to [List Azure role assignments using the Azure portal](/azure/active-directory/roles/manage-roles-portal) and [View and assign administrator roles in Microsoft Entra ID](/azure/active-directory/roles/manage-roles-portal).

## Exercises

During this lab, you'll complete the following exercises:

- Exercise 0: Configure the lab prerequisites.
- Exercise 1: Configure CI/CD Pipelines as Code with YAML in Azure DevOps.
- Exercise 2: Deploy and Setup Azure Load Testing.
- Exercise 3: Automate a Load Test with CI/CD in Azure Pipelines

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
](https://go.microsoft.com/fwlink/?linkid=2270116)
