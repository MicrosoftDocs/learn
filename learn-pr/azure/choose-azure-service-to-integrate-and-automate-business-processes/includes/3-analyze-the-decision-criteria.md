There are several different business processes that run your bicycle rental business. For example, there's the bike rental process, a return process, a bike booking process, and processes that don't directly relate to bikes, such as holiday booking for the staff.

We've introduced an array of Azure technology that could be used to help build these processes. Let's try to be more concrete about how we make the decision for a given process.

## How to choose a service

The following diagram shows a simplified flow chart that you can use to choose the best technology to use for your business process:

:::image type="content" source="../media/3-service-choice-flow-diagram.png" alt-text="Diagram of decision flow chart that will be described in depth in the text that follows.":::

The first question to ask is whether you prefer to design the workflow in a GUI designer tool or by writing code. Valid reasons for using a design-first tool, include:

- People who design the workflow have no coding experience.
- Later designers and users can consult the graphical design to clearly understand how the workflow proceeds.

Alternatively, you can choose to use a code-first tool because:

- People who design the workflow are developers and prefer to work entirely in code.
- You want the details of a workflow to be hidden from non-coders.

## Choose a :::no-loc text="design-first"::: technology

If you choose to use a design-first approach, you must also choose from Microsoft Power Automate and Azure Logic Apps.

The principal question here is who will design the workflow: will it be developers or users?

In Logic Apps, there is a GUI designer on which you draw out the workflow. It's intuitive and easy to use but you also have the opportunity to look under the hood and edit the source code for a workflow. This tool is designed for people with development skills.

In Microsoft Power Automate, extra help and templates are provided for common types of workflow. There's no way to edit the source code that the tool creates. This tool is designed for users who have a good understanding of the business process but no coding skills.

## Choose a :::no-loc text="code-first"::: technology

If you choose to use a code-first approach, your next choice is between WebJobs and Azure Functions.

Because of the extra features that are included with Azure Functions, including wider ranges of trigger events and supported languages, the ability to develop test code in the browser, and the pay-per-use price model, consider Azure Functions to be your default choice. There are a few situations in which WebJobs might be a better choice:

- You have an existing Azure App Service application, and you want to model the workflow within the application. This requirement means that the workflow can also be managed as part of the application; for example, in an Azure DevOps environment.
- You have specific customizations that you want to make to the `JobHost` that aren't supported by Azure Functions.
- You want to control your app's retry policies.
- WebJobs only supports C# on Microsoft Windows.

## Mixing technologies

Remember that there's no requirement for you to use the same technology for different workflows: if your requirements differ, you're likely to reach a different answer at the end of your decision-making process. Furthermore, you can also call one workflow from another. For example, a workflow implemented in Microsoft Power Automate can easily call another that is built as an Azure Function.

One reason to mix the technologies used in your business processes would be to give users control over a small section of a complete workflow. Do this by implementing that section in Microsoft Power Automate, then call that flow from a Logic App, WebJob, or Function.
