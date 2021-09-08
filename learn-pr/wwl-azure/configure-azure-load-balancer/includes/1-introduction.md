## Scenario

Many apps need to be resilient to failure and scale easily when demand increases. You can address those needs by using Azure Load Balancer.

Suppose you work for a healthcare organization that's launching a new portal application in which patients can schedule appointments. The application has a patient portal and web application front end and a business tier database. The database is used by the front end to retrieve and save patient information.

The new portal needs to be available around the clock to handle failures. The portal must adjust to fluctuations in load by adding and removing resources to match the load. The organization needs a solution that distributes work to virtual machines across the system as virtual machines are added. The solution should detect failures and reroute jobs to virtual machines as needed. Improved resiliency and scalability helps ensure that patients can schedule appointments from any location.

You must distribute incoming network traffic across a group of back-end resources or services such as virtual machines (VMs). You must scale your applications while maintaining throughput and keeping response times low.

## Skills measured

Configuring load-balancing is part of [Exam AZ-104: Microsoft Azure Administrator](/learn/certifications/exams/az-104).

Configure and manage virtual networking (25–30%)

Configure load balancing

 -  Configure an internal or public load balancer.
 -  Troubleshoot load-balancing.

## Learning objectives

In this module, you will learn how to:

 -  Identify features and usage cases for Azure load balancer.
 -  Implement public and internal Azure load balancers.
 -  Configure load balancer SKUs, backend pools, session persistence, and health probes.

## Prerequisites

None.
