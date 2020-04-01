The use of containers to develop and deploy software has become popular over the last few years. Containers make it easy to package and deploy an application with all its services to any computing environment. When your application meets higher demand, you can easily scale out your services by deploying additional container instances. Containers are also less resource-intensive than virtual machines. This efficiency allows you to make better use of computing resources that will save you money.

The standard container management runtime is focused on managing individual containers. However, there are times where you'll want to scale and have multiple containers working together. Scaling multiple containers becomes challenging as several factors need consideration when managing multiple containers. Suppose you need to handle load balancing, security, network connectivity, and deployment. It's common to use a container management platform such as Kubernetes to help make the management process easier.

Suppose you work at a drone management company. Your company provides a drone tracking solution to customers worldwide. Your drone tracking solution is built and deployed as microservices and included several major applications:

**[Image of the high-level architecture that describes the drone tracking solution.]**

- A drone tracking website that includes maps and information about tracked drones

- A cache services that stores frequent requested information displayed on the website

- A RESTFul API where tracked drones send data about the drone status, such as a GPS location and battery charge levels

- A queue that holds unprocessed data collected by the RESTful API

- A data processing service that fetches and processes data from the queue

- A NoSQL database that stores processed tracking data and user information captured from the website and data processing service

You're using containerized instances to quickly deploy into new customer regions and scale resources as needed to meet customer demands. You want to use a container orchestration platform that makes it simple to develop, deploy, and manage these containerized applications.

Here, you'll see how Kubernetes makes it simple to orchestrate containerized applications. The goal is to help you decide if Kubernetes is a good choice as an orchestration platform for your business.

## Learning objectives

In this module, you will:

- Evaluate whether Kubernetes is an appropriate orchestration platform for you
- Describe how the components of a Kubernetes cluster work and support compute container orchestration

## Prerequisites

- Basic understanding of microservices
- Basic understanding of how Docker containers work
