When you deploy a set of virtual machines (VMs) to host a production system, it's essential that all the VMs have the same state. They must have the same services installed. VMs should be configured in the same way, and the software on each machine must be the same version. The configuration of each VM can *drift*. You can end up with systems that are prone to failure because of incompatibilities in the setup of each machine. Azure Automation State Configuration addresses many of the problems associated with deploying at scale, and managing configuration drift.

Imagine you're an administrator for a retail company that uses Azure Virtual Machines to host its website. Your organization recently had an issue with a VM being redeployed without the Windows IIS web server feature installed. This issue caused your website to behave unpredictably.

To reduce the time you spend troubleshooting and maintaining the configuration consistency across these VMs, you decide to set up Azure Automation State Configuration.

## Learning objectives

In this module, you'll:

- Identify the capabilities of Azure Automation State Configuration
- Learn how to onboard VMs for management by Azure Automation
- Automatically update VMs to maintain a desired state configuration (DSC)

## Prerequisites

- Familiarity with Azure VMs
- Ability to execute scripts with Azure CLI and PowerShell
