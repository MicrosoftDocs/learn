When you’re creating cloud-native applications, you can enjoy the many benefits of using containers, which are a great way to bundle and run applications. Modern software systems are increasingly using containers as part of their architecture, and for good reason. Isolating system components in containers gives developers the flexibility to use the right technologies where they’re needed, while also extending applications without changing existing system architecture. As applications grow to include numerous containers deployed across multiple servers, operating them becomes more complex.

Many cloud-native architectures turn to Kubernetes to deploy and manage containers. Kubernetes, often abbreviated as K8s, provides a framework to scale, load balance, and self-heal applications. If a container goes down, Kubernetes can start another container automatically, or even replicate containers when demand increases.

Azure Kubernetes Service (AKS) is a fully managed Kubernetes service, where much of the complexity, security, and operational overheads are offloaded to Azure; perfect for a cloud-native approach.

## Scenario: Connecting fridges, at scale

Suppose you work for Adatum Corporation, a manufacturer of home appliances such as refrigerators. You lead a small development team there, and you've been tasked with building an app for smart fridges.

It's the nature of cloud-native apps to have loosely coupled functionality. With AKS, we can be more agile in our design and don't need to predict future requirements. We can start by using AKS for a small fridge inventory-management app, so businesses can know what needs to be restocked. They might even choose to develop functionality enabling the fridges to reorder items automatically.

To start, we’ll use an AKS cluster to deploy a Node.js container, which will process the messages from fridges and send them to a management web app. Later, if needed, we can add functionality to the app, such as connecting to fridge telemetry and onboard sensors.

## Prerequisites

* A basic familiarity with Azure
* A familiarity with basic Cloud Native concepts and terminology
* An understanding of cloud computing is helpful, but isn't necessary

## Learning objectives

In this module, you will:

* Create a Kubernetes AKS cluster.
* Run a docker container in Kubernetes.
* Connect a hosted docker container to a web app.
