## Motivation

You are now ready to start implementing the temperature service. In the previous unit, you determined that a serverless solution would best fit your needs. In order to implement a serverless Azure Function, it must have a place to call home - this home is an Azure Function App.

## Azure Function App Overview

Azure Functions are hosted in a container called a Function App. You can define any number of Function Apps in Azure to logically group and structure your functions in a way that makes sense for your organization. Function Apps are a compute resource in Azure. You will create a Function App that will host the escalator drive gear temperature service. There is a couple dependency decisions that need to be made in order to create the Function App, you need to decide on a service plan, and create (or choose) a compatible storage account.

### Choosing a Service Plan

Function Apps may use one of two types of service plans. The first service plan is called the Consumption service plan. This is the plan that you will choose if you wish to use the Azure serverless application platform. The Consumption service plan provides automatic scaling and bills for resources only when the functions are actually running. The Consumption plan comes with a configurable timeout period for the execution of a function. By default it is 5 minutes, but may be configured to have a timeout as long as 10 minutes.

The second plan is called the App Service plan. This plan allows you to have your function run continuously on a VM. You would choose this option if your functions are used continuously or requires more processing power or execution time than the Consumption plan can provide.

For our purposes, you will choose the Consumption plan. It is important to note that after a Function App has been created, you cannot change the service plan.

### Storage Account Requirements

When creating a Function App, it must be linked to a Storage Account that supports Blob, Queue, and Table Storage. The Function App uses this storage account for internal operations such as logging function executions and managing execution triggers. This is also where, on the Consumption service plan, the Azure Function code and configuration files are stored.

## Summary

In this unit, you learned that Azure Functions are hosted in a Function App. You also learned about the service plan options and storage account requirements. In the next unit, you will create a Function App using the Azure Portal.
