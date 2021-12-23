Managing secrets is a critical step in securing your Java applications.

Suppose that you are building a new e-commerce website for your company. This 
website will access a database, connect to third-party APIs, and will even
encrypt some personal end-user data. For all of those activities, your application
will need to store some sensitive keys, called secrets. Those secrets are some the most critical assets of your company, and hackers will try to access them.

In this module, you'll create an application that manages such secrets. We'll introduce the concepts of Zero Trust and Zero Secrets, where your Java application won't manage those secrets at all. It will make the task of attackers much more difficult. We'll see those
concepts in action, both from an IT operator perspective, and from a developer perspective.

## Goals

By the end of this module, you'll:

- Understand best practices like Zero Trust to secure any application running in the cloud.
- Know how to apply those practices using Azure Key Vault on a Java project running on Azure.

## Prerequisites

- Familiarity with developing and running Java applications.
- Beginner-level experience with cloud infrastructure.
- Intermediate-level familiarity with command-line tools, specifically the Azure CLI, and Azure-specific terminology.
