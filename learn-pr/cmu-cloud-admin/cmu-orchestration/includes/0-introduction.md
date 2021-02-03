Solutions deployed to the cloud often include dozens of cloud resources that work together to achieve a common goal. It's not difficult to create a VM in Azure or an EC2 instance in AWS. But if that VM or EC2 instance is part of a larger solution that includes virtual networks, databases, storage repositories, and other resources, creating the solution and configuring all its resources to work together is a multi-step process that can be challenging even for the most skilled cloud administrators.

## Repetition, human error, and the cloud

The challenge is even harder if a deployment has to be repeated many times, which might be the case if you need to deploy separate instances of a solution to different data centers for resiliency. The fact that people are involved means human error is a possibility. Add to that, the solution might need to be deployed in a repeatable manner to different cloud platforms -- for example, to Azure and to AWS -- and might later need to be updated by provisioning new resources or modifying existing ones, and suddenly cloud administrators need something more sophisticated than cloud portals and cloud CLIs. They need automation.

## Learning objectives

- Learn about how to automate cloud resource management with infrastructure as code tools like Terraform
- Explain the concept of Infrastructure-as-Code and enumerate the advantages that it offers over ordinary scripting
- List some of the tools that implement IaC for popular cloud platforms and describe some of the differences between them
- Understand Terraform's role as an infrastructure orchestrator and describe how it differs from a conventional configuration manager

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers
- Recognize cloud service models such as IaaS, PaaS, and SaaS and differentiate between them
- Be familiar with different organizational IT cost types like CapEx and OpEx
- Understand how cloud resource provisioning works