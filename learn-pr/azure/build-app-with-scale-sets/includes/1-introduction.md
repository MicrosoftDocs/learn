
A virtual machine scale set provides a scalable way to run applications on a set of virtual machines. The virtual machines in this type of scale set all have the same configuration, and run the same applications. As demand grows, the number of virtual machines running in the scale set increases. As demand slackens off, excess virtual machines can be shut down. This way, you maintain throughput and responsiveness without incurring the costs associated with continually running a large collection of virtual machines.

Imagine that you work for a domestic shipping company. There's a website that customers use to manage and check the status of their shipments. This site currently runs on virtual machines on-premises. The company is moving this application to Azure. Currently, there's a fixed capacity on-premises. The company can't adjust to fluctuations in load without manually intervening, and creating or deallocating virtual machines. You need a solution that will automatically handle these fluctuations in load, to ensure consistent performance for the website. The company also needs to quickly roll out application updates to the servers while minimizing impact to end users.

This module shows you how to create a virtual machine scale set, and deploy an application. Application maintenance is also a concern. You'll learn how to update an application that's deployed across a virtual machine scale set.

## Learning objectives

In this module, you'll:

- Identify the features and capabilities of virtual machine scale sets.
- Identify the use cases for running applications on virtual machine scale sets.
- Deploy an application on a virtual machine scale set.

## Prerequisites

- Basic knowledge of Azure virtual machines.
- Basic knowledge of load-balancing concepts.
  