# Title

Develop, test and deploy Azure Functions with Azure Functions Core Tools 

## Role(s)

- developer
- devops-engineer
- administrator
- solution-architect

## Level

- beginner

## Product(s)

- azure
- azure-functions

## Prerequisites

- Basic knowledge of Azure Functions

## Summary

Create and deploy an Azure Function from the command line and Visual Studio Code using Azure Functions Core Tools.

## Learning objectives

1. Install Azure Functions Core Tools locally
1. Create an Azure Function locally using Azure Functions Core Tools
1. Test an Azure Function locally using Azure Core Tools
1. Deploy an Azure Function to the cloud using Azure Core Tools

## Chunk your content into subtasks

Identify the subtasks of *Develop, test and deploy Azure Functions with Azure Functions Core Tools*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Define Azure Functions Core Tools and how they are used to create and manage Azure Functions | Learn about when and how to use Core Tools| Knowledge Check | All | Yes |
| Create a function locally in Cloud Shell using Core Tools | Develop a function locally using Core Tools | Exercise | 2 | Yes |
| Test a function locally in Cloud Shell using Core Tools | Test your function locally before deploying to the cloud | Exercise | 2,3 | No, See preceding sub-task |
| Update a function locally in Cloud Shell using Core Tools | Develop a function locally using Core Tools  | Exercise | 3 | No, See 2nd sub-task in this list |
| Deploy a function to Azure using Core Tools | Deploy a working function to Azure using Core Tools | Exercise | 4 | Yes |
| Re-deploy a locally updated function to Azure using Core Tools | Updating a function once it has been deployed | Exercise | 4 | No, see preceding sub-task |

## Outline the units

1. **Introduction**

    Azure Functions is a great way to execute the logic that runs your business in The Cloud without worrying about infrastructure and only paying for what you consume. As with all solutions, it is good to develop and test locally before deploying. 

    As its name suggests, Azure Functions Core Tools enables you to develop functions locally and then deploy when you are ready. 

    Suppose you are a developer for a car dealership chain. The sales people are always looking  for ways to modernize their workflow. Your manager has decided to build a set of applications backed by Azure Functions. The first service involves loan interest calculations, and he's asked you to look into creating an Azure Function that can be called over HTTP to return an interest calculation. In this module, we'll look at how Azure Core Tools makes it easy to develop and test functions locally and how they then help to publish to the cloud so people in your team can use what you've created. 

1. **Create and manage Azure Functions from the command line with Azure Functions Core Tools**

    - What is Azure Functions?
        - Very high-level recap of what a function is - triggers, bindings etc. 
        - Very quick motivation about why you'd use them for this scenario
    - What is Azure Functions Core Tools?
        - Introduce Core Tools
        - Explain what Core Tools can do and how the command line works
        - Talk about templates for creating a function
    - Where do I get Azure Functions Core Tools?
        - Link off to documentation on how to install Core Tools - A nice alternative would be to show a quick video on how to install the tools. 
        - Mention Visual Studio Code integration, link to it in the **Learn More** of the summary
        - Explain briefly that, for the purpose of this module, we'll use the Cloud Shell since the tools are already built-in.

        **This unit to include a 2-question Knowledge check**

1. **Exercise - Create an Azure Function with Azure Core Tools** (Local - Cloud Shell)

    Scenario is that I want to create my first function with the tools. Given that we have sandbox integration, we'll use the Cloud Shell and don't have to even install the tools. 

    List the steps which apply the learning content from previous unit:

    1. Make sure sandbox is activated
    1. `func` on command line to verify the Azure Core Tools are installed
    1. Run a couple other simple commands, explain the syntax of the commands
    1. Use `func init -l JavaScript`
    1. Use `func new` wizard to create an HTTP triggered JavaScript function (option 8 currently)
    1. Open port 7071 with `curl -X POST http://localhost:8888/openPort/7071` and note the url
    1. `func start` to start the function. 
    1. Append *api/[func-name]* to the URL and observe that it returns a message. Function is successfully running locally.
    1. Add simple-interest code to the function in the built-in editor and save
    1. Observe the Core Tools re-starting the function
    1. Test again with parameters and show that you get back a nice result from the calculation.  

    *Consider using curl on the command line to send a request to the HTTP endpoint*

1. **Deploy an Azure Function to the Cloud with Azure Core Tools**

    - Introduce the concept of a function app and why it is needed
    - Explain the steps needed from the command line to deploy our function to a function app in our (sandbox) subscription

1. **Exercise - Deploy an Azure Function to the Cloud with Azure Core Tools** (Cloud)


    1. Create a function app - use sandbox resource group (see [this script](https://docs.microsoft.com/en-us/azure/azure-functions/scripts/functions-cli-create-serverless))
        1. set storage account name
        1. set function app name
        1. use sandbox resource group
        1. call `az storage account create`
        1. call `az functionapp create`

    1. Deploy function to this function app in the cloud with `func azure functionapp publish [app-name]`
    1. Test
    1. Update function locally (Compound interest calc)
    1. Deploy and Test again

    **Consider a task validation here**

1. **Summary**

    **Consider another couple of knowledge checks**
    
    As a developer at the car dealership, you wanted use create Azure Functions to provide a loan interest calculator to the business. You used Azure Core Tools to build a prototype locally and then deployed a version to Azure for others in the team to consume. 

    ### Learn more
    - https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#create-a-local-functions-project
    - https://github.com/Azure/azure-functions-core-tools
