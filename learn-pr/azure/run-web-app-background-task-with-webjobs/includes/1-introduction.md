A small automated task, which executes automatically in response to some event, is a frequent requirement in many systems.

Suppose you are a senior web developer in a research role for an online luxury watch dealer. You have a production website that uses Azure web apps. You've built a small script that checks stock levels and reports them to an external service. You consider this script to be part of the website, but it's meant to run in the background, not in response to a user's actions on the site.

You'd like the website and the script code to be closely associated. They should be stored together as part of the same project in the same source control repository. The script may grow and change as the site changes, so you'd like to always deploy them at the same time, to the same set of cloud resources.

In this module, you will create a WebJob in the same project as an existing Web App.

By the end of this module, you will be able to automate tasks by using WebJobs.

## Learning objectives

In this module, you will:

- Identify what a WebJob is and when to use one instead of an Azure Function
- Use Visual Studio to create an App Service background task with a WebJob linked to a web project
- Package a WebJob for deployment
- Configure the WebJob operating model by using the WebJobs SDK

## Prerequisites  

- A basic familiarity with the creation, configuration, and deployment of App Service Web Apps with Visual Studio

> [!IMPORTANT]
> You will need Visual Studio 2017 with the Azure workload and the Azure Functions tools installed to complete the exercises in this module.
