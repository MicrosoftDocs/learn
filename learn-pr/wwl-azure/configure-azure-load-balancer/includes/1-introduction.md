Many applications need to be resilient to failure and scale easily when demand increases. Administrators can address these requirements by using Azure Load Balancer.

Suppose your healthcare organization is launching a new portal application for patients to schedule appointments. The application has a patient portal, web application frontend, and business tier database. The database is used by the frontend to retrieve and save patient information.

The new portal needs to be available around the clock to handle failures. The portal must adjust to fluctuations in load by adding and removing resources to match the load. You need a solution to distribute work to virtual machines across the system as virtual machines are added. The solution should detect failures and reroute jobs to virtual machines as needed. Improved resiliency and scalability are required to help ensure patients can schedule appointments from any location.

You're responsible for configuring the load balancers to distribute incoming network traffic across a group of back-end servers. You need to scale your applications while maintaining throughput and keeping response times low.

The goal of this module is to equip you to implement an Azure load balancer. 

## Learning objectives

In this module, you learn how to:

- Identify features and usage cases for Azure Load Balancer.
- Implement public and internal Azure load balancers.
- Compare features of load balancer SKUs and configuration differences.
- Configure back-end pools, load-balancing rules, session persistence, and health probes.

## Skills measured

The content in the module helps you prepare for [Exam AZ-104: Microsoft Azure Administrator](/certifications/exams/az-104). 

## Prerequisites

- Basic knowledge of virtual networks and routing.
- Familiarity with the Azure portal so you can configure the load balancer.