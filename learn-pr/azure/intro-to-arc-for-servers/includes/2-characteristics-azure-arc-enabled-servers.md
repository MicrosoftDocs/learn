The business technology landscape continuously evolves and becomes increasingly complex, with multiple applications running on different hardware across on-premises datacenters, public and private clouds, and the edge. For businesses like Contoso to succeed, they must be able to manage these disparate environments at scale, enhance security across their entire organization, and enable developer agility and innovation. Microsoft Azure provides tools and solutions that help customers innovate their hybrid environments in a secure manner and with a minimized management overhead. Azure Arc is one example, enabling organizations to manage resources hosted outside of Azure alongside native Azure resources. While Azure Arc offers support for different scenarios and resource types, most on-premises workloads still rely on physical or virtual servers running either Windows or Linux, so our focus will be on Azure Arc-enabled servers.

Azure Arc-enabled servers simplifies the process of administrating complex, distributed, hybrid environments, such as the one you deal with as Contoso's IT Engineering team lead. It provides a centralized, multicloud, and on-premises governance and management platform. It promotes a cloud-first strategy that enables automation, single-pane-of-glass monitoring, and comprehensive security, regardless of where your resources are located.

In this unit, you'll learn about the characteristics of Azure Arc-enabled servers and how to enable Azure Arc.

## What are Azure Arc-enabled servers?

Azure Arc-enabled servers lets you manage Windows and Linux physical servers and virtual machines hosted outside of Azure, on your corporate network, or other cloud provider. Management of these machines through Azure Arc is designed to be consistent with how you manage native Azure virtual machines, using standard Azure constructs such as Azure Policy and applying tags.

Azure Arc relies on the Azure Arc Connected Machine agent, a locally installed agent, to establish a logical connection between to Azure. By establishing this connection, a non-Azure resource automatically becomes a hybrid Azure resource, with its own identity represented by an Azure Resource Manager resource ID.

After you onboard your machines to Azure Arc-enabled servers, you can use Azure to manage and monitor their configuration and operations. This facilitates a range of other scenarios that use Azure services to optimize security, monitoring, and governance.

![A screenshot of the Azure portal displaying the entry representing an Azure Arc-enabled Windows server.](../media/2-azure-arc-enabled-vm-portal.png)

## What is the Connected Machine agent?

The Azure Arc-enabled servers Connected Machine agent allows you to manage your Windows and Linux machines hosted outside of Azure on your corporate network or other cloud providers. The Azure Connected Machine agent package consists of three core components:

- The Hybrid Instance Metadata service (HIMDS) manages the connection to Azure and the connected machine's Azure identity.
- The Machine Configuration agent provides functionality such as assessing whether the machine complies with required policies and enforcing compliance.
- The Extension Manager agent manages the install, uninstall, and upgrade of VM extensions, which are lightweight software components that enable post-operating system deployment configuration and automation tasks.

![A diagram outlining the core components of the Connected Machine agent.](../media/2-connected-machine-agent.png)

## What are the supported methods for onboarding machines to Azure Arc-enabled servers?

Effectively, to Arc-enable a server, you need:

- An Azure subscription
- The Connected Machine agent installed on the server, creating a connection to Azure

You can install the agent on individual Windows or Linux servers manually, or by running a script available from the Azure portal. In enterprise environments, you'll likely want to perform installations at scale, deploying the agent to many machines simultaneously through a service principal. You can automate this deployment by using the tooling of your choice, including Microsoft Configuration Manager, Group Policy, and Ansible. Additional options let you automatically discover and onboard EC2 instances in your Amazon Web Services (AWS) accounts, or automatically onboard non-Azure machines that you manage through Azure Automation Update Management.

![Screenshot that depicts the multiple options to onboard to Azure Arc-enabled servers for single server, multiple servers, and update management](../media/2-multiple-gen-script.png)

Once the agent is deployed and connected to your Azure subscription, an Azure Resource Manager object is created to represent each machine. From that point on, you can use the Azure portal, Azure command line tools, or REST API to manage the server.

## What are the supported environments and operating systems for the Connected Machine agent?

The Connected Machine agent allows you to enhance management of Windows and Linux computers residing in on-premises datacenters or hosted by third party private and public cloud providers. Azure Arc-enabled servers support the installation of the Connected Machine agent on any physical server and virtual machine hosted outside of Azure. Supported environments include:

- VMware (including Azure VMware Solution)
- Azure Local
- Other cloud environments

The Azure Connected Machine agent supports a wide range of Windows and Linux operating systems. x86-64 (64-bit) architecture is fully supported, while only some features are supported on Arm64. The Azure Connected Machine agent doesn't run on 32-bit architectures.

However, Azure Arc-enabled servers doesn't support installing the agent on virtual machines running in Azure, or virtual machines running on Azure Stack Hub or Azure Stack Edge, because they are already modeled as Azure VMs.

Choose the best response for each of the following questions.
