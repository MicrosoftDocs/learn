Using a microservices application in the cloud can provide many advantages but it also includes several shortcomings. Transient infrastructure failures, mostly network-related, are one of the key problems every cloud application has to handle.

In this module we'll set the focus on resiliency or how to make your application fault-tolerant, in a way that has the smallest possible impact on the user.

We'll explore the two main resilience approaches, a code-related handling, using the [Polly library](https://github.com/App-vNext/Polly) and an infrastructure-related one, using [Linkerd](https://linkerd.io/2/overview/).

You'll modify the application to include some Polly resiliency handling policies in a microservice. You'll also reconfigure your AKS deployment, without changing any code, to implement a Linkerd-based solution.

## Learning objectives

- Understand the key Resiliency concepts.
- Implement failure handling code for HTTP requests in one microservice.
- Deploy Linkerd onto an AKS cluster to implement an infrastructure-based resiliency solution.

## Prerequisites

- Familiarity C# and ASP.NET Core development.
- Access to an Azure subscription with **Owner** privilege.
- Access to a GitHub account