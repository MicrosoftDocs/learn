## Scenario

Suppose you work for an IT organization that provides cloud-based services to a wide range of customers. Your organization uses Azure in order to provide these services. One of your key responsibilities is to manage the software and applications used by your customers.

One day, your team receives a request from a customer to deploy a new software application on their Azure based environment. You know this will require a significant amount of time and effort to manage for several reasons:

- You will need to ensure the software is configured correctly.
- The software configured should run smoothly.
- There should be a disaster recovery plan for the software's resiliency.

To make the process easier, you decide to use a tool that can create machine images from a single source configuration. As you are dealing with Azure based environments, it makes sense to use the Azure Image Builder (AIB) service. With the AIB service, you can quickly and easily create machine images for Azure environments using standardized virtual machine (VM) images and create a configuration that describes your image and submit it to the service for building and distribution.

You can use existing scripts, commands, and processes so the VMs can take on workloads after the images are created. You then deploy the machine images to the customer's Azure environment and test the software to ensure that it is working correctly. Thanks to the AIB service, the entire process is much faster and more efficient than it would have been otherwise.

## Learning objectives

In this module, you'll:

- Evaluate the performance of an Azure Image Builder pipeline for your business.
- Describe the components and functionality of an Azure Image Builder pipeline.

## Prerequisites
- Experience with Azure, such as deploying and managing virtual machine resources.
- Experience with Azure managed identities, such as user-assigned types.
