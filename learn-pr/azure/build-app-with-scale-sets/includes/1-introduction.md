
A virtual machine scale-set gives you a scalable way to run applications on a set of virtual machines. The virtual machines in a virtual machine scale set are all configured in the same way, and run the same applications. As demand increases, the number of virtual machines running in the scale set can also increase. As demand slackens off, excess virtual machines can be shut down. In this way, you can maintain throughput and responsiveness without incurring the costs associated with continually running a large collection of virtual machines.

Image that you work for a domestic shipping company. The company has a web site that customers can use to manage and check the status of their shipments. This site currently runs on virtual machines on-premises. The company is moving this application to Azure. They currently have a fixed capacity on-premises and are unable to adjust to fluctuations in load without manually intervening and creating or deallocating virtual machines. They need a solution that will automatically handle these fluctuations in load, to ensure consistent performance for their web site. They also need a way to quickly roll out application updates to the servers while minimizing impact to end users.

This module shows you how to create a virtual machine scale set, and how to deploy an application on this scale set. Application maintenance is also a concern, so you'll learn how to update an application that is deployed across a virtual machine scale set.

## Learning objectives

In this module, you will:

- Identify the features and capabilities of virtual machine scale sets
- Identify the use cases for running applications on virtual machine scale sets
- Deploy an application on a virtual machine scale set

## Prerequisites

- Basic knowledge of Azure virtual machines
- Basic knowledge of load-balancing concepts
  