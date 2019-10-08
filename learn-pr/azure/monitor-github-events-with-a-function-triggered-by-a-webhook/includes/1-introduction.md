Webhooks offer a lightweight mechanism for apps to be notified by another service when something of interest happens via an HTTP endpoint. You can use a webhook to trigger an Azure function, and then parse the payload to determine what happened and how to respond.

Suppose you are a developer in an IT department. Management wants a regular report on updates to the company's technology Wiki. They'd like to know who contributes, how often it is updated and what pages are updated most often. The Wiki is hosted on GitHub as a GitHub Wiki on one of the company's git repositories. You've heard that GitHub supports webhooks and you can receive notifications for all kinds of events. You are also familiar with Azure Functions and decide to use a Function as the listener for Wiki update events.

By the end of this module, you'll learn how to create an Azure Function triggered by a webhook and how to secure webhook payloads with a secret.

## Learning objectives

In this module, you will:

- Trigger an Azure Function from a webhook
- Secure webhook payloads with a secret

## Prerequisites

- Beginner-level knowledge of Azure Functions
- A GitHub account (you can use a free account)
