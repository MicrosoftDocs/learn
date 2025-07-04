Azure Arc provides a wide range of capabilities for managing a large number of Linux systems. You can onboard your Linux machines at scale using automation tools such as Ansible. Once your Linux systems are onboarded to Azure Arc, you can use Azure services to work with them more efficiently at scale. For example, you can use Azure Policy to help enforce standards and compliance, and use Azure Machine Configuration to configure settings for your Linux VMs. To build and operate IT automation at scale, allowing you to create, share, and manage automation across your organization, you can use options such as the Ansible Automation Platform.

## Azure Policy

Azure Policy can help you enforce organizational standards and access the compliance of all your Linux machines. Through its compliance dashboard, Azure Policy provides an aggregated view of your Linux environment, allowing you to evaluate its overall state. Azure Policy also helps to bring your Linux resources to compliance through bulk remediation for existing resources and automatic remediation for new resources.

Common use cases for Azure Policy include implementing governance for resource consistency, regulatory compliance, security, cost, and management. Policy definitions for these common use cases are already available in your Azure environment as built-ins to help you get started.

## Azure Machine Configuration

Azure Machine Configuration provides native capability to audit or configure operating system settings as code for Linux machines on Azure Arc. It can be used on individual machines, or deployed at scale through by Azure Policy.

You can imagine each configuration as another set of properties for the machine. Configurations can include settings such as:

- Operating system settings
- Application configuration or presence
- Environment settings

Configurations are distinct from policy definitions. Machine configuration utilizes Azure Policy to dynamically assign configurations to machines. You can also assign configurations to machines manually, or by using other Azure services such as Automanage.

## Ansible Automation Platform

Azure Arc supports Red Hat Ansible IT automation for your Linux systems. Ansible Automation Platform provides an enterprise framework for building and operating IT automation at scale. Ansible Automation Platform enables users across an organization to create, share, and manage automation—from development and operations to security and network teams. IT managers can provide guidelines on how automation is applied to individual teams, and automation creators can write tasks that use existing knowledge. Ansible Automation Platform provides a more secure and stable foundation for deploying end-to-end automation, such as deploying VM extensions at scale to your Linux machines on Azure Arc.