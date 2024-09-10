Webhooks offer a lightweight mechanism for apps to be notified by another service when something of interest happens, by using an HTTP endpoint. You can use a webhook to trigger an Azure function, and then analyze the message, to determine what happened and how to respond.

Suppose you're a developer in an IT department. Management wants a regular report on updates to the company's technology Wiki. They'd like to know who contributes, how often it's updated and what pages are updated most often. The Wiki is hosted on GitHub as a GitHub Wiki on one of the company's git repositories. You've heard that GitHub supports webhooks and that you can receive notifications for all kinds of events. You're also familiar with Azure Functions and decide to use a function as the listener for Wiki update events.

By the end of this module, you'll learn how to create a function triggered by a webhook and how to secure a webhook message, or *payload*, with a secret.

## Learning objectives

In this module, you will:

- Trigger your function with a webhook
- Analyze the message from the webhook
- Secure webhook payloads with a secret

## Prerequisites

- Beginner-level knowledge of Azure Functions
- A GitHub account (you can use a free account)
