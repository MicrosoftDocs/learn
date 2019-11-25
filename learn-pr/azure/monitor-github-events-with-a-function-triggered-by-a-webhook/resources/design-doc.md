# Module Design

## Title

Monitor GitHub events with an Azure Function triggered by a webhook

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure
- Azure Functions

## Prerequisites

- Experience creating and developing Azure Functions
- Technical prerequisite, to be specially noted in the introduction unit: a (free) GitHub account

## Summary

Webhooks offer a lightweight mechanism for your app to be notified by another service when something of interest happens. Trigger an Azure function with a GitHub webhook and parse the payload for insights.  

## Learning objectives

1. Create an Azure Function triggered by a webhook
1. Secure webhook payloads with a secret

## Chunk your content into subtasks

| Subtask                                  | What part of the introduction scenario does this subtask satisfy?          | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Create a function triggered by a webhook | Creates Batch and Storage accounts in your subscription  to run Batch jobs | Exercise                                                 | 1                                                | Yes                                                                                                                            |
| Set up a webhook for a GitHub repository | Creates a .NET console app and accesses Batch account programmatically     | Exercise                                                 | 1                                                | Yes                                                                                                                            |
| Trigger a function with a GitHub event   | Creates a simple Batch job programmatically                                | Exercise                                                 | 1                                                | Yes                                                                                                                            |
| Secure webhook payloads with a secret    | Creates a more sophisticated solution that uses an application package     | Exercise                                                 | 2                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    Suppose you are a developer in your company's IT department. Management wants a regular report on how current the company's technology Wiki is kept. They'd like to know who contributes, how often it is updated and what pages get the most updates. The Wiki is actually a GitHub Wiki on one of the private repos. You've heard that GitHub supports webhooks and you can receive notifications for all kinds of events. You are also familiar with Azure Functions and decide to use a Function as the listener for Wiki update events. 

## Notes

- The key concept we are teaching in this module is that monitoring something using a function triggered by a webhook is really simple.
- We are opting for GitHub as the real-world scenario. Therefore, GitHub is a prerequisite for the exercises. 
- I recommend a that the exercise creates a function that is triggered when the Wiki on a GitHub repo changes. Follow the subtasks outlined above. 
- The repo can be public or private - private mimics a company internal Wiki scenario better, 
- Explain webhooks, then show how to configure one on a GitHub repo - I recommend registering for the [Gollum event](https://developer.github.com/v3/activity/events/types/#gollumevent) because it is simple to test and has a cool name. Just add one page to the Wiki in a repo and do a few edits and saves to trigger the webhook. 
-  On the functions side, explain briefly the concepts of triggers and bindings.  
- Start with an exercise to create a functions app, one function triggered by a webhook and show it running. Next exercise, configure a webhook and the gollum event in GitHub. Then show how the function code is updated to parse the request body and dump some details of the event payload to the console. For example, show `req.body.repository.name` and `req.headers['x-github-event']` to begin with. 
- A stretch is to log info from each event to a CosmosDB, but at least mention where the learner could take this solution. 
- Follow the Learn-Exercise pattern of paired units as much as possible in this module. Teach something and then let the user practice in an exercise.
- The final learn-exercise pair should focus on securing the webhook payload with a secret. Explain why that's important and how it is done, then update the code in the next exercise to decrypt the payload and once again show some of the contents. 
- Consider using the portal (sandbox) for function creation. Alternatively use VS Code. 
- Preference is to write function code in JavaScript to lign with other modules in the learning path. We can always add a C# pivot or alternative later. 
- References
  - [GitHub Webhooks](https://developer.github.com/webhooks/)
  - [Gollum event](https://developer.github.com/v3/activity/events/types/#gollumevent)
  - [Azure Functions HTTP triggers and bindings](https://docs.microsoft.com/azure/azure-functions/functions-bindings-http-webhook)
  - [Securing your webhooks](https://developer.github.com/webhooks/securing/)
  - [HTTP and webhooks](https://docs.microsoft.com/sandbox/functions-recipes/http-and-webhooks)