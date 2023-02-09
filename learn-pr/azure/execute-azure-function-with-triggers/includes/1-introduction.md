Imagine a scenario where a busy hair salon has a recurring problem: customers commonly miss their appointments. Appointments are reserved time slots, so if a customer misses an appointment, the salon loses money. To fix this problem, the salon reaches out to you, a software developer. To improve the situation, you decide to send two types of reminder text messages, one that is sent as soon as the appointment is scheduled or changed, and each morning send a text message to each customer who has an appointment that day.

You need to create a service that can be easily scheduled, updated, and scaled. You decide to solve this problem using an Azure Functions app. You already know how to implement the logic to send a text message. Now you need to learn how to send the message at a specific time or when a specific event occurs. Luckily, Azure Functions app supports a feature called _triggers_. Triggers are used to determine how an Azure Function is invoked.

## Learning objectives

In this module, you will:

- Determine which trigger works best for your business needs.
- Create a timer trigger to invoke a function on a consistent schedule.
- Create an HTTP trigger to invoke a function when an HTTP request is received.
- Create a blob trigger to invoke a function when a blob is created or updated in Azure Storage.

## Supported languages

This module uses the Azure portal to create and test your function code. Functions supports in-portal development for the following languages:

- C# Script (.csx)
- JavaScript
- Python
- PowerShell

Other languages such as Java, TypeScript, Go and Rust are supported by Azure Functions through local development tools. You can read more about the supported languages, tools, and features of Azure Functions in the [developer guide](/azure/azure-functions/functions-reference).