When you create cloud-native applications, you can leverage the benefits of containers, which allow you to bundle and run applications. Modern software systems are increasingly using containers as part of their architecture. Isolating system components in containers gives developers the flexibility to use the right technologies where they’re needed, while also extending applications without changing existing system architecture. As applications grow to include numerous containers deployed across multiple servers, operating them becomes more complex.

Many cloud-native architectures turn to Kubernetes to deploy and manage containers. Kubernetes, often abbreviated as K8s, provides a framework to scale, load balance, and self-heal applications. If a container goes down, Kubernetes can start another container automatically or even replicate containers when demand increases.

Azure Kubernetes Service (AKS) is a fully managed Kubernetes service that offloads a lot of the complexity, security, and operational overhead.

## Example scenario: Connecting fridges, at scale

Let's say you work for Adatum Corporation, a manufacturer of home appliances. You lead a small development team there, and you've been tasked with building an app for smart fridges.

Cloud-native apps have loosely coupled functionality by nature. With AKS, we can be more agile in our design and don't need to predict future requirements. We can start by using AKS for a small fridge inventory-management app that informs businesses about what needs to be restocked.

We start by using an AKS cluster to deploy a Node.js container, which will process messages from the fridges and send them to a management web app. Later, if needed, we can add functionality to the app, such as connecting to fridge telemetry and onboard sensors.

## Prerequisites

* A basic familiarity with Azure.
* A familiarity with basic cloud native concepts and terminology.
* An Azure subscription. If you don't have an Azure subscription, create a free account before you begin.

## Learning objectives

In this module, you will:

* Create a Kubernetes AKS cluster.
* Run a Docker container in Kubernetes.
* Connect a hosted Docker container to a web app.
